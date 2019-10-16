library ieee;
use ieee.std_logic_1164.all;

entity control is 
port(
		tick : in std_logic;
		start: in std_logic;
		tx_done : in std_logic;
		dOut: out std_logic_vector(7 downto 0):=x"00";
		send : out std_logic:='0'
);
end entity control;

architecture behavior of control is

type states is(idle,e1,e2,e3,e4,e5);
signal state:states:=idle;

begin
	process(tick) is
	begin
		if rising_edge(tick) then
		case state is
				when idle=> 
					if start='0' then
						state<=e1;
					else
						state<=idle;
					end if;
				when e1=>
					dOut<=x"61";
					send<='1';
					state<=e2;
					
				when e2=>
					send<='0';
					if tx_done='1' then
						state<=e3;
					else
						state<=e2;
					end if;
				when e3=>
					dOut<=x"0A";
					send<='1';
					state<=e4;
				when e4=>
					send<='0';
					if tx_done='1' then
						state<=e5;
					else
						state<=e4;
					end if;
				when e5=>
					state<=e5;
			end case;
		end if;
	end process;
end architecture behavior;

