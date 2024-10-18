;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-003) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define str "helloworld")
(define i 5)

(cond
  [(and
    (>= i 0)
    (< i (string-length str)))
   (string-append
    (substring str 0 i)
    "_"
    (substring str i))]
  [else
   (error
    (string-append
     "value i is invalid: "
     (number->string i)))])