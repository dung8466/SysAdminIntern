Dữ liệu trước restore

![dữ liệu trước restore](pictures/pg_data_before.png)

Stop và remove dữ liệu trên các node

```
systemctl stop patroni
rm -rf /var/lib/postgresql/17/main/
```

![cluster](pictures/pg_cluster_before.png)

Restore lại dữ liệu trên 1 node

```
sudo -u postgres pgbackrest  --stanza=cluster_1 --pg1-path=/var/lib/postgresql/17/main/ restore
systemctl start patroni
```
![cluster2](pictures/pg_cluster_restore.png)

Kiểm tra dữ liệu trên node vừa restore

![dữ liệu sau restore](pictures/pg_data_after.png)

Start lại patroni trên 2 node còn lại --> tự join cluster và sync dữ liệu.
