;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image) 
(require 2htdp/universe)

; properties of the "world" and the descending rocket
(define WIDTH 100)
(define HEIGHT 60)
(define X
  (/ WIDTH 2))
(define V 3)

; graphical constants
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "./resources/images/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

; functions
(define (picture-of-rocket t)
  (cond
    [(<= (distance t) ROCKET-CENTER-TO-TOP)
     (place-image
      ROCKET
      X
      (distance t)
      MTSCN)]
    [(> (distance t) ROCKET-CENTER-TO-TOP)
     (place-image
      ROCKET
      X
      ROCKET-CENTER-TO-TOP
      MTSCN)]))

(define (distance t)
  (* t V))

(animate picture-of-rocket)