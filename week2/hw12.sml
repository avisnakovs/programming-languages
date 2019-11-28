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
	
fun sortedMerge (a : int list, b : int list) =
	if null a andalso null b then []
	else if null a then b
	else if null b then a
    else if hd a < hd b then hd a :: sortedMerge(tl a, b)
    else hd b :: sortedMerge(a, tl b)