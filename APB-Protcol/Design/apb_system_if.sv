//Code by :: AMLAN PRATEEK ACHARYA :: APB SYSTEM INTERFACE

interface apb_system_if(input bit pclk);
    wire pwrite,ptransfer,presetn;
    wire [31:0] paddr, pwdata;
    reg [31:0] prdata;
    reg pready,pslverr;
endinterface
