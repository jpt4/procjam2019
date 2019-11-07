;dynsys.rkt
;20191107Z
;procedurally generated dynamical systems

(define (gen-ds l) (map (lambda (a) (random l)) (make-list l 0)))

#|
> (gen-ds 15)
'(12 3 6 2 11 0 9 12 7 14 2 7 7 10 4)
|#
