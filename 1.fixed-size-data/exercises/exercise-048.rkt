;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-048) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (> s 10) (< s 20)) "silver"]
    [else "gold"]))

(reward 18)
; (cond
;   [(<= 0 18 10) "bronze"]
;   [(and (> 18 10) (< 18 20)) "silver"]
;   [else "gold"])
; (cond
;   [#false "bronze"]
;   [(and (> 18 10) (< 18 20)) "silver"]
;   [else "gold"])
; (cond
;   [(and (> 18 10) (< 18 20)) "silver"]
;   [else "gold"])
; (cond
;   [(and #true #true) "silver"]
;   [else "gold"])
; (cond
;   [#true "silver"]
;   [else "gold"])
; "silver"