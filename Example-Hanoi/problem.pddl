; Problem description
; Describe one scenario within the domain constraints
; This one describes the Tower of Hanoi with 3 discs
(define (problem pb3)
  (:domain hanoi)

  ; Objects are candidates to replace free variables
  (:objects peg1 peg2 peg3 d1 d2 d3)

  ; The initial state describe what is currently true
  ; Everything else is considered false
  (:init
    ; Discs are smaller than pegs
    (smaller d1 peg1) (smaller d1 peg2) (smaller d1 peg3)
    (smaller d2 peg1) (smaller d2 peg2) (smaller d2 peg3)
    (smaller d3 peg1) (smaller d3 peg2) (smaller d3 peg3)
    ; Discs are also smaller than some other discs
    (smaller d1 d2) (smaller d1 d3)
    (smaller d2 d3)

    ; There is nothing on top of some pegs and disc
    (clear peg2)
    (clear peg3)
    (clear d1)

    ; Discs are stacked on peg1
    (on d3 peg1)
    (on d2 d3)
    (on d1 d2)
  )

  ; The goal state describe what we desire to achieve
  (:goal (and
    ; Discs stacked on peg3
    (on d3 peg3)
    (on d2 d3)
    (on d1 d2)
  ))
)