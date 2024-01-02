//Code by :: AMLAN PRATEEK ACHARYA :: APB SYSTEM INTERFACE

interface apb_system_if();
    reg pwrite,ptransfer,presetn,pclk;
    reg [31:0] paddr, pwdata;
    wire [31:0] prdata;
    wire pready,pslverr;
endinterface