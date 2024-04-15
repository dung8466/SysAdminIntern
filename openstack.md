## Keystone (Identity service)

Cung cấp 1 điểm dùng cho quản lý xác thực, ủy quyền và mục lục dịch vụ.

Người dùng và các dịch vụ định vị các dịch vụ khác sử dụng mục lục dịch vụ quản lý bởi dịch vụ nhận dạng.

Mỗi dịch vụ có thể có 1 hoặc nhiều endpoints, mỗi endpoint có thể là 1 trong 3 loại: admin, internal, public. Mỗi loại có thể nằm trên mạng khác nhau, có thể truy cập với nhiều phân quyền người dùng khác nhau.

Openstack hỗ trợ nhiều vùng cho khả năng mở rộng (scalability). Vùng mặc định là RegionOne.

--> Vùng, dịch vụ và endpoint được tạo trong dịch vụ nhận dạng tạo thành mục lục dịch vụ.

Mỗi dịch vụ Openstack cần 1 entry tương ứng với endpoint lưu trong dịch vụ nhận dạng.

1. Thành phần 

+ `Server`: Máy chủ tập trung cung cấp dịch vụ xác thực và ủy quyền sử dụng giao diện RESTful.

+ `Drivers`: Nằm trong máy chủ tập trung. Dùng để truy cập thông tin nhận dạng trong kho lưu trữ ngoài đến Openstack hoặc đã có tại nơi Openstack được triển khai.

+ `Modules`: Các module trung gian chạy tại địa chỉ không gian của các thành phần Openstack đang sử dụng dịch vụ nhận dạng. Các module này chặn các yêu cầu của dịch vụ, trích xuất thông tin xác thực, gửi các thông tin đến máy chủ tập trung để ủy quyền. Việc tích hợp các module trung gian và thành phần của Openstack sử dụng giao diện Python Web Server gateway. 

2. Các bước xác thực

+ Người dùng gửi thông tin nhận dạng (phương thức nhận dạng, domain, tên người dùng, mật khẩu, project, ...) tới dịch vụ nhận dạng.

+ Dịch vụ nhận dạng gửi lại người dùng token.

+ Người dùng gửi yêu cầu và token đến dịch vụ openstack khác.

+ Dịch vụ được yêu cầu kiểm tra token với dịch vụ nhận dạng.

+ Dịch vụ gửi lại hồi đáp cho người dùng.

## Nova (Compute service) 

Dùng để lưu và quản lý hệ thống điện toán đám mây.

1. Thành phần

+ `nova-api`: chấp nhận và phản hồi người dùng sử dụng compute API. Dịch vụ hỗ trợ Openstack Compute API.

+ `nova-api-metadata`: chấp nhận yêu cầu metadata từ instances.

+ `nova-api-compute`: tiến trình ẩn (daemon) tạo và hủy instance máy ảo qua hypervisor APIs. daemon chấp nhận hành động từ `queue` và thực hiện 1 chuỗi các câu lệnh hệ thống như khởi động KVM instance và cập nhật trạng thái trong database.

+ `nova-scheduler`: nhận yêu cầu của instance máy ảo từ `queue` và quyết định compute server nào xử lý.

+ `nova-conductor`: làm trung gian giữa `nova-compute` và database. Không triển khai tại node mà `nova-compute` chạy.

+ `nova-novncproxy`: cung cấp proxy (ủy quyền) để truy cập instance đang chạy thông qua kết nối VNC (kiểm soát từ xa).

+ `nova-spicehtml5proxy`: cung cấp proxy để truy cập instance đang chạy thông qua kết nối SPICE.

+ `queue`: là trung tâm để truyền tin giữa các daemon, thường được thực hiện với RabbitMQ.

+ `SQL database`: lưu trữ trạng thái thời gian xây dựng và thời gian chạy của cơ sở hạ tầng đám mây (cloud infrastructure) gồm loại instance có sẵn, instance đang sử dụng, mạng có sẵn, dự án.

## Neutron (network service)

Cho phép tạo và gán giao diện thiết bị quản lý bởi các dịch vụ Openstack khác với mạng.

Tương tác với dịch vụ compute để cung cấp mạng và kết nối tới instance.

1. Thành phần

+ `neutron-server`: chấp nhận và định tuyến yêu cầu API tới Openstack Network plug-in phù hợp để xử lý.

+ `Openstack Network plug-in and agent`: cắm và rút cổng, tạo mạng hoặc subnet, cung cấp địa chỉ IP.

+ `messaging queue`: dùng bởi hầu hết cài đặt mạng Openstack để định tuyến thông tin giữa neutron-server và các agents. Cũng là database để lưu trạng thái mạng của các plug-in.
