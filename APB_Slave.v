module APB(
    input clk,reset,pen,psel,pwrite,
    input[31:0] paddr,
    input[31:0] pwdata,
    output pready,
    output reg[31:0] prdata
);
  
  localparam IDLE = 2'b00;
  localparam SETUP = 2'b01;
  localparam ACCESS = 2'b10;
  reg[1:0] pr_st,nxt_st;     // present and next state 
  reg busy = 0;              // not in use here
  
  reg[31:0]mem[31:0];
  
  always@(posedge clk or negedge reset) begin
    if(!reset) pr_st <= IDLE ;
    else pr_st <= nxt_st;
  end
  
  // next state logic
  
  always@(psel, pen, pr_st) begin
    case(pr_st)
      IDLE: begin
        if(psel == 1 && pen == 0) nxt_st <= SETUP;
        else nxt_st <= IDLE;
      end 
      SETUP: begin
        if(psel == 1 && pen == 1) nxt_st = ACCESS;
        else if(psel == 1 && pen == 0) nxt_st <= SETUP;
        else nxt_st <= IDLE;
      end
      ACCESS: begin
        if(psel == 1 && pen == 0) nxt_st <=SETUP;
        else if(psel == 1 && pen == 1) nxt_st <= ACCESS;
        else nxt_st <= IDLE;
      end
      default: nxt_st = IDLE;
    endcase
  end 
//     LOGIC IN ACCESS STATE
      
  always@(posedge clk) begin
    if (pr_st == ACCESS && pready && psel) begin
      if (pwrite)
       mem[paddr] = pwdata;
      else
       prdata = mem[paddr];
    end
  end
    
  assign pready = (pr_st == ACCESS) ? 1'b1 : 1'b0;
endmodule 