;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-013) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 获取非空字符串的第1个字符
(define (string-first str)
  (if (> (string-length str) 0)
      (string-ith str 0)
      (error "str is empty")))

(string-first "hello world")
(string-first "")