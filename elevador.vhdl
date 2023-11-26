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
    parado : out std_logic
  );
end elevador ; 

architecture arch of elevador is
  type tipo_estado is ( andarUM, andarDOIS, andarTRES, andarQUATRO);
  signal y : tipo_estado;

  function subir (andar_atual : in integer) return integer is
    begin
      if andar_atual = andarUM then
        return andarDOIS;
      elsif andar_atual = andarDOIS then
        return andarTRES;
      elsif andar_atual = andarTRES then
        return andarQUATRO;
      else
        return andar_atual;
      end if;
  end subir;

  function descer (andar_atual : in integer) return integer is
    begin
      if andar_atual = andarQUATRO then
        return andarTRES;
      elsif andar_atual = andarTRES then
        return andarDOIS;
      elsif andar_atual = andarDOIS then
        return andarUM;
      else
        return andar_atual;
      end if;
  end descer;

begin
  process (reset, clock)
        IF Reset = '1' THEN
        y <= A ;
        ELSIF (Clock'EVENT AND Clock = '1') THEN
  begin
  end process;
end arch;
