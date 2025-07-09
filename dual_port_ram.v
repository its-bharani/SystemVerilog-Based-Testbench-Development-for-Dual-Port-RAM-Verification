module dual_port_ram (
    input  logic        clk,
    input  logic        wr,              // Write enable
    input  logic        rd,              // Read enable
    input  logic [11:0] wr_add,          // Write address
    input  logic [11:0] rd_add,          // Read address
    input  logic [63:0] in,              // Write data
    output logic [63:0] out              // Read data
);

    // Declare 4096 x 64-bit memory
    logic [63:0] mem [0:4095];

    // WRITE operation
    always_ff @(posedge clk) begin
        if (wr) begin
            mem[wr_add] <= in;
        end
    end

    // READ operation
    always_ff @(posedge clk) begin
        if (rd) begin
            out <= mem[rd_add];
        end else begin
            out <= 64'd0;
        end
    end

endmodule
