`include "finalcla.v"

module tb_fcla;

    reg [3:0] A, B;
    reg cin;
    reg clk;

    wire [3:0] S;
    wire cout;

    fcla uut (
        .A(A),
        .B(B),
        .cin(cin),
        .S(S),
        .cout(cout),
        .clk(clk)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        A = 4'b0000; B = 4'b0000; cin = 0;

        #10 A = 4'b1011; B = 4'b0111; cin = 0; #10 $display("Time=%0t | A=%b B=%b cin=%b | S=%b cout=%b", $time, A, B, cin, S, cout);
        #10 A = 4'b1100; B = 4'b0011; cin = 1; #10 $display("Time=%0t | A=%b B=%b cin=%b | S=%b cout=%b", $time, A, B, cin, S, cout);
        #10 A = 4'b1110; B = 4'b1111; cin = 0; #10 $display("Time=%0t | A=%b B=%b cin=%b | S=%b cout=%b", $time, A, B, cin, S, cout);
        #10 A = 4'b0011; B = 4'b1111; cin = 1; #10 $display("Time=%0t | A=%b B=%b cin=%b | S=%b cout=%b", $time, A, B, cin, S, cout);
        #10 A = 4'b1101; B = 4'b1011; cin = 0; #10 $display("Time=%0t | A=%b B=%b cin=%b | S=%b cout=%b", $time, A, B, cin, S, cout);
        #10 $finish;
        #20 $stop;
        
    end

    initial begin
        $dumpfile("finalcla.vcd");
        $dumpvars(0, tb_fcla);
    end

endmodule
