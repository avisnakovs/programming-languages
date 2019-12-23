
(* STRING, Char, List and ListPair *)

(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

                               (**** you can put all your code here ****)
                               
fun only_capitals l = List.filter (fn x => Char.isUpper(String.sub(x, 0))) l

fun longest_string1 l =
    List.foldl (fn (x, y) => if String.size(x) > String.size(y) then x else y) "" l   

fun longest_string2 l =
    List.foldl (fn (x, y) => if String.size(y) > String.size(x) then y else x) "" l

fun longest_string_helper f l =
    List.foldl f "" l

val longest_string3 = longest_string_helper (fn (x, y) => if  String.size(x) > String.size(y) then x else y)

val longest_string4 = longest_string_helper (fn (x, y) => if String.size(y) > String.size(x) then y else x)
                                            
val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o List.rev o String.explode

fun first_answer f l
    = hd (List.filter (fn x => case x of NONE => false | _ => true) (List.map f l))

fun all_answers f l =
    case (List.filter (fn x => case x of NONE => false | _ => true) (List.map f l)) of
        [] => NONE
      | filtered => SOME(List.map (fn x => valOf x) filtered)

val count_wildcards = g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size(x))

fun count_some_var (s, p)
    = g (fn () => 0) (fn x => if x = s then 1 else 0) p

fun all_strings p = 
    case p of
        Variable x        => [x]
      | TupleP ps         => List.foldl (fn (p,i) => (all_strings p) @ i) [] ps
      | ConstructorP(_,p) => all_strings p
      | _                 => []

fun distinct l =
    case l of
        [] => true
      | hd::tl => (not (List.exists (fn x => hd = x) tl)) andalso (distinct tl) 
    
val check_pat = distinct o all_strings

fun match_h (v, p) =
    let
        fun match_list (v::vv, p::pp) = match_h(v, p) @ match_list(vv, pp)
          | match_list ([], []) = [] 
    in
    case p of
        Wildcard => []
      | Variable x => [(x, v)]
      | UnitP => (case v of Unit => [] | _ => raise NoAnswer)
      | ConstP x => (case v of Const c => if x = c then [] else raise NoAnswer | _ => raise NoAnswer)
      | TupleP ps => (case v of Tuple vs => match_list(vs, ps) | _ => raise NoAnswer)
      | ConstructorP(s1, p1) => (case v of Constructor(s2, v2) =>
                                          (if s1 = s2
                                           then match_h(v2, p1)
                                           else raise NoAnswer) 
                                       | _ => raise NoAnswer) 
    end
                               
