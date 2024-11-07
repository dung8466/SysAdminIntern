- Xác định disk cần xóa: [hướng dẫn](https://github.com/dung8466/SysAdminIntern/blob/main/ceph-guide/L%E1%BA%A5y%20th%C3%B4ng%20tin%20disk.md)

- Nếu OSD của disk lỗi vẫn up, cần reweight trước khi xóa

        ceph osd crush reweight osd.<id> 0.0

- Đợi pg chuyển hết sang disk khác trước khi remove disk.

        # Lệnh này sẽ xem còn pg nào trên disk không
        ceph osd df tree
        # Lệnh này sẽ check xem cluster còn rebalance không
        ceph -s

- Nếu OSD down rồi thì có thể tiến hành loại luôn disk khỏi cluster

        export i=<osd id>
        ceph osd out ${i};ceph osd crush remove osd.${i};systemctl stop ceph-osd@${i};sleep 5;umount /var/lib/ceph/osd/ceph-${i};ceph auth del osd.${i};ceph osd rm ${i}

- Zap disk

        ceph-volume lvm zap /dev/sd<x> --destroy

- Loại disk lỗi

        /opt/MegaRAID/storcli/storcli64 /c0/v<virtual disk id> del
        hoặc
        ssacli ctrl slot=1 ld <vị trí disk> delete
