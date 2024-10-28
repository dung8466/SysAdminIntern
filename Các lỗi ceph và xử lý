1. 1 OSD down:

```
ceph osd set noout
ceph osd set noscrub
ceph osd set nodeep-scrub
ceph osd set nosnaptrim

```

- Thử restart lại OSD
- Nếu không được `ceph osd purge osd.<id> --force`

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
