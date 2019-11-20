;dynsys.rkt
;20191107Z
;procedurally generated dynamical systems

#lang racket

(require racket/draw)
(require racket/draw/arrow)

;size of dynamic system -> list of targets dots, with index as source dot
(define (gen-ds l) (map (lambda (a) (random l)) (make-list l 0)))

#|
> (gen-ds 15)
'(12 3 6 2 11 0 9 12 7 14 2 7 7 10 4)
|#

;gen-ds -> list of source co-ordinates
(define (calculate-dot-coordinates ls)
  (map (lambda (a) (list (random (* (length ls) 10)) 
			 (random (* (length ls) 10))))
       ls))

;visualize
(define radius 2)
(define (draw-ds ds dot-xy)
  (define src-xy dot-xy)
  (define tar-xy 
    (map (lambda (a) (list-ref dot-xy a))
	 ds))
  (define src-tar (zip-list src-xy tar-xy))
  (define target (make-bitmap (* (length ds) 15)
			      (* (length ds) 15)))
  (define dc (new bitmap-dc% [bitmap target]))
  (define (draw-circle c r)
    (let ([x (- (car c) r)] [y (- (cadr c) r)] [d (* 2 r)])
    (send dc draw-ellipse x y d d)))
  (begin
    (map (lambda (a) (draw-circle a radius)) src-xy)
    (map (lambda (a) (let ([s-x (caar a)] [s-y (cadar a)]
			   [t-x (caadr a)] [t-y (cadadr a)])
		       (draw-arrow dc s-x s-y t-x t-y 0 0)))
	 src-tar)
;    (send dc scale 3.0 3.0)
    (send target save-file "ds.png" 'png)))

(define (new-ds size)
  (letrec ([ds (gen-ds size)]
	   [dot-xy (calculate-dot-coordinates ds)])
    (draw-ds ds dot-xy)))

;auxiliary functions
; | l1 | == | l2 |
(define (zip-list l1 l2) (map list l1 l2))

(define dstst (gen-ds 10))
(define dstst-co (calculate-dot-coordinates dstst))
(define dstst-vis (draw-ds dstst dstst-co))
