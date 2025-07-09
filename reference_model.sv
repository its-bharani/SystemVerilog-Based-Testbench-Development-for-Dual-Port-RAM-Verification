class ref_model;

ram_trans w_data=new();
  static bit [63:0] mem [0:4095];

  mailbox #(reg_trans)wrmon2rm;
  mailbox #(reg_trans)rdmon2ref;
  mailbox #(reg_trans)ref2sb;

  function new(mailbox #(reg_trans)wrmon2rm,mailbox #(reg_trans)rdmon2ref,mailbox #(reg_trans)ref2sb);
        this.mon2rm=mon2rm;
        this.rdmon2ref=rdmon2ref;
        this.ref2sb=ref2sb;
//      this.w_data=new();
endfunction

virtual task ram_mod(reg_trans w_data);
        begin
          if (w_data.wr) begin
            mem[w_data.wr_add] <= w_data.in;
        end
    end
  if (w_data.rd) begin
    w_data.out <= mem[w_data.rd_add];
        end else begin
            w_data.out <= 64'd0;

end
endtask
virtual task start();
fork
begin
        forever
                begin
                        wrmon2rm.get(w_data);
                  rdmon2ref.get(w_data);
                ram_mod(w_data);//w_data.display("from generator the data generated------");
                  $display("ref_out=%b",w_data.out);//just to check
                        //w_data.out=ref_out;
                        ref2sb.put(w_data);
//                      w_data.display("from reference_model");
end
end
join_none
endtask
endclass
