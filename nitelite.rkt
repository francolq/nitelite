; ANTES: cargar lib.rkt y paleta.rkt

; TODO:
; - hacer obj invisible
; - sacar culitos? (parecen pijas)
; - usar musica
; - mejorar baile (saltitos)
; - arreglar tabulacion

; nuevo:
; - mejor codigo
; - mover camara
; - poner culitos
; - usar BPMs
; - luces locas
; - usar paleta de colores
; - mas guachxs, mejor ubicados
; - descoordinacion


(define bpms 127)

(clear)
(show-fps 1)
(desired-fps 1000000)
;(hint-wire)
(scale (vmul vec1 0.1))


(define (gusanito n m) (cond ((> n 0)
  ;(colour (vector (gh 0) (gh 1) (gh 2)))
  ;(colour (list-ref paleta (random 6)))
  (colour (list-ref paleta (modulo (+ n m) 6)))
  ;(scale (rsndtouch vec1 0.2))
  (push)
  ;(translate (rsndtouch vec1 0.1))
  (hint-cast-shadow)
  ;(cond ((= n 5)
  ;    (push)
  ;    (translate (vector 0.5 0 0))
  ;    (draw-sphere)
  ;    (translate (vector -1 0 0))
  ;    (draw-sphere)
  ;    (pop))
  ;      (else
  ;    (draw-sphere)))
  (draw-sphere)
  (pop)
  ;(rotate (vector 0 (* (sin (time)) 100) (* 50 (cos (time)))))
  (rotate (vector 0 (* (sintime (* 0.1 m)) 100) (* 50 (costime (* 0.1 m)))))
  (translate (vector 0 1.3 0))
  (gusanito (- n 1) m))))


(define (gusanitos m v) (cond ((> m 0)
  (push)
  (translate (vmul (car v) 15))
  (gusanito 6 m)
  (pop)
  (gusanitos (- m 1) (cdr v)))))


; LUCES
; apagar luz principal
(light-diffuse 0 vec0)
(light-diffuse 0 (vec 0.2))
(define key (make-light 'spot 'free))
(light-position key (vector 5 5 0))
(light-diffuse key (vector 1 0.95 0.8))
(shadow-light key)


; CAMARA
(define obj (build-cube))
(with-primitive obj
    (scale (vec 11.5))
    (translate (vector 0 -1 0)))
(lock-camera obj)
(camera-lag 0.1)
; camera angle
;(clip 1 10000)  ; dinamico, ver abajo


(define (animate x y)
  ; pista de baile
  ;(light-diffuse key (vector (sintime 1) (costime 1) 0.8))
  (light-diffuse key (vec (beatsin bpms)))
  (push)
    (rotate (rtouch (vector 90 0 0) 1))
    (scale 50)
    ;(colour p3)
    (texture (load-texture "PALETA_COLAB_HEX.png"))
    (draw-plane)
  (pop)
    (gusanitos x y)
    ; camara
    (with-primitive obj
        ;(identity)
        (rotate (vector 0.1 1 0))
        ; 10 segundos, maxima cercania 4
        ;(clip (min (fmod (time) 10) 4) 10000)
        (clip (+ (sin (time)) 2) 10000)
        ;(translate (vector 10 31 10))
        ;(rotate (vector (sintime 10) 0 (costime 10)))
        ;(translate (vector (fmod (* (time) 10) 10) 3 0))
))

(let* ((x 20) (y (grndvecs2 x)))
    (every-frame (animate x y)))
