`timescale 1ns/1ps

// Combo II-DLD S75
// B6  = 1 kHz main clock
// K4  = reset
// N8  = step button
// SW1 = sw[7] = bit_in

module lab2_mealy #(
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

    wire state;
    wire [1:0] value;

    mealy_toggle core (
        clk,
        reset,
        press,
        switches[7],
        state,
        value
    );

    assign led = {5'b00000, state, value};

endmodule
