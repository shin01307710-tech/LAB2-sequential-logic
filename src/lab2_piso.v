`timescale 1ns/1ps

// Combo II-DLD S75
// B6 = 1 kHz main clock
// K4 = reset
// N8 = step button
// sw[0] = mode: 1=load, 0=shift
// sw[7:4] = parallel input

module lab2_piso #(
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

    wire serial_out;
    wire [3:0] value;

    piso4 core (
        clk,
        reset,
        press && switches[0],
        press && !switches[0],
        switches[7:4],
        serial_out,
        value
    );

    assign led = {value, 3'b000, serial_out};

endmodule
