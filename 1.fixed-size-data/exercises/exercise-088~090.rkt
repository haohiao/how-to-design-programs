;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-088~090) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; # 常量定义
; SCENE
(define SCENE-WIDTH 450)
(define SCENE-HEIGHT 150)
(define SCENE
  (empty-scene SCENE-WIDTH SCENE-HEIGHT))

; CAT
(define cat1
  (bitmap "../resources/cat1.png"))
(define cat2
  (bitmap "../resources/cat2.png"))
(define CAT-WIDTH (image-width cat1))
(define VELOCITY 3)
(define MODULO-I (+ SCENE-WIDTH CAT-WIDTH))
(define CAT-Y (- SCENE-HEIGHT 1))

; 快乐指数
(define GAUGE-WIDTH 20)
(define GAUGE-HEIGHT SCENE-HEIGHT)
(define GAUGE-X (/ SCENE-WIDTH 2))
(define GAUGE-Y (/ SCENE-HEIGHT 2))
(define MAX-LEVEL 100)
(define MIN-SCALE 0.1)
(define VALUE1-OF-ADD-VOLUME 1/3)
(define VALUE2-OF-ADD-VOLUME 1/5)


; # 数据定义
; Distance -> Number
; 場景左邊界與貓之間的距離（貓的圖像以右側下端點為參考點）。
; --- -- ---
(define d1 0)
(define d2 SCENE-WIDTH)
(define d3 (* SCENE-WIDTH 1/2))
; --- -- ---

; Level -> Number
; 快樂指數（0到100的數，包含0和100）
; --- -- ---
(define l1 0)
(define l2 100)
(define l3 50)
; --- -- ---

; VCat表示具有快樂指數的貓
; VCat是結構體
(define-struct vcat [distance level])
; (make-vcat Distance Level)
; 解釋：(make-vcat d l)表示
; 貓在場景中的x坐標為d，同時快樂指數為l
; --- -- ---
(define vcat1 (make-vcat d1 l2))
(define vcat2 (make-vcat d2 l1))
(define vcat3 (make-vcat d3 l3))
; --- -- ---



; 函數定義
; VCat -> VCat
; 世界程序
(define (happy-cat vcat0)
  (big-bang vcat0
    [to-draw vcat-render]
    [on-tick vcat-next]
    [on-key vcat-key-handler]
    [stop-when vcat-end?]))

; VCat -> Image
; 輸入vcat，產生對應圖像
; --- -- ---
(check-expect (vcat-render vcat3)
              (beside (cat-render (vcat-distance vcat3))
                      (gauge-render (vcat-level vcat3))))
; --- -- ---
(define (vcat-render vcat)
  (beside (cat-render (vcat-distance vcat))
          (gauge-render (vcat-level vcat))))

; VCat -> VCat
; 計算始終滴答后的下一個VCat
; --- -- ---
(check-expect (vcat-next vcat1)
              (make-vcat (move (vcat-distance vcat1))
                         (next-level (vcat-level vcat1))))
; --- -- ---
(define (vcat-next vcat)
  (make-vcat (move (vcat-distance vcat))
             (next-level (vcat-level vcat))))

; VCat KeyEvent -> VCat
; 根據輸入的鍵，做出對應的動作，改變vcat
; --- -- ---
(check-expect (vcat-key-handler vcat3 "up")
              (make-vcat (vcat-distance vcat3)
                         (add-volume (vcat-level vcat3) "up")))
(check-expect (vcat-key-handler vcat3 "left")
              (make-vcat (vcat-distance vcat3)
                         (add-volume (vcat-level vcat3) "left")))
; --- -- ---
(define (vcat-key-handler vcat ke)
  (make-vcat (vcat-distance vcat)
             (add-volume (vcat-level vcat) ke)))

; VCat -> Boolean
; 判斷vcat是否停止運動
; --- -- ---
(check-expect (vcat-end? vcat3)
              (level-end? (vcat-level vcat3)))
; --- -- ---
(define (vcat-end? vcat)
  (level-end? (vcat-level vcat)))

; Distance -> Image
; 將貓放置在距離SCENE左邊側ds像素處。
; --- -- ---
(check-expect (cat-render 0)
              (place-image/align (get-cat-image 0) 0 CAT-Y "right" "bottom" SCENE))
(check-expect (cat-render 30)
              (place-image/align (get-cat-image 30) 30 CAT-Y "right" "bottom" SCENE))
(check-expect (cat-render 167)
              (place-image/align (get-cat-image 167) 167 CAT-Y "right" "bottom" SCENE))
; --- -- ---
(define (cat-render ds)
  (place-image/align (get-cat-image ds) ds CAT-Y "right" "bottom" SCENE))

; Distance -> Distance
; 每次時鐘滴答一次，將貓移動VELOCITY像素，
; 若貓消失在右側，則會重新出現在左側。
; --- -- ---
(check-expect (move 20) (+ 20 VELOCITY))
(check-expect (move MODULO-I) VELOCITY)
(check-expect (move (- MODULO-I VELOCITY))
              0)
; --- -- ---
(define (move ds)
  (modulo (+ ds VELOCITY) MODULO-I))

; Level -> Image
; 將Level渲染為圖像
; --- -- ---
(check-expect (gauge-render 0)
              (frame (above
                      (rectangle GAUGE-WIDTH GAUGE-HEIGHT "solid" "white")
                      (rectangle GAUGE-WIDTH 0 "solid" "red"))))
(check-expect (gauge-render 34)
              (frame (above
                      (rectangle GAUGE-WIDTH (- GAUGE-HEIGHT (get-height 34)) "solid" "white")
                      (rectangle GAUGE-WIDTH (get-height 34) "solid" "red"))))
(check-expect (gauge-render MAX-LEVEL)
              (frame (above
                      (rectangle GAUGE-WIDTH 0 "solid" "white")
                      (rectangle GAUGE-WIDTH GAUGE-HEIGHT "solid" "red"))))
; --- -- ---
(define (gauge-render level)
  (frame (above
          (rectangle GAUGE-WIDTH (- GAUGE-HEIGHT (get-height level)) "solid" "white")
          (rectangle GAUGE-WIDTH (get-height level) "solid" "red"))))

; Level -> Level
; 每時鐘滴答一次，level下降一個MIN-SCALE
; --- -- ---
(check-expect (next-level 0) 0)
(check-expect (next-level 1) 0.9)
; --- -- ---
(define (next-level level)
  (cond
    [(<= level MIN-SCALE) 0]
    [else (- level MIN-SCALE)]))

; Level String -> Level
; 根據鼠標的狀態相對提升level的值
; --- -- ---
(check-expect (add-volume 10 "up") (* 10 4/3))
(check-expect (add-volume 10 "down") (* 10 6/5))
(check-expect (add-volume 90 "down") 100)
(check-expect (add-volume 10 "a") 10)
; --- -- ---
(define (add-volume level ke)
  (cond
    [(string=? ke "up")
     (improve (+ level (* level VALUE1-OF-ADD-VOLUME)))]
    [(string=? ke "down")
     (improve (+ level (* level VALUE2-OF-ADD-VOLUME)))]
    [else level]))

; Level -> Boolean
; 當level為0時，結束動畫
; --- -- ---
(check-expect (level-end? 0) #true)
(check-expect (level-end? 23.5) #false)
; --- -- ---
(define (level-end? level)
  (if (= level 0)
      #true
      #false))

; Distance -> Image
; 根據ds是否為奇數確認貓的圖像
; --- -- ---
(check-expect (get-cat-image 23) cat1)
(check-expect (get-cat-image 0) cat2)
(check-expect (get-cat-image 25) cat1)
(check-expect (get-cat-image 66) cat2)
; --- -- ---
(define (get-cat-image ds)
  (cond
    [(odd? ds) cat1]
    [else cat2]))

; Level -> Number
; 將level轉換為需要渲染到GAUGE中的高度
; --- -- ---
(check-expect (get-height 0) 0)
(check-expect (get-height 23)
              (* (/ GAUGE-HEIGHT MAX-LEVEL) 23))
; --- -- ---
(define (get-height level)
  (* (/ GAUGE-HEIGHT MAX-LEVEL) level))

; Level -> Level
; 合理改善level的值
; --- -- ---
(check-expect (improve -3) 0)
(check-expect (improve 23) 23)
(check-expect (improve 120) 100)
; --- -- ---
(define (improve level)
  (cond
    [(< level 0) 0]
    [(> level 100) 100]
    [else level]))

; 應用
(happy-cat vcat1)