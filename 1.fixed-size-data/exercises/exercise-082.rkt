;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-082) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
(define-struct 3fstring [i1 i2 i3])
; 3Fstring结构体
; 表示由3个fstring组成的单词
; --- -- ---
(define 3fs1 (make-3fstring "a" "b" "c"))
(define 3fs2 (make-3fstring "x" "y" "z"))
(define 3fs3 (make-3fstring "a" "y" "c"))
; --- -- ---

; Fstring条目
; -- "a"~"z"
; -- #false
; 值可为#false的字母
; --- -- ---
(define fs1 #false)
(define fs2 "x")
; --- -- ---

; # 函数定义
; Fstring -> Boolean
; 判断fs1与fs2是否相同
; --- -- ---
(check-expect (fstring-equal? fs1 #false)
              #true)
(check-expect (fstring-equal? fs1 "x")
              #false)
(check-expect (fstring-equal? fs2 "x")
              #true)
; --- -- ---
(define (fstring-equal? fs1 fs2)
  (cond
    [(and (string? fs1) (string? fs2))
     (string=? fs1 fs2)]
    [(and (boolean? fs1) (boolean? fs2))
     #true]
    [else
     #false]))

; Fstring -> Fstring
; 判断2个Fstring是否相同，如果相同返回相同值，如果不同返回#false
; --- -- ---
(check-expect (compare-fstring fs1 #false)
              #false)
(check-expect (compare-fstring fs1 "x")
              #false)
(check-expect (compare-fstring fs2 "x")
              "x")
; --- -- ---
(define (compare-fstring fs1 fs2)
  (if (fstring-equal? fs1 fs2)
      fs1
      #false))


; 3Fstring -> 3Fstring
; 判断2个3Fstring是否相同，如果相同返回单词，否则将不同的字段替换为#false并返回
; --- -- ---
(check-expect (compare-word 3fs1 3fs1)
              3fs1)
(check-expect (compare-word 3fs1 3fs2)
              (make-3fstring #false #false #false))
(check-expect (compare-word 3fs1 3fs3)
              (make-3fstring "a" #false "c"))
; --- -- ---
(define (compare-word 3fs1 3fs2)
  (make-3fstring (compare-fstring (3fstring-i1 3fs1) (3fstring-i1 3fs2))
                 (compare-fstring (3fstring-i2 3fs1) (3fstring-i2 3fs2))
                 (compare-fstring (3fstring-i3 3fs1) (3fstring-i3 3fs2))))