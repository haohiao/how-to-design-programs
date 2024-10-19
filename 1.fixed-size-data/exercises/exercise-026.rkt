;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-026) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 在字符串str的索引i位置(包含长度)插入字符串“_”
(define (string-insert str i)
  (string-append
   (substring str 0 i)
   "_"
   (substring str i)))

(string-insert "helloworld" 6)
; => (string-append
;     (substring str 0 6)
;     "_"
;     (substring str 6))
; => (string-append
;     "hellow"
;     "_"
;     "orld")
; => "hellow_orld"