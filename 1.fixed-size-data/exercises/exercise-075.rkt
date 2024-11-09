;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-075) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
(define WIDTH 300)
(define HEIGHT 100)
(define WORLD (empty-scene WIDTH HEIGHT))
(define UFO-IMAGE (overlay (circle 10 "solid" "green") (ellipse 60 10 "solid" "green")))

; # 数据定义
(define-struct vel [deltax deltay])
; Vel是结构体
; (make-vel Number Number)
; 表示二维速度，deltax/deltay表示x/y轴上的速度，

(define-struct ufo [loc vel])
; UFO是结构体
; (make-ufo Posn Vel)
; 表示不明飞行物，loc/vel表示UFO在画布内的位置/速度
; --- -- ---
(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))
 
(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))
; --- -- ---

; # 函数定义
; UFO -> Image
; 在WORLD中根据ufo-loc绘制UFO-IMAGE（参考点为中心点）
; --- -- ---
(check-expect (render u1)
              (place-image UFO-IMAGE
                           (posn-x (ufo-loc u1))
                           (posn-y (ufo-loc u1))
                           WORLD))
; --- -- ---
(define (render ufo)
  (place-image UFO-IMAGE
               (posn-x (ufo-loc ufo))
               (posn-y (ufo-loc ufo))
               WORLD))

; UFO -> UFO
; 每次滴答，ufo根据ufo-vel进行移动，同时速度不变
; --- -- ---
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))
; --- -- ---
(define (ufo-move-1 ufo)
  (make-ufo (posn+ (ufo-loc ufo) (ufo-vel ufo))
            (ufo-vel ufo)))

; Pson Vel -> Posn
; p添加v
; --- -- ---
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
; --- -- ---
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))

; # 主函数
(define (main init)
  (big-bang init
    [to-draw render]
    [on-tick ufo-move-1]))

(main u1)
