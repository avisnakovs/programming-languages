fun is_older (d1 : int * int * int, d2 : int * int * int) =
    if #1 d1 <> #1 d2 then #1 d1 < #1 d2
    else if #2 d1 <> #2 d2 then #2 d1 < #2 d2
    else #3 d1 < #3 d2

fun number_in_month (d : (int * int * int) list, m : int) =
    let
        fun count_months (d : (int * int * int) list) =
            if null d 
            then 0
            else (if #2 (hd d) = m then 1 else 0) + count_months(tl d)
    in
        count_months(d)
    end
       
    
