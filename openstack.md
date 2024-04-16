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

+ `Modules`: 
  
  - Các module trung gian chạy tại địa chỉ không gian của các thành phần Openstack đang sử dụng dịch vụ nhận dạng. 
  
  - Các module này chặn các yêu cầu của dịch vụ, trích xuất thông tin xác thực, gửi các thông tin đến máy chủ tập trung để ủy quyền. 
  
  - Việc tích hợp các module trung gian và thành phần của Openstack sử dụng giao diện Python Web Server gateway. 

2. Các chức năng 

+ Identity: 

  - nhận diện người dùng đang muốn truy cập vào tài nguyên cloud.

  - identity của người dùng thường được lưu trữ trong database của keystone, có thể lưu tại external identity provider.

+ Authentication:

  - xác thực thông tin dùng để nhận định người dùng.

  - thường sử dụng password cho việc xác thực người dùng. Đối với các dịch vụ thì sử dụng tokens tạo ra.

  - token có giới hạn về thời gian sử dụng. Khi hết hạn thì người dùng được keystone cấp token mới.

  - bất kỳ ai có token đều có khả năng truy cập vào tài nguyên cloud.

+ Authorization:

  - xác định những tài nguyên mà người dùng được phép truy cập.

  - keystone kết nối người dùng với projects, domains bằng cách gán role cho người dùng vào projects, domains đó.

  - các project như Nova, Cinder,... sẽ kiểm tra role và project của người dùng và xác định giá trị của những thông tin theo cơ chế quy định (policy engine).
  
3. Các bước xác thực

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

+ `nova-api-compute`: 
  
  - tiến trình ẩn (daemon) tạo và hủy instance máy ảo qua hypervisor APIs. 
  
  - daemon chấp nhận hành động từ `queue` và thực hiện 1 chuỗi các câu lệnh hệ thống như khởi động KVM instance và cập nhật trạng thái trong database.

+ `nova-scheduler`: nhận yêu cầu của instance máy ảo từ `queue` và quyết định compute server nào xử lý.

+ `nova-conductor`: làm trung gian giữa `nova-compute` và database. Không triển khai tại node mà `nova-compute` chạy.

+ `nova-novncproxy`: cung cấp proxy (ủy quyền) để truy cập instance đang chạy thông qua kết nối VNC (kiểm soát từ xa).

+ `nova-spicehtml5proxy`: cung cấp proxy để truy cập instance đang chạy thông qua kết nối SPICE.

+ `queue`: là trung tâm để truyền tin giữa các daemon, thường được thực hiện với RabbitMQ.

+ `SQL database`: lưu trữ trạng thái thời gian xây dựng và thời gian chạy của cơ sở hạ tầng đám mây (cloud infrastructure) gồm loại instance có sẵn, instance đang sử dụng, mạng có sẵn, dự án.

2. Các bước tạo instance

+ Người dùng gửi yêu cầu tạo instance thông qua REST API.

+ `nova-api` xác nhận yêu cầu, thông tin người dùng. Khi xác nhận thành công, kiểm tra xung đột với database và tạo entry database cho instance.

+ `nova-api` gửi yêu cầu tới `nova-scheduler` cập nhật entry instance với id máy chủ chỉ định thông qua hàng chờ.

+ `nova-scheduler` nhận thông báo từ hàng chờ, định vị máy chủ bằng cách lọc và cân.

- trả về entry instance được cập nhật với id máy chủ.

- gửi yêu cầu tới `nova-compute` để khởi tạo instance trong máy chủ tương ứng.

+ `nova-compute` nhận thông báo từ hàng chờ, gửi yêu cầu đến `nova-conductor` để lấy thông tin id máy chủ, flavor (CPU,RAM,Disk).

+ `nova-conductor` nhận thông báo từ hàng chờ, giao tiếp với database để lấy thông tin instance. Gửi thông tin instance nhận được đến `nova-compute` qua hàng chờ.

+ `nova-compute` nhận thông báo từ hàng chờ, kết nới tới `glance-api` để lấy image URL sử dụng id image từ dịch vụ image và tải image từ kho image.

+ `nova-compute` gọi đến Network API để phân bổ và cấu hành mạng để instance có địa chỉ IP.

+ `nova-compute` gọi đến volume API để gán volume vào instance.

+ `nova-compute` tạo dữ liệu cho hypervisor driver và xử lý yêu cầu trên hypervisor sử dụng libvirt hoặc API. Instance/Vm được tạo trên hypervisor. 

## Neutron (network service)

Cho phép tạo và gán giao diện thiết bị quản lý bởi các dịch vụ Openstack khác với mạng.

Tương tác với dịch vụ compute để cung cấp mạng và kết nối tới instance.

1. Thành phần

+ `neutron-server`: chấp nhận và định tuyến yêu cầu API tới Openstack Network plug-in phù hợp để xử lý.

+ `Openstack Network plug-in and agent`: cắm và rút cổng, tạo mạng hoặc subnet, cung cấp địa chỉ IP.

+ `messaging queue`: 
  
  - dùng bởi hầu hết cài đặt mạng Openstack để định tuyến thông tin giữa neutron-server và các agents. 
  
  - Cũng là database để lưu trạng thái mạng của các plug-in.

## Cinder (block storage service)

Bổ sung dung lượng bộ nhớ vào máy ảo. Dịch vụ quản lý volumes, tương tác với Openstack Compute để bổ sung volumes cho instances và đồng thời cho phép quản lý volume snapshots và loại volume.

1. Thành phần

+ `cinder-api`: chấp nhận yêu cầu API, định tuyến chúng đến `cinder-volume` để xử lý.

+ `cinder-volume`: 
  
  - tương tác trực tiếp với dịch vụ Block Storage và các tiến trình như là `cinder-scheduler` thông qua `message queue`.
  
  - Dịch vụ phản hồi các yêu cầu đọc-ghi gửi tới dịch vụ Block Storage để duy trì trạng thái. 
  
  - Có thể tương tác với nhiều nhà cung cấp bộ nhớ thông qua cấu trúc driver.

+ `cinder-sheduler daemon`: Lựa chọn node cung cấp bộ nhớ tối ưu để tạo volume. Gần giống với `nova-scheduler`.

+ `cinder-backup daemon`: Sao lưu volume bất kỳ tới nơi cung cấp sao lưu bộ nhớ. Giống như `cinder-volume`, có thể tương tác với nơi cung cấp bộ nhớ thông qua cấu trúc driver.

+ `messaging queue`: định tuyến thông tin giữa các tiến trình Block Storage.

2. Các bước tạo volume

+ Người dùng gửi yêu cầu tạo volume thông qua REST API.

+ `cinder-api` xác nhận yêu cầu, thông tin người dùng. Khi xác nhận thành công, chuyển thông tin vào hàng chờ để xử lý.

+ `cinder-volume` lấy thông tin từ hàng chờ, gửi thông báo tới `cinder-scheduler` để quyết định backend nào sẽ cung cấp volume.

+ `cinder-scheduler` lấy thông tin từ hàng chờ, xây dựng danh sách ứng viên dựa trên trạng thái hiwwnj tại và tiêu chí yêu cầu volume (kích thước, availability zone, loại volume). 

+ `cinder-volume` nhận thông báo phản hồi từ `cinder-scheduler` từ hàng chờ, lặp qua danh sách ứng viên thông qua cách gọi backend driver đến khi thành công.

+ NetApp Cinder tạo volume yêu cầu thông qua tương tác với hệ thống con lưu trữ (dựa trên cấu hình và giao thức).

+ `cinder-volume` thu thập metadata volume và thông tin kết nối, gửi thông báo phản hồi đến hàng chờ.

+ `cinder-api` nhận thông báo phản hồi từ hàng chờ và gửi đến người dùng.

+ Người dùng nhận thông tin bao gồm trạng thái yêu cầu tạo, UUID volume,...

3. Các bước gán volume

+ Người dùng gửi yêu cầu gán volume thông qua gọi REST API NOVA.

+ `nova-api` xác nhận yêu cầu, thông tin người dùng. Khi xác nhận thành công, gọi Cinder API để nhận thông tin kết nối của volume cần gán.

+ `cinder-api` xác nhận yêu cầu, thông tin người dùng. Khi xác nhận thành công, gửi thông báo tới quản lý volume thông qua hàng chờ.

+ `cinder-volume` nhận thông báo từ hàng chờ, gọi Cinder driver ứng với volume cần gán.

+ NetApp Cinder driver chuẩn bị volume gán.

+ `cinder-volume` gửi thông tin phản hồi đến `cinder-api` thông qua hàng chờ.

+ `cinder-api` nhận thông báo phản hồi từ `cinder-volume` từ hàng chờ, chuyển thông tin kết nối trong phản hồi với nova.

+ Nova tạo kết nối tới bộ lưu trữ với thông tin nhận được từ Cinder.

+ Nova truyền thiết bị/file volume tới hypervisor, gán volume vào máy ảo như là một thiết bị block thực tế hoặc ảo hóa (dựa vào giao thức bộ lưu trữ).

4. Các bước sao lưu

+ Người dùng yêu cầu sao lưu volume bằng cách gọi REST API.

+ `cinder-api` xác nhận yêu cầu, thông tin người dùng. Khi xác nhận thành công, gửi thông báo tới quản lý sao lưu thông qua hàng chờ.

+ `cinder-backup` nhận thông báo từ hàng chờ, tạo bản ghi database để sao lưu và lấy thông tin từ database để sao lưu volume.

+ `cinder-backup` gọi `backup_volume` của Cinder volume driver ứng với volume cần sao lưu, gửi bản ghi sao lưu và kết nối của dịch vụ sao lưu dùng.

+ Cinder volume driver tương ứng gán với Cinder volume.

+ Volume driver gọi phương thức sao lưu để cấu hình dịch vụ sao lưu, bàn giao volume đã gán.

+ Dịch vụ sao lưu truyền dữ liệu và metadata của Cinder volume đến kho sao lưu.

+ Dịch vụ sao lưu cập nhật database với bản ghi để sao lưu và gửi thông tin phản hồi đến `cinder-api` thông qua hàng chờ.

+ `cinder-api` nhận thông báo phản hồi từ hàng chờ và chuyển kết quả trong phản hồi RESTful tới người dùng.

5. Các bước khôi phục volume

+ Người dùng gửi yêu cầu khôi phục đến Cinder volume bằng cách gọi REST API.

+ `cinder-api` xác nhận yêu cầu, thông tin người dùng. Khi xác nhận thành công, gửi thông báo tới quản lý sao lưu qua hàng chờ.

+ `cinder-backup` nhận thông báo từ hàng chờ, lấy thông tin từ bản ghi database sao lưu và bản ghi volume mới hoặc đã tồn tại, dựa trên việc bản ghi volume tồn tại có được yêu cầu không.

+ `cinder-backup` gọi phương thức `backup_restore` của Cinder volume driver ứng với volume sao lưu, gửi bản ghi sao lưu và kết nối cho dịch vụ sao lưu dùng.

+ Cinder volume driver tương ứng gán với Cinder volume.

+ Volume driver gọi phương thức `restore` để cấu hình dịch vụ sao lưu, bàn giao volume đã gán.

+ Dịch vụ sao lưu định vị metadata và dữ liệu sao lưu cho cinder volume trong kho sao lưu và sử dụng chúng để khôi phục Cinder volume về trạng thái của volume nguồn.

+ Dịch vụ sao lưu gửi thông tin phản hồi đến `cinder-api` qua hàng chờ.

+ `cinder-api` nhận thông báo phản hồi từ `cinder-backup` và gửi kết quả trong phản hồi  RESTful đến người dùng.
