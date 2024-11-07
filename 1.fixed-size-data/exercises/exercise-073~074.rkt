;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-073~074) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; # 数据定义

; # 函数定义
; Posn -> Image
; 在MTS内p的位置添加DOT
; --- -- ---
(check-expect (scene+dot (make-posn 14 23))
              (place-image DOT
                           (posn-x (make-posn 14 23))
                           (posn-y (make-posn 14 23))
                           MTS))
; --- -- ---
(define (scene+dot p)
  (place-image DOT
               (posn-x p)
               (posn-y p)
               MTS))

; Posn -> Posn
; 将p的x坐标加3
; --- -- ---
(check-expect (x+ (make-posn 24 50))
              (make-posn 27 50))
; --- -- ---
(define (x+ p)
  (posn-x-setter p (+ (posn-x p) 3)))

; Posn Number Number MouseEvt -> Posn
; 如果是鼠标点击，则是(make-posn x y)，否则是p
; --- -- ---
(check-expect (reset-dot (make-posn 23 56)
                         10 10 "button-down")
              (make-posn 10 10))
(check-expect (reset-dot (make-posn 23 56)
                         10 10 "button-up")
              (make-posn 23 56))
; --- -- ---
(define (reset-dot p x y me)
  (cond
    [(string=? me "button-down") (make-posn x y)]
    [else p]))

; Posn -> Posn
; posn-x设置器
; --- -- ---
(check-expect (posn-x-setter (make-posn 10 23) 5)
              (make-posn 5 23))
; --- -- ---
(define (posn-x-setter p x)
  (make-posn x (posn-y p)))

; # 主函数
(define  (main p0)
  (big-bang p0
    [to-draw scene+dot]
    [on-tick x+]
    [on-mouse reset-dot]))

(main (make-posn 0 50))