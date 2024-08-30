run: tb_bad
	./tb_bad

tb_bad: bad.v tb_bad.v
	iverilog -o tb_bad bad.v tb_bad.v

clean:
	rm -f tb_bad waveform.vcd

