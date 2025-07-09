class ram_wr_mon;

virtual reg_if.WR_MON wr_mon_if;

reg_trans data2rm=new();
reg_trans wr_data=new();

        mailbox #(reg_trans)wrmon2rm;
//mailbox #(reg_trans)drv2mon;
        function new(virtual reg_if.WR_MON wr_mon_if,
             mailbox #(reg_trans)wrmon2rm);
begin
        this.wr_mon_if=wr_mon_if;
        //this.drv2mon=drv2mon;
        this.wrmon2rm=wrmon2rm;
//this.wr_data=new;
end
endfunction

virtual task monitor();
begin
        @(wr_mon_if.wr_mon_cb);
                begin
                        wr_data.in<=wr_mon_if.wr_mon_cb.in;
                        wr_data.wr<=wr_mon_if.wr_mon_cb.wr;
                        wr_data.wr_add<=wr_mon_if.wr_mon_cb.wr_add;
                end
end
endtask
virtual task start();
fork
forever
begin
        monitor();
        //drv2mon.get(data2rm);
        data2rm=new wr_data;//shallow copy
        wrmon2rm.put(data2rm);//put data to mailbox
//      data2rm.display("from wr_mon");

end
join_none
endtask
endclass
