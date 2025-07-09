class test;

virtual reg_if.RD_DRV rd_dr_if;
virtual reg_if.WR_DRV wr_dr_if;
virtual reg_if.WR_MON wr_mon_if;
virtual reg_if.RD_MON rd_mon_if;

reg_env env_h;

  function new(virtual reg_if.RD_DRV rd_dr_if,
virtual reg_if.WR_DRV wr_dr_if,
virtual reg_if.WR_MON wr_mon_if,
virtual reg_if.RD_MON rd_mon_if);
        this.rd_dr_if=rd_dr_if;
        this.wr_dr_if=wr_dr_if;
        this.wr_mon_if=wr_mon_if;
        this.rd_mon_if=rd_mon_if;
        env_h=new (dr_if,wrmon_if,rdmon_if);
endfunction

virtual task build();
        env_h.build();
endtask

virtual task run();
        env_h.run();
endtask

endclass
