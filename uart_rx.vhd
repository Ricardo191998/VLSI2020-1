library ieee;
use ieee.std_logic_1164.all;

entity uart_rx is
port(
        clk50mhz : in std_logic;
        rx : in std_logic;
        rx_Data : out std_logic_vector( 7 downto 0):= x"00";
        rx_done_led : out std_logic
);

end entity uart_rx;

Architecture behavior of uart_rx is 
    signal tick : std_logic;
    signal rx_done : std_logic;
    signal dIn : std_logic_vector( 7 downto 0);
begin
    U1 :  entity work.baudRateGenerator(behavior) port map(clk50mhz,tick);
    U2 :  entity work.rx_sampler(behavior) port map(rx,tick,dIn,rx_done);
    rx_data <= dIn;

    process(rx_done)
    begin
        if rising_edge(rx_done) then 
            rx_done_led <= '1';
        end if;
    end process;
end Architecture behavior;