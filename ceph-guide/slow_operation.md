- Nếu không phải nháy nic, chỉ có 1 số OSD bị chậm thì có thể lỗi do disk bị lỗi

- Stop toàn bộ OSD trên node

      ceph osd df tree | grep -A 40 <node> | awk '{print $1}'
      #for i in `cat <tên file>`;do systemctl stop ceph-osd@$i;sleep 3;done

- Loại disk lỗi khỏi raid

- Nếu node không chạy dịch vụ gì khác mà tải vẫn cao thì bắt đầu restart node

  + Mask các OSD

        #for i in `cat <tên file>`;do systemctl mask ceph-osd@$i;done 
  + Restart node

- Start lại các OSD

      #for i in `cat <tên file>`;do systemctl unmask ceph-osd@$i;systemctl start ceph-osd@$i;sleep 30;donedone
