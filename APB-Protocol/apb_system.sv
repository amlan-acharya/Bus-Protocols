//Code by :: AMLAN PRATEEK ACHARYA :: APB SYSTEM

`timescale 1ns/1ps

module apb_system(
    input pwrite,pclk,ptransfer,presetn,
    input [31:0] paddr, pwdata,
    output [31:0] prdata,
    output pready,pslverr
    );
    wire penable,pselx;
    apb_peripheral apb_p (pready,pslverr,prdata,pclk,presetn,pwrite,penable,pselx,paddr,pwdata);
    apb_bridge apb_b (pwrite,paddr,pwdata,pready,pclk,presetn,prdata,ptransfer,pselx,penable);
endmodule

