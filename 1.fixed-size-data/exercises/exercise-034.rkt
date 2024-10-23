;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-034) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> 1String
; 获取非空字符串s的第1个字符
; 输入: "HelloWorld", 预期输出: "H"
; 输入: "X", 预期输出: "X"
(define (string-first s)
  (if (> (string-length s) 0)
      (string-ith s 0)
      (error "s is empty")))

(string-first "HelloWorld")
; -> "H"
(string-first "X")
; -> "X"