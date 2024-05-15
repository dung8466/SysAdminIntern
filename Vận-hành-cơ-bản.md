### Tạo server 1 sử dụng SSD3

+ Tạo volume boot

        openstack volume create --size 20 --type SSD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume

  --> ID volume: `fc8655e3-85e9-4099-b441-abc45822f77b`

+ Tạo server từ volume

        openstack server create --volume fc8655e3-85e9-4099-b441-abc45822f77b --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 ops-dungnt-test-server

  --> ID server: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`

### Tạo server 2 sử dụng SSD3

+ Tạo volume boot

        openstack volume create --size 30 --type SSD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume

  --> ID volume: `f426365c-5671-44fc-b5ae-47a6c33f2fb2`

+ Tạo server từ volume

        openstack server create --volume f426365c-5671-44fc-b5ae-47a6c33f2fb2 --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 ops-dungnt-test-server2

  --> ID server: `22a6155c-197f-4218-b82b-9df7f25b52f2`

### Tạo server 3 sử dụng HDD3

+ Tạo volume boot

        openstack volume create --size 30 --type HDD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume3

  --> ID volume: `745e11ed-71b1-477e-a83c-8205c00e696c`

+ Tạo server từ volume

        openstack server create --volume 745e11ed-71b1-477e-a83c-8205c00e696c --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 ops-dungnt-test-server3

    --> ID volume: `5a17a11c-4a38-4dc3-aa8e-615842af4bad`

#### Task 1: fsck ổ cứng

+ Chạy script `map_disk.sh` với lệnh `sudo -E /opt/cephtools/map_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b`

  hoặc sử dụng lệnh `rbd-ndb map SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b -c /etc/ceph/ceph.conf -n client.autobackup`

  --> volume device `/dev/nbd0`

+ Chạy lệnh `sudo e2fsck /dev/nbd0p1`

#### Task 2: reset passwd

+ Volume device `/dev/nbd0`

+ Mount volume vào `/data`: `sudo mount /dev/nbd0p1 /data`

+ Vào thư mục root của server: `sudo chroot /data`

+ Đổi mật khẩu: `passwd root` và thoát ra `exit`

+ Unmount volume `sudo umount /data`

+ Chạy script `unmap_disk.sh` với lệnh `sudo -E /opt/cephtools/unmap_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b`

  hoặc sử dụng lệnh `rbd-ndb unmap SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b -c /etc/ceph/ceph.conf -n client.autobackup`

+ Khởi động server: `openstack server start ff3930c2-b0f0-4b2e-8b1f-cae260930a72`

+ Vào console `openstack console url show ff3930c2-b0f0-4b2e-8b1f-cae260930a72` và thử mật khẩu

#### Task 3: Đổi IP của 2 server

+ Liệt kê port của 2 server

        openstack port list --server ff3930c2-b0f0-4b2e-8b1f-cae260930a72
        openstack port list --server 22a6155c-197f-4218-b82b-9df7f25b52f2

  --> port ID: `13cee214-e201-4479-a500-a774e92d5bb0` và `360cefee-0211-4397-bbcb-d541a96ad98b`

+ Tháo port của 2 server

        openstack server remove port ff3930c2-b0f0-4b2e-8b1f-cae260930a72 13cee214-e201-4479-a500-a774e92d5bb0
        openstack server remove port 22a6155c-197f-4218-b82b-9df7f25b52f2 360cefee-0211-4397-bbcb-d541a96ad98b

+ Hoán đổi port của 2 server

        openstack server add port ff3930c2-b0f0-4b2e-8b1f-cae260930a72 360cefee-0211-4397-bbcb-d541a96ad98b
        openstack server add port 22a6155c-197f-4218-b82b-9df7f25b52f2 13cee214-e201-4479-a500-a774e92d5bb0


#### Task 5: Tạo VIP cho 2 server

+ Tạo port VIP:

        openstack port create --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 VIP_10.5.9.164_10.5.9.54_dungntops_test

  --> port VIP: `c191f593-fd15-43f2-973d-f024d6229b3d | VIP_10.5.9.164_10.5.9.54_dungntops_test | fa:16:3e:73:b5:68 | ip_address='10.5.8.106', subnet_id='a618f837-00b2-4f95-b0fd-580ef1c0f426' `                 

+ Liệt kê các port của 2 server

        openstack port list --server ff3930c2-b0f0-4b2e-8b1f-cae260930a72
        openstack port list --server 22a6155c-197f-4218-b82b-9df7f25b52f2

  --> port ID: `13cee214-e201-4479-a500-a774e92d5bb0` và `360cefee-0211-4397-bbcb-d541a96ad98b`

+ Cho phép VIP vào port

        openstack port set --allowed-address ip-address=10.5.8.106 13cee214-e201-4479-a500-a774e92d5bb0
        openstack port set --allowed-address ip-address=10.5.8.106 360cefee-0211-4397-bbcb-d541a96ad98b
+ Thêm mô tả VIP cho server

        openstack server set --property server_have_VIP='10.5.8.106' ff3930c2-b0f0-4b2e-8b1f-cae260930a72
        openstack server set --property server_have_VIP='10.5.8.106' 22a6155c-197f-4218-b82b-9df7f25b52f2

#### Task 4: Tạo snapshot và restore

+ Tạo snapshot: `rbd snap create SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@ops-dungnt-snapshot-test`

+ Kiểm tra snapshot vừa tạo: `rbd snap ls SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b`

        SNAPID   NAME                      SIZE    PROTECTED  TIMESTAMP
        1509249  ops-dungnt-snapshot-test  30 GiB             Thu May  9 14:25:41 2024

+ Tạo thay đổi trên server

+ Tắt server: `openstack server stop ff3930c2-b0f0-4b2e-8b1f-cae260930a72`

+ Restore sử dụng snapshot đã tạo: `rbd snap rollback SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@ops-dungnt-snapshot-test`

+ Khởi động lại server: `openstack server start ff3930c2-b0f0-4b2e-8b1f-cae260930a72` và kiểm tra

#### Task 6: Thực hiện tăng dung lượng ổ rootdisk nodowntime thêm 10GB

+ Thực hiện tăng dung lượng từ 20GB

      openstack volume set --os-volume-api-version 3.42 fc8655e3-85e9-4099-b441-abc45822f77b --size 30

+ Kiểm tra dung lượng sau khi tăng

      openstack volume show fc8655e3-85e9-4099-b441-abc45822f77b

+ Tăng dung lương trong server

        growpart /dev/vda 1   
 
        resize2fs /dev/vda1

#### Task 7: học lệnh check log, vào VNC console của một VM để thao tác khi không SSH được

+ Lấy ID server:

      openstack server list

  --> ID: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`

+ Check log:

      openstack console log show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

+ Vào VNC console:

      openstack console url show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

#### Task 8: Clone cùng loại ổ

+ Tạo snapshot volume server 1

        rbd snap create SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@dungntops-snap2 -c /etc/ceph/ceph.conf -n client.autobackup

+ Shutdown server 2

        openstack server stop 22a6155c-197f-4218-b82b-9df7f25b52f2

+ Đổi tên volume server 2 tại CEPH

        rbd rename SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2 SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2-RES -n client.autobackup -c /etc/ceph/ceph.conf

+ Clone volume server 2 từ snapshot đã tạo trên

        rbd clone SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@dungntops-snap2 SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2 -n client.autobackup -c /etc/ceph/ceph.conf

+ Loại bỏ snapshot liên kết với volume server 2

        rbd flatten SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2 -n client.autobackup -c /etc/ceph/ceph.conf

+ Khởi động lại server 2 và kiểm tra

        openstack server start 22a6155c-197f-4218-b82b-9df7f25b52f2 && openstack console url show 22a6155c-197f-4218-b82b-9df7f25b52f2

#### Task 9: Clone khác loại ổ

+ Tắt server 3

        openstack server stop 5a17a11c-4a38-4dc3-aa8e-615842af4bad

+ Snapshot volume server đã tạo trên: `SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@dungntops-snap2`

+ Đổi tên volume server 3 tại CEPH

        rbd rename HDD3/volume-745e11ed-71b1-477e-a83c-8205c00e696c HDD3/volume-745e11ed-71b1-477e-a83c-8205c00e696c_OLD -n client.autobackup -c /etc/ceph/ceph.conf

+ Clone volume server 3 từ snapshot trên

        rbd clone SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@dungntops-snap2 HDD3/volume-745e11ed-71b1-477e-a83c-8205c00e696c -n client.autobackup -c /etc/ceph/ceph.conf

+ Loại bỏ snapshot liên kết với volume server 3

        rbd flatten HDD3/volume-745e11ed-71b1-477e-a83c-8205c00e696c -n client.autobackup -c /etc/ceph/ceph.conf

+ Khởi động lại server 3 và kiểm tra

        openstack server start 5a17a11c-4a38-4dc3-aa8e-615842af4bad && openstack console url show 5a17a11c-4a38-4dc3-aa8e-615842af4bad

#### Task 10: Liệt kê tài nguyên server và instance

##### Các tài nguyên 1 compute node

1. Uptime: Thời gian server hoạt động

2. LA Medium: Trung bình các giá trị Load Average

3. Zombies: Số tiến trình đã hoàn thành công việc nhưng vẫn còn tồn tại

4. Processes: Số tiến trình đang chạy

5. Threads: Tổng số luồng của các tiến trình

6. CPU

+ CPU Usage: Thông số liên quan đến CPU như idle (không dùng), softirq (interupt tạo bởi kernel), iowait (chờ I/O hoàn thành), user usage(thực thi tiến trình user level), nice(thực thi tiến trình độ ưu tiên thấp), system usage (thực thi tiến trình không gian kernel)

+ Load averages: Đo lường trung bình số tiến trình trong hàng chờ của hệ thống trong thời gian ngắn, trung bình và dài.

+ Memory usage: Bộ nhớ trong hệ thống bao gồm tổng, sử dụng, có thể sử dụng, còn trống, cached, bộ nhớ đệm.

+ CPU IRQ: yêu cầu interupt CPU nhận được từ thiết bị ngoại vi của từng core CPU.

+ CPU used: lưu lượng từng core CPU.

+ Processes: Thông số chi tiết tiến trình đang chạy, bị chặn, chờ thực hiện, tổng luồng.

7. Disk IOPS for /dev/$disk

+ Write I/O requests for /dev/$disk: yêu cầu ghi I/O của từng phân vùng.

+ Read I/O requests for /dev/$disk: yêu cầu đọc I/O của từng phân vùng.

+ Write I/O bytes for /dev/$disk: số byte ghi I/O

+ Read I/O bytes: số byte đọc I/O

+ Write I/O time: thời gian ghi I/O

+ Read I/O time: thời gian đọc I/O

7. Network interface stats for $netif

+ Network TX: đo lường lưu lượng dữ liệu được gửi từ một thiết bị mạng ra ngoài

+ Network RX: đo lường lưu lượng dữ liệu một thiết bị mạng nhận từ ngoài

+ Network Packets TX: đo tốc độ truyền dữ liệu của gói tin mạng đã được gửi đi từ một thiết bị mạng

+ Network Packets RX: đo tốc độ truyền dữ liệu của gói tin mạng một thiết bị mạng nhận

+ Network errors TX: đo lường số lượng lỗi xảy ra trong quá trình gửi dữ liệu từ một thiết bị mạng

+ Network errors RX: đo lường số lượng lỗi xảy ra trong quá trình nhận dữ liệu của một thiết bị mạng

+ Network drops TX: đo lường số lượng dữ liệu bị bỏ trong quá trình gửi từ một thiết bị mạng

+ Network drops RX: đo lường số lượng dữ liệu bị bỏ trong quá trình nhận của một thiết bị mạng

8. Kernel

+ Context switches: số tiến trình thay đổi trạng thái 

+ Forks: số tiến trình bản sao được tạo
  
+ File descriptors: liên quan đến tiến trình mở file và tạo kết nối mạng

9. Interrupts

+ Interrupts: CPU xử lý các yêu cầu soft irq.

+ Netfilter conntrack usage: số lượng các mục conntrack (trong tường lửa và NAT) hiện đang được sử dụng trong hệ thống

10. Conntrack

+ Conntrack: số lượng tối đa, tối thiểu số mục entry contrack

11. Network stack (TCP)

+ TCP connections: Kết nối TCP đã kết nối, chờ đợi, thiết lập kết nối và đóng kết nối

+ TCP aborts: hủy kết nối hoặc kết nối không thành công

+ TCP handshake issues: số lượng kết nối TCP đã cố gắng thiết lập, chấp nhận, đã đặt trong trạng thái thành công nhưng bị reset, muốn đặt lại TCP đã kết nối.

+ TCP SYN cookies: sử dụng cookies để xác thực kết nối hợp lệ không trước khi phản hồi

+ ICMP packets: gói tin ICMP gửi hoặc nhận

+ ICMP errors: gói tin ICMP báo lỗi 

+ IPv4 errors: lỗi liên quan đến IPv4

+ IPv6 errors: lỗi liên quan đến IPv6

12. Network stack (UDP)

+ UDP datagrams: lưu lượng giao tiếp UDP nhận và gửi

+ UDP buffer errors: lỗi bộ nhớ đệm

+ UDP errors: lỗi UDP

13. Swap

+ Swap I/O bytes: số lượng byte trao đổi giữa ram và vùng swap

+ Swap usage (bytes): số bytes swap tổng và được sử dụng

14. Disk space usage for /

+ Disk usage for /: tổng dung lượng bộ nhớ và đã sử dụng

+ Disk inodes for /: tổng số inode và đã sử dụng

15. Metrics velocity

+ Delivery time

+ Gather time

+ Written metrics

+ Error rate

##### Căc tài nguyên instance

1. CPU: Phần trăm CPU sử dụng

2. Memory: Tổng số bộ nhớ có trong hệ thống và bộ nhớ đã sử dụng

3. IOPS: tổng lưu lượng đọc ghi I/O của từng ổ đĩa

4. DISK: chi tiết lưu lượng đọc ghi I/O của từng ổ đĩa

5. NETWORK_TX: lưu lượng dữ liệu được gửi từ từng thiết bị mạng ra ngoài

6. NETWORK_RX: lưu lượng dữ liệu nhận của từng thiết bị mạng 

7. TX Packets: số lượng packet gửi từ từng thiết bị mạng ra ngoài

8. RX Packets: số lượng packet nhận của từng thiết bị mạng

9. CPU Steal: phần trăm CPU đánh cắp hoặc bị đánh từ các instance trong cụm

   --> thể hiện thời gian chờ để CPU vậy lý phân bổ, nếu quá cao cần tối ưu cấu hình hệ thống ảo hóa hoặc tăng tài nguyên CPU.

#### Task 11: Restore volume từ trash

+ Xóa server

        openstack server delete 22a6155c-197f-4218-b82b-9df7f25b52f2

+ Chuyển volume sang trash tại ceph

        rbd trash mv SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2

+ Kiểm tra volume tại trash

        rbd trash ls SSD3 -c /etc/ceph/ceph.conf -n client.autobackup | grep f426365c-5671-44fc-b5ae-47a6c33f2fb2

  --> Output `8751fb6271a537 volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2`

+ Tạo 1 volume mới

        openstack volume create --size 30 --type SSD3 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume-restore

  --> ID volume: `6e7fc030-feb6-4280-96d9-dfec19866068`

+ Restore volume từ trash sang volume khác

        rbd trash restore SSD3/8751fb6271a537 --image volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2-REStest -c /etc/ceph/ceph.conf -n client.autobackup

+ Đổi tên volume server mới

        rbd mv SSD3/volume-6e7fc030-feb6-4280-96d9-dfec19866068 SSD3/volume-6e7fc030-feb6-4280-96d9-dfec19866068-ERRtest -c /etc/ceph/ceph.conf -n client.autobackup

+ Đổi tên volume restore từ trash về volume server mới

        rbd mv SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2-REStest SSD3/volume-6e7fc030-feb6-4280-96d9-dfec19866068 -c /etc/ceph/ceph.conf -n client.autobackup

+ Tạo server mới với volume và kiểm tra dữ liệu

        openstack server create --volume 6e7fc030-feb6-4280-96d9-dfec19866068 --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 ops-dungnt-test-server2-res

  --> ID server: `549c4cae-270d-46d5-917b-d10a3a9384a2`

        openstack console url show 549c4cae-270d-46d5-917b-d10a3a9384a2

#### Task 12: Cold/Live migrate server sang node khác

+ Kiểm tra server đang ở node nào

        openstack server show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

  --> Node `iron-compute-018`

+ Kiểm tra node phù hợp qua [grafana](https://metrics.vccloud.vn)

  --> Node `iron-compute-078`

+ Live migrate

        openstack server migrate --live-migration --host iron-compute-078 --os-compute-api-version 2.30 ff3930c2-b0f0-4b2e-8b1f-cae260930a72

+ Kiểm tra server sau quá trình

        openstack server show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

  --> Node mới `iron-compute-078`

#### Task 13: Tăng quota cho CS-Production

+ Tìm kiếm project cần tăng

        openstack project list | grep CS-Production

  --> Project `af3263d460c442d5a26f79132c915926 | cloudprivate@vccloud.vn_[CS-Production]_production `

+ Kiểm tra quota của project

        openstack quota show af3263d460c442d5a26f79132c915926

    --> ` gigabytes_HDD2           | 19990`, `instances                | 10010`

+ Tăng thêm 10 instance, 100GB loại ổ HDD2

        openstack quota set --gigabytes 20090 --volume-type HDD2 --instances 10020 af3263d460c442d5a26f79132c915926

#### Task 14: Boot vào iso của server

+ Stop server tại admin

        openstack server stop 54ea7504-ec0e-4ad3-8880-03c8e7b7e76c

+ Lấy instance của server

        openstack server show 54ea7504-ec0e-4ad3-8880-03c8e7b7e76c

  --> `instance-0000b4f8`

+ Tải image về máy

        wget http://mirror.bizflycloud.vn/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso

+ Edit `instance-0000b4f8`

        virsh edit instance-0000b4f8

  Nội dung:

  ```
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <source file='/home/ansibledeploy/CentOS-7-x86_64-Minimal-2009.iso'/>
      <target dev='hdd' bus='ide'/>
      <readonly/>
      <address type='drive' controller='0' bus='1' target='0' unit='1'/>
    </disk>
  ```

  ```
  <os>
  <type arch='x86_64' machine='pc-i440fx-trusty'>hvm</type>
  <boot dev='cdrom'/>
  <boot dev='hd'/>
  <smbios mode='sysinfo'/>
  </os>
  ```

+ Set start server sang active và khởi động sử dụng `virsh`

        openstack server set --state active 54ea7504-ec0e-4ad3-8880-03c8e7b7e76c
        virsh start instance-0000b4f8

+ Vào VNC kiểm tra

        openstack console url show 54ea7504-ec0e-4ad3-8880-03c8e7b7e76c

#### Task 15: Evacuate

Nếu có vấn đề xảy ra với node compute, có thể `evacuate` (sơ tán) các instance trên node sang các node còn hoạt động.

Server `evacuate` sẽ được `rebuild` trên node mới, dữ liệu trên volume cấu hình `shared storage` sẽ được bảo toàn.

Nếu server được tạo từ `image`, volume không cấu hình `shared storage`, server sẽ được `rebuild` sử dụng `image` gốc, vẫn giữ lại `port`.

Nếu server sử dụng volume để boot, volume sẽ được tái sử dụng cho server rebuild.

+ Kiểm tra trạng thái `nova-compute` trên `hulk-compute-025`

        openstack compute service list | grep hulk-compute-025

+ Set `nova-compute` down

        openstack compute service set --down hulk-compute-025 nova-compute

+ Evacuate server trên node

        nova host-evacuate hulk-compute-025

        nova CLI is deprecated and will be a removed in a future release
        +--------------------------------------+-------------------+---------------+
        | Server UUID                          | Evacuate Accepted | Error Message |
        +--------------------------------------+-------------------+---------------+
        | 1a416870-5402-44f7-8368-e4b58e6e9c19 | True              |               |
        +--------------------------------------+-------------------+---------------+

+ Kiểm tra lại server

        openstack server show 1a416870-5402-44f7-8368-e4b58e6e9c19

  --> Node mới `hulk-compute-076`

+ Tại node cũ, kiểm tra instance còn chạy không. Tắt instance còn chạy.

        virsh destroy instance-0000b504
