(* dan grossman, coursera pl, hw2 provided code *)

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
              | y::ys' => if y = s andalso not found  then helper (ys', acc, true) else helper(ys', y::acc, found)
    in
        case xs of
            [] => NONE
          | _ => case helper(xs, [], false) of 
                     (acc, found) => if found then SOME acc else NONE
    end

fun list_from_option (NONE) = []
  | list_from_option (SOME (l)) = l
        
fun get_substitutions1 (lists, s) =
    case lists of
        [] => []
      | l::lists' => list_from_option(all_except_option(s, l)) @ get_substitutions1(lists', s)
        
fun get_substitutions2 (lists, s) =
    let fun helper ([], acc) = acc
          | helper (l::lists, acc) =  helper(lists, list_from_option(all_except_option(s,l)) @ acc)
    in
        helper(lists, [])
    end

fun similar_names (lists, {first, middle, last}) =
    let fun full_names [] = []
          | full_names (n::ns) = {first=n, last=last, middle=middle}::full_names(ns) 
    in                                   
        {first=first, middle=middle, last=last}::full_names(get_substitutions2(lists, first))
    end
        
fun card_color suit =
    case suit of
        (Clubs) => Black
      | (Diamonds) => Red
      | (Hearts) => Red
      | (Spades) => Black

fun card_value rank =
    case rank of
        Num(n) => n
      | Ace => 11
      | _ => 10

fun remove_card (cs, c, e) =
    case all_except_option(c, cs) of
        NONE => raise e
      | SOME(cs') => cs'

fun all_same_color [] = true
  | all_same_color(_::[]) = true
  | all_same_color((s,_)::(s2,r2)::cs) = if card_color(s) <> card_color(s2) then false else all_same_color((s2,r2)::cs)
    
fun sum_cards cards =
    let fun sum ([], acc) = acc
          | sum ((s, r)::cs, acc) = sum(cs, acc + card_value(r))
    in
        sum(cards, 0)
    end
            
fun score (cards, goal) =
    let val sum = sum_cards(cards)
    in if sum > goal then sum - goal else goal - sum
    end

fun officiate (cards, moves, goal) =
    let
        fun game (cards, [], held, sum) = (held, sum)
          | game ([], moves, held, sum) = (held, sum)
          | game ((dsuit, drank)::cards, m::moves, held, sum) =
            case m of
                Discard(suit, rank) => game((dsuit, drank)::cards, moves, remove_card(held, (suit, rank), IllegalMove), sum - card_value(rank))
             | Draw => game(remove_card((dsuit, drank)::cards, (dsuit, drank), IllegalMove), moves, (dsuit, drank)::held, card_value(drank) + sum) 
    in
        case game(cards, moves, [], 0) of
            (held, sum) => sum
    end
