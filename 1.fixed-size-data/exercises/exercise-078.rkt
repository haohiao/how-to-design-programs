;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-078) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
(define-struct 3fstring [i1 i2 i3])
; 表示由3个fstring组成的单词

; fstring条目
; -- "a"~"z"
; -- #false
; 值可为#false的字母