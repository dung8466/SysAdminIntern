# SysAdminIntern

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#linux">Linux</a>
      <ul>
        <li><a href="#các-lệnh-cơ-bản">Các lệnh cơ bản</a>
        <ul>
        <li><a href="#thay-đổi-thư-mục"> Thay đổi thư mục</li>
        <li><a href="#xem-thư-mục-đang-làm-việc"> Xem thư mục đang làm việc</a></li>
        <li><a href="#lịch-sử-lệnh">Lịch sử lệnh</a></li>
        <li><a href="#xử-lý-văn-bản">Xử lý văn bản</a></li>
        </ul>
</li>
        <li><a href="#quản-lý-tiến-trình">Quản lý tiến trình</a>
<ul>
<li><a href="#thông-tin-tiến-trình">Thông tin tiến trình</a>
<li><a href="#quản-lý-tiến-trình-kill">Quản lý tiến trình</a>
</ul>
<li><a href="#quản-lý-packages">Quản lý packages</a>
	<ul>
	<li><a href="#cài-đặt-phần-mềm">Cài đặt phần mềm</a></li>
	<li><a href="#cập-nhật-thông-tin-package">Cập nhật thông tin package</a></li>
	<li><a href="#cập-nhật-phiên-bản-package">Cập nhật phiên bản package</a></li>
	<li><a href="#danh-sách-package-đã-cài">Danh sách package đã cài</a></li>
	<li><a href="#tìm-kiếm-package-muốn-cài">Tìm kiếm package muốn cài</a></li>
	</ul>
</li>
       <li><a href="#startup-script">StartUp Script</a>
	<ul>
	<li><a href="#tạo-file-service">Tạo file service</a></li>
	<li><a href="#sử-dụng-cron">Sử dụng Cron</a></li>
	<li><a href="#sử-dụng-rc.local">Sử dụng rc.local</a></li>
	<li><a href="#sử-dụng-init.d">Sử dụng init.d</a></li>
	</ul>
</li> 
       <li><a href="#quản-lý-hệ-thống">Quản lý hệ thống</a>
	<ul>
	<li><a href="#quản-lý-filesystems">Quản lý filesystems</a>
	<ul>
	<li><a href="#sửa-lỗi-filesystems">Sửa lỗi filesystems</a></li>
	<li><a href="#tạo-filesystems">Tạo filesystems</a></li>
	<li><a href="#mount-và-umount">Mount/Unmount filesystems</a></li>
	</ul>
</li>
<li><a href ="#quản-lý-files">Quản lý files</a>
<ul>
<li><a href="#các-lệnh-cơ-bản-file">Các lệnh cơ bản</a></li>
<li><a href="#tìm-kiếm-file">Tìm kiếm file</a></li>
<li><a href="#quản-lý-quyền-truy-cập-sở-hữu">Quản lý quyền truy cập và sở hữu</a></li>
<li><a href="#quản-lý-thuộc-tính">Quản lý thuộc tính</a></li>
</ul>
</li>
<li><a href="#quản-lý-người-dùng-và-nhóm">Quản lý người dùng và nhóm</a>
<ul>
<li><a href="#người-dùng">Người dùng</a></li>
<li><a href="#nhóm">Nhóm</a></li>
</ul>
</li>
<li><a href="#quản-lý-disk">Quản lý disk</a>
<ul>
<li><a href="#kiểm-tra-disk">Kiểm tra disk</a></li>
<li><a href="#phân-vùng-disk">Phân vùng disk</a></li>
<li><a href ="#lab-disk">LAB</a></li>
<li><a href ="#raid">RAID</a>
	<ul>
	<li><a href="#lab-raid">LAB</a></li>
	</ul>
</li>
</ul>
</li>
<li><a href="#quản-lý-log-file">Quản lý log file</a></li>
<li><a href="#quản-lý-công-việc">Quản lý công việc</a></li>
	</ul>
</li>
   </ul>
    </li>
    <li>
      <a href="#network">Network</a>
      <ul>
      <li><a href="#ip">IP</a>
		<ul>
		<li><a href="#ip-tĩnh">IP tĩnh</a></li>
		<li><a href="#ip-động">IP động</a></li>
		</ul>
		</li>
      <li><a href="#dns">DNS</a>
	<ul>
	<li><a href="#lý-thuyết-dns">Lý thuyết</a></li>
	<li><a href="#lab-dns">LAB</a></li>
	</ul>
		</li>
      <li><a href="#dhcp">DHCP</a>
		<ul>
		<li><a href="#lý-thuyết-dhcp">Lý thuyết</a></li>
		<li><a href="#lab-dhcp">LAB</a></li>
		</ul>
		</li>
      <li><a href="#ssh">SSH</a></li>
      <li><a href="#rsync-và-scp ">rsync và scp </a></li>
      </ul>
  </li>
  </ol>
</details>


## Linux

### Các lệnh cơ bản

1. <p id="thay-đổi-thư-mục">Thay đổi thư mục:</p>
	
		cd [path]

	`path` có thể là tương đối hoặc tuyệt đối 

2. <p id="xem-thư-mục-đang-làm-việc">Xem thư mục đang làm việc:</p>

		pwd [options]

	options:
	+ -L: bao gồm cả symlinks
	+ -P: không bao gồm symlinks

3. <p id="lịch-sử-lệnh">Lịch sử lệnh:</p>

		history

	nếu sử dụng bash thì lịch sử sẽ được lưu trong `.bash_history` 

	Xem 1 câu lệnh trước/sau sử dụng mũi tên lên/xuống.

	Kết quả trả về có dạng `{number} {command}`
	--> thực thi lại câu lệnh `!{number}` ( `!!` sẽ thực thi lại câu lệnh cuối cùng)

	Tìm các lệnh trong lịch sử dùng reverse-i search sử dụng `CTRL + r` -> câu lệnh -> `CTRL + r` để duyệt hoặc `CTRL + s` duyệt ngược lại.

4. <p id="xử-lý-văn-bản">Xử lý văn bản:</p>

+ [cat](https://www.gnu.org/software/coreutils/manual/html_node/cat-invocation.html#cat-invocation): nối các văn bản và cho đầu ra là nội dung các file.

		cat [options] [file] ...
		
	Tạo file:
	
		cat > file
		
	Gộp file:
	
		cat file1 file2 ... > file_destination  
			
	Ghi kết quả vào file:
	
		cat file1 > file2 (ghi đè file hoặc tạo file nếu chưa tồn tại)

  	hoặc

  		cat file1 >> file2 (ghi vào cuối file hoặc tạo file nếu chưa tồn tại)

+ [tac](https://www.gnu.org/software/coreutils/tac): tương tự như `cat` nhưng in ngược lại (dòng cuối in đầu tiên)
+ [sort](https://www.gnu.org/software/coreutils/sort): sắp xếp các dòng trong các tập files.

		sort [options] [file] ...
	
	Ghi kết quả vào file:
	
		sort file -o file_destination
		
	hoặc
		
		sort file > temp && mv temp file

  	Chỉ giữ lại những dòng không trùng lặp

  		sort -u file
	
+ [split](https://www.gnu.org/software/coreutils/split): chia file thành các file nhỏ

		split [option]... [file [prefix]]
		
	--> tạo ra các file prefixaa, prefixab, ... ( prefix mặc định là x)
		
	ví dụ: `split -l 1 file split_file` --> chia file thành các file split_fileaa, split_fileab,... mỗi file có 1 dòng.

+ [uniq](https://www.gnu.org/software/coreutils/uniq): báo cáo hoặc bỏ qua các dòng lặp lại trong file

		uniq [options] [input [output]]

	kết hợp pipe: `sort file | uniq -cd` --> cho lần lặp lại và dòng lặp lại.
	`sort file | uniq -u` tìm kiếm dòng xuất hiện duy nhất trong file.

+ [nl](https://www.gnu.org/software/coreutils/nl): trả về số dòng có trong files

		nl [options] [file]...

	kết quả trả về có dạng `{number} {line}`

+ [head](https://www.gnu.org/software/coreutils/head): trả về nửa đầu của files(mặc định là 10 dòng đầu nếu không dùng `-n`)

		head [-n {number}] [file]...

  	Ví dụ có thể yêu cầu trả về 5 dòng đầu sử dụng

  		head -n 5 {file}

+ [tail](https://www.gnu.org/software/coreutils/tail): trả về nửa sau của files(mặc định là 10 dòng cuối nếu không dùng `-n`)

		tail [-n {number}] [file]...

  	Tương tự như `head`, yêu cầu trả về 5 dòng cuối sử dụng

  		tail -n 5 {file}

+ [less](https://greenwoodsoftware.com/less/): giống `more` nhưng có thể tiến 1 trang bằng `space` hoặc lùi 1 trang bằng `ESC + v`
Tìm kiếm ngược trong các trang sử dụng `?`, tìm kiếm xuôi sử dụng `/`.

		less [options] [file]...

+ [cut](https://www.gnu.org/software/coreutils/cut): trích xuất 1 đoạn dữ liệu từ các files.

		cut option... [file]...

	trích xuất khoảng ký tự/trường từng dòng:
		
		cut --characters|fields|bytes={number} | {number},{number} | {number}-{number} | {number}- | -{number}

	có thể thêm `--delimiter=" {character} "` để xác định dấu phân cách.

+ [wc](https://www.gnu.org/software/coreutils/wc): in ra số từ, byte, số dòng, ký tự hoặc chiều dài dòng dài nhất.

		wc [option]... [file]...

	Ví dụ đếm số dòng trong file

		wc --lines {file}

  	hoặc đếm độ dài của số dòng dài nhất trong file

  		wc --max-line-length {file}
  	

+ [grep](https://www.gnu.org/software/grep/manual/grep.html): trả về các dòng phù hợp với chuỗi/ký tự tìm kiếm.

		grep [option...] PATTERNS [file...]

	nếu muốn tìm kiếm nhiều từ khóa hoặc từ khóa bắt đầu bằng "-":
		
		grep [option...] -e PATTERNS... [file...]

	hoặc nếu các PATTERNS nằm trong 1 file có thể sử dụng:
	
		grep [option...] -f PATTERN_FILE ... [file...]

  	Mặc định sẽ tìm kiếm cả in hoa và in thường, muốn tìm kiếm riêng biệt sử dụng `-i` hoặc `-y`

  	Ví dụ tìm kiếm "alice" mà không phải là "Alice"

  		grep -i "alice" {file}

	`grep` thường sẽ sử dụng cùng [regex](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions/Cheatsheet) để tìm kiếm các chuỗi cụ thể.
	
	ví dụ: tìm kiếm số điện thoại có "-" ở giữa

		grep '[0-9]\+-[0-9]\+-[0-9]\+' file

	các output hợp lệ `012-322`, `1-2-3`,...

	ví dụ: tìm kiếm 1 dòng sau các dòng chứa "Alice" ở file test

		grep -A 1 "Alice" test

+ [sed](https://www.gnu.org/software/sed/manual/sed.html): lọc và xử lý chữ trong file hoặc kết quả của pipeline.

		sed [option]... {script} [file]...

	sử dụng `-i` nếu muốn thay đổi tại chỗ thay vì in ra màn hình.

	ví dụ: Xóa từ dòng thứ 5 đến hết trong file test

		sed -i '5,$d' test

	ví dụ: Thay thế "h" bằng "l" trong toàn bộ file

		sed -i 's/h/l/g' file

	với `s` cho biết thực hiện lệnh thay thế và `g` cho biết thay thế trong toàn bộ file

	nếu muốn sử dụng cùng [regex](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions/Cheatsheet) để xử lý các chuỗi cụ thể thì nên dùng [awk](https://github.com/onetrueawk/awk).

+ [awk](https://github.com/onetrueawk/awk): ngôn ngữ quét và xử lý chữ.

		awk [option] 'selection _criteria {action}' file

	nếu muốn in ra file thay vì màn hình 
	
		awk [option] 'selection _criteria {action}' file > output_file
		
	các biến có sẵn để thuận tiện sử dụng  `NR`: số dòng, `NF`: trường cuối cùng, `$0`: cả dòng,...

	ví dụ: 
	- In từ đầu tiên dòng thứ 3 đến dòng 6

			awk 'NR==3, NR==6 {print NR, $1}' file

	- In dòng chứa từ `foo`

			awk '/foo/ {print $0}' file

	- In tổng giá trị của trường cuối cùng

			awk '{s+=$NF} END {print s}' file

	- In các dòng có từ thứ 2 chứa ký tự `h` tiếp sau đó là `e` hoặc `o`

			awk '$2 ~ /h[eo]/ {print $0}' file

	[back to top](#sysadminintern)
### Quản lý tiến trình

1.  <p id="thông-tin-tiến-trình">Thông tin tiến trình:</p>

+ Lệnh `ps`: thông tin về các tiến trình đang chạy của người dùng hiện tại.
	`ps aux` sẽ liệt kê toàn bộ tiến trình của toàn bộ người dùng(`a`), các tiến trình không kết nối với terminal nào(`x`) và nhiều thông tin hơn(`u`).

+ Lệnh `top`: tương tự như lệnh `ps` nhưng đưa thông tin liên tục thời gian thực cho đến khi báo dừng(`CRTL C`).
+ Lệnh `htop`: tương tự `top` nhưng nâng cấp giao diện, dễ đọc.
+ Lệnh `uptime`: cho biết `load-average` của hệ thống. `load-average` là trung bình số threads đang chạy hoặc trong hàng chờ để chạy.
Lệnh `uptime` trả về kết quả `load average: <0,74>, <0,77>, <0,64>` - các thông số lần lượt là trung bình trong 1 phút, 5 phút và trong 15 phút.

+ Các phương pháp lấy thông tin ram, cpu, id:
	+ Sử dụng `ps`:
	
		Xem tiến trình nào sử dụng nhiều cpu, ram nhất
		`ps aux --sort -%cpu|mem | head -n 2`
	
		Lấy thông tin tiến trình/ kiểm tra tiết trình có đang chạy không
		`ps aux | grep {command}`
		
	+ Sử dụng `top`:
	
		`top -o %CPU|MEM`

		hoặc sử dụng `t`, `m`, `l` trong khi chạy `top` để sắp xếp theo `cpu`, `memory`, `load avg`.

	+ Sử dụng `htop`:

		`htop --sort PERCENT_CPU|PERCENT_MEM`

		hoặc sử dụng `F6` trong khi chạy `htop` và lựa chọn theo yêu cầu.

2. <p id="quản-lý-tiến-trình-kill">Quản lý tiến trình:</p>

	Kết thúc tiến trình sử dụng `kill`:

		kill [Signal or option] pid --default TERM
	
	Liệt kê các signal:
		
		kill -l 

	Các signal phổ biến
		
		SIGHUP		1			hangup
		SIGINT 	2			Interrupt from keyboard 
		SIGKILL	9			Kill signal
		SIGTERM	15			Termination signal 
		SIGSTOP	17,19,23		Stop process

  	Lệnh `kill` gửi tín hiệu TERMINATE tới tiến trình, cho phép nó `clean up`(giải phóng bộ nhớ, xử lý tiến trình con,...). Tiến trình có thể bỏ qua nếu đang trong lúc giải phóng bộ nhớ,....
   	Lệnh `kill -9` buộc tiến trình dừng mà không đợi `clean up`
### Quản lý packages

1. <p id="cài-đặt-phần-mềm">Cài đặt phần mềm:</p>

	Sử dụng package manager:

		sudo apt install {package}

	Sử dụng file deb:

		sudo dpkg -i path/to/deb_file

	Compile from source:

		cd path/to/source
		./configure -- Resolving Dependencies, nếu có
   		make
   		sudo make install -- nếu chưa install

3. <p id="gỡ-bỏ-phần-mềm">Gỡ phần mềm:</p>
	
		sudo apt remove {package} -y

	sau khi gỡ bỏ package thì nên sử dụng `sudo apt update`.

	Để gỡ bỏ các package đã không còn cần tới, sử dụng

		sudo apt autoremove

5. <p id="cập-nhật-thông-tin-package">Cập nhật thông tin package:</p>

		sudo apt update

	câu lệnh sử dụng khi cần cập nhật danh sách package trong kho repositories.

6. <p id="cập-nhật-phiên-bản-package">Cập nhật phiên bản package:</p>

		sudo apt upgrade

	câu lệnh sẽ cập nhật phiên bản của các package có sẵn trong máy thông qua thông tin về package cập nhật từ `sudo apt update`.
7. <p id="danh-sách-package-đã-cài">Danh sách package đã cài:</p>

		sudo apt list --installed

	từ đây nếu muốn xem đã cài package nào chưa `sudo apt list --installed | grep {package}`
		
8. <p id="tìm-kiếm-package-muốn-cài"> Tìm kiếm package muốn cài:</p>

		sudo apt search <package_name>

	hoặc

		sudo apt-cache search <package_name>
[back to top](#sysadminintern)
### StartUp Script

1. <p id="tạo-file-service">Tạo file service:</p>

	Có thể tạo file với đuôi .service tại `/etc/systemd/system` 

	Cấu trúc file cơ bản
	

		[Unit]
		Description=My custom startup script
	
		[Service]
		ExecStart=/bin/bash path/to/bash_script 
	
		[Install]
		WantedBy=multi-user.target

	Để có thể chạy khi hệ thống khởi động `sudo systemctl enable custom.service`

2.  <p id="sử-dụng-cron">Sử dụng cron:</p>

	Có thể thếm vào crontab file với câu lệnh `crontab -e` đoạn code khởi tạo cùng hệ thống

		@reboot sh path/to/file

	Tuy nhiên, không phải phiên bản nào của cron cũng hỗ trợ `@reboot`.

3. <p id="sử-dụng-rc.local">Sử dụng rc.local:</p>

	Có thể thêm vào file `/etc/rc.d/rc.local` đoạn code chạy file (vì file rc.local sẽ chạy lúc hệ thống khởi động)

		sh path/to/file

	Cần đảm bảo file rc.local có thể chạy được `chmod +x /etc/rc.d/rc.local`

4. <p id="sử-dụng-init.d">Sử dụng init.d:</p>

	Có thể thêm file bash script vào `/etc/init.d`, ví dụ `/etc/init.d/myscript`

	Cho phép script vừa tạo khởi chạy

		sudo chmod +x /etc/init.d/myscript

	Khởi tạo `daemon`
	
 		sudo update-rc.d <myscript> defaults

	

[back to top](#sysadminintern)
### Quản lý hệ thống 

#### Quản lý filesystems

Dùng để quản lý dữ liệu đọc và lưu của hệ thống.
Filesystem là cách quản lý dữ liệu trong partition theo 1 cách dễ quản lý.
Partition cài đặt điểm bắt đầu, kết thúc của phân vùng trên ổ cứng.
	
Các filesystems thông thường: ext{2,3,4}, xfs, ntfs, vfat, proc,...

Cả ext và xfs đều là `journaling filesystem`(filesystem lưu trữ `log` về thay đổi đến filesystem)
| ext4 | xfs |
|------|-----|
| hỗ trợ partition lên đến 1EiB, kích thước file 16TiB | hỗ trợ partition, file lên đến 8EiB |
| x | inodes(lưu thuộc tính, địa chỉ của dữ liệu) phân bổ tự động |
| giới hạn độ dài của xattr(thuộc tính thêm) không quá 1 khối (4K) | giới hạn độ dài của xattr là 64K |
| x | có sẵn công cụ backup và khôi phục dữ liệu(`xfsdump`, `xfsrestore`)
| hỗ trợ `journal checksum`(kiểm tra dữ liệu có đúng không) | x |
| có thể tắt tính năng `journal` | x |
| có thể trực tiếp shrink volume | x |

Hệ thống thư mục trong linux:

| Thư mục     |      Chức năng |
|-------------|--------------------------|
| /bin |  chứa các câu lệnh như ls, cp,..., các file có thể thực thi |
| /boot |    chứa các file để khởi tạo hệ thống |
| /dev | chứa các file thiết bị, được tạo trong thời gian khởi động hoặc khi cắm |
| /etc | chứa các file config hệ thống như tên người dùng, mật khẩu,... |
| /home | chứa các file của người dùng |
| /lib | thư viện chứa code mà ứng dụng dùng  |
| /media | các thiết bị ngoại vi như usb,... được mount vào đây |
| /mnt | là điểm mount bằng các câu lệnh tạm thời |
| /opt | được dành cho các gói package phần mềm bổ sung |
| /proc | chứa các file hệ thống ảo hiện thông tin về CPU, kernel,... |
| /root | chứa thư mục của superuser |
| /sbin | chứa các công cụ tiện ích như là init,... thường cần để tải, xóa, tái định dạng,... các lệnh này cần chạy bằng `sudo` |
| /usr | chứa các file khởi chạy, thư viện, tài nguyên cần chia sẻ bởi ứng dụng và services. |
| /srv | chứa dữ liệu liên quan đến server | 
| /sys | thư mục ảo chứa các thông tin liên quan đến thiết bị kết nối tới máy tính |
| /tmp | chứa các file tạm thời (thường tạo bởi các ứng dụng đang chạy) |
| /var | chứa các thư mục như `/log`(các file log của hệ thống), `/mail`(mail nhận được), `/spool`(hàng chờ), `/src`(src chưa được compile) và `/tmp`(tmp file được lưu sau khi tắt máy) |

1. <p id="sửa-lỗi-filesystems">Sửa lỗi filesystems: sử dụng <a href="https://manned.org/fsck"> fsck</a></p>

	các filesystems cần kiểm tra và sửa nên unmount trước khi chạy câu lệnh.

		fsck [option] path/to/filesystems|device|label|UUID

	nếu không có `option` thì sẽ chỉ trả về tình trạng của filesystems
	
	`option -r`: để người dùng tự chọn cách sửa 
	
	`option -a`: tự động sửa 

2. <p id="tạo-filesystems">Tạo filesystems: sử dụng <a href="https://manned.org/mkfs">mkfs</a></p>

		mkfs [options] [-t type] [fs-option] device [size]

	không có `-t type` thì mặc định sử dụng `ext2`
	trả về 0 thành công và 1 nếu thất bại.

2. <p id="mount-và-umount">Mount/Unmount filesystems: sử dụng <a href="https://manned.org/mount.8">mount</a> và <a href="https://manned.org/umount.8">umount</a></p>

+ mount: đăng ký filesystem của thiết bị vào 1 điểm chỉ định trên cây thư mục. Thông tin các thiết bị thường được mount tới đâu được lưu trữ tại `/ect/fstab`

	Các lệnh mount cơ bản:
		
	+ mount thiết bị vào 1 thư mục
	
			mount -t filesystem_type path/to/device_file path/to/target_directory
	+ mount thư mục vào thư mục khác

			mount --bind path/to/old_dir path/to/new_dir

	+ mount filesystem đã có trong `/etc/fstab`

			mount /my_drive

+ umount: bỏ liên kết filesystem đã mount khỏi cây thư mục.

	Các lệnh umount cơ bản:
	
	+ umount sử dụng đường dẫn tới thiết bị

			umount path/to/device_file

	+ umount sử dụng đường dẫn tới địa chỉ mount

			umount path/to/mounted_directory

	Để tự động mount filesystems thì cần thêm các thông tin cần thiết vào `/ect/fstab`:

		UUID=<uuid of device> <mount point> <file system type> <mount option> <dump> <pass>


	+ UUID: thông qua `blkid path/to/device`
	+ mount option: quyền truy cập của người dùng
	+ dump: thông thường là `0`
	+ pass: thứ tự được kiểm tra lúc reboot, thường là `2`, `1` nếu là root và `0` nếu swap


#### Quản lý files

1. <p id="các-lệnh-cơ-bản-file">Các lệnh cơ bản:</p>

	+ [ls](https://www.gnu.org/software/coreutils/ls):
		liệt kê nội dung thư mục
			`ls [option]... [path/to/folder]`
	+ [cp](https://www.gnu.org/software/coreutils/cp):
		copy file hoặc thư mục 
		`cp [option]... path/to/file|path/to/directory path/to/target_file|path/to/target_directory`
	+ [mv](https://www.gnu.org/software/coreutils/mv):
		di chuyển file hoặc thư mục 
		`mv [option]... file|directory... target_file|target_directory`
	+ [rm](https://www.gnu.org/software/coreutils/rm):
		xóa file hoặc thư mục
		`rm [option]... [file]...`

		 (`rmdir` chỉ xóa thư mục rỗng)
		
	+ [touch](https://manned.org/man/freebsd-13.1/touch):
		tạo file và thay đổi thời gian sửa đổi/truy cập
		tạo file:`touch path/to/file1 path/to/file2 ...`
	+ [ln](https://www.gnu.org/software/coreutils/ln):
		tạo liên kết tới file và thư mục(có thể là symlink hoặc hard link)
		+ symlink: trỏ tới một file hoặc thư mục
		+ hard link: như một tên khác cho file, file hoặc thư mục được link có cùng inode(chứa toàn bộ thông tin về file)
		
		```
		ln [option]... path/to/file|path/to/directory path/to/symlink|path/to/hardlink
		```

2. <p id="tìm-kiếm-file">Tìm kiếm file:</p>

+ [find](https://manned.org/find): Có thể tìm kiếm file dựa trên tên, đuôi, size, quyền của file, thời gian tạo,...

	ví dụ:
	+ tìm kiếm file được chỉnh sửa trong vòng 10 ngày
		`find / -mtime 10`

	+ tìm kiếm file có dung lượng trong khoảng 50M đến 100M
	`find / -size +50M -size -100M`

	+ tìm kiếm file tên `test` hoặc `Test`
		`find -iname "test"`
	+ tìm các thư mục rỗng
		`find / -type d -empty`
	
+ [locate](https://manned.org/locate): Tìm kiếm dựa trên file database tại ``/var/cache/locate/locatedb``, trước khi tìm kiếm cần `sudo updatedb`

	`locate [option]... pattern...`

	ví dụ: 
	+ tìm kiếm file có đuôi `.ini`, giới hạn 3 kết quả
		`locate "*.ini" -l 3`

	+ tìm kiếm các file vẫn còn trên máy có tên `test` ở mục `home`
		`locate -i -e "test" | grep "/home"`
+ [whereis](https://manned.org/whereis): Tìm kiếm tệp nhị phân(`-b`), nguồn(`-s`) và hướng dẫn(`-m`) cho một câu lệnh

		whereis [option]... [command]...
	Mặc định(không có option) sẽ tìm kiếm toàn bộ về câu lệnh 

	ví dụ:

  	+ tìm kiếm tệp nhị phân cho `gcc` tại thư mục `/usr/lib` và hướng dẫn tại `/usr/share`
	
 			whereis -bm -B /usr/lib -M /usr/share -f gcc
	+ tìm kiếm toàn bộ các tệp nhị phân khác thường(các lệnh có hơn nhiều hơn 1 tệp nhị phân)

   			whereis -u *
   	+ tìm kiếm tệp nhị phân của `gcc` và hường dẫn của `git`
 
   	  		whereis -b gcc -m git
+ [which](https://manned.org/which): Tìm kiếm đường dẫn đầy đủ của các lệnh

		which [-a] command... 

	`-a` sẽ in ra toàn bộ các kết quả chứa câu lệnh.

3. <p id="quản-lý-quyền-truy-cập-sở-hữu">Quản lý quyền truy cập, sở hữu:</p>

+ [chown](https://www.gnu.org/software/coreutils/manual/html_node/chown-invocation.html#chown-invocation): quản lý quyền của người dùng và nhóm 
	
		chown [option]... {new_owner | --reference=ref_file} file…

	nếu sử dụng `new_owner` thì chỉ định người sở hữu mới và/hoặc nhóm bằng `[owner] [ : [group] ]`
	Ví dụ: Cho nhóm `readers` sở hữu thư mục `/Reader`(bao gồm tất cả file và subfolder)

		sudo chown -R :readers /Reader 

	Nếu muốn cho cả nhóm `readers` và user `reader` sở hữu thư mục `/Reader`

		sudo chown -R reader:readers /Reader
+ [chgrp](https://www.gnu.org/software/coreutils/manual/html_node/chgrp-invocation.html#chgrp-invocation): quản lý quyền của nhóm

		chgrp [option]… {group | --reference=ref_file} file…
	
	`group` có thể là tên hoặc id(bắt đầu với `+`) của nhóm.
+ [chmod](https://www.gnu.org/software/coreutils/manual/html_node/chmod-invocation.html#chmod-invocation): quản lý quyền truy cập của file

		chmod [option]… {mode | --reference=ref_file} file…

	mode:
		
	+ chữ: `augo` `-+=` `rwx` 

		ví dụ: cho mọi người đọc file, bỏ quyền viết file với tất cả ngoại trừ chủ sở hữu
		`sudo chmod a+r,go-w file`
	+ số: `[special mode bit]{file's owner}{other in group}{other not in group}`, `4:r,2:w,1:x`

4. <p id="quản-lý-thuộc-tính">Quản lý thuộc tính:</p>

		chattr [ -RVf ] [ -v version ] [ mode ] files...

	Mục đích chính là khiến file không thể thay đổi bởi người dùng (kể cả superuser) cho đến khi thuộc tính được sửa lại.
	
 	Các mode thông thường:
	+ `i`: không thể rename, tạo symlink, thực thi, ghi.
 	+ `a`: không thể rename, tạo symlink, thực thi, chỉ có thể ghi vào cuối file
  	+ `d`: không được backup khi tiến trình dump chạy
   	+ `s`: 1 file có thuộc tính này bị sửa, thay đổi được cập nhật đồng bộ trên ổ cứng	 
	ví dụ:
	+ Khiến 1 file không thể thay đổi, xóa

			sudo chattr +i file

		thì `sudo rm -f file` cũng sẽ trả về lỗi `Operation not permitted`

#### Quản lý người dùng và nhóm

1. <p id="người-dùng">Người dùng:</p>

+ Thêm người dùng:

		useradd | adduser {user_name}

	--> tạo ra thư mục home, các file bash, mail spool tại /var/spool/mail, nhóm mới tên với user_name.

+ Cập nhật mật khẩu người dùng

		sudo passwd {user_name}

+ Xóa người dùng

		userdel | deluser [option] {user_name}

	--> nếu không có option `-r` sẽ chỉ xóa người dùng, không xóa file, thư mục.

+ Thay đổi người dùng

		usermod [option] {user}

	Các option thường sử dụng:
	+ Đặt ngày hết hạn cho tài khoản: `--expiredate`
	+ Thêm nhóm: `-aG`
	+ Thay đổi địa chỉ thư mục home: `-d`
	+ Khóa/mở khóa mật khẩu: `-L/-u`

	Ví dụ: Thêm người dùng tên `bob` vào nhóm `dba_user`
			
			sudo usermod -aG dba_user bob
2. <p id="nhóm">Nhóm:</p>

+ Thêm nhóm

		groupadd [options] {group_name}

  	Tạo nhóm với id cho trước

  		sudo groupadd --gid id group_name

+ Xóa nhóm

		groupdel [options] {group_name}
		
+ Thay đổi nhóm

		groupmod [options] {group_name}

  	Thay đổi tên nhóm

  		sudo groupmod --new-name new_group group_name

  	Thay đổi id nhóm

  		sudo groupmod --gid new_id group_name

#### Quản lý disk

1. <p id="kiểm-tra-disk">Kiểm tra disk:</p>

+ [df](https://www.gnu.org/software/coreutils/manual/html_node/df-invocation.html#df-invocation):

	Báo cáo tổng quan về dung lượng tổng, đã sử dụng, còn lại của các filesystems.

		df [option]... [file]...

	`df -h` sẽ hiển thị dung lượng ở dạng `M,G` dễ đọc

+ [du](https://www.gnu.org/software/coreutils/manual/html_node/du-invocation.html#du-invocation):

	Báo cáo dung lượng cần cho file hoặc các file trong thư mục.

		du [option]... [file]...

	Tương tự, `du -h` sẽ hiện thị bộ nhớ file chiếm dưới dạng `K,M,G`.
	--> Điểm khác biệt của 2 câu lệnh là `df` sẽ chỉ quan tâm đến mounted filesystems chứa file/thư mục, không đi vào chi tiết và `du` chỉ  trả về dung lượng mỗi file chiếm.
2. <p id="phân-vùng-disk">Phân vùng disk:</p>

	Liệt kê các disk:

		fdisk -l

	Bắt đầu việc phân vùng:

		fdisk [options] {device}
		
	hoặc: 

		cfdisk [options] {device} 	--TUI

3. <p id="lab-disk">LAB:</p>

	Thêm 1 ổ 60G với tên `/dev/sda`
	
 	Ổ cứng 60G chia thành 10G,20G,30G
	
 	--> sử dụng `fdisk /dev/sda`

 	Tạo các folder `/mnt/data1`, `/mnt/data2` và `/mnt/data3` sẽ mount vào

	--> `sudo mkdir -p /mnt/data1 /mnt/data2 /mnt/data3`
	
 	Ổ 10G format ext4, mount `/mnt/data1`
	
 	--> `sudo mkfs.ext4 /dev/sda1`
	
 	--> `sudo mount /dev/sda1 /mnt/data1`
	
 	Ổ 20G format xfs, mount `/mnt/data2`
	
 	--> `sudo apt install xfsprogs`
	
 	--> `sudo mkfs.xfs /dev/sda2`
	
 	--> `sudo mount /dev/sda2 /mnt/data2`
	
 	Ổ 30G format ext3, mount `/mnt/data3`
	
 	--> `sudo mkfs.ext3 /dev/sda3`
	
 	--> `sudo mount /dev/sda3 /mnt/data3`
	
 	Có thể kiểm tra đã tạo và mount đúng chưa sử dụng `lsblk`
	Tìm kiếm UUID sử dụng `sudo blkid`
	Tự động mount bằng cách thêm vào file `/etc/fstab`(theo cú pháp tại [Quản lý Filesystems](#quản-lý-filesystems))
	
 	```
	UUID=d10afb5c-80b0-4636-a6c0-a41e8ddfbb47      	/data1  ext4    defaults 	0	2
	UUID=5867dd50-59f1-4c62-b1e1-3552ff8b42c1       /data2  xfs     defaults	0	2
	UUID=54ae99a0-8b6f-4d57-91d9-910394825c9c       /data3  ext3    defaults	0	2
	```
	Sử dụng `sudo mount -a` hoặc khởi động lại hệ thống và kiểm tra.
4. <p id="raid">RAID:</p>

+ Khái niệm:

	Là lưu cùng 1 dữ liệu vào nhiều đĩa ổ cứng, cho phép các hoạt động đọc-ghi dữ liệu đồng thời, tăng hiệu năng, tăng MTBF(trung bình thời gian bị lỗi của phần cứng).
+ Cấu trúc và nguyên lý hoạt động: RAID được chia làm nhiều loại RAID 0,1,2,3,4,5,6,1+0,0+1,....
	+ RAID 0(Tối thiểu 2 ổ cứng): Không có dữ liệu trùng lặp, chia dữ liệu thành nhiều phần và mỗi phần lưu vào 1 ổ. Tốc độ đọc và ghi tăng nhưng mức độ đảm bảo dữ liệu không thay đổi so với 1 ổ. 
	+ RAID 1(Tối thiểu 2 ổ cứng): Các ổ đều chứa dữ liệu giống nhau. Tốc độ đọc tăng nhưng tốc độ ghi không đổi, dữ liệu được đảm bảo so với 1 ổ.	
	+ RAID 5(Tối thiểu 3 ổ): Dữ liệu chia ra làm nhiều phần và các phần đều được lưu trữ vào từng ổ ngoại trừ ổ cuối cùng lưu trữ bản sao backup của dữ liệu trên(dữ liệu backup này sẽ được lưu vào các ổ khác nhau, lần lượt từng ổ). Dữ liệu được đảm bảo nếu mất đi 1 ổ, tốc độ đọc-ghi tăng so với 1 ổ nhưng không bằng RAID 0.
Ví dụ: Có 3 ổ cứng, dữ liệu A được chia làm A1, A2 lưu vào ổ 1 và ổ 2, ổ 3 sẽ lưu backup của A. Dữ liệu B được chia làm B1, B2 lưu vào ổ 2 và ổ 3, ổ 1 lưu backup của B.

+ Quản lý RAID sử dụng [mdadm](https://manned.org/mdadm):

		mdadm [mode] <raiddevice> [options] <component-devices>

	Các lệnh cơ bản:
	+ Tạo array:
	
			sudo mdadm --create /dev/md/MyRAID --level raid_level --raid-devices number_of_disks /dev/sdXN

	+ Dừng array:

			sudo mdadm --stop /dev/md0

	+ Đánh dấu ổ lỗi:

			sudo mdadm --fail /dev/md0 /dev/sdXN

	+ Xóa ổ, phải đánh dấu ổ lỗi trước khi remove ổ:

			sudo mdadm --remove /dev/md0 /dev/sdXN

	+ Thêm ổ vào array:

			sudo mdadm --assemble /dev/md0 /dev/sdXN

		hoặc 

			sudo mdadm -Gv /dev/md0 -l 1 -n 3 -a /dev/sdc3

		Trong đó: 
		+ `-l 1`: raid 1
		+ `-n 3`: tổng số ổ(tính cả ổ cần thêm)
		+ `-a`: thêm

	+ Xóa RAID metadata:

			sudo mdadm --zero-superblock /dev/sdXN

	+ Kiểm tra thông tin chi tiết:

			sudo mdadm --detail /dev/md0
+ <p id="lab-raid">LAB:</p>
	
	Cấu hình VM theo [hướng dẫn](https://gist.github.com/fevangelou/2f7aa0d9b5cb42d783302727665bf80a)(tạo toàn bộ partitions cần thiết unformatted trước khi cấu hình raid).
	Kiểm tra cài đặt sử dụng `cat /proc/mdstat`

		md0: active raid1 sda2[1] sdb2[0] -- boot partition
		md1: active raid1 sda3[0] sdb3[1] -- root

	Cấu hình 2 ổ còn lại Raid 0:

		sudo mdadm --create --verbose /dev/md2 --level=0 --raid-devices=2 /dev/sdc /dev/sdd

	Mount vào /mnt/md2 để kiểm tra:

		sudo mkfs.ext4 /dev/md2
		sudo mkdir -p /mnt/md2
		sudo mount /dev/md2 /mnt/md2
		cd /mnt/md2

	Kiểm tra sử dụng `sysbench`:

		sudo sysbench fileio --file-total-size=15G --file-test-mode=rndrw prepare

	`--file-total-size=15G`: file test có độ lớn 15G
	`--file-test-mode=rndrw`: chế độ đọc viết ngẫu nhiên
	--> `16106127360 bytes written in 14.81 seconds (1036.594 Mib/sec)`

		sudo sysbench fileio --file-total-size=15G --file-test-mode=rndrw run

	--> `File operations:
				reads/s: 9588.64
				writes/s: 6392.36
				fsyncs/s: 20460.02
			Throughput:
				read, MiB/s: 149.82
				written, MiB/s: 99.88`

		sudo sysbench fileio --file-total-size=15G --file-test-mode=rndrw cleanup

	--> Xóa các file đã tạo

	Reset 2 ổ cứng:
	
		sudo umount /dev/md2
		sudo mdadm --stop /dev/md2
		sudo mdadm --zero-superblock /dev/sdc
		sudo mdadm --zero-superblock /dev/sdd

	Cấu hình 2 ổ RAID 1:
	
		sudo mdadm --create --verbose /dev/md2 --level=1 --raid-devices=2 /dev/sdc /dev/sdd

	Mount vào /mnt/md2 để kiểm tra:

		sudo mkfs.ext4 /dev/md2
		sudo mkdir -p /mnt/md2
		sudo mount /dev/md2 /mnt/md2
		cd /mnt/md2
	Sử dụng `sysbench` để kiểm tra:

		sudo sysbench fileio --file-total-size=15G --file-test-mode=rndrw prepare
	--> `16106127360 bytes written in 23.59 seconds (651.01 MiB/sec)`

		sudo sysbench fileio --file-total-size=15G --file-test-mode=rndrw run
	--> `File operations:
				reads/s: 6781.03
				writes/s: 4520.66
				fsyncs/s: 14470.25
			Throughput:
				read, MiB/s: 105.95
				witten, MiB/s: 70.64`


	So sánh RAID 1 và RAID 0 tại 2 ổ `/dev/sdc` và `/dev/sdd` cho thấy:
	RAID 0 trong quá trình: đọc 149.82 MiB/s, ghi 99.88 MiB/s
	RAID 1 trong quá trình: đọc 105.95 MiB/s, ghi 70.64 MiB/s
	--> Tốc độ đọc, ghi của RAID 0 nhanh hơn RAID 1.
			
	Trong VM có 2 ổ hệ thống là `/dev/sda` và `/dev/sdb`. Thử loại bỏ `/dev/sdb` tại VM
	--> Thời gian boot lâu nhưng hệ thống vẫn boot thành công.
	Kiểm tra sử dụng `cat /proc/mdstat`:

		md1: active raid1 sda3[0]
		md0: active raid1 sda2[3]

	Kiểm tra chi tiết sử dụng `sudo mdadm --detail /dev/md0`:
	
	|Number|Major|Minor|RaidDevice|State| |
	|----------|------|--------|-------------|------|-|
	|  -           | 8 | 0 | 0 | removed| |
	|3 |8|2|1|active sync| /dev/sda2|

#### Quản lý log file

Trong phần [thư mục](#quản-lý-filesystems), các log file được lưu tại `/var/log` và các thư mục con trong đó.

`/var/log/syslog` chứa dữ liệu hoạt động của toàn hệ thống trong `Debian, Ubuntu,...`.
`/var/log/auth.log`: những vấn đề liên quan đến bảo mật.
`/var/log/kern.log`: những sự kiện, lỗi, cảnh báo về kernel...

`Rotate Log`: quá trình giới hạn các file log về kích thước, thời gian,... thì sẽ đổi tên file log và tạo ra 1 file log mới trùng tên với file log ban đầu, tiếp tục ghi log vào file mới tạo.

Để thực hiện `Rotate Log`, sử dụng `logrotate`
Cấu hình `logrotate` tại `/etc/logrotate.conf`: 

```
# see "man logrotate" for details
# global options do not affect preceding include directives
# rotate log files weekly
weekly

# use the adm group by default, since this is the owning group
# of /var/log/syslog.
su root adm

# keep 4 weeks worth of backlogs
rotate 4

# create new (empty) log files after rotating old ones
create

# use date as a suffix of the rotated file
#dateext

# uncomment this if you want your log files compressed
#compress

# packages drop log rotation information into this directory
include /etc/logrotate.d

# system-specific logs may also be configured here.
```

Cấu hình từng log file cụ thể tại `/etc/logrotate.d/`, ví dụ `/etc/logrotate.d/rsyslog`
```
/var/log/syslog
/var/log/mail.info
/var/log/mail.warn
/var/log/mail.err
/var/log/mail.log
/var/log/daemon.log
/var/log/kern.log
/var/log/auth.log
/var/log/user.log
/var/log/lpr.log
/var/log/cron.log
/var/log/debug
/var/log/messages
{
        rotate 4
        weekly
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                /usr/lib/rsyslog/rsyslog-rotate
        endscript
}
```
---> toàn bộ các file `/var/log/syslog`, `/var/log/mail.info`,... sẽ có cùng cấu hình với các thông số:
+ `create {permission} {owner} {group}`: tạo file log với `{permission}` cho chủ sở hữu và nhóm.
+ `rotate 4`: giữ 4 file log
+ `weekly`: chạy rotate hàng tuần
+ `missingok`: nếu file log không tồn tại sẽ tự động chuyển đến cấu hình log file khác mà không thông báo lỗi
+ `notifempty`: không rotate nếu file trống
+ `compress`: nén file sau khi rotate(mậc định sử dụng `gzip`, `compresscmd {zip_method}` nếu muốn sử dụng phương pháp khác)
+ `delaycompress`: không nén file ngay, file được nén vào lần rotate lần sau
+ `sharescripts`: các scripts được thêm vào cấu hình sẽ chỉ chạy 1 lần thay vì chạy cho mỗi file
+ `postrotate ... endscript`: các scripts chạy sau khi rotate và trước khi nén, muốn chạy sau khi nén thì sử dụng `lastaction`
+ Ngoài ra còn 1 số thông số như:
	+ `copy`: tạo bản sao mà không thay đổi bản gốc
	+ `dateext`: thêm thông số ngày,tháng, năm vào tên file gốc thay vì chỉ thêm số ( sử dụng thêm `dateformat` để điều chỉnh cách thể hiện ngày, tháng, năm thêm vào)
	+ `mail`: các file log hết hạn, trước khi xóa sẽ được gửi đến địa chỉ mail
	+ `size`: log file sẽ rotate khi nó lớn hơn số bytes cài đặt...

Có thể test các cấu hình các log file sử dụng `sudo logrotate /etc/logrotate.conf --debug`

#### Quản lý công việc 

Trong phần [StartUp Script](#startup-script), các file script có thể tự khởi chạy sử dụng `@reboot` trong `cron`. Ngoài ra, có thể lập trình thời gian chạy khác cho file script. Thêm đoạn code vào `crontab -e`

		{minute} {hour} {day of month} {month} {day of week} /bin/sh path/to/command

với các giá trị `minute, hour, day of month, month, day of week`, ngoài các giá trị cụ thể, còn có:
		
+ `*`: tất cả các giá trị
+ `,`: 2 hoặc nhiều lần thực thi lệnh
+ `-`: khoảng thời gian thực thi lệnh
+ `/`: khoảng thời gian cụ thể
+ `L`: ngày cuối cùng của tuần trong tháng
+ `W`: ngày gần nhất trong tuần
+ `#`: ngày của tuần

Ví dụ:

+ Thực thi lệnh 2 lần 1 ngày vào lúc 6h và 18h:
	
		0 6,18 * * * /bin/sh path/to/file
+ Thực thi lệnh mỗi 6h:
	
		0 */6 * * * /bin/sh path/to/file

+ Thực thi lệnh hàng quý ngày mồng 1 lúc 8h:

		* 8 1 */3 * /bin/sh path/to/file

Nếu chỉ muốn chạy lệnh 1 lần trong 1 thời gian biết trước, có thể sử dụng `at`: lệnh `at` sẽ gửi mail lại cho người cài đặt về kết quả output và lỗi.

	echo {command} | at {-t time hoặc now + time minutes}

Thực thi nhiều lệnh bằng `at`:

	at {-t time hoặc now + time minutes}
	-->  command --> ... --> CRTL d

[back to top](#sysadminintern)
## Network

### IP

Thông tin về IP `ip -c a`

1. <p id="ip-tĩnh">IP tĩnh:</p>

	Thiết lập IP tĩnh cho Ubuntu: chỉnh sửa file tại `/etc/netplan/`(nếu không có file có thể tạo sử dụng `sudo netplan generate`)
	Nội dung file cơ bản:
	```
	network:
		version: 2
		renderer: NetworkManager
		ethernets:
			ens33:
				dhcp4: false
 				dhcp6: false
				addresses: 
					- 192.168.109.100/24
				routes:
					- to: default
						via: 192.168.109.28
				nameservers:
					addresses:
						- 8.8.8.8
	```
	Trong đó:
	+ `version: 2`: định nghĩa mạng phiên bản 2
	+ `renderer`: công cụ kiểm soát mạng, mặc định là `systemd-networkd`
	+ `ethernets`: mạng có dây, các thiết bị khác như `modems`,`wifis`,`bridges`
	+ `ens33`: tên thiết bị mạng có trong `ip -c a`
	+ `dhcp4`, `dhcp6`: vì đang thiết lập IP tĩnh, không muốn tự động cấp IP cho mạng nên để giá trị `false`
	+ `addresses`: IP tĩnh muốn thiết lập
	+ `routes`: danh sách các địa chỉ ( `- to`) và cách để đến các địa chỉ này (`via`)(router hoặc thiết bị mạng cung cấp IP)
	+ `nameservers`: DNS server

	Kiểm tra cấu hình đã đúng chưa

		sudo netplan try

	Nếu không có lỗi sẽ được hỏi có muốn sử dụng cấu hình luôn. Hoặc có thể tự sử dụng cấu hình

		sudo netplan apply
3. <p id="ip-động">IP động:</p>

	Chỉnh sửa file tại `/etc/netplan/` với nội dung

	```
	network:
		version: 2
		renderer: NetworkManager
		ethernets:
			ens33:
				dhcp4: true
				dhcp6: true
	```
Sử dụng IP tĩnh cho các server và thiết bị mạng (các thiết bị cần được truy cập bằng các thiết bị, hệ thống khác --> dễ tìm kiếm) 
Các máy tính, điện thoại cá nhân,... nên sử dụng IP động(dễ dàng gán các địa chỉ IP từ các địa chỉ IP khả dụng)

[back to top](#sysadminintern)
### DNS
1. <p id="lý-thuyết-dns">Lý thuyết:</p>

+ DNS (Domain name system): hệ thống phân giải tên miền, từ tên miền có thể trả về địa chỉ IP tương ứng và ngược lại.
+ Cơ chế hoạt động:
	+ Người dùng nhập tên miền hoặc địa chỉ trang web muốn truy cập
	+ Trình duyệt gửi tin, truy vấn DNS đệ quy để tìm IP hoặc địa chỉ mạng tương ứng
	+ Nếu `recursor DNS server` không có kết quả, nó sẽ truy vấn tới các server khác theo trình tự: `root name server`, `Top-level domain name server` và `authoritative name server`
	+ Ba loại server cùng làm việc và điều hướng cho đến khi nhận được thông tin DNS chứa IP cần truy vấn. Thông tin sau đó được gửi ngược lại `server DNS đệ quy` và trang web người dùng tìm kiếm được hiển thị. Công việc chính của `root name server` và `TLD name server` là định hướng, hiếm khi cung cấp thông tin
	+ `recursor DNS server` lưu, hoặc tạm lưu vào bộ nhớ đệm thông tin domain và địa chỉ IP của nó để lần sau có thể trực tiếp xử lý truy vấn của domain, IP đó thay vì lại truy vấn vào các server khác	
	+ Nếu yêu cầu truy vấn đã đến `authoritative name server` mà không có kết quả, sẽ trả lại thông báo lỗi
+ Các loại DNS server:
	+ Recursor Server:	
		Hoạt động như một thư viện, sẽ tìm kiếm thông tin về địa chỉ IP trong cơ sở dữ liệu của mình, nếu có thì trả về địa chỉ IP, nếu không sẽ truy vấn tới các server khác.
	+ Root name Server:
		Là server đầu tiên mà `Recursor Server` sẽ tìm kiếm nếu không có thông tin về địa chỉ IP. Là dịch vụ phân giải tên miền gốc, quản lý tất cả tên miền top-level, giúp định hướng truy vấn đến địa chỉ.
	+ TLD name Server:
		Lưu thông tin tên miền có phần mở rộng chung(.com, .net, .org,...), trả về địa chỉ của tên miền thấp hơn.
	+ Authoritative name Server:
		Lưu trữ toàn bộ thông tin về domain và subdomain, phân giải địa chỉ IP cần thiết cho `Recursor server` nếu có.
	+ Local main server:
		Duy trì và phát triển bởi tư nhân, lưu trữ domain và IP trả về truy vấn trực tiếp, không thông qua các server khác.
+ Các loại truy vấn DNS:
	+ Truy vấn đệ quy:
		Server trả về thông tin được yêu cầu(bằng cách gọi các server khác) hoặc báo lỗi nếu không tìm thấy
	+ Truy vấn không đệ quy:
		Server trả về trực tiếp thông tin dựa vào lưu trữ trước đó
	+ Truy vấn lặp lại:
		Nếu không có thông tin trùng với truy vấn, server trả về thông tin giới thiệu(gần với truy vấn nhất) đến server DNS mức thấp hơn. client sau đó sẽ thực hiện truy vấn tới địa chỉ được giới thiệu(tiếp tục cho đến khi lỗi hoặc hết thời gian)
+ Các bản ghi DNS thường sử dụng:

	+ A: Bản ghi lưu hostname với địa chỉ IPv4
	+ AAAA: tương tự `A` nhưng với địa chỉ IPv6
	+ CNAME: lưu tên hostname dưới tên khác, khi trả về client thì client sẽ truy vấn hostname với yêu cầu khác để biến bí danh thành `A hoặc AAAA`
	+ MX: lưu hostname của server SMTP email, dùng khi định hướng emails tới domain này bởi dịch vụ email
	+ TXT: lưu thông tin đọc được bởi người hoặc máy, dùng để xác minh, xác thực hoặc chuyển dữ liệu khác
	+ NS: lưu thông tin nameserver có nhiệm vụ cung cấp thông tin DNS cho domain
	+ PTR: ngược lại, cung cấp tên của hostname dựa vào địa chỉ IP
	+ SRV: tương tự `MX`, nhưng dùng cho các giao thức liên lạc khác để giúp với việc phát hiện
	+ SOA: Bản ghi quyền quản trị cho vùng tên domain, thể hiện `authorirarive name server` cho domain hiện tại, thông tin liên hệ, serial và thông tin về sự thay đổi của DNS
+ Để tìm địa chỉ IP cho domain:
	
		dig +short {domain-name}

	ở đây để tìm địa chỉ IP của trang web `dantri.vn` sử dụng `dig +short dantri.vn` --> `42.113.206.28`
2. <p id="lab-dns">LAB:</p>
+ Cấu hình DNS server
	Cấu hình DNS nghe IPv4: Sửa đổi file `/etc/default/named`

		OPTIONS="-u bind -4"

	Cấu hình Forward Zone (tên miền sang ip) và Reverse Zone (ip sang tên miền)  tại `/etc/bind/named.conf.local`

		zone "toilamlap.com" IN { 
			type master;
			file "/etc/bind/forward.toilamlap.com"; 
			allow-update {none; };
		}; 
		
		zone "89.45.103.in-addr.arpa" IN { --địa chỉ ngược lại của 3 số đầu ip
			type master;
			file "/etc/bind/reverse.toilamlap.com";
			allow-update {none; };
		};

	Tạo các file`forward.toilamlap.com` và `reverse.toilamlap.com` bằng các file mẫu

		sudo cp /etc/bind/db.local /etc/bind/forward.toilamlap.com

		sudo cp /etc/bind/db.127 /etc/bind/reverse.toilamlap.toilamlap.com

	Cấu hình file `forward.toilamlap.com`

		$TTL	604800
		@		IN			SOA	toilamlap.com.	root.toilamlap.com. (
									11					; Serial --tăng mỗi lần thay đổi
								604800				    ; Refresh
								 86400                  ; Retry
							   2419200			        ; Expire
							    604800 )			    ; Negative Cache TTL
		@		IN			NS	toilamlap.com.
				IN			A	103.45.89.45
		
	Cấu hình file `reverse.toilamlap.com`

		$TTL	604800
		@		IN			SOA	toilamlap.com.	root.toilamlap.com. (
									21					; Serial --tăng mỗi lần thay đổi
								604800				    ; Refresh
								 86400                  ; Retry
							   2419200			        ; Expire
							    604800 )			    ; Negative Cache TTL
		@		IN			NS	toilamlap.com.
				IN			A	103.45.89.45
		45		IN			PTR	toilamlap.com.

	Kiểm tra `config` đã hợp lệ chưa 

		sudo named-checkconf /etc/bind/named.conf.local
		
		sudo named-checkzone toilamlap.com /etc/bind/forward.toilamlap.com
		-- zone toilamlap.com/IN: loaded serial 11
		-- OK
		sudo named-checkzone toilamlap.com /etc/bind/reverse.toilamlap.com	
		-- zone toilamlap.com/IN: loaded serial 21
		-- OK
		
+ Cấu hình client
	Khi chưa trỏ client vào DNS server

		dig toilamlap.com 
		-- com.	5	IN	SOA	a.gtld-servers.net.	nstld.verisign-grs.com.	17044772599	1800	900	604800	86400

	Trỏ client vào DNS server tại `/etc/resolv.conf`(tạm thời)

		search toilamlap.com
		nameserver 192.168.109.130 --ip của dns server

  	Nếu muốn trỏ vào vĩnh viễn, cung cấp `addresses` cho `nameserver` như trên <a href="#ip-tĩnh">IP tĩnh</a>.

	Sau khi trỏ

		dig toilamlap.com
		-- toilamlap.com.	6453	IN	A	103.45.89.45
		-- ;;SERVER: 192.168.109.130#53(192.168.109.130) (UDP)

		dig -x 103.45.89.45
		-- 45.89.45.103.in-addr.arpa.	6468	IN	PTR	toilamlap.com.
		-- ;;SERVER: 192.168.109.130#53(192.168.109.130) (UDP)

	--> DNS server chạy port mặc định 53 UDP

[back to top](#sysadminintern)
### DHCP
1. <p id="lý-thuyết-dhcp">Lý thuyết:</p>

	DHCP giao tiếp sử dụng giao thức UDP, dùng port 67 để nghe thông tin đến và port 68 để trả lời.
+ Nguyên lý hoạt động:
	
	+ Client tạo bản tin `DISCOVERY` để yêu cầu cung cấp IP gửi cho server
	+ Client chưa biết địa chỉ chính xác của server sẽ cấp IP nên gửi bản tin dưới dạng boardcast
	+ Server nhận bản tin `DISCOVERY` và kiểm tra địa chỉ IP nào phù hợp để cấp pháp
	+ Server gửi bản tin `OFFER`(bao gồm thông tin về IP và các cấu hình khác mà client yêu cầu để truy cập mạng) dưới dạng boardcast
	+ Client nhận và chọn `OFFER` đầu tiên nhận được. Nếu không nhận được `OFFER` trong 1 khoảng thời gian, client sẽ gửi lại bản tin `DISCOVERY`
	+ Client gửi bản tin `REQUEST` dưới dạng boardcast, server nào nhận `OFFER` thì có nghĩa là client đồng ý nhận IP, server nào không nhận `OFFER` thì bỏ qua gói tin này
	+ Server nhận `OFFER` kiểm tra IP còn sử dụng được hay không. Nếu còn thì ghi nhận thông tin và gửi lại gói tin `PACK`, nếu không gửi gói tin `PNAK` và quay lại bước 1
2. <p id="lab-dhcp">LAB:</p>

	Cấu hình DHCP server tại `/etc/dhcp/dhcpd.conf`

	```
	default-lease-time 600;
	max-lease-time 7200;
	authoritative;

	ddns-update-style none;
	subnet 192.168.109.0 netmask 255.255.255.0 {
		range 192.168.109.100 192.168.109.200;
		option routers 192.168.109.254;
		option domain-name-servers 192.168.109.135 192.168.109.136;
	}
	host dungnt-dns {
	hardware ethernet 00:0c:29:8f:ff:3a;
	fixed-address 192.168.109.10;
	}
	```
	Trong đó:
	+ `default-lease-time`: thời gian tối thiểu mà thiết bị gán 1 IP
	+ `max-lease-time`: thời gian tối đa mà IP có thể gán cho thiết bị
	+ `authoritative`: Server DHCP là server chính thức cho mạng cục bộ
	+ `ddns-update-style`: Server liệu có thử cập nhật dns server khi xác nhận gán IP không
	+ `subnet <192.168.109.0> netmask <255.255.255.0> `: địa chỉ mạng và định nghĩa mạng của server(sử dụng `ip -c a`)
	+ `range <192.168.109.100> <192.168.109.200>`: dải IP mà Server sẽ gán cho thiết bị 
	+ `option routers <192.168.109.254>`: server "khuyến khích" các thiết bị sử dụng làm default gateway
	+ `option domain-name-servers <192.168.109.135> <192.168.109.136>`: dns server kèm theo với default gateway
	+ `host <dungnt-dns>`: tên host của thiết bị muốn gán IP cố định
	+ `hardware <ethernet> <00:0c:29:8f:ff:3a>`: phần cứng mạng của thiết bị(tên và địa chỉ IPv6)
	+ `fixed-address 192.168.109.10`: địa chỉ IP muốn gán cố định

	Gán DHCP Server cho 1 giao diện cụ thể tại `/etc/default/isc-dhcp-server`:
	```
	INTERFACESv4="ens33"
	```
	Khởi động lại DHCP server
		
		sudo systemctl restart isc-dhcp-server

	Kiểm tra DHCP server
		
		sudo systemctl status isc-dhcp-server
	hoặc
		
		journalctl _PID=<id của isc-dhcp-server>

[back to top](#sysadminintern)
### SSH

Cho phép kết nối giữa máy chủ và máy khách một cách bảo mật, có thể bằng mật khẩu, key(1 cặp public và private key). 
	
Private key dùng để định danh người dùng, chỉ được lưu tại máy người dùng, không chia sẻ. 

Public key dùng để xác thực người dùng, copy tới ssh host. Khi client muốn ssh sử dụng key, public key sẽ được kiểm tra với private key, nếu phù hợp sẽ cho kết nối.
	
SSH cung cấp giao diện chữ(terminal) để làm việc, các câu lệnh được gửi tới máy khách và thực hiện tại đó.
	
SSH tới host

	ssh <user_name>@<IP|domain of host>

nếu tên người client dùng trùng với tên người dùng tại host

	ssh <IP|domian of host>

Mặc định sẽ ssh sử dụng port 22, nếu muốn sử dụng port khác

	ssh <user_name>@<IP|domain of host> -p <port_number>

Copy `public key` tới host --> ssh không cần mật khẩu

	ssh-copy-id <use_name>@<IP|domain of host>

hoặc 

	cat ~/.ssh/id_rsa.pub | ssh <user_name>@<IP|domain of host> "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

Tạo key ssh

	ssh-keygen 

Mặc định sẽ tạo ra key RSA 2048 bit. Có thể tùy biến như loại xác thực, số byte, ....

	ssh-keygen -t <authentication_type> -b <byte number> ...

Trong lúc tạo key có thể cài thêm mật khẩu cho key để tăng bảo mật. Thay đổi mật khẩu này bằng

	ssh-keygen -f <private_key> -p

Khi private key có mật khẩu mà không muốn nhập lại mật khẩu đó mỗi lần ssh, sử dụng `ssh-add`

	eval $(ssh-agent) -- khởi chạy agent trong nền
	ssh-add		   -- thêm private key để agent quản lý
		
[back to top](#sysadminintern)
### rsync và scp 

rsync trên cùng 1 máy

	rsync [option]... source... dest

rsync trên 2 máy khác nhau

+ Từ client đến server

		rsync -azv source <user_name>@<IP|domain of host>:dest

+ Từ server đến client tại client

		rsync -azve ssh <user_name>@<IP|domain of host>:source dest

	Trong đó:
	+ `-a`: tất cả symlink, thuộc tính, quyền,... đều được giữ nguyên
	+ `-z`: nén các file trong lúc truyền
	+ `-v`: hiện quá trình
	+ `-e`: remote shell sử dụng, ở đây là ssh

scp trên cùng 1 máy

	scp [option]... source... dest

scp trên 2 máy khác nhau

+ Từ client đến server

		scp source... <user_name>@<IP|domain of host>:/dest

+ Giữa 2 server thông qua client

		scp -3 <user_name1>@<IP|domain of host 1>:<port_number>/path/to/source <user_name2>@<IP|domain of host 2>:<port_number>/path/to/dest
  Lưu ý đường dẫn là `path/to/source`, `path/to/dest` nếu muốn đường tuyệt đối sử dụng `<user_name1>@<IP|domain of host 1>:<port_number>//absolute/path`

[back to top](#sysadminintern)


