library ieee;
use ieee.std_logic_1164.all;

entity elevador is
  port (
    clock : in std_logic;
    reset : in std_logic;
    andarUM : in std_logic;
    andarDOIS : in std_logic;
    andarTRES : in std_logic;
    andarQUATRO : in std_logic;

    outAndarUM : out std_logic;
    outAndarDOIS : out std_logic;
    outAndarTRES : out std_logic;
    outAndarQUATRO : out std_logic;
    parado : out std_logic;
  );

end entity;

architecture my_architecture of elevador is

function subir (andar_atual : in integer) return integer is
begin
  if andar_atual = 1 then
    return 2;
  elsif andar_atual = 2 then
    return 3;
  elsif andar_atual = 3 then
    return 4;
  else
    return andar_atual;
  end if;
end function;

function descer (andar_atual : in integer) return integer is
begin
  if andar_atual = 4 then
    return 3;
  elsif andar_atual = 3 then
    return 2;
  elsif andar_atual = 2 then
    return 1;
  else
    return andar_atual;
  end if;
end function;

begin
  process (reset, clock)
        IF Reset = '1' THEN
        y <= A ;
        ELSIF (Clock'EVENT AND Clock = '1') THEN
  begin
  end process;
end architecture;
