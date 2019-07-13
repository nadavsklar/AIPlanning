; -----------------------------------------------------
; Description: Domain File.
; Date: 20.5.2019
; Change Log: 21.5.2019 - Adding first domain actions and predicates, first problem definitions.
;             10.7.2019 - Adding second and third problem definitions.
; -----------------------------------------------------
(define (domain domainCS)

    (:predicates  
        ; Indicates if x is a location.
        (Location ?x) 
        ; Connected - returns true if x and y are neighbors in the movement tree.
        ; RobotIn - returns true if robot is in x.
        (connected ?x ?y) (robotIn ?x) 
        ; Elevator definitions.
        (Elevator ?x) (ElevatorUpButton ?x) (ElevatorDownButton ?x)
        ; Objects definitions.
        (Locker ?x)  (CoffeeMachine ?x) (CoffeeCup ?x) (Assignment ?x) (Spoon ?x) (Sugar ?x) (Object ?x) 
        ; Robot's arms and carry options. 
        ; Free returns true if x is arm and x is free.
        (Arm ?x) (free ?x) (carry ?x ?y) (AtVision ?x) (Carried ?x) 
        (ACRemote ?x) (AirConditioner ?x)
        ; atLocation ?x ?y - x is in y.
        (AC_On ?x) (atLocation ?x ?y) (atLocker ?x ?y) 
        ; FloorAbove - floor x is above y.
        ; AtFloor - x is in floor y
        (Floor ?x) (FloorAbove ?x ?y) (atFloor ?x ?y) 
        (CoffeeReady ?x) (CoffeeWithSugar ?x) 
        (CoffeeRecieved ?x)
        ; Returns true if x is Prof. Brafman.
        (Brafman ?x)
    )

    ; ---------------------------------------------------
    ; Name: move
    ; Purpose: moves the robot from X to Y.
    ; Pre Conditions: Robot is in x, x and y are connected, x and y are rooms (not elevator). 
    ;                   Robot is looking at y.
    ; Post Conditions: Robot not in x, robot in y.
    ; ---------------------------------------------------
    (:action move :parameters (?x ?y)
    :precondition (and (connected ?x ?y) (robotIn ?x) (not (Elevator ?x))(not (Elevator ?y)) (AtVision ?y))
    :effect (and (robotIn ?y) (not (robotIn ?x))))   
    ; ---------------------------------------------------
    ; Name: changeVision
    ; Purpose: Chnages vision from prev to new.
    ; Pre Conditions: New is carried by robot, or robot is in loc and new is in loc. Prev in vision.
    ; Post Conditions: x not atVision, y atVision.
    ; ---------------------------------------------------
    ; atVision prev ||  Carried = not ((not atV) & (not Car))
    (:action changeVision :parameters (?prev ?new ?loc)
    :precondition 
                (and (or (and (atLocation ?new ?loc) (robotIn ?loc)) (Carried ?new))
                     (AtVision ?prev))
    :effect (and (not (AtVision ?prev)) (AtVision ?new)))
    ; ---------------------------------------------------
    ; Name: lookForward
    ; Purpose: Same as Change vision, but for rooms.
    ; ---------------------------------------------------
    (:action lookForward :parameters (?prev ?new ?loc)
    :precondition (and (Location ?loc) (Location ?new) (connected ?new ?loc) (robotIn ?loc) (AtVision ?prev))
    :effect (and (not (AtVision ?prev)) (AtVision ?new)))
    ; ---------------------------------------------------
    ; Name: submitAssignment
    ; Purpose: Submit the assingment to the right locker.
    ; Pre Conditions: ass is carried by robot. robot is in the same room as the locker.
    ; Post Conditions: ass is in locker, ass is not carried by robot.
    ; ---------------------------------------------------
    (:action submitAssignment :parameters (?ass ?locker ?arm)
    :precondition (and (carry ?arm ?ass) (AtVision ?locker) (Locker ?locker) (Assignment ?ass))
    :effect (and (not (carry ?arm ?ass)) (not (Carried ?ass)) (atLocker ?ass ?locker) (free ?arm)))
    ; ---------------------------------------------------
    ; Name: pickUp
    ; Purpose: Picks up obj with arm at loc.
    ; Pre Conditions: obj is at vision, arm is free.
    ; Post Conditions: obj is carried in arm.
    ; ---------------------------------------------------
    (:action pickUp :parameters (?obj ?arm ?loc)
    :precondition (and (AtVision ?obj) (free ?arm) (atLocation ?obj ?loc) (robotIn ?loc) (Location ?loc) (Object ?obj) (Arm ?arm))
    :effect (and (carry ?arm ?obj) (not (free ?arm)) (Carried ?obj)))
    ; ---------------------------------------------------
    ; Name: pressUpButton
    ; Purpose: Press up button in elevator.
    ; Pre Conditions: button in vision, floors are connected.
    ; Post Conditions: robot goes up from down floor to up floor.
    ; ---------------------------------------------------
    (:action pressUpButton :parameters (?arm ?button ?downFloor ?upFloor)
    :precondition (and (Arm ?arm) (AtVision ?button) (free ?arm) (ElevatorUpButton ?button) (robotIn ?downFloor) (FloorAbove ?downFloor ?upFloor))
    :effect (and (not (robotIn ?downFloor)) (robotIn ?upFloor)))
    ; ---------------------------------------------------
    ; Name: pressDownButton
    ; Purpose: Same as PressUpButton.
    ; ---------------------------------------------------
    (:action pressDownButton :parameters (?arm ?button ?downFloor ?upFloor ?elevator)
    :precondition (and (Arm ?arm) (AtVision ?button) (free ?arm) (Elevator ?elevator) (robotIn ?elevator)
        (ElevatorDownButton ?button) (robotIn ?upFloor) (FloorAbove ?downFloor ?upFloor))
    :effect (and (not (robotIn ?upFloor)) (robotIn ?downFloor)))
    ; ---------------------------------------------------
    ; Name: enterElevator
    ; Purpose: Enter elevator from lobby.
    ; Pre Conditions: loc is in floor, loc and elevator are connected.
    ; Post Conditions: robot is in elevator, robot not in loc.
    ; ---------------------------------------------------
    (:action enterElevator :parameters (?loc ?floor ?elevator)
    :precondition (and (robotIn ?floor) (robotIn ?loc) (connected ?loc ?elevator) (Elevator ?elevator) (atFloor ?loc ?floor))
    :effect (and (not (robotIn ?loc)) (robotIn ?elevator)))
    ; ---------------------------------------------------
    ; Name: exitElevator
    ; Purpose: Same as EnterElevator.
    ; ---------------------------------------------------
    (:action exitElevator :parameters (?loc ?floor ?elevator)
    :precondition (and (robotIn ?floor) (robotIn ?elevator) (connected ?loc ?elevator) (Elevator ?elevator) (atFloor ?loc ?floor))
    :effect (and (robotIn ?loc) (not (robotIn ?elevator))))
    ; ---------------------------------------------------
    ; Name: makeCoffee
    ; Purpose: makes coffee with coffee machine.
    ; Pre Conditions: Robot is carring cup, coffee machine is atvision.
    ; Post Conditions: Coffee is ready in cup, without sugar.
    ; ---------------------------------------------------
    (:action makeCoffee :parameters (?cup ?coffee_machine)
    :precondition (and (CoffeeMachine ?coffee_machine) (CoffeeCup ?cup) (AtVision ?coffee_machine) (Carried ?cup))
    :effect (CoffeeReady ?cup))
    ; ---------------------------------------------------
    ; Name: addSugar
    ; Purpose: Adds sugar to coffee.
    ; Pre Conditions: Coffee must be ready.
    ; Post Conditions: Cofee with sugar.
    ; ---------------------------------------------------
    (:action addSugar :parameters (?cup ?spoon ?sugar)
    :precondition (and (Spoon ?spoon) (Sugar ?sugar) (CoffeeCup ?cup) (CoffeeReady ?cup) (AtVision ?sugar) (Carried ?spoon) (Carried ?cup))
    :effect (CoffeeWithSugar ?cup))
    ; ---------------------------------------------------
    ; Name: giveCoffeeToBrafman
    ; Purpose: Gives to coffee to brafman.
    ; Pre Conditions: Robot is looking on Brafman, coffee is ready.
    ; Post Conditions: Brafman has coffee :)
    ; ---------------------------------------------------
    (:action giveCoffeeToBrafman :parameters (?cup ?brafman)
    :precondition (and (Brafman ?brafman) (CoffeeWithSugar ?cup) (AtVision ?brafman) (Carried ?cup))
    :effect (CoffeeRecieved ?cup))
    ; ---------------------------------------------------
    ; Name: leave
    ; Purpose: leaves the obj and free arm.
    ; Pre Conditions: obj is carried by arm.
    ; Post Conditions: obj is not carried by arm.
    ; ---------------------------------------------------
    (:action leave :parameters (?obj ?arm)
    :precondition (and (Arm ?arm) (Carried ?obj))
    :effect (and (not (Carried ?obj)) (free ?arm)))
    ; ---------------------------------------------------
    ; Name: turnAcOn
    ; Purpose: Turn on Ac!
    ; Pre Conditions: remote is carried by robot, airConditioner is atvision.
    ; Post Conditions: AC on.
    ; ---------------------------------------------------
    (:action turnAcOn :parameters (?ac ?remote)
    :precondition (and (AirConditioner ?ac) (ACRemote ?remote) (AtVision ?ac) (Carried ?remote) (not (AC_On ?ac)))
    :effect (AC_On ?ac))
)