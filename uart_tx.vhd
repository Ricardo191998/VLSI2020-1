library ieee;
use ieee.std_logic_1164.all;

entity uart_tx is port(
		clk50Mhz : in std_logic;
		tx : out std_logic;
		tx_done_led: out std_logic:='0';
		start : in std_logic
);
end entity uart_tx;

architecture behavior of uart_tx is

	signal tick: std_logic;
	signal dOut_tmp: std_logic_vector(7 downto 0);
	signal tx_done: std_logic;
	signal send : std_logic;
	
begin
	u1: entity work.divisor(behavior) port map(clk50Mhz, tick);
	u3: entity work.control(behavior) port map(tick, start, tx_done, dOut_tmp, send);
	u2: entity work.tx_sampler(behavior) port map(tick, send, dout_tmp, tx, tx_done);


	
	process(tx_done)
	begin
		if rising_edge(tx_done) then
			tx_done_led<='1';
		end if;
	end process;
end architecture behavior;
		
		