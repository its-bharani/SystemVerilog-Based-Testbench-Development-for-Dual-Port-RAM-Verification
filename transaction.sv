class ram_trans;

rand logic wr;
rand logic rd;
rand logic [11:0]wr_add;
rand logic [11:0]rd_add;
rand logic [63:0]in;
  logic [63:0]out;//output
  //constraint
  constraint in_range_c {in inside {[64'h0000_0000_0000_0000 : 64'hFFFF_FFFF_FFFF_FFFF]};}

  constraint addr_valid_c {wr_add inside {[0 : 20]};}//checking operation in first 20 locations
  constraint addr_valid_d {rd_add inside {[0 : 20]};}
  constraint wr_distribution {wr dist{0:=70, 1:=30};}
  constraint rd_distribution {rd dist{0:=30, 1:=70};}

virtual function void display(input string s);
begin
$display("------------------------%s-----------------------------",s);
  $display("in=%d",in);
  $display("wr =%d",wr);
  $display("rd=%d",rd);
  $display("wr_add=%d",wr_add);
  $display("rd_add=%d",rd_add);
  $display("-------------------------------------------------------------");
end
endfunction

endclass:ram_trans

