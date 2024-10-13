;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image) 
(require 2htdp/universe)

(define (picture-of-rocket height)
  (cond
    [(<= height 60)
     (place-image
      (bitmap "./resources/images/rocket.png")
      50
      height
      (empty-scene 100 60))]
    [(> height 60)
     (place-image
      (bitmap "./resources/images/rocket.png")
      50
      60
      (empty-scene 100 60))]))


(animate picture-of-rocket)