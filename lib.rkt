; me da pi:
(require scheme/math)
(define 2pi (* 2 pi))

(define (sintime n)
    (sin (* n (time))))
(define (costime n)
    (cos (* n (time))))

; vectors
(define (vec n) (vector n n n))
(define vec1 (vec 1))
(define vec0 (vec 0))

(define (touch v1 v2 mul)
    (vadd v1 (vmul (vector (sin (vector-ref v2 0)) 
                            (sin (vector-ref v2 1)) 
                            (sin (vector-ref v2 2))) mul)))
(define sndtouch
    (case-lambda
        [(v1 mul n1 n2 n3)
            (vadd v1 (vmul (vector (sin (gh n1)) 
                                    (sin (gh n2))
                                    (sin (gh n3))) (* 0.1 mul)))]
        [(v1 mul)
            (sndtouch v1 mul 1 5 9)]))

(define (rtouch v1 mul)
    (touch v1 (crndvec) mul))

(define rsndtouch
    (case-lambda
        [(v1 mul n1 n2 n3)
            (touch (sndtouch v1 mul n1 n2 n3) (crndvec) mul)]
        [(v1 mul)
            (touch (sndtouch v1 mul) (crndvec) mul)]))

; seis direcciones a mod 6:
(define (axismove a speed range)
    (vmul (cond
        ((equal? (fmod a 3) 0.0) (vector (* (sin (* (time) speed)) (- (* 2 (fmod a 2)) 1)) 0 0))
        ((equal? (fmod a 3) 1.0) (vector 0 (* (sin (* (time) speed)) (- (* 2 (fmod a 2)) 1)) 0))
        ((equal? (fmod a 3) 2.0) (vector 0 0 (* (sin (* (time) speed)) (- (* 2 (fmod a 2)) 1)))))
        range))

(define (axisrotate a speed radio)
    (vmul (cond
        ((equal? (fmod a 3) 0.0) (vector (* (sin (* (time) speed)) (- (* 2 (fmod a 2)) 1))
                                         (* (cos (* (time) speed)) (- (* 2 (fmod a 2)) 1)) 0))
        ((equal? (fmod a 3) 1.0) (vector 0 (* (sin (* (time) speed)) (- (* 2 (fmod a 2)) 1))
                                            (* (cos (* (time) speed)) (- (* 2 (fmod a 2)) 1))))
        ((equal? (fmod a 3) 2.0) (vector (* (sin (* (time) speed)) (- (* 2 (fmod a 2)) 1))
                                         0 (* (cos (* (time) speed)) (- (* 2 (fmod a 2)) 1)))))
        radio))

(define (grndvecs1 n)
    (if (equal? n 0) 'nil
        (cons (vector 0 (crndf) (crndf)) (grndvecs1 (- n 1)))))

(define (grndvecs2 n)
    (if (equal? n 0) 'nil
        (cons (vector (crndf) 0 (crndf)) (grndvecs2 (- n 1)))))

(define (grndvecs3 n)
    (if (equal? n 0) 'nil
        (cons (vector (crndf) (crndf) 0) (grndvecs3 (- n 1)))))


;====================================

; seno de 0 a 1 x veces por minuto:
(define (beatsin x)
    (/ (+ (sin (* (* 2pi (/ x 60.0)) (time))) 1) 2))

; salto de 0 a 1 x veces por minuto:
#;(define (beat x delta)
    (if (< (fmod (time) (/ 60 x)) delta)
        1
        0))

; salto de 0 a 1 x veces por minuto:
(define beat
    (case-lambda
        [(x) (beat x 0.25)]
        [(x delta)
            (let ((y (fmod (time) (/ 60 x))))
                (if (< y delta)
                    (sin (* (/ y delta) pi))
                0))]))

