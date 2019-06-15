(define (domain domainA)

    (:predicates  
        (Location ?x) (Elevator ?x) 
        (Locker ?x) (ElavatorButton ?x) (CoffeeMachine ?x) (ACRemote ?x) (CcoffeeCup ?x) (Assignment ?x)
        (Arm ?x) (free ?x) (carry ?x ?y) (AtVision ?x) (AC_On ?x) 
        ;atL ?x ?y - x is in y.
        (atLocation ?x ?y) (atLocker ?x ?y)
        (connected ?x ?y) (robotIn ?x)
        (Object ?x) (Carried ?x)
    )

    (:action move :parameters (?x ?y)
    :precondition (and (connected ?x ?y) (robotIn ?x))
    :effect (and (robotIn ?y) (not (robotIn ?x))))   

    ; atVision prev ||  Carried = not ((not atV) & (not Car))
    (:action changeVision :parameters (?prev ?new ?loc)
    :precondition (and (Location ?loc) (atLocation ?new ?loc) (robotIn ?loc) 
                        (not (and (not (AtVision ?prev)) (not (Carried ?prev)))))
    :effect (and (not (AtVision ?prev)) (AtVision ?new)))

    (:action submitAssignment :parameters (?ass ?locker ?arm)
    :precondition (and (carry ?arm ?ass) (AtVision ?locker))
    :effect (and (not (carry ?arm ?ass)) (not (Carried ?ass)) (atLocker ?ass ?locker) (free ?arm)))

    (:action pickUp :parameters (?obj ?arm ?loc)
    :precondition (and (AtVision ?obj) (free ?arm) (atLocation ?obj ?loc) (robotIn ?loc))
    :effect (and (carry ?arm ?obj) (not (free ?arm)) (Carried ?obj)))

)