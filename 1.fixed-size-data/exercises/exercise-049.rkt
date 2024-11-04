;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-049) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; - 步进器求值
(define (fn y)
  (- 200 (cond [(> y 200) 0] [else y])))

(fn 100)
; (- 200 (cond [(> 100 200) 0] [else 100])))
; (- 200 (cond [#false 0] [else 100])))
; (- 200 (cond [else 100])))
; (- 200 100)
; 100

(fn 210)
; (- 200 (cond [(> 210 200) 0] [else 100])))
; (- 200 (cond [#true 0] [else 100])))
; (- 200 0)
; 200

; - 修改发射火箭函数, 减少冗余
(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define ROCKET (bitmap "../resources/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
 
(define (create-rocket-scene.v5 h)
  (cond
    [(<= h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 h MTSCN)]
    [(> h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))

(define (create-rocket-scene.v6 h)
  (place-image
   ROCKET
   50
   (cond
     [(<= h ROCKET-CENTER-TO-TOP) h]
     [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
   MTSCN))

(create-rocket-scene.v5 20)
(create-rocket-scene.v6 20)
(create-rocket-scene.v5 60)
(create-rocket-scene.v6 60)