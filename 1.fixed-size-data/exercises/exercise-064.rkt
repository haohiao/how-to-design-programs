;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-064) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; posn -> number
; 计算ap到原点的曼哈顿距离
; --- -- ---
(check-expect (manhattan-distance (make-posn 0 5)) 5)
(check-expect (manhattan-distance (make-posn 2 0)) 2)
(check-expect (manhattan-distance (make-posn 6 8)) 14)
; --- -- ---
(define (manhattan-distance sp)
  (+ (abs (posn-x sp))
     (abs (posn-y sp))))