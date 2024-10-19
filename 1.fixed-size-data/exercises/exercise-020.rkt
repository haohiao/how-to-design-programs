;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-020) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 删除字符串str的索引i位置的字符
(define (string-delete str i)
  (cond
    [(and
      (>= i 0)
      (< i (string-length str)))
     (string-append
      (substring str 0 i)
      (substring str (+ i 1)))]
    [else
     (error
      (string-append
       "value i is invalid: "
       (number->string i)))]))

(string-delete "helloworld" 0)
(string-delete "helloworld" 5)
(string-delete "helloworld" 9)
(string-delete "" 0)