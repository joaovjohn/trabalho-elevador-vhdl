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
  type tipo_estado is ( indoAndarUM, indoAndarDOIS, indoAndarTRES, indoAndarQUATRO);
  signal y : tipoEstado;

  function subir (andar_atual : in tipoEstado) return tipoEstado is
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

  function descer (andar_atual : in tipoEstado) return tipoEstado is
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
  process(reset, clock)
    begin
        if reset = '1' then
            y <= andarUM;
            parado <= '1';
        elsif clock'event and clock = '1' then
            if (andarUM = '1' and andarDOIS = '0' and andarTRES = '0' and andarQUATRO = '0') then
                if (y /= indoAndarUM) then
                    parado <= '0';
                    y <= descer(y);
                else 
                    parado <= '1';
                end if;
            elsif (andarUM = '0' and andarDOIS = '1' and andarTRES = '0' and andarQUATRO = '0') then
                if (y /= indoAndarDOIS) then
                    parado <= '0';
                    if(y = andarUM) then
                        y <= subir(y);
                    else 
                        y <= descer(y);
                    end if;
                else
                    parado <= '1';
                end if;
            elsif (andarUM = '0' and andarDOIS = '0' and andarTRES = '1' and andarQUATRO = '0') then
                if (y /= indoAndarTRES) then
                    parado <= '0';
                    if(y = indoAndarUM or y = indoAndarDOIS) then
                        y <= subir(y);
                    else 
                        y <= descer(y);
                    end if;
                else
                    parado <= '1';
                end if;
            elsif (andarUM = '0' and andarDOIS = '0' and andarTRES = '0' and andarQUATRO = '1') then
                if (y /= indoAndarQUATRO) then
                    parado <= '0';
                    y <= subir(y);
                    else
                    parado <= '1';
                end if;
            end if;
  end process;
  process(y)
    begin
      andarUM <= '0';    
      andarDOIS <= '0';
      andarTRES <= '0';
      andarQUATRO <= '0';
        if y = indoAndarUM then
            outAndarUM <= '1';    
        elsif y = indoAndarDOIS then
          outAndarDOIS <= '1';
        elsif y = indoAndarTRES then
          outAndarTRES <= '1';
        elsif y = indoAndarQUATRO then
          outAndarQUATRO <= '1';
        end if;
    end process;
end arch;
