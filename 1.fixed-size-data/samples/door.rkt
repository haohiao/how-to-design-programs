;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname door) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 数据定义
; DoorState 枚举
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")
; 门的状态

; # 常量定义
(define TEXT-COLOR "red")
(define TEXT-SIZE 24)

; # 函数定义
; DoorState -> DootState
; 始终滴答一次时，关门
; --- -- ---
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
; --- -- ---
(define (door-closer s)
  (cond
    [(equal? s OPEN) CLOSED]
    [else s]))


; DoorState -> Image
; 渲染DoorState
; --- -- ---
(check-expect (door-render CLOSED)
              (text CLOSED TEXT-SIZE TEXT-COLOR)) 
; --- -- ---
(define (door-render s)
  (text s TEXT-SIZE TEXT-COLOR))

; DoorState KeyEvent -> DoorState
; 按u、l、" "可分别执行解锁、关锁、开门
; --- -- ---
(check-expect (door-action LOCKED "u")
              CLOSED)
(check-expect (door-action CLOSED "l")
              LOCKED)
(check-expect (door-action CLOSED " ")
              OPEN)
(check-expect (door-action CLOSED "A")
              CLOSED)
(check-expect (door-action LOCKED "a")
              LOCKED)
; --- -- ---
(define (door-action s k)
  (cond
    [(and (string=? s LOCKED) (string=? k "u"))
     CLOSED]
    [(and (string=? s CLOSED) (string=? k "l"))
     LOCKED]
    [(and (string=? s CLOSED) (string=? k " "))
     OPEN]
    [else s]))

; # 主函数
(define (main init)
  (big-bang init
    [to-draw door-render]
    [on-key door-action]
    [on-tick door-closer 3]))

(main LOCKED)