Tạo volume boot sử dụng SSD3

    openstack volume create --size 20 --type SSD3 --image 954b96ca-ad41-45df-9cae-40cbe03654f7 --availability-zone VC-HaNoi-HN2 --bootable ops-dungnt-test-volume

--> ID volume: `fc8655e3-85e9-4099-b441-abc45822f77b`

Tạo server từ volume

    openstack server create --volume fc8655e3-85e9-4099-b441-abc45822f77b --flavor cc589efb-b986-4b7b-aa90-e6eb92186997 --network e1b7e892-8832-4fe4-b7a7-bc29219f7c98 --availability-zone VC-HaNoi-HN2 --password Rb2arGATpXfaRA2JRHx4cX2 ops-dungnt-test-server

--> ID server: `ff3930c2-b0f0-4b2e-8b1f-cae260930a72`
Task: fsck ổ cứng

+ Chạy script `map_disk.sh` với lệnh `sudo -E /opt/cephtools/map_disk.sh fc8655e3-85e9-4099-b441-abc45822f77b` 

--> volume mount vào `/dev/nbd0`

+ Chạy lệnh `sudo e2fsck /dev/nbd0p1`

Task: Thực hiện tăng dung lượng ổ rootdisk nodowntime thêm 10GB

+ Lấy ID của volume cần tăng dung lượng

      openstack volume list

--> ID: `f5e6c5c6-f587-4117-89cd-a3fe159a094e` và dung lượng hiện tại 40GB
+ Thực hiện tăng dung lượng

      openstack volume set --os-volume-api-version 3.42 f5e6c5c6-f587-4117-89cd-a3fe159a094e --size 50

+ Kiểm tra dung lượng sau khi tăng

      openstack volume show f5e6c5c6-f587-4117-89cd-a3fe159a094e

Task: học lệnh check log, vào VNC console của một VM để thao tác khi không SSH được

+ Lấy ID server:

      openstack server list
--> ID: `bc8efd20-8b5e-40ee-a6f5-0d8d1b07afbb`
+ Check log:

      openstack console log show bc8efd20-8b5e-40ee-a6f5-0d8d1b07afbb

+ Vào VNC console:

      openstack console url show bc8efd20-8b5e-40ee-a6f5-0d8d1b07afbb
