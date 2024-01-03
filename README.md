# SysAdminIntern

## Làm việc với shell

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
