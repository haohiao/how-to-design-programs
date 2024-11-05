;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ball) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
(define-sttuct vel [deltax deltay])
; 物体在画布上的速度，即时钟每次滴答所移动的距离
; deltax -> number
; 表示物体在x轴上的速度，正负表示方向，正数向右，负数向左
; deltay -> number
; 表示物体在y轴上的速度，正负表示方向，正数向下，负数向上

(define-struct ball [location velocity])
; 在画布上移动的球
; location -> posn
; 表示球在画布中的坐标，其中球的参考点为圆心
; velocity -> vel
; 表示球的速度

; # 示例
(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))