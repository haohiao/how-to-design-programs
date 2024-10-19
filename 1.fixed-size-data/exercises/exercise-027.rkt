;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-027) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define BASE-PRICE 5)
(define BASE-ATTENDEES 120)
(define BASE-CHANGE-PRICE 0.10)
(define BASE-CHANGE-ATTENDEES 15)
(define BASE-COST 180)
(define A-ATTENDEE-COST 0.04)

; 计算给定票价ticket-price的到场人数
(define (attendees ticket-price)
  (- BASE-ATTENDEES
     (* (/ (- ticket-price BASE-PRICE) BASE-CHANGE-PRICE)
        BASE-CHANGE-ATTENDEES)))

; 计算给定票价ticket-price的收入
(define (revenue ticket-price)
  (* ticket-price
     (attendees ticket-price)))

; 计算给定票价ticket-price的成本
(define (cost ticket-price)
  (+ BASE-COST
     (* A-ATTENDEE-COST (attendees ticket-price))))
 
; 计算给定票价ticket-price的利润
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 1)