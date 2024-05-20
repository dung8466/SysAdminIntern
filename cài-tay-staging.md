
#### chrony

{% for host in chrony_server %}
server {{ host }} iburst
{% endfor %}

keyfile /etc/chrony/chrony.keys
commandkey 1
driftfile /var/lib/chrony/chrony.drift
log tracking measurements statistics
logdir /var/log/chrony
maxupdateskew 100.0
dumponexit
dumpdir /var/lib/chrony
local stratum 10

{% if is_chrony_server %}
{% for host in allow_host %}
allow {{ host }}
{% endfor %}
{% endif%}

logchange 0.5
rtconutc

1. Xóa ntpd/ntp
2. Tải chrony
3. Cấu hình chrony theo chrony.conf.j2
4. Restart chrony
5. Set timezone

#### unattended-upgrades

1. Xóa 20auto-upgrades tại `/etc/apt/apt.conf.d/20auto-upgrades`
2. tải package
3. Tạo 50unattended-upgrades tại `/etc/apt/apt.conf.d/50unattended-upgrades` theo `50unattended-upgrades.j2`
4. đặt lịch tại `/etc/apt/apt.conf.d/10periodic` theo `10periodic.j2`
5. cho phép service `unattended-upgrades`

#### disable-auto-upgrade

1. Thêm file `/etc/apt/apt.conf.d/20auto-upgrades`
2. dừng và disable `unattended-upgrades`j

#### wallaby-package

1. Tải Ubuntu cloud

       apt install software-properties-common

2. Tải Keyring

       apt install ubuntu-cloud-keyring

3. Thêm Wallaby repository

        deb http://ubuntu-cloud.archive.canonical.com/ubuntu focal-updates/wallaby main

4. Tải Openstack client

        apt install python3-openstackclient

#### public-nova-compute-ubuntu20

sysctl >> libvirt >> nova-user >> nova-compute >> nova-user

1. Load module nf_conntrack

`modprobe nf_conntrack`

config: net.ipv4.conf.all.rp_filter=0,net.ipv4.conf.default.rp_filter=0,net.netfilter.nf_conntrack_max=2000000,vm.swappiness=10

2. libvirt

`ceph_release: pacific`, `debian_version: focal`, `packages_ceph_folder: /tmp/packages_ceph,ceph_version: 16.2.13`

+ tải ca-certificates

      apt install ca-certificates
+ add ceph key https://download.ceph.com/keys/release.asc
+ thêm repo ceph
+ thêm thư mục packages_ceph_folder 0755 và thêm script 0755

      wget https://download.ceph.com/debian-{{ ceph_version }}/pool/main/c/ceph/
      for i in `cat index.html |grep {{ ceph_version }}-1{{ debian_version }} | awk -F ">" '{print $2}' | awk -F "<"       '{print $1}' | grep "librbd1\|librados2" | grep -v "dbg\|arm64"`;do wget https://download.ceph.com/debian-{{         ceph_version }}/pool/main/c/ceph/${i};done

+ chạy script
+ tải package
+ Xóa thư mục packages_ceph_folder
+ thêm các file vào /tmp
+ cài đặt libvirt ở thư mục /tmp
+ libvirt sử dụng socket
+ cấu hình libvirt tcp tại `/etc/libvirt/libvirtd.conf` theo `libvirtd.conf.j2`
+ đảm bảo libvirt started
+ cấu hình libvirt tại `/etc/default/libvirtd` theo `libvirtd.j2`
+ hủy net default
+ undefine net default

3. nova-user

+ tạo user nova, home `/var/lib/nova`
+ tạo thư mục `/var/lib/nova/.ssh` 0700
+ tạo file `/var/lib/nova/.ssh/config` 0600
+ copy file `group_vars/id_rsa` đến `/var/lib/nova/.ssh/id_rsa` 0600
+ copy file `group_vars/id_rsa.pub` đến `/var/lib/nova/.ssh/id_rsa.pub` 0644
+ copy file `group_vars/id_rsa.pub` đến `/var/lib/nova/.ssh/authorized_keys` 0600

4. nova-compute

+ tải tuned
+ `tuned-adm profile network-latency`
+ copy file đến /tmp
+ tải nova-compute từ /tmp
+ cấu hình `/etc/nova/nova.conf` theo `nova.conf.j2`
+ cấu hình `/etc/nova/nova-compute.conf` theo `nova-compute.conf.j2`
+ cho user `nova` sở hữu `/var/lib/nova/instances`

#### openvswitch

1. Copy file đến /tmp
2. tải openvswitch theo file tại /tmp

#### ocata-neutron-compute

`apt-mark hold openvswitch* python3-openvswitch`

tải neutron package `neutron-openvswitch-agent`

#### ovs-bridge

ovs_bridge_list:
  - br-prv

ovs_port_list:
  -
    bridge: br-prv
    port: bond0

1. thêm bridge `br-prv`
2. thêm port `bond0` vào `br-prv`

#### ceph-compute

1. thêm key ceph `https://download.ceph.com/keys/release.asc`
2. thêm nepo ceph `https://download.ceph.com/debian-{{ ceph_release }}/ {{ debian_version }} main`
3. đảm bảo thư mục packages_ceph tồn tại
4. copy script `install_ceph_ubuntu.sh` tải package đến /tmp 0755
5. chạy script `bash install_ceph_ubuntu.sh`
6. tải ceph package
7. dọn thư mục packages_ceph
8. tạo file config `/etc/ceph/ceph.conf` theo `ceph.conf.j2`
9. copy key `ceph.client.cinder.keyring.j2` đến `/etc/ceph/ceph.client.cinder.keyring` root:root
10. tạo file `/tmp/secret.xml` theo `secret.xml.j2`
11. `sudo virsh secret-define --file /tmp/secret.xml`
12. copy script `run.sh.j2` đến `/tmp/run.sh` root:root
13. `sudo bash /tmp/run.sh`
14. thêm secret key và user đến nova config

#### install-docker-tools

1. tải docker.io và python-setuptools
2. đổi network tại `/etc/docker/daemon.json` theo `daemon.json.j2`
3. tải docker-compose
4. cho phép khởi động theo boot
5. thêm symlink từ `/usr/local/bin/docker-compose` đến `/usr/bin/docker-compose`

#### openstack-compute-agent-compose

neutron_docker_version: train
nova_docker_version: train
ovn_docker_version: yoga-ovn
neutron_docker: false

cloud_version: cloudv2
cloud_path: /opt/{{cloud_version}}
enable_vitastor: False

1. đảm bảo file compose tại `/opt/{{cloud_version}}`
2. tạo docker-compose v2 và v3 tại `{{cloud_path}}/docker-compose.yml` theo `docker-compose.yml.j2` và `docker-compose-v3.yml.j2`

#### pull-docker-image

docker_registry_url: hub.paas.vn
docker_username: gitlab-runner
cloud_version: cloudv2

1. đăng nhập vào docker hub với username, password
2. pull v2 `docker-compose -f /opt/cloudv2/docker-compose.yml pull`
3. pull v3 `docker-compose -f /opt/cloudv3/docker-compose.yml pull`

#### disable-openstack-host-process

openstack_disable_service:
  - nova-compute

1. đảm bảo service `nova-compute` stop 

#### start_services

docker_registry_url: hub.paas.vn
cloud_version: v2

1. tải python-docker nếu verion 20
2. đăng nhập docker hub
3. cho phép docker chạy với boot
4. khởi động v3 `docker-compose -f /opt/cloudv3/docker-compose.yml up -d`
5. khởi động v2 `docker-compose -f /opt/cloudv2/docker-compose.yml up -d`

#### filebeat

1. Copy file từ `filebeat-{{ filebeat_version }}-amd64.deb` đến `/tmp/filebeat-{{ filebeat_version }}-amd64.deb`
2. tải filebeat theo `/tmp/filebeat-{{ filebeat_version }}-amd64.deb`

#### nagios_nrpe

#### splunk_forwarder

#### telegraf

influxdb_infra_url: "http://103.69.194.95:10015"
influxdb_infra_db: "stagingtelegraf"
influxdb_infra_username: "openstack"
influxdb_infra_tagpass: "staging-infra"

influxdb_cloud_url: "http://103.69.194.95:10003"
influxdb_cloud_db: "cloud-server"
influxdb_cloud_username: "cloud-server"
influxdb_cloud_tagpass: "cloud-server"
