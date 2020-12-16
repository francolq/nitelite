; nuevo:
; - usar paleta de colores
; (antes ejecutar paleta.rkt)
; - mas guachxs, mejor ubicados
; - descoordinacion


(clear)
(show-fps 1)
(desired-fps 1000000)
;(hint-wire)
(scale (vmul vec1 0.1))
(define (render n m) (cond ((> n 0)
  ;(colour (vector (gh 0) (gh 1) (gh 2)))
  ;(colour (list-ref paleta (random 6)))
  (colour (list-ref paleta (modulo (+ n m) 6)))
  ;(scale (rsndtouch vec1 0.2))
  (push)
  ;(translate (rsndtouch vec1 0.1))
  (hint-cast-shadow)
  (draw-sphere)
  (pop)
  ;(rotate (vector 0 (* (sin (time)) 100) (* 50 (cos (time)))))
  (rotate (vector 0 (* (sintime (* 0.1 m)) 100) (* 50 (costime (* 0.1 m)))))
  (translate (vector 0 1.3 0))
  (render (- n 1) m))))

(define (render2 m v) (cond ((> m 0)
  (push)
    (rotate (rtouch (vector 90 0 0) 1))
    (scale 50)
    ;(colour p3)
    (texture (load-texture "PALETA_COLAB_HEX.png"))
    (draw-plane)
  (pop)
  (push)
  (translate (vmul (car v) 20))
  (render 6 m)
  (pop)
  (render2 (- m 1) (cdr v)))))

(let* ((x 20) (y (grndvecs2 x)))
    (every-frame (render2 x y)))


;(with-state
;    (rotate (vector 90 0 0))
;    (scale 50)
;    (colour (vector 255 0 0))
;    (build-plane))


;(light-diffuse 0 vec0)

(define key (make-light 'spot 'free))
(light-position key (vector 5 5 0))
(light-diffuse key (vector 1 0.95 0.8))


(shadow-light key)


; FOG: VERY SLOW!
;(fog (vector 0 0 1) 0.01 1 100)
