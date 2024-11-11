;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise092~093-x) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


; 常量定義
; 場景
(define SCENE-WIDTH 600)
(define SCENE-HEIGHT 200)
(define SCENE-PART-WIDTH (/ SCENE-WIDTH 3))
(define SCENE
  (beside (empty-scene SCENE-PART-WIDTH SCENE-HEIGHT "green")
          (empty-scene SCENE-PART-WIDTH SCENE-HEIGHT "white")
          (empty-scene SCENE-PART-WIDTH SCENE-HEIGHT "red")))

; 變色龍
(define CHAM
  (bitmap "../resources/cham.png")) ; 以右側下端點為參考點
(define VELOCITY 3)
(define CHAM-WIDTH (image-width CHAM))
(define CHAM-HEIGHT (image-height CHAM))

; 關聯變色龍和場景
(define LEFT-SIDE 0)
(define RIGHT-SIDE (+ SCENE-WIDTH CHAM-WIDTH))
(define CHAM-Y (- SCENE-HEIGHT 1))

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

; Distance是數值
; 解釋：場景左邊界與變色龍之間的距離，有效值為區間【LEFT-SIDE，RIGHT-SIDE】。
(define d1 LEFT-SIDE)
(define d2 RIGHT-SIDE)
(define d3 (/ (+ LEFT-SIDE RIGHT-SIDE) 2))

; Color是以下
(define RED "red")
(define BLUE "blue")
(define GREEN "green")
(define EMPTY #false)
; 解釋：變色龍的顔色，當沒有顔色時為EMPTY

; Level -> Number
; 快樂指數，其有效值為區間【MIN-LEVEL，MAX-LEVEL】
(define l1 MIN-LEVEL)
(define l2 MAX-LEVEL)
(define l3 (/ (+ MIN-LEVEL MAX-LEVEL) 2))

; VCham是結構體
(define-struct vcham [distance color level])
; (make-vcham Distance Color Level)
; 解釋：(make-vcham dis col lvl)表示
; | 顔色為col和快樂指數為lvl的變色龍距離場景左側為dis像素。
(define vcham1 (make-vcham LEFT-SIDE EMPTY MAX-LEVEL))
(define vcham2 (make-vcham RIGHT-SIDE EMPTY MAX-LEVEL))
(define vcham3 (make-vcham d3 RED l3))

; 函數定義
; VCham -> Image
; 獲取當前VCham的圖像
(define (vcham-render current)
  (beside (cham-render (vcham-distance current)
                       (vcham-color current))
          (gauge-render (vcham-level current))))

; VCham -> VCham
; 時鐘滴答一次，根據當前VCham，計算下一個VCham
(define (vcham-next current)
  (make-vcham (distance-next (vcham-distance current))
              (vcham-color current)
              (level-next (vcham-level current))))

; VCham KeyEvent -> VCham
; 根據按鍵的選擇，改變當前VCham
(define (vcham-kedler current ke)
  (cond
    [(or (equal? ke "up") (equal? ke "down"))
     (vcham-level-setter current
                         (add-volume (vcham-level current) ke))]
    [(or (equal? ke "r") (equal? ke "b") (equal? ke "g") (equal? ke " "))
     (vcham-color-setter current
                         (get-color ke))]
    [else current]))

; VCham -> Boolean
; 檢查當前VCham的Level是否end
; --- -- ---
(check-expect (vcham-end? vcham3)
              (level-end? (vcham-level vcham3)))
; --- -- ---
(define (vcham-end? current)
  (level-end? (vcham-level current)))

; VCham Color -> VCham
; 將vcham的Color，設置爲col
; --- -- ---
(check-expect (vcham-color-setter (make-vcham LEFT-SIDE EMPTY MAX-LEVEL) RED)
              (make-vcham LEFT-SIDE RED MAX-LEVEL))
; --- -- ---
(define (vcham-color-setter vcham col)
  (make-vcham (vcham-distance vcham)
              col
              (vcham-level vcham)))

; VCham Level -> VCham
; 將vcham的Level，設置爲lvl
; --- -- ---
(check-expect (vcham-level-setter (make-vcham LEFT-SIDE EMPTY MAX-LEVEL) l3)
              (make-vcham LEFT-SIDE EMPTY l3))
; --- -- ---
(define (vcham-level-setter vcham lvl)
  (make-vcham (vcham-distance vcham)
              (vcham-color vcham)
              lvl))

; Distance -> Distance
; 時鐘滴答一次，根據當前Distance，計算下一個Distance
; 若變色龍消失在右側，則會重新出現在左側。
; --- -- ---
(check-expect (distance-next 20) (+ 20 VELOCITY))
(check-expect (distance-next RIGHT-SIDE) VELOCITY)
(check-expect (distance-next (- RIGHT-SIDE VELOCITY))
              0)
; --- -- ---
(define (distance-next ds)
  (modulo (+ ds VELOCITY) RIGHT-SIDE))

; Distance Color -> Image
; 將變色龍放置在距離SCENE左邊側ds像素處。
; --- -- ---
(check-expect (cham-render 0 EMPTY)
              (place-image/align (get-cham EMPTY) 0 CHAM-Y "right" "bottom" SCENE))
(check-expect (cham-render 30 RED)
              (place-image/align (get-cham RED) 30 CHAM-Y "right" "bottom" SCENE))
(check-expect (cham-render 167 BLUE)
              (place-image/align (get-cham BLUE) 167 CHAM-Y "right" "bottom" SCENE))
; --- -- ---
(define (cham-render ds col)
  (place-image/align (get-cham col) ds CHAM-Y "right" "bottom" SCENE))

; Color -> Image
; 根據col獲取對應顔色的變色龍
; --- -- ---
(check-expect (get-cham RED)
              (overlay CHAM
                       (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" RED)))
(check-expect (get-cham EMPTY) CHAM)
; --- -- ---
(define (get-cham col)
  (cond
    [(equal? col #false) CHAM]
    [else
     (overlay CHAM
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" col))]))

; KeyEvent -> Color
; 根據按鍵的選擇，獲取對應Color
; --- -- ---
(check-expect (get-color "r") RED)
(check-expect (get-color "b") BLUE)
(check-expect (get-color "g") GREEN)
(check-expect (get-color "x") EMPTY)
(check-expect (get-color " ") EMPTY)
; --- -- ---
(define (get-color ke)
  (cond
    [(equal? ke "r") RED]
    [(equal? ke "b") BLUE]
    [(equal? ke "g") GREEN]
    [else EMPTY]))

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
(check-expect (level-next 0) 0)
(check-expect (level-next 1) 0.9)
; --- -- ---
(define (level-next level)
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
(check-expect (level-end? 0) #true)
(check-expect (level-end? 23.5) #false)
(define (level-end? level)
  (if (= level 0)
      #true
      #false))

; Level -> Number
; 將level轉換為需要渲染到GAUGE中的高度
(check-expect (get-height 0) 0)
(check-expect (get-height 23)
              (* (/ GAUGE-HEIGHT MAX-LEVEL) 23))
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

; # 主函数
(define (vcham-prog vcham0)
  (big-bang vcham0
    [to-draw vcham-render]
    [on-tick vcham-next]
    [on-key vcham-kedler]
    [stop-when vcham-end?]))

; # 應用
(vcham-prog vcham1)