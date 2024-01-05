# SysAdminIntern

## Linux

### Các lệnh cơ bản

1. Thay đổi thư mục:
	
		cd [path]

	`path` có thể là tương đối hoặc tuyệt đối 

2. Xem thư mục đang làm việc

		pwd [options]

	options:
	+ -L: bao gồm cả symlinks
	+ -P: không bao gồm symlinks

3. Lịch sử lệnh

		history

	nếu sử dụng bash thì lịch sử sẽ được lưu trong `.bash_history` 

	Xem 1 câu lệnh trước/sau sử dụng mũi tên lên/xuống.

	Kết quả trả về có dạng `{number} {command}`
	--> thực thi lại câu lệnh `!{number}` ( `!!` sẽ thực thi lại câu lệnh cuối cùng)

	Tìm các lệnh trong lịch sử dùng reverse-i search sử dụng `CTRL + r` -> câu lệnh -> `CTRL + r` để duyệt hoặc `CTRL + s` duyệt ngược lại.

4. Xử lý văn bản

+ [cat](https://www.gnu.org/software/coreutils/manual/html_node/cat-invocation.html#cat-invocation): nối các văn bản và cho đầu ra là nội dung các file.

		cat [options] [file] ...
		
	Tạo file:
	
		cat > file
		
	Gộp file:
	
		cat file1 file2 ... > file_destination  
			
	Ghi kết quả vào file:
	
		cat file1 > file2 hoặc cat file1 >> file2 nếu muốn ghi vào cuối file

+ [tac](https://www.gnu.org/software/coreutils/tac): tương tự như `cat` nhưng in ngược lại (dòng cuối in đầu tiên)
+ [sort](https://www.gnu.org/software/coreutils/sort): sắp xếp các dòng trong các tập files.

		sort [options] [file] ...
	
	Ghi kết quả vào file:
	
		sort file -o file_destination
		
	hoặc
		
		sort file > temp && mv temp file
	
+ [split](https://www.gnu.org/software/coreutils/split): chia file thành các file nhỏ

		split [option]... [file [prefix]]
		
	--> tạo ra các file prefixaa, prefixab, ... ( prefix mặc định là x)
		
	ví dụ: `split -l 1 file split_file` --> chia file thành các file split_fileaa, split_fileab,... mỗi file có 1 dòng.

+ [uniq](https://www.gnu.org/software/coreutils/uniq): báo cáo hoặc bỏ qua các dòng lặp lại trong file

		uniq [options] [input [output]]

	kết hợp pipe: `sort file | uniq -cd` --> cho lần lặp lại và dòng lặp lại.

+ [nl](https://www.gnu.org/software/coreutils/nl): trả về số dòng có trong files

		nl [options] [file]...

	kết quả trả về có dạng `{number} {line}`

+ [head](https://www.gnu.org/software/coreutils/head): trả về nửa đầu của files(mặc định là 10 dòng đầu)

		head [options] [file]...

+ [tail](https://www.gnu.org/software/coreutils/tail): trả về nửa sau của files(mặc định là 10 dòng cuối)

		tail [options] [file]...

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

+ [grep](https://www.gnu.org/software/grep/manual/grep.html): trả về các dòng phù hợp với chuỗi/ký tự tìm kiếm.

		grep [option...] PATTERNS [file...]

	nếu muốn tìm kiếm nhiều từ khóa hoặc từ khóa bắt đầu bằng "-":
		
		grep [option...] -e PATTERNS... [file...]

	hoặc nếu các PATTERNS nằm trong 1 file có thể sử dụng:
	
		grep [option...] -f PATTERN_FILE ... [file...]

	thường sẽ sử dụng cùng [regex](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions/Cheatsheet) để tìm kiếm các chuỗi cụ thể.
	
	ví dụ: tìm kiếm số điện thoại có "-" ở giữa

		grep '[0-9]\+-[0-9]\+-[0-9]\+' file

	các output hợp lệ `012-322`, `1-2-3`,...

+ [sed](https://www.gnu.org/software/sed/manual/sed.html): lọc và xử lý chữ trong file hoặc kết quả của pipeline.

		sed [option]... {script} [file]...

	sử dụng `-i` nếu muốn thay đổi tại chỗ thay vì in ra màn hình.

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

### Quản lý tiến trình

1.  Thông tin tiến trình

+ Lệnh `ps`: thông tin về các tiến trình đang chạy của người dùng hiện tại.
	`ps aux` sẽ liệt kê toàn bộ tiến trình của toàn bộ người dùng(`a`), các tiến trình không kết nối với terminal nào(`x`) và nhiều thông tin hơn(`u`).

+ Lệnh `top`: tương tự như lệnh `ps` nhưng đưa thông tin liên tục thời gian thực cho đến khi báo dừng(`CRTL C`).
+ Lệnh `htop`: tương tự `top` nhưng nâng cấp giao diện, dễ đọc.
+ Lệnh `uptime`: cho biết `load-average` của hệ thống. `load-average` là trung bình số threads đang chạy hoặc trong hàng chờ để chạy.
Lệnh `uptime` trả về kết quả `load average: 0,74, 0,77, 0,64` - các thông số lần lượt là trung bình trong 1 phút, 5 phút và trong 15 phút.

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

2. Quản lý tiến trình

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
		
### Quản lý packages

1. Cài đặt phần mềm:

		sudo apt install {package}

2. Gỡ phần mềm:
	
		sudo apt remove {package} -y

	sau khi gỡ bỏ package thì nên sử dụng `sudo apt update`.

3. Cập nhật thông tin package:

		sudo apt update

	câu lệnh sử dụng khi cần cập nhật danh sách package trong kho repositories.

4. Cập nhật phiên bản package:

		sudo apt upgrade

	câu lệnh sẽ cập nhật phiên bản của các package có sẵn trong máy thông qua thông tin về package cập nhật từ `sudo apt update`.
5. Danh sách package đã cài:

		sudo apt list --installed

	từ đây nếu muốn xem đã cài package nào chưa `sudo apt list --installed | grep {package}`
		

### StartUp Script

1. Tạo file service:

	Có thể tạo file với đuôi .service tại `/etc/systemd/system` 

	Cấu trúc file cơ bản
	

		[Unit]
		Description=My custom startup script
	
		[Service]
		ExecStart=/bin/bash path/to/bash_script 
	
		[Install]
		WantedBy=multi-user.target

	Để có thể chạy khi hệ thống khởi động `sudo systemctl enable custom.service`

2.  Sử dụng cron:

	Có thể thếm vào crontab file với câu lệnh `crontab -e` đoạn code khởi tạo cùng hệ thống

		@reboot sh path/to/file

	Tuy vậy, không phải phiên bản nào của cron cũng hỗ trợ `@reboot`.

3. Sử dụng rc.local;

	Có thể thêm vào file `/etc/rc.d/rc.local` đoạn code chạy file (vì file rc.local sẽ chạy lúc hệ thống khởi động)

		sh path/to/file

	Cần đảm bảo file rc.local có thể chạy được `chmod +x /etc/rc.d/rc.local`

4. Sử dụng init.d:

	Có thể thêm file bash script vào `/etc/init.d` và sử dụng `sudo update-rc.d <service name> defaults [priority]`

### Quản lý hệ thống 

#### Quản lý filesystems

Dùng để quản lý dữ liệu đọc và lưu của hệ thống.
	
Các filesystems thông thường: ext{2,3,4}, ntfs, vfat, proc,...

Hệ thống thư mục trong linux:

| Thư mục     |      Chức năng |
|-------------|:--------------------------:|
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

1. Sửa lỗi filesystems: sử dụng [fsck](https://manned.org/fsck)

	các filesystems cần kiểm tra và sửa nên unmount trước khi chạy câu lệnh.

		fsck [option] path/to/filesystems|device|label|UUID

	nếu không có `option` thì sẽ chỉ trả về tình trạng của filesystems
	`option -r`: để người dùng tự chọn cách sửa 
	`option -a`: tự động sửa 

+ Tạo filesystems: sử dụng [mkfs](https://manned.org/mkfs)

		mkfs [options] [-t type] [fs-option] device [size]

	không có `-t type` thì mặc định sử dụng `ext2`
	trả về 0 thành công và 1 nếu thất bại.

2. Mount/Unmount filesystems: sử dụng [mount](https://manned.org/mount.8) và [umount](https://manned.org/umount.8)

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

1. Các lệnh cơ bản:

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

2. Tìm kiếm file

+ [find](https://manned.org/find): Có thể tìm kiếm file dựa trên tên, đuôi, size, quyền của file, thời gian tạo,...

	ví dụ:
	+ tìm kiếm file được chỉnh sửa trong vòng 10 ngày
		`find / -mtime 10`

	+ tìm kiếm file có dung lượng trong khoảng 50M đến 100M
	`find / -size +50M -size -100M`

	
+ [locate](https://manned.org/locate): Tìm kiếm dựa trên file database tại ``/var/cache/locate/locatedb``, trước khi tìm kiếm cần `sudo updatedb`

	`locate [option]... pattern...`

	ví dụ: 
	+ tìm kiếm file có đuôi `.ini`, giới hạn 3 kết quả
		`locate "*.ini" -l 3`

	+ tìm kiếm các file vẫn còn trên máy có tên `test` ở mục `home`
		`locate -i -e "test" | grep "/home"`
+ [whereis](https://manned.org/whereis): Tìm kiếm tệp nhị phân, nguồn và hướng dẫn cho một câu lệnh

	ví dụ:
	+ tìm kiếm tệp nhị phân cho `gcc` tại thư mục `/usr/lib` và hướng dẫn tại `/usr/share`
	` whereis -bm -B /usr/lib -M /usr/share -f gcc`
+ [which](https://manned.org/which): Tìm kiếm đường dẫn đầy đủ của các lệnh

		which [-a] command... 

	`-a` sẽ in ra toàn bộ các kết quả chứa câu lệnh.

3. Quản lý quyền truy cập, sở hữu

+ [chown](https://www.gnu.org/software/coreutils/manual/html_node/chown-invocation.html#chown-invocation): quản lý quyền của người dùng và nhóm 
	
		chown [option]... {new_owner | --reference=ref_file} file…

	nếu sử dụng `new_owner` thì chỉ định người sở hữu mới và/hoặc nhóm bằng `[owner] [ : [group] ]`
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

4. Quản lý thuộc tính

		chattr [ -RVf ] [ -v version ] [ mode ] files...

	Mục đích chính là khiến file thay đổi bởi người dùng (kể cả superuser) cho đến khi thuộc tính được sửa lại.
	ví dụ:
	+ Khiến 1 file không thể thay đổi, xóa

			sudo chattr +i file

		thì `sudo rm -f file` cũng sẽ trả về lỗi `Operation not permitted`

#### Quản lý người dùng và nhóm

1. Người dùng

+ Thêm người dùng:

		useradd | adduser {user_name}

	--> tạo ra thư mục home, các file bash, mail spool tại /var/spool/mail, nhóm mới tên với user_name.

+ Xóa người dùng

		userdel | deluser [option] {user_name}

	--> nếu không có option sẽ chỉ xóa người dùng, không xóa file, thư mục.

+ Thay đổi người dùng

		usermod [option] {user}

	Các option thường sử dụng:
	+ Đặt ngày hết hạn cho tài khoản: `--expiredate`
	+ Thêm nhóm: `-aG`
	+ Thay đổi địa chỉ thư mục home: `-d`
	+ Khóa/mở khóa mật khẩu: `-L/-u`

2. Nhóm

+ Thêm nhóm

		groupadd [options] {group_name}


+ Xóa nhóm

		groupdel [options] {group_name}
		
+ Thay đổi nhóm

		groupmod [options] {group_name}

#### Quản lý disk

1. Kiểm tra disk

+ [df](https://www.gnu.org/software/coreutils/manual/html_node/df-invocation.html#df-invocation):

	Báo cáo tổng quan về dung lượng tổng, đã sử dụng, còn lại của các filesystems.

		df [option]... [file]...

+ [du](https://www.gnu.org/software/coreutils/manual/html_node/du-invocation.html#du-invocation):

	Báo cáo dung lượng cần cho file hoặc các file trong thư mục.

		du [option]... [file]...


	--> Điểm khác biệt của 2 câu lệnh là `df` sẽ chỉ quan tâm đến mounted filesystems chứa file/thư mục, không đi vào chi tiết và `du` chỉ  trả về dung lượng mỗi file chiếm.
2. Phân vùng disk

	Liệt kê các disk:

			fdisk -l

	Bắt đầu việc phân vùng:

			fdisk [options] {device}
		
	hoặc: 

			cfdisk [options] {device} 	--TUI
3. RAID

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

	+ Xóa ổ:

			sudo mdadm --remove /dev/md0 /dev/sdXN

	+ Thêm ổ vào array:

			sudo mdadm --assemble /dev/md0 /dev/sdXN

	+ Xóa RAID metadata:

			sudo mdadm --zero-superblock /dev/sdXN

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

## Network

### IP

Thông tin về IP `ip -c a`

1. IP tĩnh

	Thiết lập IP tĩnh cho Ubuntu: chỉnh sửa file tại `/etc/netplan/`(nếu không có file có thể tạo)
	Nội dung file cơ bản:
	```
	network:
		version: 2
		renderer: NetworkManager
		ethernets:
			ens33:
				dhcp4: false
				addresses: [192.168.109.100/24]
	```
	Trong đó:
	+ `version: 2`: định nghĩa mạng bản 2
	+ `renderer`: công cụ kiểm soát mạng
	+ `ethernets`: mạng có dây, các thiết bị khác như `modems`,`wifis`,`bridges`
	+ `ens33`: tên thiết bị mạng có trong `ip -c a`
	+ `dhcp4`: vì đang thiết lập IP tĩnh, không muốn tự động cấp IP cho mạng nên để giá trị `false`
	+ `addresses`: IP tĩnh muốn thiết lập
2. IP động



		




