//Code by :: AMLAN PRATEEK ACHARYA :: APB PERIPHERAL

`timescale 1ns/1ps

module apb_peripheral(
    output logic pready,pslverr,
    output logic [31:0] prdata='hz,
    input pclk,presetn,pwrite,penable,pselx,
    input [31:0] paddr,
    input [31:0] pwdata
  );
  localparam N = 1024;
  reg [31:0] ctrl_reg[N];
  reg [1:0] state;
  localparam IDLE = 2'd0, SETUP = 2'd1, TRANSFER = 2'd2, ERROR = 2'd3;

  always @(posedge pclk) begin
    if(!presetn) begin
      case(state)
        IDLE :
          if(pselx) state=SETUP;
          else state=IDLE;
        SETUP :
          begin
            if(penable && pselx)
            begin
              if(paddr<=N) state=TRANSFER;
              else state=ERROR;
            end
            else state=SETUP;
          end
        TRANSFER : state=IDLE;
        ERROR : state=IDLE;
          default : state=IDLE;
      endcase
    end
  end

  always @(state) begin
    case (state)
      IDLE : begin pready<=1'b0; pslverr=1'b0; prdata<='hz; end
      SETUP : pready<=1'b1;
      TRANSFER :
      begin
        if(pwrite) ctrl_reg[paddr]<=pwdata; //WRITE OPERATION
        else prdata<=ctrl_reg[paddr];  //READ OPERATION
        pready<=1'b0;
      end
      ERROR : pslverr=1'b1;
      default : begin pready<=1'b0; pslverr=1'b0; prdata<='hz; end
    endcase
  end
endmodule

