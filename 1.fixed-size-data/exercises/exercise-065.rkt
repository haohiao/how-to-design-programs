;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-065) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title producer year])
; constructor: make-movie
; selector: movie-title, movie-producer, movie-year
; predicate: movie?

(define-struct person [name hair eyes phone])
; constructor: make-person
; selector: person-name, person-hair, person-eyes, person-phone
; predicate: person?

(define-struct pet [name number])
; constructor: make-pet
; selector: pet-name, pet-number
; predicate: pet?

(define-struct CD [artist title price])
; constructor: make-CD
; selector: CD-artist, CD-title, CD-price
; predicate: CD?

(define-struct sweater [material size producer])
; constructor: make-sweater
; selector: sweater-material, sweater-size, sweater-producer
; predicate: sweater?