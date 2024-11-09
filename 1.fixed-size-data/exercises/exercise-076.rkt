;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-076) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; # 数据定义
(define-struct movie [title producer year])
; (make-movie String String Number)
; 表示电影信息，title是电影名，producer是制片人，year是制作年份

(define-struct person [name hair eyes phone])
; (make-person String String String String)
; 表示人，name是人的姓名，hair是头发的颜色，eyes是眼睛的颜色，phone是人的手机号

(define-struct pet [name number])
; (make-pet String Number)
; 表示宠物的信息，name是宠物的姓名，number是宠物唯一标识

(define-struct CD [artist title price])
; (make-CD String String Number)
; 表示CD的信息，artist是艺术家，title是CD的名称，price是CD售卖的价格

(define-struct sweater [material size producer])
; (make-sweater String String String)
; 表示毛衣，material是毛衣的材质，size是毛衣的尺寸，producer是毛衣的供应商