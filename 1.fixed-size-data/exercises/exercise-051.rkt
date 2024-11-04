;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-051) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 数据定义
; Time -> Number
; Time表示时钟滴答累积的时间

; TrafficLIght Enumeration -> String:
; - "red"
; - "green"
; - "yellow"
; 交通信号的三种状态

; # 常量定义
(define BASE-TIME 3)

(define LIGHT-RADIUS 20)
(define SPACE-WIDTH (* 1/10 LIGHT-RADIUS))
(define TRAFFICLIGHT-WIDTH (+ (* 3 2 LIGHT-RADIUS) (* 2 SPACE-WIDTH) 2))
(define TRAFFICLIGHT-HEIGHT (+ (* 2 LIGHT-RADIUS) 2))

(define LIGHT-FRAME (circle LIGHT-RADIUS "outline" "black"))
(define SPACE (rectangle SPACE-WIDTH 0 "solid" "transparent"))
(define TRAFFICLIGHT-FRAME (rectangle
                            TRAFFICLIGHT-WIDTH
                            TRAFFICLIGHT-HEIGHT
                            "outline"
                            "black"))

; # 函数定义
; TrafficLIght Boolean -> Image
; TrafficLIght各个项的图片渲染
; color表示灯的颜色，switch表示灯的亮灭
; --- -- ---
(check-expect (light-item-render "red" #true)
              (underlay (circle LIGHT-RADIUS "solid" "red")
                        LIGHT-FRAME))
(check-expect (light-item-render "green" #false)
              LIGHT-FRAME)
; --- -- ---
(define (light-item-render color switch)
  (if switch
      (underlay (circle LIGHT-RADIUS "solid" color)
                LIGHT-FRAME)
      LIGHT-FRAME))

; TrafficLIght -> Image
; 根据state渲染交通灯
; --- -- ---
(check-expect (render "red")
              (underlay (beside (light-item-render "red" (string=? "red" "red"))
                                SPACE
                                (light-item-render "red" (string=? "red" "yellow"))
                                SPACE
                                (light-item-render "red" (string=? "red" "green")))
                        TRAFFICLIGHT-FRAME))
; --- -- ---
(define (render state)
  (underlay (beside (light-item-render state (string=? state "red"))
                    SPACE
                    (light-item-render state (string=? state "yellow"))
                    SPACE
                    (light-item-render state (string=? state "green")))
            TRAFFICLIGHT-FRAME))

; TrafficLight -> TrafficLight
; 获取下一个状态
; --- -- ---
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
; --- -- ---
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; # 主函数
(define (main init)
  (big-bang init
    [to-draw render]
    [on-tick traffic-light-next BASE-TIME]))

(main "green")