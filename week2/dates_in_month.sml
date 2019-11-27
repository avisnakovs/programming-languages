fun contains (l : int list, i : int) =
    if null l
    then false
    else hd l = i orelse contains(tl l, i)

fun dates_in_months (d : (int*int*int) list, c : int list) =
    if null d 
    then []
    else (if contains(c, #3 (hd d)) 
		then hd d :: dates_in_months(tl d, c)
		else dates_in_months(tl d, c))
