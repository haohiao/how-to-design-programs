;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-057) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 数据定义
; LRCD(launching rocket countdown) 条目
; - "resting"
; - [-3, -1]区间的整数
; - 非负整数
; "resting"表示火箭停在地面
; [-3, -1]表示倒计时
; 非负整数表示火箭飞行时的高度
; 高度指的是画布底部与火箭参考点的距离
; 火箭参考点为(center, bottom)

; # 常量定义
(define WORLD-WIDTH 100)
(define WORLD-HEIGHT 300)
(define WORLD (empty-scene WORLD-WIDTH WORLD-HEIGHT))

(define ROCKET (bitmap "../resources/rocket.png"))
(define ROCKET-X (/ WORLD-WIDTH 2))
(define SPEED 3)

(define TEXT-SIZE 20)
(define TEXT-COLOR "red")
(define TEXT-X 10)
(define TEXT-Y (* 3/4 WORLD-WIDTH))

; # 函数定义
; LRCD -> Image
; 将状态渲染为停止或飞行的火箭
; --- -- ---
(check-expect (show "resting")
              (place-image/align ROCKET
                                 ROCKET-X WORLD-HEIGHT
                                 "center" "bottom"
                                 (draw-background "resting")))
(check-expect (show -2)
              (place-image/align ROCKET
                                 ROCKET-X WORLD-HEIGHT
                                 "center" "bottom"
                                 (draw-background -2)))
(check-expect (show (/ WORLD-HEIGHT 2))
              (place-image/align ROCKET
                                 ROCKET-X (/ WORLD-HEIGHT 2)
                                 "center" "bottom"
                                 (draw-background (/ WORLD-HEIGHT 2))))
(check-expect (show 0)
              (place-image/align ROCKET
                                 ROCKET-X WORLD-HEIGHT
                                 "center" "bottom"
                                 (draw-background 0)))
(check-expect (show WORLD-HEIGHT)
              (place-image/align ROCKET
                                 ROCKET-X 0
                                 "center" "bottom"
                                 (draw-background WORLD-HEIGHT)))
; --- -- ---
(define (show x)
  (place-image/align ROCKET
                     ROCKET-X (if (and (number? x) (>= x 0)) (- WORLD-HEIGHT x) WORLD-HEIGHT)
                     "center" "bottom"
                     (draw-background x)))

; LRCD -> Image
; 根据状态渲染背景图片
; --- -- ---
(check-expect (draw-background "resting")
              WORLD)
(check-expect (draw-background -2)
              (place-image (text "-2" TEXT-SIZE TEXT-COLOR)
                           TEXT-X TEXT-Y
                           WORLD))
(check-expect (draw-background 14)
              WORLD)
; --- -- ---
(define (draw-background x)
  (if (and (number? x) (<= -3 x -1))
      (place-image (text (number->string x) TEXT-SIZE TEXT-COLOR)
                   TEXT-X TEXT-Y
                   WORLD)
      WORLD))

; LRCD -> LRCD
; 火箭开始飞行
; --- -- ---
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 32) (+ 32 SPEED))
(check-expect (fly 0) (+ 0 SPEED))
; --- -- ---
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (+ x 1)]
    [(<= 0 x) (+ x SPEED)]))

; LRCD KeyEvent -> LRCD
; 按下空格键火箭进行倒计时
; --- -- ---
(check-expect (launch "resting" " ")
              -3)
(check-expect (launch "resting" "s")
              "resting")
(check-expect (launch -3 " ")
              -3)
(check-expect (launch 41 " ")
              41)
; --- -- ---
(define (launch x ke)
  (cond
    [(string? x) (if (string=? ke " ") -3 x)]
    [else x]))

; # 主函数
(define (main ws)
  (big-bang ws
    [to-draw show]
    [on-tick fly 0.25]
    [on-key launch]))

(main "resting")