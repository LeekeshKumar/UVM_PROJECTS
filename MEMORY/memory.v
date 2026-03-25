
`define WIDTH 8
`define DEPTH 32
`define ADDR_SIZE $clog2(`DEPTH)
module mem (clk,res,wr_rd,addr,wdata,rdata,valid,ready);

input clk,res,wr_rd,valid;
input [`WIDTH-1:0] wdata;
input [`ADDR_SIZE-1:0] addr;
output reg[`WIDTH-1:0] rdata;
output reg ready;
integer i;

reg[`WIDTH-1:0]mem[`DEPTH-1:0];

		always@(posedge clk)begin
			if(res==1)begin
			rdata=0;
			ready=0;
			for(i=0;i<`DEPTH;i++) mem[i]=0;
			end else begin
			if(valid==1)begin
			ready=1;
				if(wr_rd==1)
				mem[addr]=wdata;
					if(wr_rd==0)
						rdata=mem[addr];
							end else begin
							ready=0;
								end
						end
				end
endmodule

