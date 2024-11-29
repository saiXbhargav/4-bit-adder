module dff (input clk,input d,output q);
    wire q1,q1n;
    wire clkn;
    not (clkn,clk);
    not (nd,d);
    nand (dc,d,clkn);
    nand (ndc,nd,clkn);
    nand (q1,dc,q1n);
    nand (q1n,ndc,q1);
    wire dc1,ndc1;
    
    nand (dc1,q1,clk);
    nand (ndc1,q1n,clk);
    nand (q,dc1,qn);
    nand (qn,ndc1,q);

endmodule


module dff4 (
    input clk,
    input [3:0] d,  
    output [3:0] q  
);

    dff uff0 (.clk(clk), .d(d[0]), .q(q[0]));
    dff uff1 (.clk(clk), .d(d[1]), .q(q[1]));
    dff uff2 (.clk(clk), .d(d[2]), .q(q[2]));
    dff uff3 (.clk(clk), .d(d[3]), .q(q[3]));

endmodule

module cla (
    input [3:0] A,        
    input [3:0] B,        
    input cin,            
    output [3:0] S,       
    output cout           
);
    wire [3:0] G;         
    wire [3:0] P;         
    wire [3:1] C;         

    and (G[0], A[0], B[0]);
    and (G[1], A[1], B[1]);
    and (G[2], A[2], B[2]);
    and (G[3], A[3], B[3]);

    xor (P[0], A[0], B[0]);
    xor (P[1], A[1], B[1]);
    xor (P[2], A[2], B[2]);
    xor (P[3], A[3], B[3]);

    wire [3:1] K; 
    and (K[1], P[0], cin);
    or  (C[1], K[1], G[0]);

    and (K[2], P[1], C[1]);
    or  (C[2], K[2], G[1]);

    and (K[3], P[2], C[2]);
    or  (C[3], K[3], G[2]);

    wire cout1;
    and (cout1, P[3], C[3]);
    or  (cout, cout1, G[3]);

    xor (S[0], P[0], cin);
    xor (S[1], P[1], C[1]);
    xor (S[2], P[2], C[2]);
    xor (S[3], P[3], C[3]);
    
endmodule

module fcla (
    input [3:0] A,
    input [3:0] B,
    input cin,
    output [3:0] S,
    output cout,
    input clk
);
    wire [3:0] A_reg, B_reg;  
    wire [3:0] S_int;         
    wire cout_int;            
    wire cin_reg;

    dff4 dff_A (
        .clk(clk),
        .d(A),
        .q(A_reg)
    );

    dff4 dff_B (
        .clk(clk),
        .d(B),
        .q(B_reg)
    );

    dff dff_cin (
        .clk(clk),
        .d(cin),
        .q(cin_reg)
    );

    cla cla_inst (
        .A(A_reg),    
        .B(B_reg),    
        .cin(cin_reg),    
        .S(S_int),    
        .cout(cout_int) 
    );

    dff4 dff_S (
        .clk(clk),
        .d(S_int),
        .q(S)
    );

    dff dff_cout (
        .clk(clk),
        .d(cout_int),
        .q(cout)
    );
endmodule

