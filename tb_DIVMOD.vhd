LIBRARY ieee; use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, ieee.std_logic_unsigned.all;

ENTITY tb_DIVMOD IS
END tb_DIVMOD;
ARCHITECTURE behavior OF tb_DIVMOD IS 
    COMPONENT DIVMOD_top
    PORT(SYS_CLK,KEY1,KEY2,KEY3,KEY4,RESET: IN std_logic;
         SMG_DATA: OUT std_logic_vector(7 downto 0);
         SCAN_SIG: OUT std_logic_vector(5 downto 0));
    END COMPONENT;
   --Inputs
   signal SYS_CLK: std_logic := '0';
   signal KEY1,KEY2,KEY3,KEY4,RESET: std_logic := '1';
 	--Outputs
   signal SMG_DATA: std_logic_vector(7 downto 0);
   signal SCAN_SIG: std_logic_vector(5 downto 0);
   -- Clock period definitions
   constant SYS_CLK_period : time := 20 ns;
   -- others
   signal clk_cnt: natural:=0;
BEGIN
   uut: DIVMOD_top PORT MAP (SYS_CLK,KEY1,KEY2,KEY3,KEY4,RESET,SMG_DATA,SCAN_SIG);
   -- Clock process definitions
   SYS_CLK_process :process
   begin
		SYS_CLK <= '0';
		wait for SYS_CLK_period/2;
		SYS_CLK <= '1';
		wait for SYS_CLK_period/2;
      clk_cnt<=clk_cnt+1;
   end process;
   -- Stimulus process
   stim_proc: process
   begin		
      wait for SYS_CLK_period;
      if clk_cnt=100000 then key1<='0'; end if;
      if clk_cnt=200000 then key1<='1'; end if;
      if clk_cnt=300000 then key1<='0'; end if;
      if clk_cnt=400000 then key1<='1'; end if;
      if clk_cnt=500000 then key3<='0'; end if;
      if clk_cnt=600000 then key3<='1'; end if;
      if clk_cnt=700000 then key3<='0'; end if;
      if clk_cnt=800000 then key3<='1'; end if;
      if clk_cnt=900000 then reset<='0'; end if;
      if clk_cnt=1000000 then reset<='1'; end if;
      if clk_cnt=1100000 then wait; end if;
   end process;
END;