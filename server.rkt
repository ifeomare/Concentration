#lang htdp/isl+
(require 2htdp/image)
(require 2htdp/universe)

;;CONSTANTS
(define MY-NAME "Ifeoma")

(define CIRCLE (circle 80 100 "blue"))
(define SQUARE (square 80 'outline 'darkgreen))
(define DIAMOND (rhombus 80 45 "solid" 'aliceblue))
(define STAR (star 80 "solid" 'peachpuff))
(define TRIANGLE (triangle 80 'solid 'darksalmon))
(define SUN (radial-star 32 30 40 'solid 'darkorange))
(define STOP-SIGN (regular-polygon 20 8 'solid 'black))
(define FLOWER (pulled-regular-polygon 50 5 1.1 140 'solid 'red))

;;heart
(define HEART-TOP (underlay/xy (circle 20 'solid "blue") 37 0 (circle 20 'solid "blue")))
(define HEART-BOTTOM (rotate 55 (wedge 60 74.5 'solid "blue")))
(define HEART (underlay/offset HEART-BOTTOM -1 -28 HEART-TOP))

;;smiley face
(define face (circle 80 "solid" "yellow"))          ; The main face
(define left-eye (circle 10 "solid" "black"))        ; Left eye
(define right-eye (circle 10 "solid" "black"))       ; Right eye
(define mouth (ellipse 60 30 "solid" "black"))     ; Mouth (ellipse)

; Position the eyes and mouth on the face
(define left-eye-position (place-image left-eye 70 60 face))  ; Place left eye
(define right-eye-position (place-image right-eye 130 60 left-eye-position)) ; Place right eye
(define SMILEY-FACE (place-image mouth 100 120 right-eye-position)) ; Place the smile


;;A match is a natnum in [0..10]
;; An opp is a structure: (make-opp string natnum)
;; with this opponent's name and number of successful matches
(define-struct opp (name matches))
;; TEMPLATE FOR FUNCTIONS ON AN OPP
;; opp ... --> ...
;; Purpose:
;; (define (f-on-opp an-opp ...)
;;   (... (opp-name an-opp) ... (opp-matches an-opp)))
;;
;;  ;; Sample instances of opp
;;  (define OPP1  (make-opp ... ...))
;;
;;  ;; Sample expressions for f-on-opp
;;  (define OPP1-VAL ... OPP1 ...) ...
;;
;;  ;; Tests using sample computations for f-on-opp
;;  (check-expect (f-on-opp OPP1 ...) OPP-VAL) ...
;;
;;  ;; Tests using sample values for f-on-opp
;;  (check-expect (f-on-opp ... ...) ... ) ...

;; Sample instances of opp
(define INIT-OPP  (make-opp MY-NAME 0))
(define INIT-OPP2 (make-opp MY-NAME 3))

;; loo is a (listof opp)
;; Sample instances of loo
(define INIT-OPPS  (list INIT-OPP))
(define INIT-OPPS2 (list INIT-OPP2))
(define OPPS3 (list INIT-OPP INIT-OPP2))

;; A card is a structure: (make-card image boolean boolean)
;;with the card's front image, whether it's face up or down, and whether the card's been matched
(define-struct card (front face-up? matched?))
;; TEMPLATE FOR FUNCTIONS ON A CARD
;; card ... --> ...
;; Purpose:
;; (define (f-on-card a-card ...)
;;   (... (card-front a-card) ... (card-face-up? a-card)
;;    ...(card-matched? a-card)))
;;
;;  ;; Sample instances of card
;;  (define CARD1  (make-card ... ...))
;;
;;  ;; Sample expressions for f-on-card
;;  (define CARD1-VAL ... CARD1 ...) ...
;;
;;  ;; Tests using sample computations for f-on-card
;;  (check-expect (f-on-card CARD1 ...) CARD-VAL) ...
;;
;;  ;; Tests using sample values for f-on-card
;;  (check-expect (f-on-card ... ...) ... ) ...

;; Instances of card
(define CARD (make-card CIRCLE #false #false))
(define CARD2 (make-card SQUARE #false #false))
(define CARD3 (make-card DIAMOND #false #false))
(define CARD4 (make-card STAR #false #false))
(define CARD5 (make-card TRIANGLE #false #false))
(define CARD6 (make-card SUN #false #false))
(define CARD7 (make-card STOP-SIGN #false #false))
(define CARD8 (make-card FLOWER #false #false))
(define CARD9 (make-card HEART #false #false))
(define CARD10 (make-card SMILEY-FACE #false #false))

;; loc is a (listof cards)
(define CARD-DECK (list CARD CARD
                        CARD2 CARD2
                        CARD3 CARD3
                        CARD4 CARD4
                        CARD5 CARD5
                        CARD6 CARD6
                        CARD7 CARD7
                        CARD8 CARD8
                        CARD9 CARD9
                        CARD10 CARD10))

;;Sample instances of loc
(define INIT-LOC2 (list CARD CARD))
(define INIT-LOC3 (list CARD CARD
                        CARD3 CARD3
                        CARD4 CARD4
                        CARD7 CARD7
                        CARD8 CARD8
                        CARD10 CARD10))

;; A world is either
;;  1. 'uninitialized
;;  2. a structure: (make-world loo loc)
(define-struct world (opps cards))

#|
 TEMPLATE FOR FUNCTIONS ON A WORLD
 world ... --> ...
 Purpose:
 (define (f-on-world w ...)
   (if (eq? a-world 'uninitialized)
       ...
       (... (f-on-loo (world-opps w))... (f-on-loc (world-cards w)))))

  ;; Sample instances of world
  (define WORLD1  'uninitialized)
  (define WORLD2  (make-world ... ... ... ...))

  ;; Sample expressions for f-on-world
  (define WORLD1-VAL ... WORLD1 ...)
  (define WORLD2-VAL ... WORLD2 ...) ...

  ;; Tests using sample computations for f-on-world
  (check-expect (f-on-world WORLD1 ...) WORLD1-VAL)
  (check-expect (f-on-world WORLD2 ...) WORLD2-VAL) ...

  ;; Tests using sample values for f-on-world
  (check-expect (f-on-world ... ...) ... ) ...     |#

(define INIT-WORLD  (make-world INIT-OPPS CARD-DECK))
(define INIT-WORLD2 (make-world INIT-OPPS2 INIT-LOC2))
(define WORLD3 (make-world (list (make-opp "iworld1" 7)
                                 (make-opp "iworld2" 9))
                           (list (make-card (text "1" 50 'red) #false #false))))
(define WORLD4 (make-world (list (make-opp "iworld3" 8)
                                 (make-opp "iworld2" 5))
                           (list (make-card (text "2" 50 'blue) #false #false))))
(define UNINIT-WORLD 'uninitialized)

;; A universe is a structure: (make-univ (listof iworld) world)
(define-struct univ (iws game))

;; Template for a function on a universe
#| ;; Sample instances of univ
   (define UNIV1 (make-univ ... ...))

   universe ... --> ...
   Purpose:
   (define (f-on-univ a-univ ...)
     (...(univ-iws a-univ)...(univ-world a-univ)...))

   ;; Sample expressions for f-on-univ
   (define UNIV1-VAL ...) ...

   ;; Tests using sample computations for f-on-univ
   (check-expect (f-on-univ UNIV1 ...) UNIV1-VAL) ...

   ;; Tests using sample values for f-on-univ
   (check-expect (f-on-univ ... ...) ...) ...
|#

;; Sample instances of universe
(define INIT-UNIV  (make-univ '() UNINIT-WORLD))
(define OTHR-UNIV  (make-univ (list iworld1 iworld2) WORLD3))
(define OTHR-UNIV2 (make-univ (list iworld3 iworld2) WORLD4))

;; Any → universe
;; Purpose: Run the universe server
#|
(define (run-server a-z)
(universe
INIT-UNIV
(on-new add-new-iworld)
(on-msg process-message)
(on-disconnect rm-iworld)))
Three server handlers must be designed and
|#
