- Kiểm tra có bao nhiêu controller

        ssacli ctrl all show

- Kiểm tra disk và virtual disk:

        ssacli ctrl slot=<controller slot> pd all show
        ssacli ctrl slot=<controller slot> ld all show

- Disk bị đánh trạng thái failed là disk lỗi:

        Array F

          logicaldrive 6 (7.28 TB, RAID 0, Failed)

- Bật/tắt led locate disk:

        ssacli ctrl slot=<controller slot> pd <port number>:<box number>:<slot> modify led=on/offoff
