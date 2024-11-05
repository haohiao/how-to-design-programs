;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-068) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
(define-sttuct vel [deltax deltay])
; 物体在画布上的速度，即时钟每次滴答所移动的距离


(define-struct ball [x y deltax deltay])
; 在画布上移动的球
; x, y -> number, number
; 表示球在画布中的坐标，其中球的参考点为圆心
; deltax, deltay -> number, number
; 表示物体在x/y轴上的速度，正负表示方向，正数向右/下，负数向左/上

; # 示例
(define ball1
  (make-ball 30 40 -10 5))