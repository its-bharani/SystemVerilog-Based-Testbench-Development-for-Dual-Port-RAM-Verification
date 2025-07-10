class ref_model;
ram_trans w_data=new();
ram_trans r_data=new();
ram_trans m_data=new;
  static logic [63:0] mem [0:4095];

  mailbox #(ram_trans)wrmon2rm;
  mailbox #(ram_trans)rdmon2ref;
  mailbox #(ram_trans)ref2sb;

  function new(mailbox #(ram_trans)wrmon2rm,mailbox #(ram_trans)rdmon2ref,mailbox #(ram_trans)ref2sb);
        this.wrmon2rm=wrmon2rm;
        this.rdmon2ref=rdmon2ref;
        this.ref2sb=ref2sb;
//      this.w_data=new();
endfunction

virtual task ram_mod(ram_trans m_data);
if (m_data.wr) begin
            mem[m_data.wr_add]= m_data.in;
        end
  if (m_data.rd) begin
    m_data.out = mem[m_data.rd_add];
        end else begin
            m_data.out = 64'd0;

    end
endtask
virtual task start();
fork        forever
                begin
                wrmon2rm.get(w_data);
                rdmon2ref.get(r_data);
                m_data.wr<=w_data.wr;
                m_data.wr_add<=w_data.wr_add;
                m_data.in<=w_data.in;
                m_data.rd<=r_data.rd;
                m_data.rd_add<=r_data.rd_add;
                ram_mod(m_data);//m_data.display("from reference model the data generated------");
             //     $display("ref_out=%d",m_data.out);//just to check
                        //w_data.out=ref_out;
                        ref2sb.put(m_data);
//                      w_data.display("from reference_model");
end
join_none
endtask
endclass

