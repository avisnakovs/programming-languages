#lang racket

(define ys (list (list 1 3 4) 3 4 (list (list 1) 2) 1))

(define (sum3 xs)
  (cond 
    [(null? xs) 0]
    [(number? (car xs)) (+ (car xs) (sum3 (cdr xs)))]
    [#t (+ (sum3 (car xs)) (sum3 (cdr xs)))]))