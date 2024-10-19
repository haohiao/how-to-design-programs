;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-025) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; 判断图像相对是宽还高
(define (image-classify image)
  (cond
    [(>= (image-height image) (image-width image)) "tall"]
    [(= (image-height image) (image-width image)) "square"]
    [(<= (image-height image) (image-width image)) "wide"]))

; 矩形的属性
(define MODE "solid")
(define COLOR "red")

(image-classify (rectangle 4 6 MODE COLOR))
; => "tall"
(image-classify (rectangle 6 4 MODE COLOR))
; => "wide"
(image-classify (rectangle 5 5 MODE COLOR))
; => "tall"

; 条件(= (image-height image)无法触发，因为在它之上的条件(>= (image-height image)已经包含该条件。
; 该函数中的条件判断存在问题，>,<,=应该各自为判断条件，改进如下

; 判断图像相对是宽还高
(define (image-classify-v2 image)
  (cond
    [(< (image-width image) (image-height image))
     "tall"]
    [(> (image-width image) (image-height image))
     "wide"]
    [else
     "square"]))

(image-classify-v2 (rectangle 4 6 MODE COLOR))
; => "tall"
(image-classify-v2 (rectangle 6 4 MODE COLOR))
; => "wide"
(image-classify-v2 (rectangle 5 5 MODE COLOR))
; => "square"