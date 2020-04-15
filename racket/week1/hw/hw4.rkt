#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(< n 0)  (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (nth xs (remainder n (length xs)) 0)]))

(define (nth xs n acc)
  (if (null? xs)
      (error "nth: not found")
      (if (= n acc)
          (car xs)
          (nth (cdr xs) n (+ acc 1)))))



(define (stream-for-n-steps s n)
  (letrec ([f (lambda (stream seq acc)
                (let ([pr (stream)])
                  (if (= n seq)
                      null
                      (cons acc (f (cdr pr) (+ seq 1) (car pr))))))])
    (f (cdr (s)) 0 (car (s)))))


(define funny-number-stream
  (letrec ([f (lambda (x) (cons (negate-fives x) (lambda () (f (+ 1 x)))))])
    (lambda () (f 1))))

(define (negate-fives x)
  (if (= 0 (remainder x 5)) (- x) x))



(define dan-then-dog
  (letrec ([dan (lambda () (cons "dan.jpg" dog))]
           [dog (lambda () (cons "dog.jpg" dan))])
    dan))

(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (n) (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (f (+ 1 n)))))])
    (lambda () (f 0))))









      