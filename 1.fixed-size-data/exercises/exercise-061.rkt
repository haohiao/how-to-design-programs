;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-061) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 数据定义
; Time -> Number
; Time表示时钟滴答累积的时间

; N-TrafficLIght Enumeration -> String:
(define RED 0)
(define GREEN 1)
(define YELLOW 2)
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
(check-expect (light-item-render RED #true)
              (underlay (circle LIGHT-RADIUS "solid" (get-color RED))
                        LIGHT-FRAME))
(check-expect (light-item-render GREEN  #false)
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
(check-expect (render RED)
              (underlay (beside (light-item-render RED (string=? (get-color 0) "red"))
                                SPACE
                                (light-item-render RED (string=? (get-color 0) "yellow"))
                                SPACE
                                (light-item-render RED (string=? (get-color 0) "green")))
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
(check-expect (traffic-light-next RED) YELLOW)
(check-expect (traffic-light-next YELLOW) GREEN)
(check-expect (traffic-light-next GREEN) RED)
; --- -- ---
(define (traffic-light-next s)
  (cond
    [(equal? s RED) GREEN]
    [(equal? s YELLOW) RED]
    [(equal? s GREEN) YELLOW]))

; N-TrafficLight -> ImageColor
; 获取s对应的颜色
; --- -- ---
(check-expect (get-color RED) "red")
(check-expect (get-color GREEN) "green")
(check-expect (get-color YELLOW) "yellow")
; --- -- ---
(define (get-color s)
  (cond
    [(= s RED) "red"]
    [(= s GREEN) "green"]
    [(= s YELLOW) "yellow"]))

; # 主函数
(define (main init)
  (big-bang init
    [to-draw render]
    [on-tick traffic-light-next BASE-TIME]))

(main GREEN)