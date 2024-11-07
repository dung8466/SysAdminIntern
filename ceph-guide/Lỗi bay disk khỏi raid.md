- Disk bị lỗi Ubad

      storcli64 /c0/e<number>/s<number> set good
      #thử restart lại osd
      systemctl restart ceph-osd@<id>
      
- Disk ở trạng thái Frgn-Bad
  + Kiểm tra bằng lệnh `storcli64 /c0 show all`

        ví dụ
        FOREIGN CONFIGURATION :
        =====================
        
        ---------------------------------------
        DG EID:Slot Type  State     Size NoVDs 
        ---------------------------------------
         0 -        RAID0 Frgn  1.745 TB     1

        PD LIST :
        =======
        
        --------------------------------------------------------------------------------------
        EID:Slt DID State DG     Size Intf Med SED PI SeSz Model                      Sp Type 
        --------------------------------------------------------------------------------------
        16:0     22 Onln   6 1.745 TB SATA SSD N   N  512B SAMSUNG MZ7LH1T9HMLT-00005 U  -    
        16:1     26 UBad   F 1.745 TB SATA SSD N   N  512B -                          U  -

    + Set các disk bị "UBad F" đó về Ugood

          storcli64 /c0/e<number>/s<number> set good

    + Import lại các disk dùng
   
          storcli64 /c0 /fall import
          #thử restart lại osd
          systemctl restart ceph-osd@<id>

