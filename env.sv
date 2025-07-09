class reg_env;

virtual reg_if.WR_DRV wr_dr_if;
virtual reg_if.RD_DRV rd_dr_if;
virtual reg_if.WR_MON wr_mon_if;
virtual reg_if.RD_MON rd_mon_if;

  mailbox #(reg_trans)gen2wrdr=new();
mailbox #(reg_trans)ref2sb=new();
  mailbox #(reg_trans)wrmon2rm=new();
  mailbox #(reg_trans)rdmon2ref=new();
  mailbox #(reg_trans)rdmon2sb=new();
  mailbox #(reg_trans)gen2rddr=new();

ram_gen gen_h;
ram_wr_mon wrmon_h;
ram_wr_drv wrdri_h;
ram_rd_mon rdmon_h;
ram_rd_drv rddri_h;
ram_sb sb_h;
ref_model model_h;

  function new(virtual reg_if.WR_DRV wr_dr_if,
virtual reg_if.RD_DRV rd_dr_if,
virtual reg_if.WR_MON wr_mon_if,
virtual reg_if.RD_MON rd_mon_if);
        this.wr_dr_if=wr_dr_if;
        this.rd_dr_if=rd_dr_if;
        this.wr_mon_if=wr_mon_if;
        this.rd_mon_if=rd_mon_if;
endfunction

virtual task build();
  gen_h=new(gen2wrdr,gen2rddr);
  wrdri_h=new(wr_dr_if,gen2wrdr);
  wrmon_h=new(wr_mon_if,wrmon2rm);
  rddri_h=new(rd_dr_if,gen2rddr);
  rdmon_h=new(rd_mon_if,rdmon2sb);
  model_h=new(wrmon2rm,rdmon2ref,ref2sb);
  sb_h=new(ref2sb,rdmon2sb);
endtask

  virtual task start();
gen_h.start;
wrdri_h.start;
wrmon_h.start;
rddri_h.start;
rdmon_h.start;
model_h.start;
sb_h.start;
endtask

virtual task run();
start();
endtask

endclass
