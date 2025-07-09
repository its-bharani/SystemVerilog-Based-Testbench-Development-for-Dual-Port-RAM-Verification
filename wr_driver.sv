class ram_wr_drv;

virtual reg_if.WR_DRV wr_dr_if;//virtual interface

reg_trans data2duv=new();

  mailbox #(reg_trans)gen2wrdr;

  function new(virtual reg_if.WR_DRV wr_dr_if,mailbox #(reg_trans)gen2wrdr);

        this.wr_dr_if=wr_dr_if;
        this.gen2wrdr=gen2wrdr;
endfunction

virtual task drive();
  begin@(wr_dr_if.wr_dr_cb)begin
                wr_dr_if.wr_dr_cb.in<=data2duv.in;
                wr_dr_if.wr_dr_cb.wr<=data2duv.wr;
               wr_dr_if.wr_dr_cb.wr_add<=data2duv.wr_add;
                
end
end
endtask

virtual task start();
fork forever
        begin
                gen2wrdr.get(data2duv);//get data from mailbox
                drive();
//              drv2mon.put(data2duv);//put into mailbox
//              data2duv.display("at driver----generated data----------------");
end
join_none

endtask
endclass
