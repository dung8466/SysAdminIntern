Kiểm tra health

    ceph health detail

Tắt cảnh báo osd_down tại mon 1 và 2.

Nếu lỗi slow operation từ OSD đến OSD => restart lần lượt từng OSD đến khi hết OSD chậm

Nếu nháy nic liên tục => check với bên TK => Trong khi chờ đưa node về maintain

    ceph osd set noout
    ceph osd df tree | grep <tên node> -A 44 | awk '{print $1}'
    #for i in `cat <file>`;do systemctl stop ceph-osd@$i; sleep 5;done

Đến khi mạng bình thường lại thì start lại OSD

    #for i in `cat <file>`;do systemctl start ceph-osd@$i; sleep 30;done
    ceph tell osd.* injectargs '--osd-max-backfills 1'
    ceph osd unset nooutnoout
    
