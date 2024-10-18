;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-009) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define in-string "hello world")
(define in-image (rectangle 20 20 "solid" "blue"))
(define in-number-1 1)
(define in-number-0 0)
(define in-true #true)
(define in-false #false)

(define (in->positive in)
  (cond
    [(string? in)
     (string-length in)]
    [(image? in)
     (* (image-width in)
        (image-height in))]
    [(number? in)
     (if (> in 0)
         (- in 1)
         in)]
    [(boolean? in)
     (if (boolean=? in #true)
         10
         20)]))

(in->positive in-string)
(in->positive in-image)
(in->positive in-number-1)
(in->positive in-number-0)
(in->positive in-true)
(in->positive in-false)
