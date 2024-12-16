#!/bin/bash

# Huong dan su dung: ./remove_osd_down.sh <disk loi>

# Kiểm tra tham số đầu vào
if [ -z "$1" ]; then
        echo "Ví dụ: ./remove_disk_error.sh sdc"
        exit 1
fi

disk=$1

# Kiểm tra xem disk có chứa dữ liệu Ceph hay không
if ! lsblk | grep -A 1 "$disk" | grep -q "ceph"; then
        echo "$disk không phải là disk data của Ceph."
        exit 1
else
        # Lấy thông tin osd từ disk
        osd_disk=$(ceph-volume lvm list | grep "$disk" -B 20 | grep -o "osd\.[0-9]\+")
        echo "Disk $disk: $osd_disk"
        # Kiểm tra xem osd down hay chưa
        osd_status=$(ceph osd df tree | grep "$osd_disk" | awk '{print $(NF-1)}')
        if [ "$osd_status" == "up" ]; then
                # OSD đang up
                # Reweight OSD về 0
                ceph osd crush reweight "$osd_disk" 0.0
                echo "Sleep 60s để pg đi hết"
                sleep 60
        fi
        # Loại osd khỏi cluster
        ceph osd purge --force "$osd_disk"
        # Zap disk
        ceph-volume lvm zap --destroy /dev/"$disk"
        # Lấy thông tin disk trong raid
        vendor=$(/usr/sbin/lshw | grep vendor | awk '{print $2}' | head -n1)
        v_disk=$(bash /opt/scripts/all_info_disk.sh | grep "$disk")
        if [[ $vendor == "Dell" ]]; then
                location=$(bash /opt/scripts/all_info_disk.sh | grep "$disk" | awk -F ',' '{gsub(/^ *| *$/, "", $(NF-1)); print $(NF-1)}')
                echo "Xóa Disk $disk: $location"
                /opt/MegaRAID/perccli/perccli64 "$location" del
        elif [[ $vendor == "Supermicro" || $vendor == "Joyent" ]]; then
                location=$(bash /opt/scripts/all_info_disk.sh | grep "$disk" | awk -F ',' '{gsub(/^ *| *$/, "", $(NF-1)); print $(NF-1)}')
                echo "Xóa Disk $disk: $location"
                /opt/MegaRAID/storcli/storcli64 "$location" del
        elif [[ $vendor == "HPE" ]]; then
                info=$(bash /opt/scripts/all_info_disk.sh | grep "$disk")
                slot=$(echo "$info" | awk -F ', ' '/slot=/ {print $2}' | awk '{print $2}')
                location=$(echo "$info" | awk -F ', ' '/port:box:bay/ {print $NF}' | awk -F ' = ' '{print $2}' | awk -F ':' '{print $3}')
                echo "Xóa Disk $disk: slot $slot logicaldrive $location"
                if [[ $slot == 1 ]]; then
                        ssacli ctrl slot=$slot ld $location delete
                elif [[ $slot == 2 ]]; then
                        ssacli ctrl slot=$slot ld $((location - 30)) delete
                fi
        fi
fi
