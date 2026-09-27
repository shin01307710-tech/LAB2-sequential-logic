`timescale 1ns/1ps

// Combo II-DLD S75
// Main clock B6 = 1 kHz
// K4 = reset
// DIPSW1..8 = sw[7]..sw[0]

module lab2_segment_scan #(
    parameter integer STABLE_CYCLES = 20
) (
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire [7:0] led,
    output wire [7:0] seg_data,
    output wire [7:0] seg_com
);

    wire reset;
    wire press;
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

    wire [7:0] selected;
    wire [7:0] segments;
    wire [2:0] index;

    // COM[7]??:
    // switches[7:4], 1, 2, 3, 4, 5, 6, 7
    wire [31:0] digits = {
        28'h7654321,
        switches[7:4]
    };

    segment_scan8 core (
        clk,
        reset,
        1'b1,
        digits,
        selected,
        segments,
        index
    );

    // Logical index 0 -> physical COM[7]
    assign seg_com = ~{
        selected[0],
        selected[1],
        selected[2],
        selected[3],
        selected[4],
        selected[5],
        selected[6],
        selected[7]
    };

    assign seg_data = segments;
    assign led = {5'b00000, index};

endmodule
