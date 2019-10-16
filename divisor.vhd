library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor is port(
	clk50MHz: in std_logic;
	tick:	out std_logic:='0'
	);
end entity divisor;


architecture behavior of divisor is
signal tck : std_logic := '0';
begin
	tick <= tck;
	process(clk50MHz)
		variable cnt : integer := 0;
	begin
			if rising_edge(clk50MHZ) then
					if cnt = 162 then
							cnt := 0;
							tck <= not tck;
					else
							cnt := cnt +1;
					
					end if;
			
			
			end if;
	
	end process;
end architecture behavior;