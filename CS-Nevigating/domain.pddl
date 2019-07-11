(define (domain domainA)

    (:predicates  
        (Location ?x)
        (connected ?x ?y) (robotIn ?x)
        (Elevator ?x) (ElevatorUpButton ?x) (ElevatorDownButton ?x)
        (Locker ?x)  (CoffeeMachine ?x) (ACRemote ?x) (CoffeeCup ?x) (Assignment ?x) (Spoon ?x) (Sugar ?x) (Object ?x) 
        (Arm ?x) 
        (free ?x) (carry ?x ?y) (AtVision ?x) (Carried ?x) 
        (AC_On ?x) (atLocation ?x ?y) (atLocker ?x ?y) ; atLocation ?x ?y - x is in y.
        (Floor ?x) (FloorAbove ?x ?y) (atFloor ?x ?y) ; floor x is above y, x is in floor y
        (CoffeeReady ?x) (CoffeeWithSugar ?x) 
        (CoffeeRecieved ?x)

        ;*******;
        (Brafman ?x)
        ;*******;
    )

    (:action move :parameters (?x ?y)
    :precondition (and (connected ?x ?y) (robotIn ?x) (not (Elevator ?x))(not (Elevator ?y)) (AtVision ?y))
    :effect (and (robotIn ?y) (not (robotIn ?x))))   

    ; atVision prev ||  Carried = not ((not atV) & (not Car))
    (:action changeVision :parameters (?prev ?new ?loc)
    :precondition 
                (and (or (and (atLocation ?new ?loc) (robotIn ?loc)) (Carried ?new))
                     (AtVision ?prev))
    :effect (and (not (AtVision ?prev)) (AtVision ?new)))

    (:action lookForward :parameters (?prev ?new ?loc)
    :precondition (and (Location ?loc) (Location ?new) (connected ?new ?loc) (robotIn ?loc) (AtVision ?prev))
    :effect (and (not (AtVision ?prev)) (AtVision ?new)))

    (:action submitAssignment :parameters (?ass ?locker ?arm)
    :precondition (and (carry ?arm ?ass) (AtVision ?locker) (Locker ?locker) (Assignment ?ass))
    :effect (and (not (carry ?arm ?ass)) (not (Carried ?ass)) (atLocker ?ass ?locker) (free ?arm)))

    (:action pickUp :parameters (?obj ?arm ?loc)
    :precondition (and (AtVision ?obj) (free ?arm) (atLocation ?obj ?loc) (robotIn ?loc) (Location ?loc) (Object ?obj) (Arm ?arm))
    :effect (and (carry ?arm ?obj) (not (free ?arm)) (Carried ?obj)))

    (:action pressUpButton :parameters (?arm ?button ?downFloor ?upFloor)
    :precondition (and (Arm ?arm) (AtVision ?button) (free ?arm) (ElevatorUpButton ?button) (robotIn ?downFloor) (FloorAbove ?downFloor ?upFloor))
    :effect (and (not (robotIn ?downFloor)) (robotIn ?upFloor)))

    (:action pressDownButton :parameters (?arm ?button ?downFloor ?upFloor ?elevator)
    :precondition (and (Arm ?arm) (AtVision ?button) (free ?arm) (Elevator ?elevator) (robotIn ?elevator)
        (ElevatorDownButton ?button) (robotIn ?upFloor) (FloorAbove ?downFloor ?upFloor))
    :effect (and (not (robotIn ?upFloor)) (robotIn ?downFloor)))

    (:action enterElevator :parameters (?loc ?floor ?elevator)
    :precondition (and (robotIn ?floor) (robotIn ?loc) (connected ?loc ?elevator) (Elevator ?elevator) (atFloor ?loc ?floor))
    :effect (and (not (robotIn ?loc)) (robotIn ?elevator)))

    (:action exitElevator :parameters (?loc ?floor ?elevator)
    :precondition (and (robotIn ?floor) (robotIn ?elevator) (connected ?loc ?elevator) (Elevator ?elevator) (atFloor ?loc ?floor))
    :effect (and (robotIn ?loc) (not (robotIn ?elevator))))

    (:action makeCoffee :parameters (?cup ?coffee_machine)
    :precondition (and (CoffeeMachine ?coffee_machine) (CoffeeCup ?cup) (AtVision ?coffee_machine) (Carried ?cup))
    :effect (CoffeeReady ?cup))

    (:action addSugar :parameters (?cup ?spoon ?sugar)
    :precondition (and (Spoon ?spoon) (Sugar ?sugar) (CoffeeCup ?cup) (CoffeeReady ?cup) (AtVision ?sugar) (Carried ?spoon) (Carried ?cup))
    :effect (CoffeeWithSugar ?cup))

    (:action giveCoffeeToBrafman :parameters (?cup ?brafman)
    :precondition (and (Brafman ?brafman) (CoffeeWithSugar ?cup) (AtVision ?brafman) (Carried ?cup))
    :effect (CoffeeRecieved ?cup))

    (:action leave :parameters (?obj ?arm)
    :precondition (and (Arm ?arm) (Carried ?obj))
    :effect (and (not (Carried ?obj)) (free ?arm)))
)