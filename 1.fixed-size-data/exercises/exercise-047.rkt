;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-047) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
(define CONTAINER-WIDTH 10)
(define CONTAINER-HEIGHT 102)
(define INDEX-RX "left")
(define INDEX-RY "bottom")
(define INDEX-WIDTH (- CONTAINER-WIDTH 2))
(define INDEX-X 1)
(define INDEX-Y (- CONTAINER-HEIGHT 1))
(define INDEX-COLOR "red")
(define BASE-INDEX 0.1)
(define MIN-INDEX 0)
(define MAX-INDEX 100)

(define CONTAINER (empty-scene
                   CONTAINER-WIDTH
                   CONTAINER-HEIGHT))

; # 数据定义
; Index -> NonnegativeInteger(非负整数)
; 快乐指数

; # 函数定义
; Index -> Image
; 将快乐指数i渲染成图片
; --- -- ---
(check-expect (render 50)
              (place-image/align (rectangle INDEX-WIDTH 50 "solid" INDEX-COLOR)
                                 INDEX-X INDEX-Y
                                 INDEX-RX INDEX-RY
                                 CONTAINER))
; --- -- ---
(define (render i)
  (place-image/align (rectangle INDEX-WIDTH i "solid" INDEX-COLOR)
                     INDEX-X INDEX-Y
                     INDEX-RX INDEX-RY
                     CONTAINER))

; Index -> Index
; 时钟滴答后快乐指数i减少0.1，直至减少至0
; --- -- ---
(check-expect (clock-tick-handler 10)
              9.9)
(check-expect (clock-tick-handler MIN-INDEX)
              MIN-INDEX)
; --- -- ---
(define (clock-tick-handler i)
  (if (> i MIN-INDEX)
      (limit-number (- i BASE-INDEX) MIN-INDEX MAX-INDEX)
      MIN-INDEX))

; Index String -> Index
; 通过向上和向下箭头键来提升快乐指数
; 向上箭头键: 提升1/3
; 向下箭头键: 提升1/5
; --- -- ---
(check-expect (keystroke-handler 15 "up")
              20)
(check-expect (keystroke-handler 99 "up")
              MAX-INDEX)
(check-expect (keystroke-handler MAX-INDEX "up")
              MAX-INDEX)
(check-expect (keystroke-handler MIN-INDEX "up")
              MIN-INDEX)
(check-expect (keystroke-handler 10 "down")
              12)
(check-expect (keystroke-handler MAX-INDEX "down")
              MAX-INDEX)
(check-expect (keystroke-handler 99 "down")
              MAX-INDEX)
(check-expect (keystroke-handler MIN-INDEX "down")
              MIN-INDEX)
(check-expect (keystroke-handler 4 " ")
              4)
; --- -- ---
(define (keystroke-handler i key)
  (cond
    [(string=? key "up")
     (limit-number (+ i (* i 1/3))
                   MIN-INDEX MAX-INDEX)]
    [(string=? key "down")
     (limit-number (+ i (* i 1/5))
                   MIN-INDEX MAX-INDEX)]
    [else i]))

; Number -> Number
; 限制number，当number大于ceiling或小于floor时，将返回ceiling或floor
; --- -- ---
(check-expect (limit-number 23 0 72) 23)
(check-expect (limit-number 84 0 72) 72)
(check-expect (limit-number -1 0 72) 0)
; --- -- ---
(define (limit-number number floor ceiling)
  (cond
    [(> floor number) floor]
    [(< ceiling number) ceiling]
    [else number]))

; # 主函数
(define (main i)
  (big-bang i
    [to-draw render]
    [on-tick clock-tick-handler]
    [on-key keystroke-handler]))

(main 10)