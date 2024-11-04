;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-060) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 数据定义
; Time -> Number
; Time表示时钟滴答累积的时间

; N-TrafficLIght Enumeration -> String:
; - 0: 红色
; - 1: 绿色
; - 2: 黄色
; 交通信号的三种状态

; # 常量定义
(define BASE-TIME 1)

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
; N-TrafficLIght Boolean -> Image
; N-TrafficLIght各个项的图片渲染
; color表示灯的颜色,switch表示灯的亮灭
; --- -- ---
(check-expect (light-item-render 0 #true)
              (underlay (circle LIGHT-RADIUS "solid" "red")
                        LIGHT-FRAME))
(check-expect (light-item-render 1  #false)
              LIGHT-FRAME)
; --- -- ---
(define (light-item-render s switch)
  (if switch
      (underlay (circle LIGHT-RADIUS "solid" (get-color s))
                LIGHT-FRAME)
      LIGHT-FRAME))

; N-TrafficLIght -> Image
; 根据state渲染交通灯
; --- -- ---
(check-expect (render 0)
              (underlay (beside (light-item-render 0 (string=? (get-color 0) "red"))
                                SPACE
                                (light-item-render 0 (string=? (get-color 0) "yellow"))
                                SPACE
                                (light-item-render 0 (string=? (get-color 0) "green")))
                        TRAFFICLIGHT-FRAME))
; --- -- ---
(define (render state)
  (underlay (beside (light-item-render state (string=? (get-color state) "red"))
                    SPACE
                    (light-item-render state (string=? (get-color state) "yellow"))
                    SPACE
                    (light-item-render state (string=? (get-color state) "green")))
            TRAFFICLIGHT-FRAME))

; N-TrafficLight -> N-TrafficLight
; 获取下一个状态
; --- -- ---
(check-expect (traffic-light-next 0) 1)
(check-expect (traffic-light-next 1) 2)
(check-expect (traffic-light-next 2) 0)
; --- -- ---
(define (traffic-light-next s)
  (modulo (+ s 1) 3))

; N-TrafficLight -> ImageColor
; 获取s对应的颜色
; --- -- ---
(check-expect (get-color 0) "red")
(check-expect (get-color 1) "green")
(check-expect (get-color 2) "yellow")
; --- -- ---
(define (get-color s)
  (cond
    [(= s 0) "red"]
    [(= s 1) "green"]
    [(= s 2) "yellow"]))

; # 主函数
(define (main init)
  (big-bang init
    [to-draw render]
    [on-tick traffic-light-next BASE-TIME]))

(main 1)