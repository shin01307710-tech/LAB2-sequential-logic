`timescale 1ns/1ps

module mealy_toggle (
    input  wire       clk,
    input  wire       rst,
    input  wire       enable,
    input  wire       bit_in,
    output reg        state,
    output wire [1:0] value
);

    always @(posedge clk) begin
        if (rst)
            state <= 1'b0;
        else if (enable && bit_in)
            state <= ~state;
    end

    assign value = bit_in
                 ? (state ? 2'b01 : 2'b10)
                 : 2'b00;

endmodule
