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
  //reg [31:0] ctrl_reg[N];
  reg [31:0] ctrl_reg0='h0,ctrl_reg1='h0,ctrl_reg2='h0,ctrl_reg3='h0,ctrl_reg4='h0,temp;
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
    else begin
      ctrl_reg0='h0;
      ctrl_reg1='h0;
      ctrl_reg2='h0;
      ctrl_reg3='h0;
      ctrl_reg4='h0;
    end
  end

  always @(state) begin
    case (state)
      IDLE : begin pready<=1'b0; pslverr<=1'b0; prdata<='hz; end
      SETUP : pready<=1'b1;
      TRANSFER :
      begin
        if(pwrite) begin //WRITE OPERATION
          temp=pwdata;
          case(paddr)
            'd0: ctrl_reg0=temp;
          	'd1: ctrl_reg1=temp;
          	'd2: ctrl_reg2=temp;
          	'd3: ctrl_reg3=temp;
          	'd4: ctrl_reg4=temp;
            default : ctrl_reg0=temp;
          endcase
        end
        else begin //READ OPERATION
          case(paddr)
            'd0: temp=ctrl_reg0;
          	'd1: temp=ctrl_reg1;
          	'd2: temp=ctrl_reg2;
          	'd3: temp=ctrl_reg3;
          	'd4: temp=ctrl_reg4;
            default : temp=ctrl_reg0;
          endcase
          prdata=temp;
        end 
        pready<=1'b0;
      end
      ERROR : pslverr=1'b1;
      default : begin pready<=1'b0; pslverr=1'b0; prdata<='hz; end
    endcase
  end
endmodule