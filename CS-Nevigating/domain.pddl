(define (domain domainA)

    (:predicates  
        (Location ?x) (Floor ?x)
        (connected ?x ?y) (robotIn ?x)
        (Elevator ?x) (ElevatorUpButton ?x) (ElevatorDownButton ?x)
        (Locker ?x)  (CoffeeMachine ?x) (ACRemote ?x) (CcoffeeCup ?x) (Assignment ?x) (Spoon ?x) (Sugar ?x) (Object ?x) 
        (Arm ?x) 
        (free ?x) (carry ?x ?y) (AtVision ?x) (Carried ?x) 
        (AC_On ?x) (atLocation ?x ?y) (atLocker ?x ?y) ; atLocation ?x ?y - x is in y.
        (FirstFloor ?x) (SecondFloor ?x)
        (CoffeeReady ?x) (CoffeeWithSugar ?x) 
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
    :precondition (and (carry ?arm ?ass) (AtVision ?locker) (Locker ?locker) (Assignment ?ass))
    :effect (and (not (carry ?arm ?ass)) (not (Carried ?ass)) (atLocker ?ass ?locker) (free ?arm)))

    (:action pickUp :parameters (?obj ?arm ?loc)
    :precondition (and (AtVision ?obj) (free ?arm) (atLocation ?obj ?loc) (robotIn ?loc) (Location ?loc) (Object ?obj) (Arm ?arm))
    :effect (and (carry ?arm ?obj) (not (free ?arm)) (Carried ?obj)))

    (:action pressUpButton :parameters (?arm ?button ?loc)
    :precondition (and (Arm ?arm) (Location ?loc) (AtVision ?button) (free ?arm) (ElevatorUpButton ?button))
    :effect (when (FirstFloor ?loc))  )


                        (when (and (boarded ?passenger)
                             (destin ?passenger ?floor))
                        (and (not (boarded ?passenger))
                             (served ?passenger))))


)