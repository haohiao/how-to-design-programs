;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-080) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct movie [title director year])
(define (fn-with-movie m)
  (... (movie-title m)
   ... (movie-director m)
   ... (movie-year m)))

(define-struct pet [name number])
(define (fn-with-pet p)
  (... (pet-name p)
   ... (pet-number p)))

(define-struct CD [artist title price])
(define (fn-with-CD cd)
  (... (CD-artist cd)
   ... (CD-title cd)
   ... (CD-price cd)))

(define-struct sweater [material size color])
(define (fn-with-sweater s)
  (... (sweater-material s)
   ... (sweater-size s)
   ... (sweater-color s)))