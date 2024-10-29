;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname moving-car) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)

(define TREE-X (* 1/2 WIDTH-OF-WORLD))

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define WIDTH-OF-CAR-BODY (* 8 WHEEL-RADIUS))
(define HEIGHT-OF-CAR-BODY (* WIDTH-OF-CAR-BODY 2/5))
(define SPEED 3) ; CAR每时钟滴答移动的像素点

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE 0 "solid" "white")) ; 前后WHEELS间隔的距离
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define BODY-OF-CAR (above/align
                     "center"
                     (rectangle
                      (* 1/2 WIDTH-OF-CAR-BODY)
                      (* 1/3 HEIGHT-OF-CAR-BODY)
                      "solid"
                      "red")
                     (rectangle
                      WIDTH-OF-CAR-BODY
                      (* 2/3 HEIGHT-OF-CAR-BODY)
                      "solid"
                      "red")))
(define CAR (underlay/align/offset
             "center"
             "bottom"
             BODY-OF-CAR
             0
             WHEEL-RADIUS
             BOTH-WHEELS))

(define TREE (underlay/xy
              (circle 10 "solid" "green")
              9 15
              (rectangle 2 20 "solid" "brown")))
(define WORLD (place-image/align
               TREE
               TREE-X
               HEIGHT-OF-WORLD
               "center"
               "bottom"
               (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))



; # 数据定义
; WorldState 是 Number
; 解释: WORLD左边界到CAR右边界的距离

; # 函数定义
; WorldState -> Image
; 将CAR放置在距离WORLD左边界x像素的位置
; --- -- ---
(check-expect (place-car 50)
              (place-image/align CAR 50 HEIGHT-OF-WORLD "right" "bottom" WORLD))
(check-expect (place-car 150)
              (place-image/align CAR 150 HEIGHT-OF-WORLD "right" "bottom" WORLD))
; --- -- ---
(define (place-car x)
  (place-image/align
   CAR
   x HEIGHT-OF-WORLD "right" "bottom"
   WORLD))

; WorldState -> WorldState
; 根据当前x，计算下一个时钟滴答时间后的WorldState
; --- -- ---
(check-expect (next-distance 20) (+ 20 SPEED))
(check-expect (next-distance 78) (+ 78 SPEED))
; --- -- ---
(define (next-distance x)
  (+ x SPEED))

; WorldState -> Boolean
; 判断汽车是否从WORLD右边界消失
; --- -- ---
(check-expect (stop? (* 1/2 WIDTH-OF-WORLD)) #false)
(check-expect (stop? WIDTH-OF-WORLD) #false)
(check-expect (stop? (+ WIDTH-OF-WORLD (image-width CAR) 1)) #true)
; --- -- ---
(define (stop? x)
  (> x (+ WIDTH-OF-WORLD (image-width CAR))))

; WorldState Number Number String -> WorldState
; 如果给定的me是"button-down", 将车放到x-mouse的位置
; --- -- ---
(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10) 
(check-expect (hyper 32 10 20 "move") 32)
; --- -- ---
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? me "button-down") x-mouse]
    [else x-position-of-car]))


; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main ws)
  (big-bang ws
    [on-tick next-distance]
    [to-draw place-car]
    [on-mouse hyper]
    [stop-when stop?]))

(main 0)