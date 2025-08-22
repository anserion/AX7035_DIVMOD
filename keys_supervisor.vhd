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
use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keys_supervisor is
   Port (clk,en: in std_logic; debounce: in natural range 0 to 1023;
         key1,key2,key3,key4,reset: in std_logic;
         op1,op2: out std_logic_vector(7 downto 0));
end keys_supervisor;

architecture Behavorial of keys_supervisor is
signal op1_reg,op2_reg: std_logic_vector(7 downto 0):=conv_std_logic_vector(0,8);
begin
  op1<=op1_reg; op2<=op2_reg;
  process(clk)
  variable fsm: natural range 0 to 7:= 0;
  variable cnt: natural range 0 to 1023:=0;
  begin
    if rising_edge(clk) and en='1' then
      case fsm is
      when 0 => if (key1='0')or(key2='0')or(key3='0')or(key4='0')or(reset='0')
                then cnt:=0; fsm:=1; end if;
      when 1 => if cnt=debounce then fsm:=2; else cnt:=cnt+1; end if;
      when 2 => if key1='0' then op1_reg<=op1_reg+1; end if;
                if key2='0' then op1_reg<=op1_reg-1; end if;
                if key3='0' then op2_reg<=op2_reg+1; end if;
                if key4='0' then op2_reg<=op2_reg-1; end if;
                if reset='0' then op1_reg<=(others=>'0'); op2_reg<=(others=>'0'); end if;
                fsm:=3;
      when 3 => if (key1='1')and(key2='1')and(key3='1')and(key4='1')and(reset='1')
                then cnt:=0; fsm:=4; end if;
      when 4 => if cnt=debounce then fsm:=0; else cnt:=cnt+1; end if;
      when others => null;
      end case;
    end if;
  end process;
end;
