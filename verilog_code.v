To implement a delay circuit  in Verilog 

module delay (
    input  a,
    input  clk,
    output a_delay
);

reg [2:0] a_reg;

always @(posedge clk)
begin
    a_reg[0] <= a;
    a_reg[1] <= a_reg[0];
    a_reg[2] <= a_reg[1];
end

assign a_delay = a_reg[2];

endmodule


`timescale 1ns/1ps

module delay_tb;

reg clk;
reg a;
wire a_delay;

delay U0 (
    .a(a),
    .clk(clk),
    .a_delay(a_delay)
);

always #10 clk = ~clk;

initial begin
    clk = 0;
    a = 0;

    
    @(posedge clk);
    a = 1;

    @(posedge clk);
    a = 0;

    repeat(10) @(posedge clk);

    $finish;
end

endmodule






To implement a delay circuit using a 3-bit shift register in Verilog HDL.


module delay #(parameter M=100)(
    input  a,
    input  clk,
    output a_delay
);

reg [M-1:0] a_reg;

always @(posedge clk)
begin
    a_reg <= {a,a_reg[M-1:1]};
end

assign a_delay = a_reg[0];

endmodule


module tb;

reg clk;
reg a;
wire a_delay;

delay #(.M(100)) U0 (
    .a(a),
    .clk(clk),
    .a_delay(a_delay)
);

// Clock generation
always #10 clk = ~clk;
    

// Stimulus
initial begin
    clk=0;
    a = 0;

    #20 a = 1;
    #20  a=0;
    #2500 $finish;
    
    
end

endmodule






To design and simulate a negative edge detector using Verilog HDL.


module neg_edge_detector(
    input clk,
    input a,
    output pulse
);

reg a_delay;

always @(posedge clk)
begin
    a_delay <= a;
end

assign pulse = a_delay & ~a;

endmodule


`timescale 1ns/1ps

module neg_edge_detector_tb;

reg clk;
reg a;
wire pulse;

neg_edge_detector U0(
    .clk(clk),
    .a(a),
    .pulse(pulse)
);

always #10 clk = ~clk;

initial
begin
    clk = 0;
    a = 0;

    #20 a = 1;
    #40 a = 0;

    #40 a = 1;
    #40 a = 0;

    #40 $finish;
end

endmodule





Verilog module that synchronizes an asynchronous input signal a to the clock domain clkb using a two-stage synchronizer.

module cdc_pulse(input a,clka,clkb, output signal_a,signal_b);

reg [1:0]a_reg=0;


always @(posedge clkb) begin
 a_reg[0]<=a;
a_reg[1]<=a_reg[0];
end
assign signal_a=(a_reg[0]&(~a_reg[1]));
assign signal_b=(~a_reg[0]&(a_reg[1]));
endmodule


module cdc_pulse_tb();
reg a,clka=0,clkb=0;
wire signal_a,signal_b;

cdc_pulse c1(.a(a),.clka(clka),.clkb(clkb),.signal_a(signal_a),.signal_b(signal_b));

always begin
clka=~clka;
#50;
end

always begin
clkb=~clkb;
#10;
end

initial begin
a=0; #100;
a=1;
#100;
a=0;
#1000;
end
endmodule






2)