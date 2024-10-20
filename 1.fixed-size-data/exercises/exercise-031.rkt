;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-031) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; signature-name寄给<fst lst>的一封信
(define (letter fst lst signature-name)
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst)
   "\n\n"
   (closing signature-name)))

; 信头
(define (opening first-name)
  (string-append "Dear " first-name ","))

; 信体
(define (body first-name last-name)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " last-name " have won our lottery. So, " "\n"
   first-name ", " "hurry and pick up your prize."))

; 信尾
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

; 主函数
(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

(define root-path "../resources/letter-files/")
(define in-fst-path (string-append root-path "fst.txt"))
(define in-lst-path (string-append root-path "lst.txt"))
(define in-signature-path (string-append root-path "signature.txt"))
(define out-path (string-append root-path "out.txt"))
(main in-fst-path
      in-lst-path
      in-signature-path
      out-path)