Mật khẩu các dịch vụ tại `group_vars`

### Chạy tags pre-setup

#### Disable login notify
#### sshusersp2_dont_use
#### sshpolicy
#### sshnotify
#### utilitytools
#### chrony
#### unattended-upgrades
#### disable-auto-upgrade

### Cài đặt gói cần thiết

#### wallaby-package

       sudo apt install software-properties-common ubuntu-cloud-keyring
       sudo apt-add-repository 'deb http://ubuntu-cloud.archive.canonical.com/ubuntu focal-updates/wallaby main'
       sudo apt install python3-openstackclient

#### public-nova-compute-ubuntu20
       sysctl >> libvirt >> nova-user >> nova-compute >> nova-user

1. sysctl

       sudo modprobe nf_conntrack

   Cấu hình `/etc/sysctl.conf`

       net.ipv4.conf.all.rp_filter=0
       net.ipv4.conf.default.rp_filter=0
       net.netfilter.nf_conntrack_max=2000000
       vm.swappiness=10

2. libvirt

       sudo apt install ca-certificates
       wget -qO - https://download.ceph.com/keys/release.asc | sudo apt-key add -
       sudo apt-add-repositorory 'deb https://download.ceph.com/debian-pacific/ focal main'
       sudo mkdir /tmp/packages_ceph

   Tạo script install `/tmp/packages_ceph/install_ceph_ubuntu.sh

       wget https://download.ceph.com/debian-16.2.13/pool/main/c/ceph/
       for i in `cat index.html |grep 16.2.13-1focal | awk -F ">" '{print $2}' | awk
        -F "<" '{print $1}' | grep "librbd1\|librados2" | grep -v "dbg\|arm64"`;do wget https://download.ceph.
       com/debian-16.2.13/pool/main/c/ceph/${i};done

   Chạy script `sudo bash /tmp/packages_ceph/install_ceph_ubuntu.sh`

   Install package `sudo dpkg -i *.deb`

   Dọn thư mục `sudo rm -r /tmp/packages_ceph/*`

   Copy file từ ansible

       sudo rsync -azv roles/public-nova-compute-ubuntu20/files/qemu-block-extra_1%3a4.2-3ubuntu6.21_amd64.deb,qemu-utils_1%3a4.2-3ubuntu6.21_amd64.deb,qemu-system-common_1%3a4.2-3ubuntu6.21_amd64.deb,qemu-system-x86_1%3a4.2-3ubuntu6.21_amd64.deb,qemu-kvm_1%3a4.2-3ubuntu6.21_amd64.deb,libvirt0_6.0.0-0ubuntu8.16_amd64.deb,libvirt-clients_6.0.0-0ubuntu8.16_amd64.deb,libvirt-daemon-driver-qemu_6.0.0-0ubuntu8.16_amd64.deb,libvirt-daemon-driver-storage-rbd_6.0.0-0ubuntu8.16_amd64.deb,libvirt-daemon_6.0.0-0ubuntu8.16_amd64.deb,libvirt-daemon-system-systemd_6.0.0-0ubuntu8.16_amd64.deb,libvirt-daemon-system_6.0.0-0ubuntu8.16_amd64.deb,libvirt-dev_6.0.0-0ubuntu8.16_amd64.deb,python3-libvirt_6.1.0-1_amd64.deb,virt-top_1.0.9-1_amd64.deb,dnsmasq-base_2.80-1.1ubuntu1.5_amd64.deb,nova-common_3%3a23.1.0-0ubuntu1~cloud0_all.deb,python3-nova_3%3a23.1.0-0ubuntu1~cloud0_all.deb,nova-compute-libvirt_3%3a23.1.0-0ubuntu1~cloud0_all.deb,nova-compute-kvm_3%3a23.1.0-0ubuntu1~cloud0_all.deb,nova-compute_3%3a23.1.0-0ubuntu1~cloud0_all.deb ansibledeploy@<ip>://tmp/packages_ceph/

   Install missing dependency `sudo wget https://download.ceph.com/debian-16.2.13/pool/main/c/ceph/libjaeger_16.2.13-1focal_amd64.deb`

   Install package `sudo dpkg -i qemu*.deb libvirt*.deb virt*.deb python3-lib*.deb dns*.deb libja*.deb`

   Disable, stop, mask libvirt `libvirtd.socket - libvirtd-ro.socket - libvirtd-admin.socket - libvirtd-tls.socket - libvirtd-tcp.socket`

   Cấu hình `/etc/libvirt/libvirtd.conf`

       listen_tls = 0
       listen_tcp = 1
       auth_tcp = "none"
       unix_sock_group = "libvirt"
       unix_sock_rw_perms = "0770"
       auth_unix_ro = "none"
       auth_unix_rw = "none"

   Restart `libvirtd`

   Cấu hình `/etc/default/libvirtd`

       start_libvirtd="yes"
       libvirtd_opts="-l"
       LIBVIRTD_ARGS="--listen"

4. nova-user

       sudo useradd -m -d /var/lib/nova -s /bin/bash -r nova
       sudo mkdir /var/lib/nova/.ssh
       sudo chmod 0700 /var/lib/nova/.ssh && sudo chown nova:nova /var/lib/nova/.ssh

   Cấu hình `/var/lib/nova/.ssh/config` theo `nova_ssh_config.j2`

   Copy ssh key `sudo rsync -azv group_vars/id_rsa* ansibledeploy@<ip>://var/lib/nova/.ssh/`

   Cấu hình `/var/lib/nova/.ssh/authorized_keys` theo `group_vars/id_rsa.pub`
   
5. nova-compute

       sudo apt install tuned
       sudo tuned-adm profile network-latency
       sudo dpkg -i nova*.deb libs*.deb

   Cấu hình `/etc/nova/nova.conf` theo `nova.conf.j2`

   Cấu hình `/etc/nova/nova-compute.conf` theo `nova-compute.conf.j2`

       sudo chown nova:nova /var/lib/nova/instances

#### openvswitch

openvswitch_version: 2.8.0

Copy file `sudo rsync -azv roles/openvswitch/files/* ansibledeploy@<ip>://tmp/`

Tải thêm packagepackage `sudo wget https://ftp.debian.org/debian/pool/main/s/six/python-six_1.12.0-1_all.deb`

Install package `sudo dpkg -i python-six_1.12.0-1_all.deb`

Install package `sudo dpkg -i *_2.8.0.deb`

#### ocata-neutron-compute

       apt-mark hold openvswitch* python3-openvswitch

Install package `sudo apt install neutron-openvswitch-agent`

Cấu hình `/etc/neutron/neutron.conf` theo `neutron.conf.new.j2`

Chạy ansible lấy mk 

Cấu hình `/etc/neutron/plugins/ml2/openvswitch_agent.ini` theo `openvswitch_agent.ini.j2`

chạy ansible lấy management_address

#### ovs-bridge

Thêm bridge `sudo ovs-vsctl add-br br-prv`

Thêm port ch bridge `sudo ovs-vsctl add-port br-prv bond0`

#### ceph-compute

Các package cho ceph đã được thêm ở trên

Cấu hình `/etc/ceph/ceph.conf` theo `ceph.conf.j2`

Cấu hình key `/etc/ceph/ceph.client.cinder.keyring` theo `ceph.client.cinder.keyring.j2`

Tạo file `/tmp/secret.xml` theo `secret.xml.j2`

       sudo virsh secret-define --file /tmp/secret.xml
Tạo file `/tmp/run.sh` theo `run.sh.j2`

       sudo bash /tmp/run.sh

Thêm key và user vào `/etc/nova/nova.conf`

       rbd_user = cinder
       rbd_secret_uuid = {{ ceph_nova_uuid }}

Restart `nova-compute`

#### install-docker-tools

       sudo apt install docker.io python-setuptools

Cấu hình `/etc/docker/daemon.json` theo `daemon.json.j2`

       sudo apt install docker-compose
       sudo systemctl enable docker
       sudo pip install 'docker>=2.6,<3.0.0'
       sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
       sudo chown root:root /usr/local/bin/docker-compose && sudo chmod 0755 /usr/local/bin/docker-compose
       sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

#### openstack-compute-agent-compose

       sudo mkdir /opt/cloudv2

Tạo file `/opt/cloudv2/docker-compose.yml` theo `docker-compose.yml.j2`

#### pull-docker-image

Đăng nhập hub sử dụng tk,mk -- chạy ansible để có mk và pull luôn image :v


#### disable-openstack-host-process

       sudo systemctl stop nova-compute
       sudo systemctl disable nova-compute
       sudo systemctl mask nova-compute

#### start_services

       sudo apt install python3-docker
       sudo systemctl enable docker
       docker-compose -f /opt/cloudv2/docker-compose.yml up -d

#### filebeat

       sudo rsync -azv roles/filebeat/files/filebeat-7.15.1-amd64.deb ansibledeploy@<ip>://tmp/
       sudo dpkg -i filebeat-7.15.1-amd64.deb

Cấu hình `/etc/filebeat/filebeat.yml`

```
filebeat.inputs:
- type: log
  paths:
    - /var/log/apache2/*.log
  document_type: apache
- type: log
  paths:
    - /var/log/auth.log
    - /var/log/secure
  document_type: auth
- type: log
  paths:
    - /var/log/boot.log
  document_type: boot
- type: log
  paths:
    - /var/log/btmp
  document_type: btmp
- type: log
  paths:
    - /var/log/ceilometer/*.log
  document_type: ceilometer
- type: log
  paths:
    - /var/log/ceph/*.log
  document_type: ceph
- type: log
  paths:
    - /var/log/cinder/*.log
  document_type: cinder
- type: log
  paths:
    - /opt/cloud-email-service/log/production.log
  document_type: cloud-mail
- type: log
  paths:
    - /var/log/cron
  document_type: cron
- type: log
  paths:
    - /opt/billing/log/*.log
  document_type: dashboard-billing
- type: log
  paths:
    - /opt/server/log/*.log
  document_type: dashboard-server
- type: log
  paths:
    - /var/log/dmesg
  document_type: dmsg
- type: log
  paths:
    - /var/log/dpkg.log
  document_type: dpkg
- type: log
  paths:
    - /var/log/thor-event/*.log
  document_type: thor-event
- type: log
  paths:
    - /var/log/vm-datatransfer-staging/*.log
  document_type: vm-datatransfer-staging
- type: log
  paths:
    - /var/log/vm-datatransfer/*.log
  document_type: vm-datatransfer
- type: log
  paths:
    - /var/log/loadbalancer/*.log
  document_type: loadbalancer
- type: log
  paths:
    - /var/log/lb-staging/*.log
  document_type: lb-staging
- type: log
  paths:
    - var/log/fsck/*
  document_type: fsck
- type: log
  paths:
    - /var/log/glance/*.log
  document_type: glance
- type: log
  paths:
    - /var/log/haproxy.log
  document_type: haproxy
- type: log
  paths:
    - /var/log/heat/*.log
  document_type: heat
- type: log
  paths:
    - /var/log/kern.log
  document_type: kern
- type: log
  paths:
    - /var/log/keystone/*.log
  document_type: keystone
- type: log
  paths:
    - /var/log/libvirt/*.log
    - /var/log/libvirt/qemu/*.log
  document_type: libvirt
- type: log
  paths:
    - /var/log/mail.log
  document_type: mail
- type: log
  paths:
    - /var/log/mcollective.log
  document_type: mcollective
- type: log
  paths:
    - /var/log/messages
  document_type: syslog
- type: log
  paths:
    - /var/log/mistral/*.log
  document_type: mistral
- type: log
  paths:
    - /var/log/mongodb/*.log
  document_type: mongo
- type: log
  paths:
    - /var/log/mysql/*.log
  document_type: mysql
- type: log
  paths:
    - /var/log/neutron/*.log
  document_type: neutron
  tags: ["neutron"]
- type: log
  paths:
    - /var/log/nova/*.log
  document_type: nova
- type: log
  paths:
    - /var/log/octavia/*.log
  document_type: octavia
- type: log
  paths:
    - /var/log/openvswitch/*.log
  document_type: openvswitch
- type: log
  paths:
    - /var/log/mysqld.log
  document_type: mysql-percona
- type: log
  paths:
    - /var/log/rabbitmq/*.log
    - /var/log/rabbitmq/startup_err
  document_type: rabbitmq
- type: log
  paths:
    - /opt/emc/scaleio/gateway/logs/api_operations.log
    - /opt/emc/scaleio/gateway/logs/scaleio.log
    - /opt/emc/scaleio/gateway/logs/operations.log
  document_type: scaleio_gateway
- type: log
  paths:
    - /opt/emc/scaleio/mdm/logs/trc.0
    - /opt/emc/scaleio/mdm/logs/exp.0
  document_type: scaleio_mdm
- type: log
  paths:
    - /var/log/senlin/*.log
  document_type: senlin
- type: log
  paths:
    - /var/log/syslog
  document_type: syslog
- type: log
  paths:
    - /var/log/trove/*.log
  document_type: trove
- type: log
  paths:
    - /var/log/upstart/*.log
  document_type: upstart
- type: log
  paths:
    - /var/log/openvpn/openvpn-auth.log
  document_type: vpnstaff
- type: log
  paths:
    - /opt/webmail/logs/*.log
  document_type: webmail
- type: log
  paths:
    - /opt/webmail/log/*.log
  document_type: webmail_a
- type: log
  paths:
    - /opt/webmail_b/*.logs
  document_type: webmail_b
- type: log
  paths:
    - /var/log/wtmp
  document_type: wtmp
- type: log
  paths:
    - /var/log/yum.log
  document_type: yum
- type: log
  paths:
    - /var/log/zookeeper/zookeeper.log
  document_type: zookeeper
- type: log
  paths:
    - /var/log/apache2/keystone_access.log
  document_type: apache
  tags: ["keystone_access"]

processors:
  - drop_fields:
      fields: ["host"]
  - copy_fields:
      fields:
        - from: "agent.hostname"
          to: "agent.host"
      fail_on_error: false
      ignore_missing: true
  - rename:
      fields:
        - from: "agent.host"
          to: "host"
      ignore_missing: false
      fail_on_error: true

output.redis:
  hosts: {{ logstash_redis_host }}
  password: "{{ logstash_redis_password }}"
  key: "{{ logstash_namespace }}"
  db: 0
  timeout: 5
```

logstash có trong `group_vars`

       sudo systemctl enable filebeat

#### nagios_nrpe

       sudo apt install monitoring-plugins nagios-plugins nagios-nrpe-server sysstat python2
       sudo rsync -azv roles/nagios_nrpe/files/get-pip.py ansibledeploy@<pip>://tmp/
       python2 get-pip.py
       ~/.local/bin/pip2 install requests
       python2 -m pip install psutil redis
       sudo mkdir /opt/vccloud_check
       sudo rsync -azv roles/nagios_nrpe/files/plugins/* ansibledeploy@<ip>://opt/vccloud_check
       sudo chown nagios:nagios /opt/vccloud_check && sudo chmod 0750 /opt/vccloud_check

Cấu hình `/etc/sudoers.d/nagios_sudoers`

```
Defaults:nagios !requiretty
nagios ALL = (root) NOPASSWD: /usr/sbin/conntrack
nagios ALL = (root) NOPASSWD: /usr/sbin/service
```

Cấu hình `/etc/nagios/nrpe.cfg`

```
log_facility=daemon
pid_file=/var/run/nagios/nrpe.pid
server_port=5666
nrpe_user=nagios
# The adm group is only good for viewing all the log files in /var/log
nrpe_group=adm
allowed_hosts=<ip>,<ip>,...

dont_blame_nrpe=0

allow_bash_command_substitution=0

debug=0
command_timeout={{ command_timeout }}
connection_timeout=300
include=/etc/nagios/nrpe_local.cfg
include_dir=/etc/nagios/nrpe.d/

command[check_users]=/opt/vccloud_check/check_users -w 5 -c 10
command[check_zombie_procs]=/opt/vccloud_check/check_procs -w 5 -c 10 -s Z
command[check_server_load]=/opt/vccloud_check/check_server_load.py -w 1.0,0.8,0.75  -c 1.2,0.9,0.85
command[check_ram]=/opt/vccloud_check/check_mem.pl -w 10 -c 5 -F -A
command[check_rootdisk]=/opt/vccloud_check/check_disk -w 20% -c 10% -p /
command[check_logdisk]=/opt/vccloud_check/check_disk -w 20% -c 10% -p /var/log
command[check_swap]=/opt/vccloud_check/check_swap -a -w 80% -c 50%
command[check_cpu]=/opt/vccloud_check/check_cpu.sh -w 70 -c 80 -iw 20 -ic 30
command[check_total_threads]=/opt/vccloud_check/check_total_threads.sh -C 5000
```

Cấu hình `/etc/sudoers.d/nagios`

```
Defaults:nagios !requiretty
nagios ALL = (root) NOPASSWD: /usr/sbin/conntrack
nagios ALL = (root) NOPASSWD: /usr/sbin/service
```
       sudo systemctl start nagios-nrpe-server
       
#### splunk_forwarder

       sudo rsync -azv roles/splunk_forwarder/files/splunkforwarder-8.0.2.1-f002026bad55-linux-2.6-amd64.deb ansibledeploy@<ip>://tmp/
       sudo dpkg -i splunkforwarder-8.0.2.1-f002026bad55-linux-2.6-amd64.deb

Cấu hình `/opt/splunkforwarder/etc/splunk-launch.conf`

       SPLUNK_SERVER_NAME=SplunkForwarder

Cấu hình `/etc/systemd/system/SplunkForwarder.service`

```
[Unit]
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=/opt/splunkforwarder/bin/splunk _internal_launch_under_systemd
LimitNOFILE=65536
SuccessExitStatus=51 52
RestartPreventExitStatus=51
RestartForceExitStatus=52
KillMode=mixed
KillSignal=SIGINT
TimeoutStopSec=10min
User=root
Delegate=true
CPUShares=1024
PermissionsStartOnly=true

[Install]
WantedBy=multi-user.target
```

       sudo systemctl daemon-reload
       sudo /opt/splunkforwarder/bin/splunk start --accept-license --no-prompt --answer-yes
       sudo /opt/splunkforwarder/bin/splunk enable boot-start -user root

Cấu hình `/opt/splunkforwarder/etc/system/local/inputs.conf`

```
[default]

[monitor:///var/log/messages]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/boot.log]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/dmesg]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/secure]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/yum.log]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/kern.log]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/syslog]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/dpkg.log]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/dmesg]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX
[monitor:///var/log/auth.log]
disabled = 0
sourcetype = OS_LOG
blacklist = \.(?:txt|gz)
index = VCCL_XXXXX

```

       sudo systemctl restart SplunkForwarder

Cấu hình `/opt/splunkforwarder/etc/system/local/outputs.conf`

```
[tcpout]
defaultGroup = vccloud-lb
indexAndForward = false
useACK = true
maxQueueSize = auto
compressed = false
autoLBFrequency = 40

[tcpout:vccloud-lb]
server = <ip>,<ip>,...
```

       sudo systemctl restart SplunkForwarder

Cấu hình `/opt/splunkforwarder/etc/system/local/server.conf`

```
[httpServer]
disableDefaultPort=true
```

       sudo mkdir /opt/splunkforwarder/etc/apps/SplunkUniversalForwarder/local

Cấu hình `/opt/splunkforwarder/etc/apps/SplunkUniversalForwarder/local/limits.conf`

```
[thruput]
maxKBps = 20480
```

       sudo systemctl restart SplunkForwarder
#### telegraf

       sudo apt install libguestfs-tools
       sudo rsync -azv roles/telegraf/files/kvmtop_2.1.3_linux_amd64.deb  ansibledeploy@<ip>://tmp/
       sudo apt install libncurses5
       sudo dpkg -i kvmtop_2.1.3_linux_amd64.deb
       sudo systemctl restart kvmtop
       sudo rsync -azv roles/telegraf/files/telegraf.compute ansibledeploy@<ip>://usr/bin/telegraf

Cấu hình `/etc/systemd/system/telegraf.service`

```
[Unit]
Description=telegraf - A system statistics collector
[Service]
ExecStart=/usr/bin/telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/teleg
raf.d ${TELEGRAF_OPTS}
Restart=always
RestartSec=60
[Install]
WantedBy=multi-user.target
```

Chạy ansible tag telegraf để đầy đủ cấu hình

       sudo systemctl daemon-reload
       sudo mkdir -p /etc/telegraf /etc/telegraf/telegraf.d /var/log/telegraf 

Cấu hình `/etc/telegraf/telegraf.conf`v

```
[global_tags]

# Configuration for telegraf agent
[agent]
  interval = "30s"
  round_interval = true
  metric_batch_size = 5000
  metric_buffer_limit = 50000
  collection_jitter = "0s"
  flush_interval = "30s"
  flush_jitter = "0s"
  precision = ""
  quiet = false
  logfile = "/var/log/telegraf/telegraf.log"
```

Cấu hình `/etc/telegraf/telegraf.d/telegraf_infra.conf`

Cấu hình `/etc/telegraf/telegraf.d/telegraf_cloud.conf`

Chạy ansible :v

#### Enable login notify

Chạy ansible tag post_tasks
