;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-017) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; 判断图像相对是宽还高
(define (image-classify image)
  (cond
    [(< (image-width image) (image-height image))
     "tall"]
    [(> (image-width image) (image-height image))
     "wide"]
    [else
     "square"]))

(define cat (bitmap "../resources/cat.png"))
(image-classify cat)

(image-classify (rectangle 10 2 "solid" "red"))

(image-classify (square 4 "solid" "red"))