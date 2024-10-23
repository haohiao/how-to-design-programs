;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-036) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Image -> Number
; 计算给定图像image中像素的数量
; 输入: (rectangle 20 20 "solid" "red")
; 预期输出: 400
; 输入: (rectangle 10 20 "solid" "red")
; 预期输出: 200
; 输入: (rectangle 20 10 "solid" "red")
; 预期输出: 200
(define (image-area image)
  (* (image-width image)
     (image-height image)))

(image-area (rectangle 20 20 "solid" "red"))
(image-area (rectangle 10 20 "solid" "red"))
(image-area (rectangle 20 10 "solid" "red"))