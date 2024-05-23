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
       sudo apt-add-reposity 'deb https://download.ceph.com/debian-pacific/ focal main'
       sudo mkdir /tmp/packages_ceph

   Tạo script install `/tmp/packages_ceph/install_ceph_ubuntu.sh

       wget https://download.ceph.com/debian-16.2.13/pool/main/c/ceph/
       for i in `cat index.html |grep 16.2.13-1focal | awk -F ">" '{print $2}' | awk
        -F "<" '{print $1}' | grep "librbd1\|librados2" | grep -v "dbg\|arm64"`;do wget https://download.ceph.
       com/debian-16.2.13focal/pool/main/c/ceph/${i};done

   Chạy script `sudo bash /tmp/packages_ceph/install_ceph_ubuntu.sh`

   Install package `sudo dpkg -i *.deb`

   Dọn thư mục `sudo rm -r /tmp/packages_ceph/*`

   Copy file từ ansible `sudo rsync -azv roles/public-nova-compute-ubuntu20/files/* ansibledeploy@<ip>://tmp/packages_ceph/`

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

3. nova-user

       sudo useradd -m -d /var/lib/nova -s /bin/bash -r nova
       sudo mkdir /var/lib/nova/.ssh
       sudo chmod 0700 /var/lib/nova/.ssh && sudo chown nova:nova /var/lib/nova/.ssh

   Cấu hình `/var/lib/nova/.ssh/config` theo `nova_ssh_config.j2`

   Copy ssh key `sudo rsync -azv group_vars/id_rsa* ansibledeploy@<ip>://var/lib/nova/.ssh/`

   Cấu hình `/var/lib/nova/.ssh/authorized_keys` theo `group_vars/id_rsa.pub`
   
4. nova-compute

       sudo apt install tuned
       sudo tuned-adm profile network-latency
       sudo dpkg -i nova*.deb libs*.deb

   Cấu hình `/etc/nova/nova.conf` theo `nova.conf.j2`

   Cấu hình `/etc/nova/nova-compute.conf` theo `nova-compute.conf.j2`

       sudo chown nova:nova /var/lib/nova/instances

#### openvswitch

openvswitch_version: 2.8.0

Copy file `sudo rsync -azv roles/openvswitch/files/* ansibledeploy@<ip>://tmp/`

Install package `sudo dpkg -i *_2.8.0.deb`

#### ocata-neutron-compute

       apt-mark hold openvswitch* python3-openvswitch

Install package `sudo apt install neutron-openvswitch-agent`

Cấu hình `/etc/neutron/neutron.conf` theo `neutron.conf.new.j2`

Cấu hình `/etc/neutron/plugins/ml2/openvswitch_agent.ini` theo `openvswitch_agent.ini.j2`

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
       sudo mask nova-compute

#### start_services

       sudo apt install python3-docker
       sudo systemctl enable docker
       docker-compose -f /opt/cloudv2/docker-compose.yml up -d

#### filebeat



#### nagios_nrpe



#### splunk_forwarder
#### telegraf
#### Enable login notify
