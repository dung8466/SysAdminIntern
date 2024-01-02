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

+ cat: nối các văn bản và cho đầu ra là nội dung các file.

		 cat [options] [file] ...
		
	Tạo file:
	
		cat > file
		
	Gộp file:
	
			cat file1 file2 ... > file_destination  
			
	Ghi kết quả vào file:
	
			cat file1 > file2 hoặc cat file1 >> file2 nếu muốn ghi vào cuối file

+ tac: tương tự như `cat` nhưng in ngược lại (dòng cuối in đầu tiên)
+ sort: sắp xếp các dòng trong các tập files.

		sort [options] [file] ...
	
	Ghi kết quả vào file:
	
		sort file -o file_destination
		
	hoặc
		
		sort file > temp && mv temp file
	
+ split: chia file thành các file nhỏ

		split [option]... [file [prefix]]
		--> tạo ra các file prefixaa, prefixab, ... ( prefix mặc định là x)
		
	ví dụ: `split -l 1 file split_file` --> chia file thành các file split_fileaa, split_fileab,... mỗi file có 1 dòng.

+ uniq: báo cáo hoặc bỏ qua các dòng lặp lại trong file

		uniq [options] [input [output]]

	kết hợp pipe: `sort file | uniq -cd` --> cho lần lặp lại và dòng lặp lại.

+ nl: trả về số dòng có trong files

		nl [options] [file]...

	kết quả trả về có dạng `{number} {line}`

+ head: trả về nửa đầu của files(mặc định là 10 dòng đầu)

		head [options] [file]...

+ tail: trả về nửa sau của files(mặc định là 10 dòng cuối)

		tail [options] [file]...

+ less: giống `more` nhưng có thể tiến 1 trang bằng `space` hoặc lùi 1 trang bằng `ESC + v`
Tìm kiếm ngược trong các trang sử dụng `?`, tìm kiếm xuôi sử dụng `/`.

		less [options] [file]...

+ cut: trích xuất 1 đoạn dữ liệu từ các files.

		cut option

