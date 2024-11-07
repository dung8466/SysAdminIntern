- Thông tin disk được lưu trong /opt/diskinfo/yy-mm-dddd.txt

- Chạy script /opt/scripts/all_info_disk.sh để lấy thông tin disk mới nhất. Chạy script mỗi lần reboot, bổ sung disk, remove disk,...

- Mỗi lần reboot thì tên disk mount có thể thay đổi.

- Để xác định disk:
  + Lấy thông tin disk ở file gần nhất khi reboot. Ví dụ reboot ngày 20/10/2024 thì tìm ở file 2024-10-19.txt hoặc xa hơn.
    - Disk thông tin 600605b00d20c390258235e37a7c5924, sdx, 7.276 TB, ST8000NM0055-1RM112 ZA1GHX5L SN05 , /c1/v0, /c1/e8/s0
  + Chạy lại script lấy thông tin disk mới nhất.
    - Disk thông tin 600605b00d20c390258235e37a7c5924, sdk, 7.276 TB, ST8000NM0055-1RM112 ZA1GHX5L SN05 , /c1/v0, /c1/e8/s0
  + Từ WWN của disk (giá trị đầu tiên), slot của disk tại raid controller sẽ xác định được disk mới. 

- Xác định osd đang nằm trên disk nào

      ceph-volume lvm list

- Kết hợp với /opt/diskinfo để tìm disk.

- Có thể sử dụng `iostat /dev/sd<x>` để kiểm tra đọc/ghi của disk.
