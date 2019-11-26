fun is_older (d1 : int * int * int, d2 : int * int * int) =
    if #1 d1 <> #1 d2 then #1 d1 < #1 d2
    else if #2 d1 <> #2 d2 then #2 d1 < #2 d2
    else #3 d1 < #3 d2

                    
