### VPN

1. Khái niệm VPN? Công dụng của VPN

+ VPN (Mạng riêng ảo) tạo ra kết nối mạng riêng tư giữa các thiết bị thông qua Internet.

+ VPN hoạt động bằng cách ẩn địa chỉ IP của người dùng và mã hóa dữ liệu để chỉ người được cấp quyền nhận dữ liệu mới có thể đọc được.

+ Công dụng:

  - Quyền riêng tư: VPN sử dụng mã hóa dữ liệu cá nhân như mật khẩu, thông tin thẻ tín dụng và lịch sử duyệt web,...
  - Tính ẩn danh: VPN che giấu địa chỉ IP thực của người dùng và thay thế bằng địa chỉ IP của máy chủ VPN, giúp người dùng duyệt web ẩn danh và tránh bị theo dõi.
  - Bảo mật: VPN đảm bảo rằng dữ liệu và tài nguyên nội bộ của công ty chỉ có thể truy cập bởi những người dùng được ủy quyền qua kết nối an toàn.

2. Giao thức VPN

+ Point-to-Point Tunneling Protocol (PPTP): Một trong những giao thức VPN lâu đời nhất, được phát triển bởi Microsoft. Nó đơn giản và dễ cài đặt.
  - PPTP đóng gói dữ liệu mạng gốc vào một “IP envelope” (bao IP).
  - Khi PPTP server nhận được các gói dữ liệu đóng gói, nó sẽ loại bỏ lớp bao IP và giải mã dữ liệu mạng gốc bên trong.
  - Dữ liệu sau đó được chuyển tiếp đến đích cuối cùng, chẳng hạn như một trang web hoặc thiết bị đích khác.

  - Bảo mật: Sử dụng các phương pháp mã hóa cơ bản, hiện được coi là không an toàn do nhiều lỗ hổng bảo mật đã được phát hiện. Thiết lập kết nối với IP, username và password.
  

![point to point tunneling](pictures/pptp.png)

+ Layer 2 Tunneling Protocol (L2TP): Là giao thức kết hợp PPTP và Layer 2 Forwarding (L2F). 

  - Kết nối LAC (L2TP Access Concentrator) và LNS (L2TP Network Server) - hai điểm cuối của giao thức - trên Internet.
  - Một layer liên kết PPP được kích hoạt và đóng gói lại, sau đó, lớp liên kết này được chuyển qua web.
  - Kết nối PPP được khởi tạo bởi người dùng với ISP. Khi LAC chấp nhận kết nối, liên kết PPP được thiết lập.
  - Một vị trí trống trong tunnel mạng được chỉ định và yêu cầu sau đó được chuyển đến LNS. Khi kết nối được xác thực và chấp nhận hoàn toàn, một giao diện PPP ảo sẽ được tạo.

  - Bảo mật: L2TP chỉ tạo đường hầm mà không mã hóa nên thường được sử dụng với Internet Protocol security (IPsec).

![layer 2 tunneling](pictures/l2tp.jpg)

+ Secure Socket Tunneling Protocol (SSTP): là một loại VPN tunnel sử dụng kênh SSL 3.0 (cho phép truyền tải và mã hóa dữ liệu, cũng như kiểm tra tính toàn vẹn của lưu lượng) để gửi lưu lượng PPP hoặc L2TP.

SSTP chỉ hoạt động tốt nếu có đủ băng thông trên liên kết mạng không được tạo tunnel. Nếu không có đủ băng thông, TCP timer sẽ hết hạn.

  - SSL sử dụng cổng 443 để kết nối với máy chủ.
  - Để xác nhận kết nối, nó yêu cầu xác thực người dùng và thường được xác thực bởi client.
  - Sử dụng chứng chỉ máy chủ để xác thực.
 
  - Bảo mật: Cung cấp tính bảo mật cao (mã hóa AES 256-bit)

![secure socket tunneling](pictures/sstp.png)


+ Internet Key Exchange Version 2 (IKEv2): là một giao thức tunnelling dựa trên IPSec, cung cấp một kênh giao tiếp VPN bảo mật và xác định các phương tiện kết nối và xác thực tự động cho các liên kết bảo mật IPSec theo cách chúng được bảo vệ.

  - Chịu trách nhiệm thiết lập Security Association (SA) đảm bảo liên kết giữa VPN client và VPN server trong IPSec.
  - Tự động khôi phục kết nối khi có sự cố mạng.

  - Bảo mật: sử dụng xác thực chứng chỉ server (không thực hiện bất kỳ hành động nào cho đến khi xác định được danh tính của người yêu cầu)


![IKEv2](pictures/IKEv2.png)

+ OpenVPN: là một giải pháp mã nguồn mở và linh hoạt cho mạng riêng ảo (VPN), sử dụng giao thức OpenVPN.

  - Sử dụng SSL (Secure Socket Tunneling protocol)/TLS (Transport Layer Security) để thiết lập kênh bảo mật giữa client và server.
  - Sau khi thiết lập kênh bảo mật, OpenVPN sử dụng giao thức Diffie-Hellman để trao đổi các khóa mã hóa.
  - Khóa mã hóa được sử dụng để tạo một kênh mã hóa bảo mật cho việc truyền dữ liệu. Tất cả dữ liệu truyền qua kênh này đều được mã hóa.

![openvpn](pictures/OPENVPN.jpg)

3. Cách VPN hoạt động

Hoạt động bằng cách tạo ra một kết nối an toàn và mã hóa giữa thiết bị của người dùng và máy chủ VPN thông qua một đường hầm bảo mật.



+ VPN client-to-site: cho phép người dùng có thể kết nối đến 1 mạng riêng ở xa thông qua 1 VPN server

![client to site](pictures/openvpn-cts.png)

+ VPN site-to-site:

![site to site](pictures/site2site-help.png)

![vpc](pictures/vpc-vpn.png)

4. Cấu hình VPN Client-to-Site

+ Tại Site:

  - Cấu hình openvpn config 

```
port 1194
proto udp
dev tun
ca ca.crt
cert issued/server1.crt
key private/server1.key  # This file should be kept secret
dh dh.pem
server 10.8.0.0 255.255.255.0 #subnet cho VPN
ifconfig-pool-persist ipp.txt
push "route 10.20.6.0 255.255.255.0"
keepalive 10 120
tls-auth ta.key 0 # This file is secret
cipher AES-256-CBC
persist-key
persist-tun
status /var/log/openvpn-status.log
log         /var/log/openvpn.log
log-append  /var/log/openvpn.log
verb 3
explicit-exit-notify 1
```

  - Cho phép ip forward: `echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf && sysctl -p`
  - Cho phép lưu lượng của client đến LAN: `iptables -t nat -A POSTROUTING -s 10.20.6.0/24 -o eth0 -j MASQUERADE`

+ Tại Client:
  - Cấu hình config:

```
client
dev tun
proto udp
remote 103.107.181.141 1194  # Địa chỉ IP của máy chủ OpenVPN và cổng

route 10.20.6.0 255.255.255.0

tls-auth ta.key 1
data-ciphers AES-256-GCM:AES-256-CBC
cipher AES-256-CBC

resolv-retry infinite
remote-cert-tls server
nobind
persist-key
persist-tun
verb 3

<ca>
</ca>
<cert>
</cert>
<key>
</key>
<tls-auth>
</tls-auth>
```
  
  - Kết nối với VPN qua daemon: `openvpn --config client.ovpn --daemon`
