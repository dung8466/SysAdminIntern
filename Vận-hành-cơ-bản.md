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
