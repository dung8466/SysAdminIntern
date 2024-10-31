1. 1 OSD down:

```
ceph osd set noout
ceph osd set noscrub
ceph osd set nodeep-scrub
ceph osd set nosnaptrim
```

- Thử restart lại OSD
- Nếu không được `ceph osd purge osd.<id> --force`
- Zap disk: `ceph-volume lvm zap /dev/sd<x> --destroy`
- Loại disk khỏi raid: `storcli64 /c0/v<y> del`

```
ceph osd unset noout
ceph osd unset noscrub
ceph osd unset nodeep-scrub
ceph osd unset nosnaptrim
```

2. Nhiều OSD down:

```
ceph osd set noout
ceph osd set noscrub
ceph osd set nodeep-scrub
ceph osd set nosnaptrim
```

- Reboot server

3. Tim lỗi phần cứng disk:

```
cat messages-* | grep blk_update
```

--> Tên 2 disk, khi reboot thì 2 tên disk này sẽ thay đổi
