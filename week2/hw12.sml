fun alternate (l : int list) =
    let 
        fun alt(l : int list, b : bool) =
            if null l
            then 0
            else if b
            then hd l - alt(tl l, false)
            else hd l + alt(tl l, true)
    in
        alt(l, true)
    end