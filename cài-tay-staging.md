#### sshusersp2_dont_use

#### sshpolicy

#### utilitytools

#### chrony

chrony server: `172.25.252.10`

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

##### Ubuntu

1. Xóa ntpd
2. Tải chrony
3. Cấu hình chrony
4. Restart chrony
5. Set timezone

#### unattended-upgrades

#### disable-auto-upgrade

#### wallaby-package

1. Tải Ubuntu cloud
2. Tải Keyring
3. Thêm Wallaby repository
4. Tải Openstack client

#### public-nova-compute-ubuntu20

sysctl >> libvirt >> nova-user >> nova-compute >> nova-user

1. Load module nf_conntrack

`modprobe nf_conntrack`

config: net.ipv4.conf.all.rp_filter=0,net.ipv4.conf.default.rp_filter=0,net.netfilter.nf_conntrack_max=2000000,vm.swappiness=10

2. libvirt

+ tải ca-certificates
+ add ceph key https://download.ceph.com/keys/release.asc
+ thêm repo ceph

#### openvswitch

#### ocata-neutron-compute

#### ovs-bridge

#### ceph-compute

#### install-docker-tools

#### openstack-compute-agent-compose

#### pull-docker-image

#### disable-openstack-host-process

#### start_services

#### filebeat

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
