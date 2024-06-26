## Netstat output

"Local address": Các dịch vụ, giao diện mạng trên máy tính có IP riêng, lắng nghe các kết nối từ các máy khác yêu cầu đến IP của chúng. 

Ví dụ:


Máy có sử dụng dịch vụ ảo hóa với giao diện `virbr0` địa chỉ `192.168.122.1`, 

```
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:902             0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      -
tcp        0      0 192.168.122.1:53        0.0.0.0:*               LISTEN      -
```

Địa chỉ `127.0.0.53`: địa chỉ local DNS caching server, `systemd` cấu hình dịch vụ DNS lắng nghe trên địa chỉ này.

Địa chỉ `0.0.0.0`:  máy lắng nghe trên tất cả các địa chỉ IP có trên máy.

Địa chỉ `127.0.0.1`: địa chỉ loopback, thường dùng để truy cập vào chính máy tính từ bên trong máy tính.

Địa chỉ `192.168.122.1`: địa chỉ mạng ảo trên máy tính, dùng để giao tiếp giữa máy ảo với nhau hoặc máy chính với máy ảo.

Các địa chỉ tại "Foreign Address" thể hiện địa chỉ IP nào có thể gọi đến các địa chỉ và cổng đang lắng nghe tại máy tính.

`0.0.0.0:*`: máy tính lắng nghe từ mọi địa chỉ IP và từ bất kỳ cổng nào của IP đó.

## Iptables rule

Bảng quy tắc chia ra nhiều `chain` như `INPUT`, `OUTPUT`, `FOWWARD`,.... (các gói tin gửi đến máy sẽ được lọc bởi `chain INPUT`, gói tin gửi đi sẽ được lọc bởi `chain OUTPUT` và gói tin chuyển tiếp được lọc bởi `chain FORWARD`...).

Với mỗi `chain`, gói tin sẽ đi lần lượt các quy định trong `chain`. Nếu quy định không khớp với gói tin, gói tin sẽ tiếp tục chuyển sang quy tắc tiếp theo. Nếu quy định khớp với gói tin, quy định sẽ được áp dụng với gói tin.

Ví dụ:

```
Chain INPUT (policy ACCEPT)
ACCEPT  tcp  --  172.16.47.140  anywhere  tcp dpt:ssh
DROP    tcp  --  anywhere       anywhere

Chain OUTPUT (policy ACCEPT)
ACCEPT  tcp --  anywhere  anywhere
DROP    tcp --  anywhere  anywhere
```
Đối với các gói tin được chuyển đến: Xét theo `chain INPUT`

  + Các gói tin chuyển đến từ địa chỉ `172.16.47.140` qua cổng 22, sử dụng giao thức `tcp` khớp với quy định đầu tiên -> ACCEPT.

  + Các gói tin đến từ địa chỉ `172.16.47.140` qua các cổng khác, sử dụng giao thức `tcp` không khớp với quy định đầu -> xét tiếp quy định tiếp theo -> khớp với quy định thứ 2 -> DROP.

  + Các gới tin đến từ các địa chỉ khác, sử dụng giao thức `tcp` không khớp với quy định đầu -> xét quy định tiếp theo -> khớp với quy định thứ 2 -> DROP.

Đối với các gói tin gửi đi: Xét theo `chain OUTPUT`

  + Các gói tin gửi đi đến bất kỳ sử dụng giao thức `tcp` đều khớp với quy định đầu tiên -> ACCEPT
  + Quy định thứ 2 sẽ không được xét đến.

## Keepalived protocol

Keepalived sử dụng VRRP (Virtual Router Redundancy Protocol) để giao tiếp giữa master và backup.

+ VRRP không sử dụng giao thức TCP hay UDP. VRRP sử dụng giao thức IP số 112 để hoạt động.

+ Các gói tin VRRP advertisement có địa chỉ đích đến là IP multicast.

## TIG workflow

Hệ thống monitoring sử dụng TIG stack bao gồm:

+ Collector: cài trên máy muốn theo dõi, có nhiệm vụ lưu thông tin của host và gửi về database, ở đây là Telegraf.

+ Database: Lưu trữ thông tin mà collector thu thập được, thường sử dụng time series database (có 1 hoặc nhiều điểm, mỗi điểm là 1 mẫu rời rạc các số liệu), ở đây là InfluxDB.

+ Visualizer: Biểu diễn các thông tin thu thập được qua bảng, biểu đồ,... ở đây là Grafana.

+ Alerter: Gửi thông báo khi có sự cố.

--> Telegraf thu thập các thông tin hệ thống như network, cpu, ram,... và lưu vào InfluxDB. Grafana sử dụng dữ liệu trong InfluxDb để biểu diễn bảng, biểu đồ. Khi có sự cố (cpu quá tải,...) grafana có thể gửi email, slack,... tới người dùng.

![TIG workflow](pictures/TIG.png)
