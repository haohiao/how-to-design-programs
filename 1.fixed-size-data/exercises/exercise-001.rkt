;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-001) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 某点的笛卡儿坐标
(define x 3)
(define y 4)

; 该点与原点(0,0)之间的距离
(sqrt (+ (sqr x) (sqr y)))