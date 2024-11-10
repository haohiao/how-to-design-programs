;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-087) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 20)
(define SCENE-MIDDLE 10)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))


(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 20)
(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" "red"))

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; # 数据定义
(define-struct editor [text index])
; Editor是结构体
; (make-editor String Number)
; 表示编辑器,text表示编辑器的文本，而index表示第1个字符到光标之间的字符数
; --- -- ---
(define editor0 (make-editor "" 0))
(define editor1 (make-editor "helloworld" 5))
(define editor2 (make-editor "helloworld" 10))
(define editor3 (make-editor "helloworld" 0))
; --- -- ---

; # 函数定义
; Editor -> String
; 获取e中光标前的字符串
; --- -- ---
(check-expect (editor-pre editor0)
              "")
(check-expect (editor-pre editor1)
              "hello")
(check-expect (editor-pre editor2)
              "helloworld")
(check-expect (editor-pre editor3)
              "")
; --- -- ---
(define (editor-pre e)
  (substring (editor-text e) 0 (editor-index e)))

; Editor -> String
; 获取e中光标后的字符串
; --- -- ---
(check-expect (editor-post editor0)
              "")
(check-expect (editor-post editor1)
              "world")
(check-expect (editor-post editor2)
              "")
(check-expect (editor-post editor3)
              "helloworld")
; --- -- ---
(define (editor-post e)
  (substring (editor-text e) (editor-index e)))

; String String -> Editor
; 根据光标前后的字符串组合Editor
; --- -- ---
(check-expect (make-editor-with-s "" "")
              editor0)
(check-expect (make-editor-with-s "hello" "world")
              editor1)
(check-expect (make-editor-with-s "helloworld" "")
              editor2)
(check-expect (make-editor-with-s "" "helloworld")
              editor3)
; --- -- ---
(define (make-editor-with-s pro post)
  (make-editor (string-append pro post)
               (string-length pro)))

; Editor -> Image
; 渲染e为图形
; --- -- ---
(check-expect (render editor0)
              (place-image/align
               (text-render editor0)
               0 SCENE-MIDDLE
               "left" "center"
               SCENE))
(check-expect (render editor1)
              (place-image/align
               (text-render editor1)
               0 SCENE-MIDDLE
               "left" "center"
               SCENE))
; --- -- ---
(define (render e)
  (place-image/align
   (text-render e)
   0 SCENE-MIDDLE
   "left" "center"
   SCENE))

; Editor -> Image
; 渲染文本与光标图片
; --- -- ---
(check-expect (text-render editor0)
              (beside (text (editor-pre editor0) TEXT-SIZE TEXT-COLOR)
                      CURSOR
                      (text (editor-post editor0) TEXT-SIZE TEXT-COLOR)))
(check-expect (text-render editor1)
              (beside (text (editor-pre editor1) TEXT-SIZE TEXT-COLOR)
                      CURSOR
                      (text (editor-post editor1) TEXT-SIZE TEXT-COLOR)))
; --- -- ---
(define (text-render e)
  (beside (text (editor-pre e) TEXT-SIZE TEXT-COLOR)
          CURSOR
          (text (editor-post e) TEXT-SIZE TEXT-COLOR)))

; Editor KeyEnv -> Editor
; 根据所按按键ke修改e的状态
; --- -- ---
(check-expect (edit (make-editor "hello" 3) "left")
              (make-editor "hello" 2))
(check-expect (edit (make-editor "hello" 0) "left")
              (make-editor "hello" 0))
(check-expect (edit (make-editor "hello" 3) "right")
              (make-editor "hello" 4))
(check-expect (edit (make-editor "hello" 5) "right")
              (make-editor "hello" 5))
(check-expect (edit (make-editor "hello" 3) "a")
              (make-editor "helalo" 4))
(check-expect (edit (make-editor "hello" 3) "\b")
              (make-editor "helo" 2))
(check-expect (edit (make-editor "hello" 0) "\b")
              (make-editor "hello" 0))
(check-expect (edit (make-editor "hello" 3) "\t")
              (make-editor "hello" 3))
(check-expect (edit (make-editor "hello" 3) "\r")
              (make-editor "hello" 3))
; --- -- ---
(define (edit e ke)
  (cond
    [(key=? ke "left") (cursor-left e)]
    [(key=? ke "right") (cursor-right e)]
    [(key=? ke "\b") (delete-left e)]
    [(key=? ke "\t") e]
    [(key=? ke "\r") e]
    [(and (= (string-length ke) 1)
          (<= (image-width (text-render (add-left e ke))) SCENE-WIDTH))
     (add-left e ke)]
    [else e]))

; Editor -> Editor
; 将e的光标左移1位，若前面无字符保持原状
; --- -- ---
(check-expect (cursor-left editor0) editor0)
(check-expect (cursor-left editor1) (make-editor "helloworld" 4))
(check-expect (cursor-left editor2) (make-editor "helloworld" 9))
(check-expect (cursor-left editor3) (make-editor "helloworld" 0))
; --- -- ---
(define (cursor-left e)
  (if (string=? (editor-pre e) "") e
      (make-editor-with-s (string-remove-last (editor-pre e))
                          (string-append (string-last (editor-pre e))
                                         (editor-post e)))))

; Editor -> Editor
; 将e的光标右移1位，若前面无字符保持原状
; --- -- ---
(check-expect (cursor-right editor0) editor0)
(check-expect (cursor-right editor1) (make-editor "helloworld" 6))
(check-expect (cursor-right editor2) (make-editor "helloworld" 10))
(check-expect (cursor-right editor3) (make-editor "helloworld" 1))
; --- -- ---
(define (cursor-right e)
  (if (string=? (editor-post e) "") e
      (make-editor-with-s (string-append (editor-pre e)
                                         (string-first (editor-post e)))
                          (string-rest (editor-post e)))))

; Editor -> Editor
; 删除e光标前的1位字符，若前面无字符保持原状
; --- -- ---
(check-expect (delete-left editor0) editor0)
(check-expect (delete-left editor1) (make-editor "hellworld" 4))
(check-expect (delete-left editor2) (make-editor "helloworl" 9))
(check-expect (delete-left editor3) (make-editor "helloworld" 0))
; --- -- ---
(define (delete-left e)
  (if (string=? (editor-pre e) "") e
      (make-editor-with-s (string-remove-last (editor-pre e))
                          (editor-post e))))

; Editor 1String -> Editor
; 将s添加到e的光标前
; --- -- ---
(check-expect (add-left editor0 "A") (make-editor "A" 1))
(check-expect (add-left editor1 " ") (make-editor "hello world" 6))
; --- -- ---
(define (add-left e s)
  (make-editor-with-s (string-append (editor-pre e) s)
                      (editor-post e)))

; String -> 1String
; extracts the first 1String from a non-empty string.
; --- -- ---
(check-expect (string-first "") "")
(check-expect (string-first "s") "s")
(check-expect (string-first "string") "s")
; --- -- ---
(define (string-first str)
  (if (> (string-length str) 0)
      (substring str 0 1)
      str))


; String -> String
; extracts all but the first 1String from a String
; --- -- ---
(check-expect (string-rest "") "")
(check-expect (string-rest "b") "")
(check-expect (string-rest "string") "tring")
; --- -- ---
(define (string-rest str)
  (if (> (string-length str) 0)
      (substring str 1)
      str))


; String -> 1String
; extracts the last 1String from a non-empty string.
; --- -- ---
(check-expect (string-last "") "")
(check-expect (string-last "d") "d")
(check-expect (string-last "hello world") "d")
; --- -- ---
(define (string-last str)
  (if (> (string-length str) 0)
      (substring str (- (string-length str) 1))
      str))


; String -> String
; remove the last 1String in a non-empty String
; --- -- ---
(check-expect (string-remove-last "") "")
(check-expect (string-remove-last "b") "")
(check-expect (string-remove-last "string") "strin")
; --- -- ---
(define (string-remove-last str)
  (if (> (string-length str) 0)
      (substring str 0 (sub1 (string-length str)))
      str))

; # 主函数
(define (main init)
  (big-bang init
    [to-draw render]
    [on-key edit]))

(main editor0)