### Openvswitch architecture

![openvswitch architecture](pictures/openvswitch.jpg)

+ ovs-vswitchd:
  - daemon chính của Openvswitch
  - chịu trách nhiệm thực hiện chuyển mạch dữ liệu
  - Xử lý các `flow table` và chuyển tiếp gói tin dựa vào rule trong table
+ SDN (Software Defined Networking)
  - tương tác trực tiếp với các tầng chuyển mạch (switch) và định tuyến (router) của mạng
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

1. Ingress (Đầu vào): Khi một gói tin đến cổng OVS, nó sẽ đi vào datapath của OVS.
2. Classification (Phân loại): Gói tin được phân loại dựa trên các header của nó. Quá trình phân loại này bao gồm việc trích xuất các trường như địa chỉ MAC nguồn và đích, VLAN tags, địa chỉ IP và cổng.
3. Lookup (Tra cứu): Module kernel của OVS thực hiện tra cứu trong bảng flow để xác định cách gói tin nên được xử lý. Bảng flow gồm các entry (mục) flow xác định điều kiện khớp và các hành động liên quan.
4. Action Execution (Thực thi hành động): Nếu tìm thấy entry flow khớp, các hành động định nghĩa trong entry đó sẽ được áp dụng cho gói tin. Các hành động này có thể bao gồm chuyển tiếp đến cổng khác, sửa đổi header của gói tin hoặc loại bỏ gói tin.
5. Miss Handling (Xử lý khi không khớp): Nếu không tìm thấy entry flow nào khớp, gói tin sẽ được gửi lên userspace của OVS để xử lý thêm. Điều này có thể bao gồm tra cứu các bảng flow cấp cao hơn, truy vấn controller hoặc cài đặt các entry flow mới.
6. Forwarding (Chuyển tiếp): Sau khi xử lý, gói tin được chuyển tiếp đến cổng ra hoặc các cổng thích hợp.

### Cấu trúc bảng flow

| Priority | Match Conditions | Actions |
| -------- | ---------------- | ------- |
| 100      | in_port=1, dl_dst=00:00:00:00:01 | output:2 |
| 50      | in_port=1 | mod_dl_dst=00:00:00:00:02, output:3 |
| 1     | in_port=2 | drop |

### Cài đặt openvswitch Ubuntu 16.04

    sudo apt install openvswitch-switch

### Các lệnh vswitch

1. Liệt kê các switch

        ovs-vsctl show
   hoặc

        ovs-vsctl list-br

2. Tạo switch mới

        ovs-vsctl add-br <bridge_name>

3. Xóa switch

        ovs-vsctl del-br <bridge_name>

4. Thêm một port vào switch

        ovs-vsctl add-port <bridge_name> <net interface>

5. Xóa port khỏi switch

        ovs-vsctl del-port <bridge_name> <net interface>

6. Liệt kê thông tin port numbers

        ovs-ofctl dump-ports <bridge_name>

7. Liệt kê thông tin các port trong switch

        ovs-vsctl list-ports <bridge_name>

8. Liệt kê toàn bộ thông tin switch

        ovs-ofctl show <bridge_name>

9. Set kiểu cho port

        ovs-vsctl set interface <net interface> type=<type_name>

10. On/Off giao thức STP

        ovs-vsctl set Bridge <vswitch> stp_enable=<{true|flase}>

11. Kiểm tra trạng thái STP của switch

        ovs-vsctl get bridge <bridge_name> stp_enable

12. Thiết lập bridge priority để chọn root bridge

        ovs-vsctl set bridge <bridge_name> other-config:stp-priority=<priority_value>

13. Thiết lập port priority để chọn root bridge

        ovs-vsctl set port <port_name> other-config:stp-port-priority=<priority_value>

### Tạo vswitch

1. Bằng lệnh

+ Tạo bridge mới

        sudo ovs-vsctl add-br br0

+ Thêm port vào bridge

        sudo ovs-vsctl add-port br0 eth1

+ Thêm cổng nội bộ (internal port) để sử dụng trong các máy ảo hoặc container

        sudo ovs-vsctl add-port br0 int-port -- set Interface int-port type=internal

+ Cấu hình IP cho cổng nội bộ

        sudo ip addr add <ip> dev int-port
        sudo ip link set int-port up

2. Bằng file .xml

+ Tạo bridge mới và thêm port

        <network>
          <name>br0</name>
          <forward mode='bridge'/>
          <bridge name='br0'/>
          <interface type='bridge'>
            <source bridge='br0'/>
            <target dev='eth1'/>
          </interface>
        </network>

+ Tạo máy ảo sử dụng cổng nội
  - Cấu hình máy ảo sử dụng bridge

        <devices>
          <interface type='bridge'>
            <mac address='địa chỉ mac'/>
            <source bridge='br0'/>
            <model type='virtio'/>
            <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
          </interface>
        </devices>
    - Cấu hình IP ch cổng nội bộ sử dụng câu lệnh
    - Sử dụng `virsh` quản lý mạng

          # Định nghĩa mạng từ tệp XML
          virsh net-define br0.xml

          # Tự động khởi động mạng khi host khởi động
          virsh net-autostart br0

          # Khởi động mạng
          virsh net-start br0

### Tap interface và uplink port

1. Tap interface

sử dụng trong Open vSwitch để xử lý và định tuyến các gói tin

Tap interface hoạt động ở lớp liên kết dữ liệu (Layer 2) của mô hình OSI

cho phép các gói tin Ethernet đi qua và có thể được sử dụng để kết nối các máy ảo hoặc container với mạng vật lý hoặc mạng ảo khác

+ Tạo tap interface
  
      ip tuntap add dev tap0 mode tap

+ Xóa tap interface

      ip link delete tap0
2. Uplink port

thường được sử dụng để kết nối switch ảo với mạng vật lý

Uplink port hoạt động ở lớp mạng (Layer 3) hoặc lớp liên kết dữ liệu (Layer 2) của mô hình OSI

cấu hình chuyển tiếp lưu lượng mạng từ switch nội bộ đến mạng bên ngoài hoặc ngược lại

+ Uplink port

      ovs-vsctl add-br br0
      ovs-vsctl add-port br0 eth0
