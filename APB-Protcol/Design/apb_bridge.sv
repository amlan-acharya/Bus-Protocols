//Code by :: AMLAN PRATEEK ACHARYA :: APB BRIDGE

`timescale 1ns/1ps

module apb_bridge(
    inout pwrite,
    inout [31:0] paddr, pwdata,
    input pready, pclk,presetn,
    inout [31:0] prdata,
    input ptransfer,
    output logic pselx,penable
  );
  reg [1:0] state;
  localparam IDLE = 2'd0, SETUP=2'd1, ACCESS=2'd2;

  always @(posedge pclk) begin
    if(!presetn) begin
        case(state)
          IDLE :
            if(!ptransfer) state=IDLE;
            else state=SETUP;
          SETUP :
            state=ACCESS;
          ACCESS :
            if(!pready) state=ACCESS;
            else if (pready && ptransfer) state=SETUP;
            else if(pready && !ptransfer) state=IDLE;
          default : state=IDLE;
      endcase
    end
  end

  always @ (state)
  begin
    case(state)
      IDLE : begin pselx='h0 ; penable='h0 ; end
      SETUP : begin pselx='h1; penable='h0; end
      ACCESS : begin pselx='h1; penable='h1; end
      default : begin pselx='h0; penable='h0; end
    endcase
  end
endmodule