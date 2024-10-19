;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname profit-from-cinema) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 计算给定票价ticket-price的到场人数
(define (attendees ticket-price)
  (- 120
     (* (/ (- ticket-price 5) 0.10)
        15)))

; 计算给定票价ticket-price的收入
(define (revenue ticket-price)
  (* ticket-price
     (attendees ticket-price)))

; 计算给定票价ticket-price的成本
(define (cost ticket-price)
  (+ 180
     (* 0.04 (attendees ticket-price))))
 
; 计算给定票价ticket-price的利润
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))