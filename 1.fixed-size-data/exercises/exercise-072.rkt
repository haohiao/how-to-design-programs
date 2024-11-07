;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-073) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 数据定义
(define-struct phone# [area switch num])
; (make-phone# Number Number Number)
; 手机号
; area是区域代码，区间[100, 999]
; switch是街区电话交换机的电话代码, 区间[100, 999]
; num是街区电话交换机内的电话号码，区间[0000, 9999]