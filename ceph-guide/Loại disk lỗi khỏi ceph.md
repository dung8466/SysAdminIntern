Xác định disk cần xóa: [hướng dẫn]()

Nếu OSD của disk lỗi vẫn up, cần reweight trước khi xóa

    ceph osd crush reweight osd.<id> 0.0

Đợi pg chuyển hết sang disk khác trước khi remove disk.

    # Lệnh này sẽ xem còn pg nào trên disk không
    ceph osd df tree
    # Lệnh này sẽ check xem cluster còn rebalance không
    ceph -s

Nếu OSD down rồi thì có thể tiến hành loại luôn disk khỏi clustercluster

