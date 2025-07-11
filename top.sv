interface ram_if(input bit clk);
  logic wr;
  logic rd;
  logic [11:0]wr_add;
  logic [11:0]rd_add;
  logic [63:0]in;
  logic [63:0]out;

  clocking wr_dr_cb@(posedge clk);
    default input #1 output #1;
output in;
output wr;
output wr_add;
endclocking

  clocking wr_mon_cb@(posedge clk);
    default input #1 output #1;
input in;
input wr;
input wr_add;
endclocking

  clocking rd_dr_cb@(posedge clk);
     default input #1 output #1;
output rd;
output rd_add;
endclocking

  clocking rd_mon_cb@(posedge clk);
    default input #1 output #1;
input out;
input rd;
input rd_add;
endclocking

  //modports
  modport WR_DRV(clocking wr_dr_cb);
  modport WR_MON(clocking wr_mon_cb);
  modport RD_DRV(clocking rd_dr_cb);
  modport RD_MON(clocking rd_mon_cb);

    endinterface
package ram_pkg;
`include "transaction.sv"
`include "generator.sv"
`include "rd_driver.sv"
`include "rd_monitor.sv"
`include "wr_driver.sv"
`include "wr_monitor.sv"
`include "reference_model.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
endpackage


module top();

import ram_pkg::*;
        reg clk;
        //ram_sb_cg cg;
        ram_if DUV_IF(clk);
//      ram_sb_cg=new();
        test t_h;
  dual_port_ram DUV(.clk(clk),.in(DUV_IF.in),.wr(DUV_IF.wr),.rd(DUV_IF.rd),.wr_add(DUV_IF.wr_add),.rd_add(DUV_IF.rd_add),.out(DUV_IF.out));

initial begin
        clk=1'b0;
        forever #10 clk=~clk;
end

initial begin
        //if($test$plusargs("test"));
//begin

  t_h=new(DUV_IF.RD_DRV,DUV_IF.WR_DRV,DUV_IF.WR_MON,DUV_IF.RD_MON);

t_h.build();
t_h.run();
#50000
  $display("\n\n******** COVERAGE REPORT ********\n");
 $display("Functional Coverage = %0.2f%%", $get_coverage());
  //$coverage_save("coverage.ucdb"); // QuestaSim only
  //$display("Coverage saved to coverage.ucdb");
 // $finish;
//end


$finish;

end
endmodule

      
    
