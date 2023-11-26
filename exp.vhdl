library ieee ;
use ieee.std_logic_1164.all ;

entity elevador is
  port (
    clock, reset, ir_para_andar1, ir_para_andar2, ir_para_andar3, ir_para_andar4, ir_para_andar5, ir_para_andar6: in std_logic;
    esta_andar1, esta_andar2, esta_andar3, esta_andar4, esta_andar5, esta_andar6, parado: out std_logic

  ) ;
end elevador ; 

architecture arch of elevador is
    type tipo_estado is ( indo_para_andar1, indo_para_andar2, indo_para_andar3, indo_para_andar4, indo_para_andar5, indo_para_andar6);
    signal y : tipo_estado;

    function descer(signal y_atual : tipo_estado) return tipo_estado is
    begin
        if (y_atual = indo_para_andar2) then
            return indo_para_andar1;
        elsif (y_atual = indo_para_andar3) then
            return indo_para_andar2;
        elsif (y_atual = indo_para_andar4) then
            return indo_para_andar3;
        elsif (y_atual = indo_para_andar5) then
            return indo_para_andar4;
        elsif (y_atual = indo_para_andar6) then
            return indo_para_andar5;
        end if;
    end descer;

    function subir(signal y_atual : tipo_estado) return tipo_estado is
        begin
            if (y_atual = indo_para_andar1) then
                return indo_para_andar2;
            elsif (y_atual = indo_para_andar2) then
                return indo_para_andar3;
            elsif (y_atual = indo_para_andar3) then
                return indo_para_andar4;
            elsif (y_atual = indo_para_andar4) then
                return indo_para_andar5;
            elsif (y_atual = indo_para_andar5) then
                return indo_para_andar6;
            end if;
        end subir;

begin
    process(reset, clock)
    begin
        if reset = '1' then
            y <= indo_para_andar1;
            parado <= '1';
        elsif clock'event and clock = '1' then
            if (ir_para_andar1 = '1' and ir_para_andar2 = '0' and ir_para_andar3 = '0' and ir_para_andar4 = '0' and ir_para_andar5 = '0' and ir_para_andar6 = '0') then
                if (y /= indo_para_andar1) then
                    parado <= '0';
                    y <= descer(y);
                else 
                    parado <= '1';
                end if;
            elsif (ir_para_andar1 = '0' and ir_para_andar2 = '1' and ir_para_andar3 = '0' and ir_para_andar4 = '0' and ir_para_andar5 = '0' and ir_para_andar6 = '0') then
                if (y /= indo_para_andar2) then
                    parado <= '0';
                    if(y = indo_para_andar1) then
                        y <= subir(y);
                    else 
                        y <= descer(y);
                    end if;
                else
                    parado <= '1';
                end if;
            elsif (ir_para_andar1 = '0' and ir_para_andar2 = '0' and ir_para_andar3 = '1' and ir_para_andar4 = '0' and ir_para_andar5 = '0' and ir_para_andar6 = '0') then
                if (y /= indo_para_andar3) then
                    parado <= '0';
                    if(y = indo_para_andar1 or y = indo_para_andar2) then
                        y <= subir(y);
                    else 
                        y <= descer(y);
                    end if;
                else
                    parado <= '1';
                end if;
            elsif (ir_para_andar1 = '0' and ir_para_andar2 = '0' and ir_para_andar3 = '0' and ir_para_andar4 = '1' and ir_para_andar5 = '0' and ir_para_andar6 = '0') then
                if (y /= indo_para_andar4) then
                    parado <= '0';
                    if(y = indo_para_andar5 or y = indo_para_andar6) then
                        y <= descer(y);
                    else
                        y <= subir(y);
                    end if;
                else
                    parado <= '1';
                end if;
            elsif (ir_para_andar1 = '0' and ir_para_andar2 = '0' and ir_para_andar3 = '0' and ir_para_andar4 = '0' and ir_para_andar5 = '1' and ir_para_andar6 = '0') then
                if (y /= indo_para_andar5) then
                    parado <= '0';
                    if (y = indo_para_andar6) then
                        y <= descer(y);
                    else
                        y <= subir(y);
                    end if;
                else
                    parado <= '1';
                end if;
            elsif (ir_para_andar1 = '0' and ir_para_andar2 = '0' and ir_para_andar3 = '0' and ir_para_andar4 = '0' and ir_para_andar5 = '0' and ir_para_andar6 = '1') then
                if (y /= indo_para_andar6) then
                    parado <= '0';
                    y <= subir(y);
                else
                    parado <= '1';
                end if;
            end if;
        end if;
    end process;

    process(y)
    begin
        esta_andar1 <= '0';    
        esta_andar2 <= '0';
        esta_andar3 <= '0';
        esta_andar4 <= '0';
        esta_andar5 <= '0';
        esta_andar6 <= '0';
        if y = indo_para_andar1 then
            esta_andar1 <= '1';    
        elsif y = indo_para_andar2 then
            esta_andar2 <= '1';
        elsif y = indo_para_andar3 then
            esta_andar3 <= '1';
        elsif y = indo_para_andar4 then
            esta_andar4 <= '1';
        elsif y = indo_para_andar5 then
            esta_andar5 <= '1';
        elsif y = indo_para_andar6 then
            esta_andar6 <= '1';
        end if;
    end process;

end arch;