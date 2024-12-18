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
        osd_number=$(echo "$osd_disk" | sed 's/osd\.//')
        # Kiểm tra xem osd down hay chưa
        osd_status=$(ceph osd df tree | grep "$osd_disk" | awk '{print $(NF-1)}')
        if [ "$osd_status" == "up" ]; then
                # OSD đang up
                # Reweight OSD về 0
                ceph osd crush reweight "$osd_disk" 0.0
                echo "Sleep 60s để pg active"
                sleep 60
        fi
        # Loại osd khỏi cluster
        ceph osd out "$osd_number"
        ceph osd crush remove osd."$osd_number"
        systemctl stop ceph-osd@"$osd_number"
        sleep 5
        umount /var/lib/ceph/osd/ceph-"$osd_number"
        ceph auth del osd."$osd_number"
        ceph osd rm "$osd_number"
        echo "Loại OSD $osd_number thành công"
        if [[ $(echo "$disk" | grep 'nvme') ]]; then
                exit 0
        else
                echo "Zap disk lỗi"
                # Zap disk
                ceph-volume lvm zap --destroy /dev/"$disk"
                # Kiểm tra kết quả của lệnh zap
                if [ $? -ne 0 ]; then
                        echo "Lỗi: Không thể zap disk /dev/$disk, kiểm tra lại đúng disk và osd chưa"
                        read -p "Nếu đúng disk thì bỏ qua zap, tiến hành loại khỏi raid? (y/n)" choice
                        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
                                echo "Tiếp tục các bước tiếp theo..."
                        else
                                echo "Thoát!"
                                exit 1
                        fi
                else
                        echo "Zap disk /dev/$disk thành công"
                fi
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
fi
