### Openvswitch architecture

![openvswitch architecture](pictures/openvswitch.jpg)

+ ovs-vswitchd:
  - daemon chính của Openvswitch
  - chịu trách nhiệm thực hiện chuyển mạch dữ liệu
  - Xử lý các `flow table` và chuyển tiếp gói tin dựa vào rule trong table
+ ovs-dpctl:
  - công cụ để tạo, sửa và xóa datapath
+ ovs-ofctl
  - công cụ theo dõi và quản trị OpenFlow switch
  - liệt kê các luồng đã triển khai trên OVS kernel
+ ovs-appctl
  - giao tiếp và điều khiển các daemon của OVS
+ ovsdb
  - lưu trữ cấu hình về bridge, port, interface, địa chỉ của OpenFlow controller
  - tổ chức dưới dạng bảng và hàng, tương tự như một cơ sở dữ liệu quan hệ
+ ovsdb-server
  - daemon quản lý cơ sở dữ liệu của OVS
  - cung cấp giao diện RPC(remote procedure call) gọi tới ovsdb
  - có thể chạy như backup server hoặc active server
  - hỗ trợ giao thức OVSDB (Open vSwitch Database Management Protocol) để thực hiện thao tác thêm, sửa, xóa,... trên cơ sở dữ 
+ ovs-vsctl
  - truy vấn và cập nhật cấu hình của ovs-vswitchd (với sự giúp đỡ của ovsdb-server)
+ ovs-dbtool
  - quản lý các cơ sở dữ liệu OVSDB
  - dùng để tạo, kiểm tra, và sửa các file cơ sở dữ liệu
+ Linux kernel module
  - bao gồm openvswitch.ko (chuyển mạch gói tin, xử lý các bảng flow) 
  - datapath (sử dụng các cấu trúc dữ liệu như các bảng hash để quản lý các flow và thực hiện các hành động tương ứng trên các gói tin)

### Flow gói tin 

1. Gói tin đi vào NIC (Network Interface Card) của hệ thống
2. Gói tin chuyển tới openvswitch.ko trong kernel, kiểm tra flow entries trong datapath
3. Nếu không có flow entry phù hợp, gói tin được gửi đến ovs-vswitchd để xử lý, cài đặt thêm flow entry mới nếu cần
4. Gói tin được xử lý theo hành động trong flow entry (Forward, Drop, Modify, Encapsulate)
5. Gói tin được chuyển tới cổng đích và rời khỏi hệ thống qua NIC đích
