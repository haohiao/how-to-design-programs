;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-038) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; 获取给定非空字符串s被移除最后1个字符后的字符串
; 输入: "HelloWorld", 预期输出: "HelloWorl"
; 输入: "X", 预期输出: ""
(define (string-remove-last s)
  (if (> (string-length s) 0)
      (substring s 0 (- (string-length s) 1))
      (error "s is empty")))

(string-remove-last "HelloWorld")
(string-remove-last "X")