#lang racket

(define xs (list 1 2 3 4))
(define ys (list (list 1 3 4) 3 4 (list (list 1) 2) 1))

(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum1 (cdr xs)))
          (+ (sum1 (car xs)) (sum1 (cdr xs))))))