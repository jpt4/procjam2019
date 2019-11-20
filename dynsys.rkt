;dynsys.rkt
;20191107Z
;procedurally generated dynamical systems

#lang racket

(require racket/draw)

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
(define (draw-ds ds ds-xy)
  (define target (make-bitmap (* (length ds) 15)
			      (* (length ds) 15)))
  (define dc (new bitmap-dc% [bitmap target]))
  (define (draw-circle c r)
    (let ([x (- (car c) r)] [y (- (cadr c) r)] [d (* 2 r)])
    (send dc draw-ellipse x y d d)))
  (begin
    (map (lambda (a) (draw-circle a radius)) ds-xy)
    (send target save-file "ds.png" 'png)))

(define dstst (gen-ds 10))
(define dstst-co (calculate-dot-coordinates dstst))
(define dstst-vis (draw-ds dstst dstst-co))
