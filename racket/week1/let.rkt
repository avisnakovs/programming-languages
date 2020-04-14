#lang racket

(define (max xs)
  (cond [(null? xs) (error "empty list")]
        [(null? (cdr xs)) (car xs)]
        [#t (let ([tlans (max (cdr xs))])
              (if (> tlans (car xs))
                  tlans
                  (car xs)))]))