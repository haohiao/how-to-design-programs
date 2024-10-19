;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-019) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 在字符串str的索引i位置(包含长度)插入字符串inserter
(define (string-insert str i inserter)
  (cond
    [(and
      (>= i 0)
      (<= i (string-length str)))
     (string-append
      (substring str 0 i)
      inserter
      (substring str i))]
    [else
     (error
      (string-append
       "value i is invalid: "
       (number->string i)))]))

(string-insert "helloworld" 0 "_")
(string-insert "helloworld" 5 "_")
(string-insert "helloworld" 10 "_")
(string-insert "" 0 ".")
(string-insert "helloworld" 15 "_")