Kiểm tra disk vật lý

    ssacli ctrl slot=1 pd all show

Kiểm raid đã bật cache chưa

    ssacli ctrl slot=1 show

Nếu `Configured Drive Write Cache Policy` không phải là `Enable`

    ssacli ctrl slot=1 modify dwc=enable usage=configured forced

Thêm disk HDD,SSD vào raid 0

    ssacli ctrl slot=1 create type=ld drives=<vị trí> raid=0

Add disk SSD theo raid 1 (ld sau khi tạo sẽ không có caching)

    ssacli ctrl slot=2 create type=ld drives=<vị trí disk>,<vị trí disk>,.. raid=1

Thông tin thêm: [HP Smart Storage Admin CLI](https://gist.github.com/mrpeardotnet/a9ce41da99936c0175600f484fa20d03)
