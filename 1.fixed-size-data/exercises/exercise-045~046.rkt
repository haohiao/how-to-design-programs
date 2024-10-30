;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-045~046) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
(define WORLD-WIDTH 360)
(define WORLD-HEIGHT 120)
(define SPEED 3) ; 猫的移动速度
(define CAT-RX "right") ; 猫参考点X位置
(define CAT-RY "bottom") ; 猫参考点Y位置
(define CAT-Y (- WORLD-HEIGHT 1)) ; 猫的纵轴位置

(define WORLD
  (empty-scene WORLD-WIDTH WORLD-HEIGHT))
(define CAT1
  (bitmap "../resources/cat1.png"))
(define CAT2
  (bitmap "../resources/cat2.png"))

(define CAT-WIDTH (image-width CAT1))

; # 数据定义
; MovingTime -> NonnegativeInteger(非负整数)
; MovingTime是猫移动的时长

; # 补充说明
; 猫放置在WORLD中时以横轴右边界，纵轴底部为参考点

; # 函数定义
; MovingTime -> Image
; 根据猫移动的时长将其放入WORLD中
; --- -- ---
(check-expect (render 10)
              (place-image/align (get-cat-image-by-movingtime 10)
                                 (get-position 10)
                                 CAT-Y
                                 CAT-RX
                                 CAT-RY
                                 WORLD))
(check-expect (render 100)
              (place-image/align (get-cat-image-by-movingtime 100)
                                 (get-position 100)
                                 CAT-Y
                                 CAT-RX
                                 CAT-RY
                                 WORLD))
; --- -- ---
(define (render t)
  (place-image/align (get-cat-image-by-movingtime t)
                     (get-position t)
                     CAT-Y
                     CAT-RX
                     CAT-RY
                     WORLD))

; MovingTime -> Number
; 根据t计算猫的位置
; 位置是通过计算猫移动的总路程模WORLD和CAR的宽度之和,
; 这样就能平滑的“循环”移动
; --- -- ---
(check-expect (get-position 10)
              (modulo (* 10 SPEED) (+ WORLD-WIDTH CAT-WIDTH)))
(check-expect (get-position 100)
              (modulo (* 100 SPEED) (+ WORLD-WIDTH CAT-WIDTH)))
; --- -- ---
(define (get-position t)
  (modulo (* t SPEED) (+ WORLD-WIDTH CAT-WIDTH)))

; Number -> Image
; 根据猫的位置p判断猫的图片状态
; p为偶数时为CAT1，p为奇数时为CAT2
; --- -- ---
(check-expect (get-cat-image-by-position 0)
              CAT1)
(check-expect (get-cat-image-by-position 1)
              CAT2)
; --- -- ---
(define (get-cat-image-by-position p)
  (if (even? p)
      CAT1
      CAT2))

; MovingTime -> Image
; 根据猫移动时长t判断猫的图片状态
; --- -- ---
(check-expect (get-cat-image-by-movingtime 0)
              CAT1)
(check-expect (get-cat-image-by-movingtime 1)
              CAT2)
; --- -- ---
(define (get-cat-image-by-movingtime t)
  (get-cat-image-by-position (get-position t)))

; 主函数
(define (main t)
  (big-bang t
    [to-draw render]
    [on-tick add1]))

(main 0)