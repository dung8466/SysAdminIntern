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
