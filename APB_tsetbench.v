module APB_tb;
  
  reg clk,reset,pen,psel,pwrite;
  wire pready;
  reg[31:0]pwdata;
  wire [31:0]prdata;
  reg[31:0]paddr;
  
  APB DUT(
    .clk(clk),
    .reset(reset),
    .pen(pen),
    .psel(psel),
    .paddr(paddr),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .prdata(prdata),
    .pready(pready)
  );
  
  initial
    begin
      clk = 1'b0;
      reset = 1'b0;
      #10 reset = 1'b1;
    end 
  
//   clock generation 
  always #5 clk = ~clk; 
//   function for read 
  
  task read(integer n);
    
    for(integer i = 0; i<n;i = i +1) begin
      @(negedge clk);
      psel =  1;
      paddr = i;
      pwrite = 0;
      pen = 0;
      
      @(negedge clk);
      pen = 1;
    end 
  endtask 
    
//     function for write 
    
  task write(integer n);
  for(integer i = 0 ; i <n ; i = i+1) begin 
      @(negedge clk );
        psel = 1 ;
        paddr = i;
        pwrite = 1;
        pwdata = $unsigned($random);
        pen = 0;
          
      @(negedge clk) 
            pen = 1;
    end 
  endtask 
      
  initial 
    begin 
      repeat(3) @(negedge clk);
      write(3);
      @(negedge clk);
     read(3);
    end
      
  initial #500 $finish;
  
  initial
    begin 
      $dumpfile("APB_Slave.vcd");
      $dumpvars(-1,APB_tb);
    end 
endmodule 
