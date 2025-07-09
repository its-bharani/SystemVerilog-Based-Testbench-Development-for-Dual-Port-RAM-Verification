class ram_rd_drv;

virtual reg_if.RD_DRV rd_dr_if;//virtual interface

reg_trans data2duv=new();

  mailbox #(reg_trans)gen2rddr;
//mailbox #(reg_trans)drv2mon;

  function new(virtual reg_if.RD_DRV rd_dr_if,mailbox #(reg_trans)gen2rddr);
        this.rd_dr_if=rd_dr_if;
        this.gen2rddr=gen2rddr;
        //this.drv2mon=drv2mon;
endfunction

virtual task drive();
  begin@(rd_dr_if.rd_dr_cb)begin
                rd_dr_if.rd_dr_cb.rd<=data2duv.rd;
                rd_dr_if.rd_dr_cb.rd_add<=data2duv.rd_add;
end
end
endtask

virtual task start();
fork forever
        begin
                gen2rddr.get(data2duv);//get data from mailbox
                drive();
//              drv2mon.put(data2duv);//put into mailbox
//              data2duv.display("at driver----generated data----------------");
end
join_none

endtask
endclass
