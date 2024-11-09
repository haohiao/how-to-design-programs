;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-079) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
; --- -- ---
(define RED "red")
(define WHITE "white")
; --- -- ---

; H is a Number between 0 and 100.
; interpretation represents a happiness value
; --- -- ---
(define HAPPY 80)
(define SORRY 20)
; --- -- ---

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
; --- -- ---
(define zhaozhihao (make-person "zhihao" "zhao" #true))
(define haohiao (make-person "hiao" "hao" #true))
; --- -- ---

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; --- -- ---
(define oladog-z124 (make-dog haohiao "olddog-z124" 22 HAPPY))
(define xiaohuang (make-dog zhaozhihao "xiaohuang" 12 SORRY))
; --- -- ---

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight
; --- -- ---
(define waiting-weapon #false)
(define weapon1 (make-posn 20 30))
; --- -- ---