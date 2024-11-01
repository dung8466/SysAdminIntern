Kiểm tra raid có enable locate không

    /opt/MegaRAID/storcli/storcli64 /c0 show activityforlocate
    /opt/MegaRAID/storcli/storcli64 /c1 show activityforlocate

Nếu chưa enable cần enable locate

    /opt/MegaRAID/storcli/storcli64 /c0 set activityforlocate=on
    /opt/MegaRAID/storcli/storcli64 /c1 set activityforlocate=on

Locate tất cả các disk tất cả các disk trong controller 

    for i in {<start>..<end>};do /opt/MegaRAID/storcli/storcli64 /c0/e<Enclosure ID>/s${i} start locate;done
    for i in {<start>..<end>};do /opt/MegaRAID/storcli/storcli64 /c1/e<Enclosure ID>/s${i} start locate;done

Stop locate disk cần xác định

    /opt/MegaRAID/storcli/storcli64 /c1/e<Enclosure ID>/s<Slot ID> stop locate

Sau khi thực hiện xong thao tác cần stop locate tất cả các disk

    for i in {<start>..<end>};do /opt/MegaRAID/storcli/storcli64 /c0/e<Enclosure ID>/s${i} stop locate;done
    for i in {<start>..<end>};do /opt/MegaRAID/storcli/storcli64 /c1/e<Enclosure ID>/s${i} stopop locate;done
