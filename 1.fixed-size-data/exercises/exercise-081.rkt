;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-081) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
; Hour -> Number
; 表示小时

; Minute -> Number
; 表示分钟

; Second -> Number
; 表示秒

(define-struct time [hour minute second])
; Time是结构it
; (make-time Hour Minute Second)
; 表示时间，hour/minute/second分别表示时/分/秒
; --- -- ---
(define t1 (make-time 12 30 2))
(define t2 (make-time 2 2 2))
; --- -- ---

; # 函数定义
; Time -> Second
; 将Time转换为Second
; --- -- ---
(check-expect (time->seconds t1) 45002)
; --- -- ---
(define (time->seconds t)
  (+ (* (time-hour t) 3600)
     (* (time-minute t) 60)
     (time-second t)))