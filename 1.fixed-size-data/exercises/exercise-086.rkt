;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-086) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define-struct editor [pre post])
; Editor是结构体
; (make-editor String String)
; 表示编辑器,(string-append pre post)表示编辑器的文本，而编辑器的光标在pre和post之间
; --- -- ---
(define editor0 (make-editor "" ""))
(define editor1 (make-editor "hello" "world"))
(define editor2 (make-editor "helloworld" ""))
(define editor3 (make-editor "" "helloworld"))
; --- -- ---

; # 函数定义
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
(check-expect (edit (make-editor "hel" "lo") "left")
              (make-editor "he" "llo"))
(check-expect (edit (make-editor "" "hello") "left")
              (make-editor "" "hello"))
(check-expect (edit (make-editor "hel" "lo") "right")
              (make-editor "hell" "o"))
(check-expect (edit (make-editor "hello" "") "right")
              (make-editor "hello" ""))
(check-expect (edit (make-editor "hel" "lo") "a")
              (make-editor "hela" "lo"))
(check-expect (edit (make-editor "hel" "lo") "\b")
              (make-editor "he" "lo"))
(check-expect (edit (make-editor "" "hello") "\b")
              (make-editor "" "hello"))
(check-expect (edit (make-editor "hel" "lo") "\t")
              (make-editor "hel" "lo"))
(check-expect (edit (make-editor "hel" "lo") "\r")
              (make-editor "hel" "lo"))
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
(check-expect (cursor-left editor1) (make-editor "hell" "oworld"))
(check-expect (cursor-left editor2) (make-editor "helloworl" "d"))
(check-expect (cursor-left editor3) (make-editor "" "helloworld"))
; --- -- ---
(define (cursor-left e)
  (if (string=? (editor-pre e) "") e
      (make-editor (string-remove-last (editor-pre e))
                   (string-append (string-last (editor-pre e))
                                  (editor-post e)))))

; Editor -> Editor
; 将e的光标右移1位，若前面无字符保持原状
; --- -- ---
(check-expect (cursor-right editor0) editor0)
(check-expect (cursor-right editor1) (make-editor "hellow" "orld"))
(check-expect (cursor-right editor2) (make-editor "helloworld" ""))
(check-expect (cursor-right editor3) (make-editor "h" "elloworld"))
; --- -- ---
(define (cursor-right e)
  (if (string=? (editor-post e) "") e
      (make-editor (string-append (editor-pre e)
                                  (string-first (editor-post e)))
                   (string-rest (editor-post e)))))

; Editor -> Editor
; 删除e光标前的1位字符，若前面无字符保持原状
; --- -- ---
(check-expect (delete-left editor0) editor0)
(check-expect (delete-left editor1) (make-editor "hell" "world"))
(check-expect (delete-left editor2) (make-editor "helloworl" ""))
(check-expect (delete-left editor3) (make-editor "" "helloworld"))
; --- -- ---
(define (delete-left e)
  (if (string=? (editor-pre e) "") e
      (make-editor (string-remove-last (editor-pre e))
                   (editor-post e))))

; Editor 1String -> Editor
; 将s添加到e的光标前
; --- -- ---
(check-expect (add-left editor0 "A") (make-editor "A" ""))
(check-expect (add-left editor1 " ") (make-editor "hello " "world"))
; --- -- ---
(define (add-left e s)
  (make-editor (string-append (editor-pre e) s)
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