(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

              (* put your solutions for problem 2 here *)

fun all_except_option (s, xs) =
    let fun helper (ys, acc, found) =
            case ys of
                [] => (acc, found)
              | y::ys' => if same_string(y, s) then helper (ys', acc, true) else helper(ys', y::acc, found)
    in
        case xs of
            [] => NONE
          | _ => case helper(xs, [], false) of 
                     (acc, found) => if found then SOME acc else NONE
    end


        
fun get_substitutions1 (lists, s) =
    let fun list_from_option (NONE) = []
          | list_from_option (SOME (l)) = l
    in
        case lists of
            [] => []
          | l::lists' => list_from_option(all_except_option(s, l)) @ get_substitutions1(lists', s)
    end

fun get_substitutions2 (lists, s) =
    let fun lfo (NONE) = []
          | lfo (SOME (l)) = l
        fun helper (lists, acc) =
            case lists of
                [] => acc
              | l::lists' => helper(lists', lfo(all_except_option(s,l)) @ acc)
    in
        helper(lists, [])
    end

fun similar_names (lists, {first, middle, last}) =
    let fun full_names [] = []
          | full_names (n::ns) = {first=n, last=last, middle=middle}::full_names(ns) 
    in                                   
        {first=first, middle=middle, last=last}::full_names(get_substitutions2(lists, first))
    end
        
