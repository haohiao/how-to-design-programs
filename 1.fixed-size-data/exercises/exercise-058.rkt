;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-058) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
; Price 区间
; -- [0, 1000)
; -- [1000, 10000)
; -- [10000, ~)
; 物品价格

; # 常量定义
(define LOW-PRICE-CEILING 1000)
(define HIGH-PRICE-FLOOR 10000)
(define LOW-TAX 0)
(define MIDDLE-TAX 0.05)
(define HIGH-TAX 0.08)

; # 函数定义
; Price -> Number
; 计算对p收取的税额
; --- -- ---
(check-expect (sales-tax 0)
              (* 0 LOW-TAX))
(check-expect (sales-tax (/ LOW-PRICE-CEILING 2))
              (* (/ LOW-PRICE-CEILING 2) LOW-TAX))
(check-expect (sales-tax LOW-PRICE-CEILING)
              (* LOW-PRICE-CEILING MIDDLE-TAX))
(check-expect (sales-tax (/ (+ LOW-PRICE-CEILING HIGH-PRICE-FLOOR) 2))
              (* (/ (+ LOW-PRICE-CEILING HIGH-PRICE-FLOOR) 2) MIDDLE-TAX))
(check-expect (sales-tax HIGH-PRICE-FLOOR)
              (* HIGH-PRICE-FLOOR HIGH-TAX))
(check-expect (sales-tax (+ HIGH-PRICE-FLOOR 1244))
              (* (+ HIGH-PRICE-FLOOR 1244) HIGH-TAX))
; --- -- ---
(define (sales-tax p)
  (cond
    [(and (>= p 0) (< p LOW-PRICE-CEILING)) 0]
    [(and (>= p LOW-PRICE-CEILING) (< p HIGH-PRICE-FLOOR)) (* 0.05 p)]
    [(>= p HIGH-PRICE-FLOOR) (* 0.08 p)]))
