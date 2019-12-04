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

fun merge ([], l2) = l2
  | merge (x::[], l2) = x::l2
  | merge (x::xs', l2) = x::merge(xs', l2)
              
fun all_except_option (s, xs) =
    let fun helper (ys, acc, found) =
            case ys of
                y::[] => if same_string(y, s) then (acc, true) else (y::acc, found)
              | y::ys' => if same_string(y, s) then helper (ys', acc, true) else helper(ys', y::acc, found)
    in
        case xs of
            [] => NONE
          | _ => case helper(xs, [], false) of 
                     (acc, found) => if found then SOME acc else NONE
    end


fun get_substitutions1 (lists, s) =
    let
        fun list_from_option (NONE) = []
          | list_from_option (SOME (l)) = l
    in
        case lists of
            [] => []
          | l::[] => list_from_option(all_except_option(s, l))
          | l::lists' => merge(list_from_option(all_except_option(s, l)), get_substitutions1(lists', s))
    end

