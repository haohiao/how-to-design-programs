;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-053) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; # 数据定义
; LR(launching rocket) 条目
; - "resting"
; - NonnegativeNumber(非负数)
; "resting"表示火箭停在地面
; NonnegativeNumber表示火箭飞行时的高度
; 高度指的是画布顶部与火箭参考点的距离
; 火箭参考点为(center, bottom)

; # 常量定义
(define WORLD-WIDTH 100)
(define WORLD-HEIGHT 100)
(define WORLD (empty-scene WORLD-WIDTH WORLD-HEIGHT))

(define ROCKET (bitmap "../resources/rocket.png"))
(define ROCKET-X (/ WORLD-WIDTH 2))


; LR例子
; - "resting"
(place-image/align ROCKET ROCKET-X WORLD-HEIGHT "center" "bottom" WORLD)
; - NonnegativeNumber
(place-image/align ROCKET ROCKET-X 0 "center" "bottom" WORLD)
(place-image/align ROCKET ROCKET-X (/ WORLD-HEIGHT 2) "center" "bottom" WORLD)
(place-image/align ROCKET ROCKET-X WORLD-HEIGHT "center" "bottom" WORLD)
