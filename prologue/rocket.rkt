;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image) 
(require 2htdp/universe)

(define (picture-of-rocket height)
  (cond
    [(<= height
         (- HEIGHT (/ (image-height ROCKET) 2)))
     (place-image
      ROCKET
      50
      height
      (empty-scene WIDTH HEIGHT))]
    [(> height
        (- HEIGHT (/ (image-height ROCKET) 2)))
     (place-image
      ROCKET
      50
      (- HEIGHT (/ (image-height ROCKET) 2))
      (empty-scene WIDTH HEIGHT))]))

(define WIDTH 100)
(define HEIGHT 60)
(define ROCKET (bitmap "./resources/images/rocket.png"))

(animate picture-of-rocket)