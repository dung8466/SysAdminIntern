
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

	+ Các giao thức của lớp ứng dụng gồm HTTP, SMTP.

+ Lớp trình bày (presentation layer):

	+ Chức năng chính là giải quyết vấn đề liên quan đến cú pháp, ngữ nghĩa của dữ liệu hiển thị tại lớp ứng dụng.

	+ 2 thiết bị kết nối có thể sử dụng 2 phương pháp `encoding` (mã hóa) khác nhau nên lớp trình bày cần chuyển dữ liệu thành cú pháp mà lớp ứng dụng có thể hiểu.

	+ Nếu các thiết bị kết nối sử dụng kết nối mã hóa thì lớp trình bày phải thêm mã hóa ở phía người gửi và thêm giải mã ở phía người nhận để lớp ứng dụng có dữ liệu đọc được, không bị mã hóa.

	+ Nén dữ liệu nhận được từ lớp ứng dụng trước khi chuyển xuống lớp phiên.

+ Lớp phiên (session layer):

	+ Cho phép mở và đóng liên kết giữa 2 thiết bị. Đảm bảo phiên mở đủ lâu để truyền hết dữ liệu và đóng phiên để giảm tài nguyên.

	+ Truyền dữ liệu với các `checkpoints`. Ví dụ cần truyền 100MB thì có thể có `checkpoint` mỗi 5MB, nếu liên kết bất ngờ đóng khi đã truyền 52MB thì phiên sẽ tiếp tục ở `checkpoint` cuối (50MB).

+ Lớp truyền tải (transport layer):

	+ Đảm nhiệm cho kết nối end-to-end giữa các thiết bị.

	+ Lấy dữ liệu từ lớp phiên và phân nhỏ thành các `segments` và gửi xuống lớp mạng. Tại thiết bị nhận thì gộp các `segments` thành dữ liệu và gửi lên lớp phiên.

	+ Kiểm soát luồng và lỗi, là tầng cuối cùng chịu trách nhiệm về mức độ an toàn trong truyền dữ liệu.

	+ Có thể thực hiện ghép kênh (multiplex) một vài liên kết thành 1 để giảm giá thành.

+ Lớp mạng (network layer):

	+ Phân phối dữ liệu giữa các thiệt bị khác mạng, nếu trên cùng 1 mạng thì lớp mạng không cần thiết.

	+ Chia nhỏ các `segments` từ lớp truyền tải thành các gói tin. Tại thiết bị nhận thì gộp lại các gói tin nhận được.

	+ Tìm đường đi vật lý tối ưu nhất cho dữ liệu (routing).

	+ Giao thức lớp mạng bao gồm IP, ICMP, IGMP và IPsec.

+ Lớp liên kết dữ liệu (data link layer):

	+ Phân phối dữ liệu từ nút này sang nút khác, các thiết bị trên cùng một mạng.

	+ Nhận gói tin từ `network` và chia nhỏ thành các `frames`, truyền tuần tự các `frame`, xử lý thông điệp xác nhận (ACK).

	  --> Kiểm soát lỗi, luồng, lưu lượng.

	+ Chuyển đổi các `frame` thành chuỗi bit và chuyển xuống lớp vật lý.
    
+ Lớp vật lý (physical layer):

	+ Bao gồm các thiết bị vật lý liên quan đến việc truyền dữ liệu (cáp, thiết bị chuyển mạch, ...).

	+ Có chức năng truyền chuỗi bit qua các phương tiện vật lý.

Ưu điểm: 

+ Hỗ trợ cả 2 service: connection-oriented (hướng liên kết) và connectionless (không liên kết).
+ Tất cả các lớp đều hoạt động độc lập.
+ Bảo mật và đáng tin cậy hơn mô hình TCP/IP
+ Tách biệt giao diện, giao thức và dịch vụ -> khá linh hoạt.

Nhược điểm:

+ Cài đặt mô hình khó.
+ Không hỗ trợ các giao thức và ứng dụng thường dùng ở internet như HTTP, FTP, TCP, UDP, IP, and Ethernet --> sử dụng như 1 mô hình tham khảo.

### Mô hình TCP/IP

Có 4 lớp trong mô hình TCP/IP:

+ Lớp vật lý (Physical):
	+ Có tên khác là lớp giao diện mạng (Network Interface Layer).
	+ Là sự kết hợp của lớp vật lý và lớp liên kết dữ liệu của mô hình OSI.
	+ Đảm nhiệm tạo dữ liệu và yêu cầu kết nối.
	+ Dữ liệu được đóng gói vào khung (`frame`)  và được định tuyến.
+ Lớp mạng (Internet):
	+ Gần giống với lớp mạng của mô hình OSI.
 	+ Định nghĩa giao thức chịu trách nhiệm truyền dữ liệu trong mạng.
  	+ Các phân đoạn dữ liệu được đóng gói thành các `packets` với kích thước phù hợp với mạch chuyển mạng mà nó được dùng để vận chuyển.
  	+ Thêm header chứa thông tin của lớp mạng vào `packet` và vận chuyển đến lớp tiếp theo.
  	+ Giao thức của lớp mạng bao gồm IP, ICMP, ARP.
+ Lớp truyền tải (Transport):
	+ Xử lý các vấn đề giao tiếp: trao đổi tín hiệu ACK (xác nhận đã nhận dữ liệu), truyền lại các `packets` bị thiếu, đảm báo các `packets` được truyền đến đúng thứ tự và không lỗi.
	+ Giao thức của lớp mạng bao gồm TCP, UDP.
+ Lớp ứng dụng (Application):
	+ Đảm nhiệm vai trò giao tiếp giữa 2 thiết bị thông qua các dịch vụ mạng (trình duyệt web, email, ...).
 	+ Dữ liệu định dạng theo kiểu Byte to Byte, cùng với các thông tin định tuyến giúp xác định đường đi đúng của gói tin.
  	+ Giao thức của lớp ứng dụng bao gồm HTTP, FTP, POP3, SMTP, SNMP.  

Ưu điểm:

+ Hỗ trợ nhiều giao thức định tuyến.
+ Dễ áp dụng và mở rộng.
+ Sử dụng kiến trúc client-server --> dễ quản lý, bảo mật tốt hơn và chia sẻ tài nguyên.
+ Là mô hình được áp dụng trong thực tế.

Nhược điểm:

+ Khả năng bảo mật và đáng tin cậy kém hơn mô hình OSI

--> Cả 2 mô hình đều mô tả cách mà dữ liệu được truyền giữa 2 thiết bị qua mạng, dữ liệu được xử lý thông qua các lớp trong mô hình, mỗi lớp có một chức năng riêng.

Điẻm khác biệt:

| OSI | TCP/IP |
|-----|--------|
| Có cấu trúc liên quan đến cách hoạt động của mạng | Là giao thức kết nối dựa trên các giao thức mạng chuẩn và cho phép các máy kết nối qua mạng |
| Không phụ thuộc vào giao thức | Phụ thuộc vào giao thức |
| Gồm 7 lớp, mỗi lớp có 1 chức năng riêng | Gồm 4 lớp, trong đó lớp vật lý là sự kết hợp của lớp vật lý và liên kết dữ liệu của mô hình OSI, lớp ứng dụng là sự kết hợp của lớp phiên, trình bày và ứng dụng của mô hình OSI |

## UDP và TCP

### UDP

Là giao thức giao tiếp không đáng tin cậy (không có tính năng xác thực, khôi phục sau lỗi và kiểm soát luồng).

Dữ liệu được chia thành các gói tin. Mỗi gói tin chứa đủ thông tin để xác định nguồn, đích và kiểm soát lỗi.

UDP không yêu cầu thiết lập kết nối trước khi truyền tải các gói tin. Có thể gửi trực tiếp các gói tin đến IP và cổng nhận.

UDP sử dụng trong trường hợp cần muốn ưu tiên thời gian truyền tải, cần thời gian thực, chấp nhận bỏ qua gói tin thay vì chờ đợi. UDP được sử dụng trong truyền tải audio/video trực tuyến (streaming), game trực tuyến, DNS,... các ứng dụng không yêu cầu tin cậy và thiết lập kết nối trước.

### TCP

Là giao thức đảm bảo truyền tin giữa các thiết bị trong mạng.

Dữ liệu cũng được chia nhỏ thành các gói tin như UDP. Mỗi gói tin chứa các thông tin như địa chỉ nguồn, đích, kiểm tra lỗi, số thứ tự, số ACK, độ đai header, các bit điều khiển cờ, ....

TCP yêu cầu thiết lập kết nối trước khi truyền tin, sử dụng `3-way handshake`.



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

