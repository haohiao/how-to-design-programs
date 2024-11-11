;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise091) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


; 常量定義
; 場景
(define SCENE-WIDTH 450)
(define SCENE-HEIGHT 150)
(define SCENE
  (empty-scene SCENE-WIDTH SCENE-HEIGHT))

; 貓
(define cat1
  (bitmap "../resources/cat1.png"))
(define cat2
  (bitmap "../resources/cat2.png"))
(define CAT-WIDTH (image-width cat1))
(define VELOCITY 3)

; 關聯貓和場景
(define LEFT-SIDE (+ 0 CAT-WIDTH))
(define RIGHT-SIDE SCENE-WIDTH)
(define CAT-Y (- SCENE-HEIGHT 1))

; 測量器
(define GAUGE-WIDTH 20)
(define GAUGE-HEIGHT SCENE-HEIGHT)

; 快樂指數
(define MIN-LEVEL 0)
(define MAX-LEVEL 100)
(define MIN-SCALE 0.1)
(define VALUE1-OF-ADD-VOLUME 1/3)
(define VALUE2-OF-ADD-VOLUME 1/5)

; 關聯場景和測量器
(define GAUGE-X (/ SCENE-WIDTH 2))
(define GAUGE-Y (/ SCENE-HEIGHT 2))

; 數據定義
; Distance -> Number
; 場景左邊界與貓之間的距離（貓的圖像以右側下端點為參考點）。
(define d1 0)
(define d2 SCENE-WIDTH)
(define d3 (* SCENE-WIDTH 1/2))

; Level -> Number
; 快樂指數（MIN-LEVEL到MAX-LEVEL的數，包含端點）
(define l1 MIN-LEVEL)
(define l2 MAX-LEVEL)
(define l3 50)

; Direction是下列之一
(define LEFT "left")
(define RIGHT "right")
; 解釋：貓的移動方向
; LEFT向左移動
; RIGHT向右移動

; Walk是結構體
(define-struct walk [dis dir])
; (make-walk Distance Direction)
; 解釋：(make-walk dis dir)表示
; 貓與場景左邊側距離為dis，向dir方向移動
(define walk1 (make-walk LEFT-SIDE RIGHT))
(define walk2 (make-walk LEFT-SIDE LEFT))
(define walk3 (make-walk RIGHT-SIDE RIGHT))
(define walk4 (make-walk RIGHT-SIDE LEFT))

; VCat是結構體
(define-struct vcat [walk level])
; (make-vcat Walk Level)
; 解釋：(make-vcat w l)表示
; 貓在場景中的x坐標為(walk-dis w)，移動方向為(walk-dir w)，同時快樂指數為l
(define vcat1 (make-vcat walk1 l2))
(define vcat2 (make-vcat walk2 l1))
(define vcat3 (make-vcat walk3 l3))

; 函數定義
; VCat -> Image
; 輸入vcat，產生對應圖像
; --- -- ---
(check-expect (vcat-render vcat3)
              (beside (walk-render (vcat-walk vcat3))
                      (gauge-render (vcat-level vcat3))))
; --- -- ---
(define (vcat-render vcat)
  (beside (walk-render (vcat-walk vcat))
          (gauge-render (vcat-level vcat))))

; VCat -> VCat
; 計算始終滴答后的下一個VCat
; --- -- ---
(check-expect (vcat-next vcat1)
              (make-vcat (walk-next (vcat-walk vcat1))
                         (next-level (vcat-level vcat1))))
; --- -- ---
(define (vcat-next vcat)
  (make-vcat (walk-next (vcat-walk vcat))
             (next-level (vcat-level vcat))))

; VCat KeyEvent -> VCat
; 根據輸入的鍵，做出對應的動作，改變vcat
; --- -- ---
(check-expect (vcat-key-handler vcat3 "up")
              (make-vcat (vcat-walk vcat3)
                         (add-volume (vcat-level vcat3) "up")))
(check-expect (vcat-key-handler vcat3 "left")
              (make-vcat (vcat-walk vcat3)
                         (add-volume (vcat-level vcat3) "left")))
; --- -- ---
(define (vcat-key-handler vcat ke)
  (make-vcat (vcat-walk vcat)
             (add-volume (vcat-level vcat) ke)))

; VCat -> Boolean
; 判斷vcat是否停止運動
; --- -- ---
(check-expect (vcat-end? vcat3)
              (level-end? (vcat-level vcat3)))
; --- -- ---
(define (vcat-end? vcat)
  (level-end? (vcat-level vcat)))

; Walk -> Image
; 輸入walk並渲染圖像
; --- -- ---
(check-expect (walk-render walk1)
              (distance-render (walk-dis walk1)))
; --- -- ---
(define (walk-render walk)
  (distance-render (walk-dis walk)))

; Walk -> Walk
; 根據walk移動貓，考慮轉向
; --- -- ---
(check-expect (walk-next walk1)
              (make-walk (+ (walk-dis walk1) VELOCITY)
                         (walk-dir walk1)))
(check-expect (walk-next walk2)
              walk1)
(check-expect (walk-next walk3)
              walk4)
(check-expect (walk-next walk4)
              (make-walk (- (walk-dis walk4) VELOCITY)
                         (walk-dir walk4)))
; --- -- ---
(define (walk-next current)
  (cond
    [(<= (walk-dis (move current)) LEFT-SIDE)
     (make-walk LEFT-SIDE RIGHT)]
    [(>= (walk-dis (move current)) RIGHT-SIDE)
     (make-walk RIGHT-SIDE LEFT)]
    [else (move current)]))

; Walk -> Walk
; 根據walk移動貓，不考慮轉向
; --- -- ---
(check-expect (move (make-walk LEFT-SIDE LEFT)) (make-walk (- LEFT-SIDE VELOCITY) LEFT))
(check-expect (move (make-walk LEFT-SIDE RIGHT)) (make-walk (+ LEFT-SIDE VELOCITY) RIGHT))
; --- -- ---
(define (move walk)
  (make-walk (cond [(equal? (walk-dir walk) LEFT)
                    (- (walk-dis walk) VELOCITY)]
                   [(equal? (walk-dir walk) RIGHT)
                    (+ (walk-dis walk) VELOCITY)])
             (walk-dir walk)))

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

; Distance -> Image
; 將貓放置在距離SCENE左邊側ds像素處。
; --- -- ---
(check-expect (distance-render 0)
              (place-image/align (get-cat-image 0) 0 CAT-Y "right" "bottom" SCENE))
(check-expect (distance-render 30)
              (place-image/align (get-cat-image 30) 30 CAT-Y "right" "bottom" SCENE))
(check-expect (distance-render 167)
              (place-image/align (get-cat-image 167) 167 CAT-Y "right" "bottom" SCENE))
; --- -- ---
(define (distance-render ds)
  (place-image/align (get-cat-image ds) ds CAT-Y "right" "bottom" SCENE))

; 主函数
(define (happy-cat vcat0)
  (big-bang vcat0
    [to-draw vcat-render]
    [on-tick vcat-next]
    [on-key vcat-key-handler]
    [stop-when vcat-end?]))

; 应用
(happy-cat vcat1)