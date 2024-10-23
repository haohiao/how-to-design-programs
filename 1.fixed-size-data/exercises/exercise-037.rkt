;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-037) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; 获取给定非空字符串s移除第1个字符串后的子字符串
; 输入: "HelloWorld", 预期输出: "elloWorld"
; 输入: "X", 预期输出: ""
(define (string-rest s)
  (if (> (string-length s) 0)
      (substring s 1)
      (error "s is empty")))

(string-rest "HelloWorld")
(string-rest "X")