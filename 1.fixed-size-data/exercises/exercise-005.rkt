;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-005) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; 常量
(define TREE-LENGTH 20)
(define TREE-WIDTH 10)

; 树
(above
 (triangle (* 2 TREE-WIDTH) "solid" "lightgreen")
 (rectangle TREE-WIDTH TREE-LENGTH "solid" "lightbrown"))
 
  
  