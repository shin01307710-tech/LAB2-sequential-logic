`timescale 1ns/1ps

// Combo II-DLD S75
// B6  = 1 kHz main clock
// K4  = reset
// N8  = step button
// sw[0] = load
// sw[1] = transfer
// sw[7:4] = data input

module lab2_register #(
    parameter integer STABLE_CYCLES = 20
) (
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire [7:0] led
);

    wire reset, press;
    wire [7:0] switches;

    wire [3:0] stored;
    wire [3:0] value;

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        clk,
        rst,
        button,
        sw,
        reset,
        press,
        switches
    );

    register_pair core (
        clk,
        reset,
        press & switches[0],
        press & switches[1],
        switches[7:4],
        stored,
        value
    );

    assign led = {stored, value};

endmodule
