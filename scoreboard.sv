class ram_sb;
  ram_trans r_data = new();
  ram_trans sb_data = new();

  mailbox #(ram_trans) ref2sb;
  mailbox #(ram_trans) rdmon2sb;


  // Covergroup definition
  covergroup ram_sb_cg; // Replace 'clk' with your actual clock if needed
    cp_1: coverpoint r_data.wr {
      bins write_on  = {1};
      bins write_off = {0};
    }

    cp_2:  coverpoint r_data.rd {
      bins read_on  = {1};
      bins read_off = {0};
    }

    cp_3: coverpoint r_data.wr_add {
      bins low    = {[0:1023]};
      bins mid    = {[1024:2047]};
      bins high   = {[2048:3071]};
      bins upper  = {[3072:4095]};
    }

   cp_4: coverpoint r_data.rd_add {
      bins low    = {[0:1023]};
      bins mid    = {[1024:2047]};
      bins high   = {[2048:3071]};
      bins upper  = {[3072:4095]};
    }

    cp_5: coverpoint r_data.in {
      bins zero    = {64'd0};
      bins low     = {[1:100]};

       cp_6: coverpoint r_data.out {
      bins zero      = {64'd0};
      bins non_zero  = default;
    }


// Inside your covergroup


///  c1 : cross cp_1, cp_2, cp_3, cp_4, cp_5, cp_6;
 c2: cross cp_1,cp_3;
  c3: cross cp_2,cp_4;
 c4: cross cp_1,cp_2;
//c5: cross cp_1,cp_6;
 // c6: cross cp_2,cp_6;
c7: cross cp_3,cp_4;
c8:cross cp_3,cp_6;
c9:cross cp_4,cp_6;
c10: cross c2,c3;
c11:cross c4,c7;
//c12:cross c8,c9;
//c13:cross c10,c11;
//c7:cross cp_4,cp_6;
  endgroup:ram_sb_cg

  // Coverage group instance
 // ram_sb_cg sb_cg;
  // Constructor
  function new(mailbox #(ram_trans) ref2sb,
               mailbox #(ram_trans) rdmon2sb);
    this.ref2sb   = ref2sb;
    this.rdmon2sb = rdmon2sb;
    ram_sb_cg = new(); // instantiate covergroup
  endfunction
  virtual task start();
    fork
      forever begin
        ref2sb.get(r_data);
        rdmon2sb.get(sb_data);
        check(sb_data);
      end
    join_none
  endtask

  // Check task with coverage sampling
  virtual task check(ram_trans rdata);
    begin
   ram_sb_cg.sample(); // sample coverage here

      if (r_data.out === rdata.out) begin
        $display("r_data.out = %d --- rdata.out = %d --- data matches", r_data.out, rdata.out);
        r_data.display("---data generated----------");
      end
      else begin
        $display("r_data.out = %d ----------- rdata.out = %d ------------ not matching", r_data.out, rdata.out);
        r_data.display("---data generated----------");
      end
    end
     endtask

endclass

               
