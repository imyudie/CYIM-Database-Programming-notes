/*
1.conditions-
    - IF - THEN - ELSE
    - CASE
        -simple(=)
        -searched
2.loop-
    - WHILE(condition)
    - FOR

e.g. if condition
    IF condition THEN -- if condition is null ,the PL treat it as false.
        statement{PL,SQL}
    ELSE
        statement{PL,SQL}
    END IF;

    if condition then
        statement
    elsif condition THEN 
        statement
    else
        statement
    end if;

e.g. case expression 依條件回傳值
    |-E-|-D-|-C-|-B-|-A-|
    0   20  40  60  80  100
          可  不  好  好
          以  錯  棒  棒
        　　　　　　　 棒
    --Return a value based on conditions; the value cannot exist independently.
    --(search case)
    --範圍判斷
    l_rank := case
                when S<=20 then 'E'
                when S<=40 then 'D'
                when S<=60 then 'C'
                when S<=80 then 'B'
                else 'A'
            END; -- The data type of the return values must be consistent.
    l_rank := case
                when R='A' then '好棒棒'
                when R='B' then '好棒'
                when R='C' then '不錯'
                else '可以'
            END;

    --simplify the expression.
    --(simple case)
    l_rank := case R 
                when 'A' then '好棒棒'
                when 'B' then '好棒'
                when 'C' then '不錯'
                else '可以'
            END;
    
e.g. csae statements 依條件執行stmt
    case 
        when s <= 20 
            stmt;
            stmt;
        when condition then
            stmt;
            .
            .
        else 
            stmt;
    end case;
    --若condition 為相等判斷
    case selector
        when 'A' then
            stmt;
        when 'B' then
            stmt;
        else
            stmt;
    end case;

*/