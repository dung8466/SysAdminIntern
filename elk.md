1. Install Elasticsearch & Kibana

- Thêm public key: `wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`

- Tải về Elasticsearch và Kibana:

```
  apt-get install apt-transport-https
  && echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list 
  && apt update
  && apt-get install elasticsearch
  && apt-get install kibana
```

- Tải Elasticsearch theo link ![](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-with-debian-package#first-node)

- Tải Kibana theo link ![](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-kibana-with-debian-package)

- Reconfig node Elasticsearch để join cluster
  + `/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node`
  + `/usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token <token>`
  + Xong khi các node đã join xong, xoá dòng `cluster.initial_master_nodes` tại node đầu tiên, sửa lại `discovery.seed_hosts` trên các node master chứa toàn bộ ip node master.
 
- Config Kiban:
  + `/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana`
  + `/usr/share/kibana/bin/kibana-setup --enrollment-token <token>`
  + Sửa config để thêm nhiều host elasticsearch

- Kiểm tra các node trong cluster:

```

curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cat/nodes?v
ip          heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
10.5.91.73            33          93   6    0.05    0.09     0.09 dm        -      ops-dungnt-elk-master1
10.5.89.231           15          89   7    0.42    0.30     0.20 hs        -      ops-dungnt-elk-data1
10.5.91.103           14          92   7    0.05    0.13     0.18 cw        -      ops-dungnt-elk-data2
10.5.88.158           55          93   5    0.16    0.26     0.18 m         -      ops-dungnt-elk-master2
10.5.88.173           38          93   6    0.19    0.29     0.19 m         *      ops-dungnt-elk-master3

```

- Kiểm tra cluster health:

```
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cluster/health?pretty
```

### Kafka

- Liệt kê topic
  
  `/opt/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092`
  

- Tạo topic
  
  `/opt/kafka/bin/kafka-topics.sh --create --topic apache --bootstrap-server localhost:9092`
  

- Chi tiết topic
  
  `/opt/kafka/bin/kafka-topics.sh --describe --topic apache --bootstrap-server localhost:9092`
  

- Xoá topic
  
  `/opt/kafka/bin/kafka-topics.sh --delete --topic apache --bootstrap-server localhost:9092`
  
- Xem chi tiết topic chạy
  
  `/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic apache --from-beginning`

  ### Kiểm tra cluster ELK

  - Lấy lại password cho user `elastic`:
 
  ```
  /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
  ```

  - Xem số node, công dụng của các node:

  ```
  curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cat/nodes?v
  ```

  + Giá trị trả về:

  ```

  ip          heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
  10.5.91.103           53          93   6    0.13    0.21     0.14 ciw       -      ops-dungnt-elk-data2
  10.5.89.231           60          94   7    0.10    0.18     0.16 his       -      ops-dungnt-elk-data1
  10.5.91.73            32          91   7    0.06    0.11     0.13 dim       *      ops-dungnt-elk-master1
  10.5.88.173           38          84   6    1.14    0.47     0.22 cim       -      ops-dungnt-elk-master3
  10.5.88.158           15          85   7    0.05    0.15     0.18 fim       -      ops-dungnt-elk-master2

  Trong đó:
  + c : coordinating only (chỉ điều phối query, không lưu data)
  + i : ingest node (xử lý pipeline ingest)
  + w : warm data node (lưu dữ liệu “warm” – dữ liệu ít truy cập, giá rẻ hơn hot node)
  + h : hot data node (lưu dữ liệu “hot” – dữ liệu truy cập thường xuyên)
  + f : frozen data node (lưu dữ liệu “frozen” – dung lượng lớn, truy cập hiếm, chủ yếu đọc)
  + t : transform (xử lý transform jobs)
  + d : data node (truyền thống, tổng hợp nếu không chia hot/warm/cold)
  + s : cold data node (lưu dữ liệu “cold” – ít truy cập hơn warm, thường gắn với hardware rẻ, disk dung lượng lớn)
  + m : master-eligible node (có thể làm master)
  ```

  - Xem các shards lưu trữ trên node nào:

  ```
  curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cat/shards?v
  ```

  + Giá trị trả về:
 
  ```
  index                                                              shard prirep state       docs   store dataset ip          node
  .ds-.logs-elasticsearch.deprecation-default-2025.08.16-000003      0     p      STARTED        0    249b    249b 10.5.89.231 ops-dungnt-elk-data1
  .ds-.logs-elasticsearch.deprecation-default-2025.08.16-000003      0     r      STARTED        0    249b    249b 10.5.91.73  ops-dungnt-elk-master1
  .internal.alerts-stack.alerts-default-000001                       0     p      STARTED        0    249b    249b 10.5.89.231 ops-dungnt-elk-data1
  .internal.alerts-stack.alerts-default-000001                       0     r      STARTED        0    249b    249b 10.5.91.73  ops-dungnt-elk-master1
  filebeat                                                           0     p      STARTED        0    249b    249b 10.5.89.231 ops-dungnt-elk-data1
  filebeat                                                           0     r      STARTED        0    249b    249b 10.5.91.73  ops-dungnt-elk-master1
  ...

  Trong đó
  + prirep: p (primary) hay r (replica)
  ```

  - Xem tổng dung lượng các theo index:

  ```
  curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cat/indices?v
  ```

  + Giá trị trả về:

  ```
  health status index                                                              uuid                   pri rep docs.count docs.deleted store.size pri.store.size dataset.size
  green  open   .internal.alerts-transform.health.alerts-default-000001            AmPCZshjT2WqrWR6zowPWQ   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-observability.logs.alerts-default-000001          xbeuYc8nRAGAB9hPWaDbAA   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-observability.uptime.alerts-default-000001        j3Yz_unaRiy2ZjVSerasNg   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-ml.anomaly-detection.alerts-default-000001        veVuodAOR82lMkb7sc-3GA   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-observability.slo.alerts-default-000001           CeOafq-TQFWGoQ6GcYSxig   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-default.alerts-default-000001                     pqB68UtgSxuzB9hpBZmARw   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-observability.apm.alerts-default-000001           nSI_MTDXQSmJiQkrYFnWrQ   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-observability.metrics.alerts-default-000001       eC0XIPPdRTyD9xJ5n2ASLA   1   1          0            0       498b           249b         249b
  green  open   .ds-filebeat-9.0.3-2025.07.24-000002                               SSTIrMhmRBSJeCe5TCxI0g   1   1          0            0       498b           249b         249b
  green  open   .ds-logs-generic-default-2025.08.20-000002                         vo_R3LBMQKepZbWyoioj9w   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-ml.anomaly-detection-health.alerts-default-000001 SaDh2TIkSSGsALdL4Yc4MQ   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-observability.threshold.alerts-default-000001     OXaYDnJTTYW_KYBnTJU9vA   1   1          0            0       498b           249b         249b
  green  open   .internal.alerts-security.alerts-default-000001                    wKO6ESE1SsOyOx-Vt7VRvA   1   1          0            0       498b           249b         249b
  green  open   filebeat                                                           yomUlWKRQxO4dIOK5vkuQQ   1   1          0            0       498b           249b         249b
  green  open   .ds-filebeat-9.0.3-2025.07.14-000001                               qxJ1liD7TRCbo8p4JqnvzQ   1   1       1989            0   1010.4kb        505.2kb      505.2kb
  green  open   .internal.alerts-stack.alerts-default-000001                       wGB4FKUSRICAkUkPVhsEJQ   1   1          0            0       498b           249b         249b
  green  open   .ds-logs-generic-default-2025.07.21-000001                         dcC5QLQ2Qe6eWqIXEBwVwQ   1   1   60701444            0      9.9gb          4.9gb        4.9gb  
  ```

  - Xem thông tin chi tiết từng node (host, ip, disk data dung lượng, iostat,...)

  ```
  curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_nodes/stats/fs?pretty
  ```

  + Giá trị trả về:

  ```
  {
  "_nodes" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "cluster_name" : "elasticsearch-demo",
  "nodes" : {
    "EKmxQ8DGRpmlO5tS1bFF2g" : {
      "timestamp" : 1758700455013,
      "name" : "ops-dungnt-elk-master1",
      "transport_address" : "10.5.91.73:9300",
      "host" : "10.5.91.73",
      "ip" : "10.5.91.73:9300",
      "roles" : [
        "data",
        "ingest",
        "master"
      ],
      "attributes" : {
        "xpack.installed" : "true",
        "transform.config_version" : "10.0.0",
        "ml.config_version" : "12.0.0"
      },
      "fs" : {
        "timestamp" : 1758700455014,
        "total" : {
          "total_in_bytes" : 40483942400,
          "free_in_bytes" : 32270028800,
          "available_in_bytes" : 32253251584
        },
        "data" : [
          {
            "path" : "/var/lib/elasticsearch",
            "mount" : "/ (/dev/vda1)",
            "type" : "ext4",
            "total_in_bytes" : 40483942400,
            "free_in_bytes" : 32270028800,
            "available_in_bytes" : 32253251584,
            "low_watermark_free_space_in_bytes" : 6072591360,
            "high_watermark_free_space_in_bytes" : 4048394240,
            "flood_stage_free_space_in_bytes" : 2024197120
          }
        ],
  ```

  - Xem chi tiết giá trị disk của cluster:
 
  ```
  curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cat/allocation?v
  ```

  + Giá trị trả về:

  ```
  shards shards.undesired write_load.forecast disk.indices.forecast disk.indices disk.used disk.avail disk.total disk.percent host        ip          node                   node.role
    54                0                 0.0                12.4gb        6.4gb     9.2gb     28.4gb     37.7gb           24 10.5.91.73  10.5.91.73  ops-dungnt-elk-master1 dim
     0                0                 0.0                    0b           0b    36.6gb        1gb     37.7gb           97 10.5.88.158 10.5.88.158 ops-dungnt-elk-master2 fim
     1                0                 0.0               505.2kb      505.2kb     2.6gb     73.7gb     76.4gb            3 10.5.91.103 10.5.91.103 ops-dungnt-elk-data2   ciw
     1                0                 0.0               505.2kb      505.2kb     2.7gb     34.9gb     37.7gb            7 10.5.88.173 10.5.88.173 ops-dungnt-elk-master3 cim
    54                0                 0.0                12.4gb        6.5gb     9.2gb     67.2gb     76.4gb           12 10.5.89.231 10.5.89.231 ops-dungnt-elk-data1   his
  ```

  - Xem pipeline logstash:

  ```
  curl -s http://localhost:9600/_node/pipelines?pretty
  ```
  
  - Filter logstash:

  ```
  grok: parse log
  date: chuẩn hoá timestamp
  geoip: ip location
  useragent: Phân tích chuỗi User-Agent của HTTP thành trình duyệt, OS, device
  mutate: Dùng để đổi tên field, xóa field, thêm field, đổi type (string → integer/float/bool)
  ```

  - Xem tại sao shard không relocate được
 
  ```
  curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200/_cluster/allocation/explain?pretty
  ```

  Filebeat config call domian instead of ip kafka,
  Gọi vào Kafka cluster thì chỉ cần 1 ip hoặc domain thay vì nhiều ip
  Delete index,data log
  Làm sao để biết index để search nhanh
