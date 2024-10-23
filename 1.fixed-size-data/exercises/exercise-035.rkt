;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-035) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> 1String
; 获取非空字符串s的最后1个字符
; 输入: "HelloWorld", 预期输出: "d"
; 输入: "X", 预期输出: "X"
(define (string-last s)
  (if (> (string-length s) 0)
      (string-ith s (sub1 (string-length s)))
      (error "s is empty")))

(string-last "HelloWorld")
; -> "d"
(string-last "X")
; -> "X"