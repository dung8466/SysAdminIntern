Tạo volume boot sử dụng SSD3

    openstack volume create --size 20 --type SSD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume

--> ID volume: `fc8655e3-85e9-4099-b441-abc45822f77b`

Tạo server từ volume

    openstack server create --volume fc8655e3-85e9-4099-b441-abc45822f77b --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 --password Rb2arGATpXfaRA2JRHx4cX2 ops-dungnt-test-server

--> ID server: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
Task: fsck ổ cứng

+ Chạy script `map_disk.sh` với lệnh `sudo -E /opt/cephtools/map_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b` 

--> volume device `/dev/nbd0`

+ Chạy lệnh `sudo e2fsck /dev/nbd0p1`

Task: reset passwd

+ Volume device `/dev/nbd0`
+ Mount volume vào `/data`: `sudo mount /dev/nbd0p1 /data`
+ Vào thư mục root của server: `sudo chroot /data`
+ Đổi mật khẩu: `passwd root` và thoát ra `exit`
+ Unmount volume `sudo umount /data`
+ Chạy script `unmap_disk.sh` với lệnh `sudo -E /opt/cephtools/unmap_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b`
+ Khởi động server: `openstack server start ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
+ Vào console `openstack console url show ff3930c2-b0f0-4b2e-8b1f-cae260930a72` và thử mật khẩu

Task: Thực hiện tăng dung lượng ổ rootdisk nodowntime thêm 10GB

+ Thực hiện tăng dung lượng từ 20GB

      openstack volume set --os-volume-api-version 3.42 fc8655e3-85e9-4099-b441-abc45822f77b --size 30

+ Kiểm tra dung lượng sau khi tăng

      openstack volume show fc8655e3-85e9-4099-b441-abc45822f77b
+ Tăng dung lương trong server

        growpart /dev/vda 1   
 
        resize2fs /dev/vda1

Task: học lệnh check log, vào VNC console của một VM để thao tác khi không SSH được

+ Lấy ID server:

      openstack server list
--> ID: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
+ Check log:

      openstack console log show ff3930c2-b0f0-4b2e-8b1f-cae260930a72

+ Vào VNC console:

      openstack console url show ff3930c2-b0f0-4b2e-8b1f-cae260930a72
