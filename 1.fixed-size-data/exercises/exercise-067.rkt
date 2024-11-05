;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-067) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
; direction enum -> string
; -- "up": 上
; -- "down": 下
; 表示画布内的方向

(define-struct balld [location direction])
; 在画布上移动的球
; location -> number
; 表示球与画布顶部的距离,其中球的参考点为圆心
; direction -> direction enum
; 表示球在画布中移动的方向

; # 常量定义
(define SPEED 3)

; # 示例
(make-balld 10 "up")
(make-balld 59 "down")