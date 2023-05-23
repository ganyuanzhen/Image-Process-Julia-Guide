`ifndef _MY_DRIVER_SV_
`define _MY_DRIVER_SV_

class my_driver extends uvm_driver;
	function new(string name = "my_driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	extern virtual task main_phase(uvm_phase phase);
endclass

task my_driver::main_phase(uvm_phase phase);
	top_tb.rxd <= 8'b0; 
	top_tb.rx_dv <= 1'b0;
	while(!top_tb.rst_n)
		@(posedge top_tb.clk);
	repeat (16) begin
		@(posedge top_tb.clk);
		top_tb.rxd <= $urandom_range(0, 255);
		top_tb.rx_dv <= 1'b1;
		`uvm_info("my_driver", "data is drived", UVM_LOW)
	end
	@(posedge top_tb.clk);
	top_tb.rx_dv <= 1'b0;
endtask

`endif
