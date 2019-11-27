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
      