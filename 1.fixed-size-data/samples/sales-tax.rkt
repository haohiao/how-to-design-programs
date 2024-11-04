;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sales-tax) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
; Price 区间
; -- [0, 1000)
; -- [1000, 10000)
; -- [10000, ~)
; 物品价格

; # 函数定义
; Price -> Number
; 计算对p收取的税额
; --- -- ---
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 432) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 4325) (* 0.05 4325))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 42641) (* 0.08 42641))
; --- -- ---
(define (sales-tax p)
  (cond
    [(and (>= p 0) (< p 1000)) 0]
    [(and (>= p 1000) (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))
