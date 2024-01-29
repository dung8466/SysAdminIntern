
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

![3-way handshake](pictures/tcp-start.gif)

Quá trình `3-way handshake`:

+ client gửi `SYN` tới server, thông báo với server muốn kết nối.
+ server nhận được và gửi lại `SYN-ACK`. Trong đó, `ACK` để xác nhận yêu cầu kết nối của client và `SYN` để biểu thị số thứ tự mà nó có thể bắt đầu.
+ clent gửi `ACK` để xác nhận đã thiết lập kết nối và sẽ bắt đầu quá trình truyền tải dữ liệu.

Sau khi kết thúc quá trình truyền tải dữ liệu, client sẽ kết thúc kết nối đã thiết lập.

![Kết thúc kết nối](pictures/tcp-end.gif)

Quá trình hủy kết nối:

+ client gửi `FIN` thông báo muốn kết thúc kết nối đã thiết lập.
+ server nhận được và gửi lại `ACK` để xác nhận quá trình hủy kết nối.
+ server gửi `FIN` để kết thúc kết nối.
+ client gửi `ACK` và kết thúc kết nối.

TCP được sử dụng trong trường hợp cần đảm bảo các gói tin được truyền đi đúng và đủ, thời gian truyền không phải thời gian thực. TCP thường được sử dụng trong truyền tải dữ liệu web, gửi/nhận email, truyền tệp tin giữa máy chủ và client, ....

## IPv4 và IPv6

### IPv4

Cấu trúc: Gồm 32 bit, chia làm 4 cụm (`octet`) với 2 cụm đầu là phần mạng (chỉ định số độc nhất được gán cho mạng và cũng xác định loại mạng được gán), 2 cụm sau là phần host (chỉ định cho mỗi máy, xác định máy trong mạng). --> Trong cùng 1 mạng, phần mạng sẽ giống nhau và phần host sẽ khác nhau.

Phân lớp: Gồm 5 lớp A, B, C, D, E.

+ Lớp A:
	+ 8bit đầu phần mạng (bit đầu luôn là 0) và 24bit sau phần host.
	+ Có các địa chỉ mạng từ `1.0.0.0` đến `126.0.0.0` và mỗi mạng có 224 địa chỉ host.
	+ Dải địa chỉ private: `10.x.x.x`.
+ Lớp B:
	+ 16bit đầu phần mạng (2bit đầu luôn là 1.0) và 16bit sau phần host.
	+ Có các địa chỉ mạng từ `128.0.0.0` đến `191.255.0.0` và mỗi mạng có 214 địa chỉ host.
	+ Dải địa chỉ private: `172.16.x.x` đến `172.31.x.x`.
+ Lớp C:
	+ 24bit đầu phần mạng (3bit đầu luôn là 1.0.0) và 8bit sau phần host.
	+ Có các địa chỉ mạng từ `192.0.0.0` đến `223.255.255.0` và mỗi mạng có 26 địa chỉ host.
	+ Dải địa chỉ private: `192.168.x.x`.
+ Lớp D:
	+ Những địa chỉ `multicast` bao gồm `224.0.0.0` đến `239.255.255.255`. `Multicast`: 1 gói tin có thể chuyển đến nhiều người nhận nhưng có chọn lọc thay vì gửi đến tất cả các thiết bị trong phạm vi như `boardcast`.
+ Lớp E:
	+ Có vai trò dự phòng, bao gồm các địa chỉ từ `240.0.0.0` trở đi.
 	+ Thường được sử dụng trong nghiên cứu, không dùng trong internet thông thường.

<p id="chia-subnet">Chia IPv4</p>

+ Đầu tiên ta cần xác định địa chỉ IP thuộc lớp nào --> tính được số bit cần mượn --> tính được số bit host sau khi mượn.
+ Tìm số đường mạng theo công thức `2^(số bit mượn)` (số đường mạng có thể phân ra từ mạng gốc).
+ Xác định mỗi đường mạng sẽ có bao nhiêu máy đặt trong đó theo công thức `2^(số bit host sau khi mượn) - 2` vì sẽ phải bỏ đi địa chỉ mạng và boardcast.
+ Tìm subnet mask mới. Dựa vào lớp mạng, mượn bao nhiêu bit sẽ phải bật lên bấy nhiêu bit 1 ở subnet mặc định.
+ Tìm bước nhảy theo công thức `256 - (subnet mask mới)`. --> Số dải IP khả dụng trong mạng

Ví dụ: Từ 192.168.1.1/29 tìm phạm vi địa chỉ host nó thuộc về.

+ Mạng thuộc lớp C, 24bit dùng cho mạng --> mượn `29 - 24 = 5bit` --> số bit host `8 - 5 = 3bit`
+ Số đường mạnh `2^5 = 32`
+ Số host mỗi đường mạng `2^3 - 2 = 6`
+ Subnet mới:
	+ subnet mặc định `/24`: `255.255.255.0` --> `11111111.11111111.1111111.00000000`
 	+ mượn 5bit --> `11111111.11111111.11111111.11111000` --> `255.255.255.248`
+ Bước nhảy `256 - 248 = 32`
+ Các dải IP khả dụng
	+ `192.168.1.1` đến `192.168.1.6`, `192.168.1.0`: địa chỉ mạng, `192.168.1.7`: boardcast
	+ `192.168.1.9` đến `192.168.1.14`, `192.168.1.8`: địa chỉ mạng, `192.168.1.15`: boardcast
 	+ `192.168.1.17` đến  `192.168.1.22`, `192.168.1.16`: địa chỉ mạng, `192.168.1.23`: boardcast
  	+ `192.168.1.25` đến `192.168.1.30`, `192.168.1.24`: địa chỉ mạng, `192.168.1.31`: boardcast...
  --> mạng `192.168.1.1/29` thuộc dải `192.168.1.1` đến `192.168.1.6`, với địa chỉ mạng là `192.168.1.0`, boardcast là `192.168.1.7`.
### IPv6

Cấu trúc: Gồm 128bit, được chia làm 8 nhóm, mỗi nhóm gồm 4 số hex tách biệt bằng `:` (IPv6-address/ prefix-length).

Ví dụ: `1080:0000:0000:0070:0000:0989:CB45:345F`, `200F::AB00:0:0:0:0/56` ( 56 prefix cho `200F00000000AB`).

Nén IPv6: Cho phép bỏ `0` trước mỗi nhóm, nhóm toàn `0` thay bằng `0`, thay `::` cho các nhóm liên tiếp toàn `0`.

--> Từ `1080:0000:0000:0070:0000:0989:CB45:345F` thành `1080:0:0:70::989: CB45:345F`.

Bao gồm 3 phần:

+ Site prefix: Định danh mạng hay tổ chức. Cho biết địa chỉ hay mạng thuộc tổ chức nào. 
+ Subnet ID: Phân chia mạng thành các phần nhỏ hơn (`subnet`)
+ Interface ID: Định danh thiết bị trong mạng. Giúp xác định thiết bị cụ thể trong mạng.

Phân loại: Chia làm 3 loại:

+ IPv6 Unicast: 1 địa chỉ Unicast được định nghĩa duy nhất trên một cổng của 1 node IPv6. Gói tin gửi đến Unicast được đưa đến cổng định nghĩa bởi địa chỉ đó.
+ IPv6 Multicast: Được định nghĩa 1 nhóm các cổng IPv6. Gói tin gửi đến Multicast được xử lý bởi tất cả các thành viên của nhóm Multicast.
+ IPv6 Anycast: Được đăng ký cho nhiều cổng trên nhiều node. Gói tin gửi đến Anycast được chuyển đến 1 trong số các cổng Anycast, thường là gần nhất.

## Switching

Là kết hợp nhiều `network interfaces` (giao diện mạng) thành một giao diện liên kết duy nhất, hoạt động cuả giao diện này phụ thuộc vào chế độ (dự phòng hoặc cân bằng tải).

+ Sử dụng hệ điều hành CentOs, thêm 1 mạng vào hệ thống.

	+ Kiểm tra `bonding` đã kích hoạt chưa

			lsmod | grep bonding

 	+ Nếu chưa thì kích hoạt

		 	sudo modprobe --first-time bonding
			modinfo bonding

 	+ Cấu hình `bonding` tự động chạy khi hệ thống khởi động tại `/etc/modprobe.d/bonding.conf`

 			alias bond0 bonding

	+ Kiểm tra các giao diện mạng `ip -c a` --> `ens33` và `ens36` đều `UP`, `bond0` có state `DOWN`.

	+ Cấu hình giao diện `bond0` master tại `/etc/sysconfig/network-scripts/ifcfg-bond0`


			DEVICE=bond0
			IPADDR=172.16.47.130
			NETMASK=255.255.255.0
			GATEWAY=172.16.47.1
			ONBOOT=yes
			BOOTPROTO=no
			USERCTL=no
			NM_CONTROLLED=no
			BONDING_OPTS="miimon=1000 mode=1"


		Với `miimon`: thời gian dám sát MII của NIC (milisecond), `mode=1`: mode active-backup của bonding.

	+ Cấu hình `ens33` slave tại `/etc/sysconfig/network-scripts/ifcfg-ens33`

			DEVICE=ens33
			TYPE=Ethernet
			ONBOOT=yes
			BOOTPROTO=none
			NM_CONTROLLED=no
			MASTER=bond0
			SLAVE=yes

	+ Cấu hình `ens36` slave tại `/etc/sysconfig/network-scripts/ifcfg-ens36`


			DEVICE=ens36
			TYPE=Ethernet
			ONBOOT=yes
			BOOTPROTO=none
			NM_CONTROLLED=no
			MASTER=bond0
			SLAVE=yes


	+ Khởi động giao diện `bond0`

			sudo service network restart

	+ Kiểm tra sử dụng `ip -c a` --> `ens33` và `ens36` có thêm giá trị `SLAVE`, không còn địa chỉ IP.

		`bond0` có giá trị `MASTER`, state `UP` và có giá trị IP, netmask,... theo cấu hình đã cài đặt. 

	+ Kiểm tra cơ chế hoạt động của bonding với `cat /sys/class/net/bond0/bonding/mode` --> `active-backup 1`.

	+ Kiểm tra giao diện mạng bonding có hoạt động không với `cat /sys/class/net/bonding_masters` --> `bond0`.

	+ Thử ngắt kết nối giao diện mạng `ens36` --> chỉ `ens36` `DOWN`, cả `ens33` và `bond0` đều `UP` và vẫn hoạt động bình thường.

	+ Ngắt kết nối cả 2 giao diện mạng `ens33` và `ens36` thì `bond0` `DOWN`.

+ Sử dụng hệ điều hành Ubuntu, thêm 1 mạng vào hệ thống.

	+ Cấu hình `bond0` tại `/etc/netplan/*.yaml`:

 			network:
   				version: 2
   				ethernets:
   					ens33:
   						dhcp4: false
   					ens37:
   						dhcp4: false
   				bonds:
   					bond0:
   						interfaces: [ens33, ens37]
   						dhcp4: false
   						addresses: [172.16.47.100/24]
   						nameservers:
   							addresses: [8.8.8.8]
   						parameters:
   							mode: active-backup
   							mii-monitor-interval: 100
 	+ Áp dụng cấu hình sử dụng `sudo netplan apply`. 
  	
## Routing

Một mạng máy tính được tạo ra từ nhiều máy tính kết nối gọi là các nút và các đường dẫn, liên kết các nút đó. Định tuyến là lựa chọn đường dẫn tốt nhất dựa trên 1 số quy tắc định trước.

Bộ định tuyến là thiết bị mạng kết nối các máy tính và mạng với những mạng khác. Có chức năng xác định đường dẫn, chuyển tiếp dữ liệu và cân bằng tải (gửi bản sao của cùng 1 gói dữ liệu bằng nhiều đường dẫn khác nhau).

Phương pháp hoạt động: 
+ các gói dữ liệu được gửi đến bộ định tuyến trước
+ Bộ định tuyến sau đó sẽ tra cứu gói có tiêu đề và xác định điểm đích của nó 
+ Tự tra cứu bảng nội bộ của nó và chuyển tiếp gói (đến bộ định tuyến tiếp theo hoặc thiết bị khác)
Phân loại:
+ Định tuyến tĩnh: sử dụng bảng tĩnh để đặt cấu hình và chọn các tuyến mạng theo cách thủ công.
+ Định tuyến động: các bộ định tuyến tạo và cập nhật bảng định tuyến trong thời gian chạy dựa trên điều kiện mạng thực tế.

Bảng định tuyến: là 1 bộ quy tắc dưới dạng bảng, lưu thông tin các định tuyến. Bao gồm nhiều entry, mỗi entry chứa thông tin các tuyến đường đến các đích khác nhau.

Cấu trúc 1 entry:
+ Địa chỉ IP đích: có thể là 1 host (host-id khác 0) hoặc 1 mạng (host-id bằng 0).
+ Địa chỉ IP của next-hop router hoặc địa chỉ mạng kết nối trực tiếp: địa chỉ có thể chuyển tiếp gói tin đến đích.
+ Network interface: cổng của router được sử dụng để gửi gói tin đến next-hop.
+ Cờ: cho biết nguồn cập nhật của route.
+ Metric: "khoảng cách" từ router đến IP đích, dùng để so sánh khi các route sử dụng cùng 1 giao thức định tuyến.
+ Administrative Distance: số ưu tiên đặt cho bảng định tuyến, gán cho các giao thức (giá trị từ 0 đến 255, càng bé càng ưu tiên).

Cài đặt định tuyến tĩnh:

+ Kiểm tra định tuyến hiện tại:

		route -n
  hoặc

  		ip r

+ Thêm định tuyến tĩnh sử dụng `ip route`:

		ip route add <IP/mask> via <gateway IP> [dev <network interface>]
+ Thêm định tuyến sử dụng `route`:

   		route add -net <IP> netmask <mask> [gw <gateway IP>] [<network interface>]

+ Thêm định tuyến tĩnh tại `/etc/netplan/*.yaml`:

		routes:
  			- to: <IP đích>
  			  via: <gateway IP>
+ Thêm định tuyến vĩnh viễn cho RHEL, FEDORA, CentOS tại `/etc/sysconfig/network-scripts/route-<network interface>`:

		<IP | IP/mask> via <gateway IP>
+ Thêm định tuyến vĩnh viễn cho Ubuntu tại `/etc/network/interfaces`:

		up route add -net <IP> netmask <mask> gw <gateway IP>
+ Xóa định tuyến sử dụng `ip route`:

		ip route del <IP/mask> via <gateway IP> [dev <network interface>]
+ Xóa định tuyến sử dụng `route`:

		route del -net <IP> netmask <mask> [gw <gateway IP>] [<network interface>]
+ Khóa route (tim route cho địa chỉ hoặc mạng sẽ tìm kiếm thất bại):

		route add -net <IP/mask> reject

## Firewall

Là thiết bị/phần mềm mạng giám sát lưu lượng mạng đến và đi, có thể cho phép hoặc chặn dữ liệu theo quy tắc bảo mật.

	sudo iptables [option] CHAIN_rule [-j target]

 `iptables` cần được lưu lại thủ công mỗi lần reboot. Có thể tự động load `iptables` mỗi lần reboot sử dụng package `iptables-presistent`, các quy tắc sẽ được lưu tại `/etc/iptables/rules.v4` và `/etc/iptables/rules.v6`. 

 Lưu các quy tắc sử dụng `iptables-save` và `ip6tables-save`

 		sudo iptables-save > /etc/iptables/rules.v4
   		sudo ip6tables-save > /etc/iptables/rules.v6

 + Kiểm tra quy tắc của `iptables`

 		sudo iptables -L


 + Chặn 1 port có thể chặn đến/đi, giao thức tcp/udp, ...

 		iptables -A <INPUT | OUTPUT> <-p tcp | -p udp> <-s IP | -d IP> <--dport port_number> -j DROP

Trong đó:
	+ `-p`: giao thức mạng muốn chặn.
 	+ `-s`: IP nguồn muốn chặn.
  	+ `-d`: IP đích muốn chặn.
   	+ `-dport`: port muốn chặn.
Ngược lại, nếu muốn cho phép có thể thay thế `DROP` thành `ACCEPT`.

+ Chặn toàn bộ port trừ 1 số port:
	+ Khởi tạo lại các quy tắc

			iptables -Z --zero-counter
 			iptables -F --flush rules
   			iptbales -X --delete all extra chains
 	+ Cài đặt quy tắc filter mặc định

   			iptables -P INPUT DROP
    			iptables -P OUTPUT DROP
    			iptables -P FORWARD DROP
    + Chấp nhận loopback (localhost)

			iptables -A INPUT  -i lo -j ACCEPT
			iptables -A OUTPUT -o lo -j ACCEPT
	+ Cho phép port

			iptables -A <INPUT | OUTPUT> -p <tcp | udp> [-m multiport] --dport <port number 1, port number 2,...> -j ACCEPT

 	+ Chặn hết các port không `ACCEPT`

			iptables -A <INPUT | OUTPUT> -j DROP

+ Chỉ cho phép ssh từ 1 số nguồn:

		iptables -A INPUT -p tcp --dport ssh -s <IP/mask> -j ACCEPT
  		iptbales -A INPUT -p tcp --dport ssh -j REJECT
  
## DHCP và DNS

## Keepalived

## Debug, config network

## Ansible

## Git

