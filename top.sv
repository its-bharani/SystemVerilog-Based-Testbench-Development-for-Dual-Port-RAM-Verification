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
`include "driver.sv"
`include "read_monitor.sv"
`include "monitor.sv"
`include "reference_model.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
endpackage
      
    
