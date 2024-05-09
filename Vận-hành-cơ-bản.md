### Tạo server 1 sử dụng SSD3

+ Tạo volume boot

        openstack volume create --size 20 --type SSD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume

--> ID volume: `fc8655e3-85e9-4099-b441-abc45822f77b`

+ Tạo server từ volume

        openstack server create --volume fc8655e3-85e9-4099-b441-abc45822f77b --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 --password Rb2arGATpXfaRA2JRHx4cX2 ops-dungnt-test-server

--> ID server: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`

### Tạo server 2 sử dụng SSD3

+ Tạo volume boot

        openstack volume create --size 30 --type SSD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume

--> ID volume: `f426365c-5671-44fc-b5ae-47a6c33f2fb2`

+ Tạo server từ volume

        openstack server create --volume f426365c-5671-44fc-b5ae-47a6c33f2fb2 --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 --password Rb2arGATpXfaRA2JRHx4cX2 ops-dungnt-test-server2

--> ID server: `22a6155c-197f-4218-b82b-9df7f25b52f2`
### Tạo server 3 sử dụng HDD3

+ Tạo volume boot

        openstack volume create --size 30 --type HDD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume3

--> ID volume: `745e11ed-71b1-477e-a83c-8205c00e696c`
+ Tạo server từ volume

        openstack server create --volume 745e11ed-71b1-477e-a83c-8205c00e696c --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 --password Rb2arGATpXfaRA2JRHx4cX2 ops-dungnt-test-server3

--> ID volume: `5a17a11c-4a38-4dc3-aa8e-615842af4bad`

1. Task: fsck ổ cứng

+ Chạy script `map_disk.sh` với lệnh `sudo -E /opt/cephtools/map_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b` 

--> volume device `/dev/nbd0`

+ Chạy lệnh `sudo e2fsck /dev/nbd0p1`

2. Task: reset passwd

+ Volume device `/dev/nbd0`
+ Mount volume vào `/data`: `sudo mount /dev/nbd0p1 /data`
+ Vào thư mục root của server: `sudo chroot /data`
+ Đổi mật khẩu: `passwd root` và thoát ra `exit`
+ Unmount volume `sudo umount /data`
+ Chạy script `unmap_disk.sh` với lệnh `sudo -E /opt/cephtools/unmap_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b`
+ Khởi động server: `openstack server start ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
+ Vào console `openstack console url show ff3930c2-b0f0-4b2e-8b1f-cae260930a72` và thử mật khẩu

4. Task: Tạo snapshot và restore

+ Tạo snapshot: `rbd snap create SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@ops-dungnt-snapshot-test`
+ Kiểm tra snapshot vừa tạo: `rbd snap ls SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b`

        SNAPID   NAME                      SIZE    PROTECTED  TIMESTAMP
        1509249  ops-dungnt-snapshot-test  30 GiB             Thu May  9 14:25:41 2024
+ Tạo thay đổi trên server
+ Tắt server: `openstack server stop ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
+ Restore sử dụng snapshot đã tạo: `rbd snap rollback SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@ops-dungnt-snapshot-test`
+ Khởi động lại server: `openstack server start ff3930c2-b0f0-4b2e-8b1f-cae260930a72` và kiểm tra

5. Task: Tạo VIP cho 2 server

+ Tạo port VIP:

        openstack port create --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 VIP_10.5.9.164_10.5.9.54_dungntops_test

--> port VIP: c191f593-fd15-43f2-973d-f024d6229b3d | VIP_10.5.9.164_10.5.9.54_dungntops_test | fa:16:3e:73:b5:68 | ip_address='10.5.8.106', subnet_id='a618f837-00b2-4f95-b0fd-580ef1c0f426'                  

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

6. Task: Thực hiện tăng dung lượng ổ rootdisk nodowntime thêm 10GB

+ Thực hiện tăng dung lượng từ 20GB

      openstack volume set --os-volume-api-version 3.42 fc8655e3-85e9-4099-b441-abc45822f77b --size 30

+ Kiểm tra dung lượng sau khi tăng

      openstack volume show fc8655e3-85e9-4099-b441-abc45822f77b
+ Tăng dung lương trong server

        growpart /dev/vda 1   
 
        resize2fs /dev/vda1

7. Task: học lệnh check log, vào VNC console của một VM để thao tác khi không SSH được

+ Lấy ID server:

      openstack server list
--> ID: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
+ Check log:

      openstack console log show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

+ Vào VNC console:

      openstack console url show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

8. Clone cùng loại ổ

+ Tạo snapshot volume server 1

        rbd snap create SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@dungntops-snap2 -c /etc/ceph/ceph.conf -n client.autobackup
+ Shutdown server 2

        openstack server stop 22a6155c-197f-4218-b82b-9df7f25b52f2
+ Đổi tên volume server 2

        rbd rename SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2 SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2-RES -n client.autobackup -c /etc/ceph/ceph.conf
+ Clone volume server 2 từ snapshot đã tạo trên

        rbd clone SSD3/volume-fc8655e3-85e9-4099-b441-abc45822f77b@dungntops-snap2 SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2 -n client.autobackup -c /etc/ceph/ceph.conf
+ Loại bỏ snapshot liên kết với volume server 2

        rbd flatten SSD3/volume-f426365c-5671-44fc-b5ae-47a6c33f2fb2 -n client.autobackup -c /etc/ceph/ceph.conf
+ Khởi động lại server 2 và kiểm tra

        openstack server start 22a6155c-197f-4218-b82b-9df7f25b52f2 && openstack console url show 22a6155c-197f-4218-b82b-9df7f25b52f2
