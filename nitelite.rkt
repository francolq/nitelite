(clear)
(show-fps 1)
(desired-fps 1000000)
;(hint-wire)
(scale (vmul vec1 1))
(define (render n) (cond ((> n 0)
  ;(colour (vector (gh 0) (gh 1) (gh 2)))
  ;(scale (rsndtouch vec1 0.2))
  (push)
  ;(translate (rsndtouch vec1 0.1))
  (draw-sphere)
  (pop)
  ;(rotate (vector 0 (* (sin (time)) 100) (* 50 (cos (time)))))
  (rotate (vector 0 (* (sintime 1) 100) (* 50 (costime 1))))
  (translate (vector 0 1.3 0))
  (render (- n 1)))))

(define (render2 m v) (cond ((> m 0)
  (push)
  (translate (vmul (car v) (* m 2)))
  (render 5)
  (pop)
  (render2 (- m 1) (cdr v)))))

;(every-frame (render2 10 (grndvecs2 10)))

(let* ((x 10) (y (grndvecs2 x)))
    (every-frame (render2 x y)))


(with-state
    (rotate (vector 90 0 0))
    (scale 10)
    (build-plane))

