fun is_older (d1 : int * int * int, d2 : int * int * int) =
    if #1 d1 <> #1 d2 then #1 d1 < #1 d2
    else if #2 d1 <> #2 d2 then #2 d1 < #2 d2
    else #3 d1 < #3 d2

fun number_in_months (d : (int*int*int) list, m : int list) =
    if null d
    then 0
    else
        let fun contains (l : int list, i : int) =
                if null l
                then false
                else hd l = i orelse contains(tl l, i)
        in
            (if contains(m, #2 (hd d)) then 1 else 0) + number_in_months(tl d, m)
        end

fun number_in_month (d : (int * int * int) list, m : int) =
    number_in_months(d, [m])

