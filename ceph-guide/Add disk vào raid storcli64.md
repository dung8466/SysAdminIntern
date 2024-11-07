- Kiểm tra các disk unconfig trong raid

        /opt/MegaRAID/storcli/storcli64 /c0/dall show all
        /opt/MegaRAID/storcli/storcli64 /c1/dall show all

- Kết quả nằm trong UN-CONFIGURED DRIVE LIST

        ví dụ
        UN-CONFIGURED DRIVE LIST :
        ========================
    
        -------------------------------------------------------------------------------
        EID:Slt DID State DG     Size Intf Med SED PI SeSz Model               Sp Type
        -------------------------------------------------------------------------------
        8:14     29 UGood -  7.276 TB SATA HDD N   N  512B ST8000NM0055-1RM112 D  -
        -------------------------------------------------------------------------------
- Dựa vào EID:Slt mà thêm disk

1. HDD

        /opt/MegaRAID/storcli/storcli64 /c0 add vd  type=r0 drives=<EID>:<Slt> AWB pdcache=off
        /opt/MegaRAID/storcli/storcli64 /c1 add vd  type=r0 drives=<EID>:<Slt> AWB pdcache=off
  
2. SSD

        /opt/MegaRAID/storcli/storcli64 /c0 add vd  type=r0 drives=<EID>:<Slt> WT nora
        /opt/MegaRAID/storcli/storcli64 /c1 add vd  type=r0 drives=<EID>:<Slt> WT nora
