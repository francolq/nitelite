; antes cargar lib.rkt, audio_in.rkt y paleta.rkt

(define bpms 127)

(clear)
(show-fps 1)
(desired-fps 1000000)
(scale (vmul vec1 0.1))  ; escalado general

; LUCES
;(light-diffuse 0 vec0)      ; apagar luz principal
(light-diffuse 0 (vec 0.2))  ; atenuar luz principal
(define key (make-light 'spot 'free))
(light-position key (vector 5 5 0))
(light-diffuse key (vector 1 0.95 0.8))
(shadow-light key)


; CAMARA
(reset-camera)
(define obj (build-cube))
(with-primitive obj
  (rotate (vector -30 0 0))
  (scale (vec 11.5))
  (translate (vector 0 -1 0)))
(lock-camera obj)
(camera-lag 0.1)


(define alto 6)
(define cuantos 20)
(gain 0.3)  ; nivel de manija
(define (forma)
  ;(hint-wire)
  (draw-sphere))

(define (camara)
  (with-primitive obj
    (rotate (vector 0 0.4 0.4))  ; rotacion
    ;(rotate (vector (* (sin (* (time) 0.5)) 0.25) 0 0))  ; de arriba
    (clip (+ (sin (* (time) 0.5)) 1.8) 10000)))  ; zoom

(define (pista)
  (push)
    (rotate (rtouch (vector 90 0 0) 0.5))
    (scale 50)
    (texture (load-texture "PALETA_COLAB_HEX.png"))
    (draw-plane)
  (pop))

(define (gusanito n m) (cond ((> n 0)
  ;(colour (vmul (list-ref paleta (modulo (+ n m) 6)) (gh (fmod m 4))))  ; con musica
  (colour (list-ref paleta (modulo (+ n m) 6)))  ; sin musica
  (scale (vadd vec1 (vmul (vec 0.005) (gh (fmod m 4)))))  ; latidos
  (push)
    (cond ((= n 6) (hint-cast-shadow)))  ; sombra en las patas
    (cond ((or (= n 4) (= n 5))
      (translate (vector (* 2.0 (- 0.5 (beatsin (* 0.5 bpms)))) 0 0))))  ; meneo
    (forma)
  (pop)
  ; usar m para defasaje entre gusanitos
  ; usar n para mayores angulos arriba
  (rotate (vmul (vector 0 (* (sin (+ (* (time) (* 0.2 m)) m)) (* (- 7 n) 10))
                          (* (cos (+ (* (time) (* 0.2 m)) m)) (* (- 7 n) 5)))
                (logistic (- (gh 0) 1))))
  (translate (vector 0 1.3 0))
  (gusanito (- n 1) m))))

(define (gusanitos m v) (cond ((> m 0)
  (push)
    (rotate (vector 0 (* (time) (* 2 m)) 0))  ; girar en la pista
    (translate (vmul (car v) 15))  ; su lugar en la pista
    (translate (vector 0 (* (beatsin bpms) (gh 0)) 0))  ; saltitos
    ;(gusanito (+ 5 (modulo m 2)) m)  ; largo variable
    (gusanito alto m)
  (pop)
  (gusanitos (- m 1) (cdr v)))))

(define (animate x y)
  ;(light-diffuse key (vec (beatsin bpms)))
  (light-diffuse key (vec (* (gh 0) (beatsin bpms))))
  (pista)
  (gusanitos x y)
  (camara))

(let* ((x cuantos) (y (grndvecs2 x)))
  (every-frame (animate x y)))
