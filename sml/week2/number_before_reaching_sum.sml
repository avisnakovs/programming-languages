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

    