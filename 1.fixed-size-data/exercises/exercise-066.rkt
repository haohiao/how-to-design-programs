;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-066) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title producer year])
(make-movie "无回" "haohiao" 2001)

(define-struct person [name hair eyes phone])
(make-person "haohiao" "🧑" "👓" "134-xxxx-xxxx")

(define-struct pet [name number])
(make-pet "olddog-z124" 21)

(define-struct CD [artist title price])
(make-CD "周杰伦" "十里香" 5)

(define-struct sweater [material size producer])
(make-sweater "黑色休闲毛衣" "XXL" "妈妈牌")