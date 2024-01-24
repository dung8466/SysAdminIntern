
# Network

<details>
  <summary>Table of Contents</summary>
    <ol>
	    <li>Tam</li>
    </ol>
</details>

## Mô hình OSI, TCP/IP

### Mô hình OSI

Có 7 lớp trong mô hình OSI:

+ Lớp ứng dụng (application layer):

 + Là lớp duy nhất tương tác trực tiếp với dữ liệu từ người dùng. Các ứng dụng như trình duyệt web, email đều dựa vào lớp ứng dụng để bắt đầu kết nối.

 + Cung cấp giao thức và thao tác dữ liệu mà các phần mềm dựa vào để trình bày dữ liệu tới người dùng.

Các giao thức của lớp ứng dụng gồm HTTP, SMTP.

+ Lớp trình bày (presentation layer):

Chức năng chính là giải quyết vấn đề liên quan đến cú pháp, ngữ nghĩa của dữ liệu hiển thị tại lớp ứng dụng.

2 thiết bị kết nối có thể sử dụng 2 phương pháp `encoding` (mã hóa) khác nhau nên lớp trình bày cần chuyển dữ liệu thành cú pháp mà lớp ứng dụng có thể hiểu.

Nếu các thiết bị kết nối sử dụng kết nối mã hóa thì lớp trình bày phải thêm mã hóa ở phía người gửi và thêm giải mã ở phía người nhận để lớp ứng dụng có dữ liệu đọc được, không bị mã hóa.

Nén dữ liệu nhận được từ lớp ứng dụng trước khi chuyển xuống lớp phiên.

+ Lớp phiên (session layer):

Cho phép mở và đóng liên kết giữa 2 thiết bị. Đảm bảo phiên mở đủ lâu để truyền hết dữ liệu và đóng phiên để giảm tài nguyên.

Truyền dữ liệu với các `checkpoints`. Ví dụ cần truyền 100MB thì có thể có `checkpoint` mỗi 5MB, nếu liên kết bất ngờ đóng khi đã truyền 52MB thì phiên sẽ tiếp tục ở `checkpoint` cuối (50MB).

+ Lớp truyền tải (transport layer):

Đảm nhiệm cho kết nối end-to-end giữa các thiết bị.

Lấy dữ liệu từ lớp phiên và phân nhỏ thành các `segments` và gửi xuống lớp mạng. Tại thiết bị nhận thì gộp các `segments` thành dữ liệu và gửi lên lớp phiên.

Kiểm soát luồng và lỗi, là tầng cuối cùng chịu trách nhiệm về mức độ an toàn trong truyền dữ liệu.

Có thể thực hiện ghép kênh (multiplex) một vài liên kết thành 1 để giảm giá thành.

+ Lớp mạng (network layer):

Phân phối dữ liệu giữa các thiệt bị khác mạng, nếu trên cùng 1 mạng thì lớp mạng không cần thiết.

Chia nhỏ các `segments` từ lớp truyền tải thành các gói tin. Tại thiết bị nhận thì gộp lại các gói tin nhận được.

Tìm đường đi vật lý tối ưu nhất cho dữ liệu (routing).

Giao thức lớp mạng bao gồm IP, ICMP, IGMP và IPsec.

+ Lớp liên kết dữ liệu (data link layer):

Phân phối dữ liệu từ nút này sang nút khác, các thiết bị trên cùng một mạng.

Nhận gói tin từ `network` và chia nhỏ thành các `frames`, truyền tuần tự các `frame`, xử lý thông điệp xác nhận (ACK).

--> Kiểm soát lỗi, luồng, lưu lượng.

Chuyển đổi các `frame` thành chuỗi bit và chuyển xuống lớp vật lý.
    
+ Lớp vật lý (physical layer):

Bao gồm các thiết bị vật lý liên quan đến việc truyền dữ liệu (cáp, thiết bị chuyển mạch, ...).

Có chức năng truyền chuỗi bit qua các phương tiện vật lý.

Ưu điểm: 

+ Hỗ trợ cả 2 service: connection-oriented (hướng liên kết) và connectionless (không liên kết).
+ Tất cả các lớp đều hoạt động độc lập.
+ Bảo mật và đáng tin cậy hơn mô hình TCP/IP
+ Tách biệt giao diện, giao thức và dịch vụ -> khá linh hoạt.

Nhược điểm:

+ Cài đặt mô hình khó.
+ Không hỗ trợ các giao thức và ứng dụng thường dùng ở internet như HTTP, FTP, TCP, UDP, IP, and Ethernet --> sử dụng như 1 mô hình tham khảo.

### Mô hình TCP/IP

Có 4 tầng trong mô hình TCP/IP:

+ Tầng vật lý (Link layer):
+ Tầng mạng (Internet):
+ Tầng truyền tải (Transport):
+ Tầng ứng dụng (Application):

Ưu điểm:

+ Hỗ trợ nhiều giao thức định tuyến.
+ Dễ áp dụng và mở rộng.
+ Sử dụng kiến trúc client-server --> dễ quản lý, bảo mật tốt hơn và chia sẻ tài nguyên.

Nhược điểm:

+ Khả năng bảo mật và đáng tin cậy kém hơn mô hình OSI

--> Cả 2 mô hình đều mô tả cách mà dữ liệu được truyền giữa 2 thiết bị qua mạng

## UDP và TCP

### UDP

### TCP

## IPv4 và IPv6

### IPv4

### IPv6

## Switching

## Routing

## Firewall

## DHCP và DNS

## Keepalived

## Debug, config network

## Ansible

## Git

