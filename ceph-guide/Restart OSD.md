Set flags cho cluster

    ceph osd set noout
    ceph osd set noscrub
    ceph osd set nodeep-scrub
    ceph osd set nosnaptrim

Lấy osd id bỏ vào 1 file

    ceph osd df tree | grep <tên node> -A 44 | awk '{print $1}'

Stop lần lượt từng OSD (chờ PG về trạng thái active hết rồi mới stop osd tiếp theo)

    #for i in `cat <file>`;do systemctl stop ceph-osd@$i; sleep 5;done

Mask các service osd để khi reboot các osd không tự động restart

    #for i in `cat <file>`;do systemctl mask ceph-osd@$i;done

Reboot server

Start từng OSD (Chờ PG về trạng thái active hết rồi mới start osd tiếp theo)

    #for in `cat <file>`;do systemctl unmask ceph-osd@$i; systemctl start ceph-osd@$i; sleep 60;done

Set backfill cho OSD về 1

    ceph tell osd.* injectargs '--osd-max-backfills 1'

Unset flags cho cluster

    ceph osd unset noout
    ceph osd unset noscrub
    ceph osd unset nodeep-scrub
    ceph osd unset nosnaptrim
