;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-016) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; 计算给定图像中像素的数量
(define (image-area image)
  (* (image-width image)
     (image-height image)))



(define cat (bitmap "../resources/cat.png"))
(image-area cat)
