Tắt cảnh báo osd_down tại cinder/mon 1 và 2 tại các cụm.

Trong quá trình thêm, luôn theo dõi cluster

    watch ceph -s

Kiểm tra node

    date
    ceph versions

Nếu time không lệch, ceph version đúng thì tiếp tục.

Thao tác trên chính node cần thêm.

Nếu là node data mới, boostrap osd. Nếu không thì bỏ qua

    ceph auth get-or-create client.bootstrap-osd | tee /var/lib/ceph/bootstrap-osd/ceph.keyring
    chown ceph. /var/lib/ceph/bootstrap-osd/ceph.keyring

Zap các disk cần thêm

    #for i in {c..p}; do ceph-volume lvm zap /dev/sd${i} --destroy; done

Chuẩn bị disk

    #for i in {c..p}; do ceph-volume lvm prepare --crush-device-class <hdd | ssd> --data /dev/sd$i; sleep 3; done

    Nếu là NVME: ceph-volume lvm batch --osds-per-device 2 --crush-device-class=nvme /dev/$i --yes

Tìm root, host, weight, id của osd

    ceph osd df tree
  
    * Id sẽ là các id ở dưới cùng chưa có host, có status down
    * Weight giống các osd khác trong node
    * Root sẽ là HDD1,SSD2,....
    * host là tên node

Thêm các id của osd vào 1 file để dễ thao tác nếu có nhiều osd.

Add osd vào crush map, cách tầm 30s thêm 1 osd

    #ceph osd crush add osd.<id> <weight> root=<root> host=<host>

    hoặc

    #for i in `cat osd-id`; do ceph osd crush add osd.${i} weight root=<weight> host=<host>; sleep 30; done

Active osd lên

    cat /var/lib/ceph/osd/ceph-<id>/fsid
    #ceph-volume lvm activate <id> <kết quả lệnh cat>

    hoặc

    for i in `cat osd-id`; do a=`cat /var/lib/ceph/osd/ceph-$i/fsid`; ceph-volume lvm activate $i $a; sleep 60;  done

Chuyển backfill các osd về 1

    ceph tell osd.* injectargs '--osd-max-backfills 1'
