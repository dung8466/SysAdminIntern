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
+ ovsdb-server
  - daemon quản lý cơ sở dữ liệu của OVS
  - lưu trữ cấu hình switch và các cấu hình mạng liên quan
  - hỗ trợ giao thức OVSDB (Open vSwitch Database Management Protocol) để thực hiện thao tác thêm, sửa, xóa,... trên cơ sở dữ 
+ ovsdb
  - 
+ ovs-vsctl
  - truy vấn và cập nhật cấu hình của ovs-vswitchd (với sự giúp đỡ của ovsdb-server)
+ ovs-dbtool
+ Linux kernel module
