;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname r3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 常量定义
(define DELTA 0.0000001)

; # 数据定义
(define-struct r3 [x y z])
; R3是结构体
; (make-r3 Number Number Number)
; 表示三维空间的坐标
; --- -- ---
(define ORIGN (make-r3 0 0 0))
(define r3-ex1 (make-r3 1 2 13))
(define r3-ex2 (make-r3 -1 0 3))
; --- -- ---


; # 函数定义
; R3 -> Number
; 计算p到原点的距离
; --- -- ---
(check-within (r3-distance-to-0 r3-ex1)
              (sqrt (+ (sqr (r3-x r3-ex1))
                       (sqr (r3-y r3-ex1))
                       (sqr (r3-z r3-ex1))))
              DELTA)
(check-within (r3-distance-to-0 r3-ex2)
              (sqrt (+ (sqr (r3-x r3-ex2))
                       (sqr (r3-y r3-ex2))
                       (sqr (r3-z r3-ex2))))
              DELTA)
; --- -- ---
(define (r3-distance-to-0 p)
  (sqrt (+ (sqr (r3-x p))
           (sqr (r3-y p))
           (sqr (r3-z p)))))

