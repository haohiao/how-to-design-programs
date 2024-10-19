;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-029) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
  (* 1.50 (attendees ticket-price)))
 
; 计算给定票价ticket-price的利润(version.1)
(define (profit.v1 ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

; 计算给定票价ticket-price的利润(version.2)
(define (profit.v2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (* 1.50
        (+ 120
           (* (/ 15 0.1)
              (- 5.0 price))))))

(profit.v1 1) ; => 511.2
(profit.v1 2) ; => 937.2
(profit.v1 3) ; => 1063.2
(profit.v1 4) ; => 889.2
(profit.v1 5) ; => 415.2

(profit.v2 1) ; => 511.2
(profit.v2 2) ; => 937.2
(profit.v2 3) ; => 1063.2
(profit.v2 4) ; => 889.2
(profit.v2 5) ; => 415.2