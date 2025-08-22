--Copyright 2025 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity DIVMOD_8x8_bit is
    Port (CLK: in std_logic; A,B : in  STD_LOGIC_VECTOR (7 downto 0);
          Q,R : out  STD_LOGIC_VECTOR (7 downto 0));
end DIVMOD_8x8_bit;

architecture Behavioral of DIVMOD_8x8_bit is
type T_2n1_bit is array(0 to 8) of std_logic_vector(15 downto 0);
signal tmp_r,tmp_b: T_2n1_bit;
signal tmp_q:std_logic_vector(7 downto 0);
begin
tmp_r(0)(15 downto 8)<=(others=>'0');
tmp_r(0)(7 downto 0)<=A;
gen: for i in 0 to 7 generate
  begin
     tmp_q(7-i)<='1' when tmp_r(i)(14-i downto 7-i) >= B else '0';
     tmp_b(i)(15 downto 15-i)<=(others=>'0');
     tmp_b(i)(6-i downto 0)<=(others=>'0');
     tmp_b(i)(14-i downto 7-i)<=(others=>'0') when tmp_q(7-i)='0' else b;
	  tmp_r(i+1)(14 downto 0)<=tmp_r(i)(14 downto 0) - tmp_b(i)(14 downto 0);
  end generate;
  
  process (clk)
  begin
    if rising_edge(clk) then
      Q<=tmp_q;
      R<=tmp_r(8)(7 downto 0);
    end if;
  end process;
end Behavioral;
