;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-018) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 通过字符"_"拼接在两个字符串str1和str2
(define (string-join str1 str2)
  (string-append str1 "_" str2))

(string-join "hello" "world")