library ieee;
use ieee.std_logic_1164.all;

entity tx_sampler is 
port(
		tick : in std_logic;
		send: in std_logic;
		dOut: in std_logic_vector(7 downto 0);
		tx : out std_logic:='1';
		tx_done : out std_logic:='0'
);
end entity tx_sampler;

architecture behavior of tx_sampler is
signal nbit: integer range 0 to 7:=0;
signal ntick: integer range 0 to 15:=0;
type states is(idle, start, data, stop);
signal state:states:=idle;

begin
	process(tick)
	begin
		if rising_edge(tick) then
					case state is
				when idle=> 
					tx_done<='0';
					
					if send='1' then
						tx<='0';
						nbit<=0;
						ntick<=0;
						state<=start;
					else
						state<=idle;
					end if;
				when start=>
					if ntick =15 then
						ntick<=0;
						state<=data;
					else
						ntick<=ntick+1;
						state<=start;
					end if;
						
				when data=>
					tx<=dOut(nbit);
					if ntick=15 then
						ntick<=0;
						if nbit=7 then
							state<=stop;
						else
							nbit<=nbit+1;
							state<=data;
						end if;
					else
						ntick<=ntick+1;
						state<=data;
					end if;
				when stop=>
					if ntick=15 then
						tx_done<='1';
						state<=idle;
					else
						ntick<=ntick+1;
						state<=stop;
					end if;	
			end case;	
		end if;
	end process;
end architecture behavior;