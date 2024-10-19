;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-028) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(profit 1) ; => 511.2
(profit 2) ; => 937.2
(profit 3) ; => 1063.2
(profit 4) ; => 889.2
(profit 5) ; => 415.2

; 根据上述值进一步求得最佳利润
(profit 2.5) ; => 1037.7
(profit 2.7) ; => 1056.9
(profit 2.8) ; => 1062
(profit 2.9) ; => 1064.1 (max)
(profit 3.5) ; => 1013.7
(profit 3.3) ; => 1042.5
(profit 3.2) ; => 1052.4
(profit 3.1) ; => 1059.3