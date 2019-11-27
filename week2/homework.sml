fun contains (l : int list, i : int) =
    if null l
    then false
    else hd l = i orelse contains(tl l, i)

fun is_older (d1 : int * int * int, d2 : int * int * int) =
    if #1 d1 <> #1 d2 then #1 d1 < #1 d2
    else if #2 d1 <> #2 d2 then #2 d1 < #2 d2
    else #3 d1 < #3 d2

fun number_in_months (d : (int*int*int) list, m : int list) =
    if null d
    then 0
    else (if contains(m, #2 (hd d)) then 1 else 0) + number_in_months(tl d, m)

fun number_in_month (d : (int * int * int) list, m : int) =
    number_in_months(d, [m])


fun dates_in_months (d : (int*int*int) list, c : int list) =
    if null d 
    then []
    else (if contains(c, #3 (hd d)) 
	  then hd d :: dates_in_months(tl d, c)
	  else dates_in_months(tl d, c))

fun get_nth (l : string list, n : int) =
    let
        fun find(s : string list, count : int) = 
            if count = n
            then hd s
            else find(tl s, count + 1)
    in
        find(l, 1)
    end 
        
fun date_to_string (d : int*int*int) = 
    let 
        fun name_of_month (n : int) =
            get_nth(["January", "February", "March", "April", "May", "June", 
                     "July","August", "September","October", "November", "December"], n)
    in
        name_of_month(#2 d) ^ " " ^ Int.toString(#3 d) ^ ", " ^ Int.toString(#1 d)
    end

fun number_before_reaching_sum (sum : int, l : int list) =
    let
        fun find(l : int list, collector : int, count : int) = 
            let 
                val current = collector + hd l
            in
                if sum <= current
                then count - 1
                else find(tl l, current, count + 1)
            end
    in
        find(l, 0, 1)
    end 
	
fun what_month (day : int) =
    number_before_reaching_sum(day, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]) + 1

                                                                                            
fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2) 

fun oldest (d : (int * int * int) list) =
    if null d
    then NONE
    else
        let
            val tail_oldest = oldest(tl d)
        in
            if not(isSome tail_oldest) orelse is_older(hd d, valOf tail_oldest)
            then SOME (hd d)
            else tail_oldest
        end
