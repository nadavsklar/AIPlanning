; -----------------------------------------------------
; Description: Problem 2.
; Date: 20.5.2019
; Change Log: 21.5.2019 - Adding first domain actions and predicates, first problem definitions.
;             10.7.2019 - Adding second and third problem definitions.
; -----------------------------------------------------
(define (problem MakeCoffee)
(:domain domainCS)

    (:objects 
        ; ------------- Objects ----------------
        left_arm right_arm
        enterence elevator  
        kitchen first_lobby 
        second_lobby room209
        up_button down_button
        coffee_machine spoon sugar cup 
        floor0 floor1 floor2
        brafman
    )
    ; ----------------- Init State -------------
    (:init 
        ; Robot location and floor.
        (robotIn room209) (robotIn floor2)
        (AtVision brafman)
        ; Locations
        (Location enterence) (Location kitchen) (Location first_lobby) (Location second_lobby) (Location room209) (Location elevator)
        ; Arms
        (Arm left_arm) (Arm right_arm) 
        (free left_arm) (free right_arm)
        ; Objects
        (CoffeeCup cup) (CoffeeMachine coffee_machine) (Spoon spoon) (Sugar sugar)
        (Brafman brafman)
        (Object cup) (Object spoon) (Object sugar)
        ; Elevator
        (Elevator elevator) (ElevatorUpButton up_button) (ElevatorDownButton down_button)
        ; Floors
        (Floor floor0) (Floor floor1) (Floor floor2)
        (FloorAbove floor0 floor1) (FloorAbove floor0 floor2) (FloorAbove floor1 floor2)
        ; Objects locations
        (atLocation coffee_machine kitchen) (atLocation spoon kitchen) (atLocation sugar kitchen) (atLocation cup room209)
        (atLocation brafman room209) (atLocation up_button elevator) (atLocation down_button elevator)
        ; Floor rooms
        (atFloor second_lobby floor2)
        (atFloor first_lobby floor1)
        (atFloor enterence floor0)
        ; Movement Graph
        (connected room209 second_lobby) (connected second_lobby room209)
        (connected second_lobby elevator) (connected elevator second_lobby)
        (connected elevator first_lobby) (connected first_lobby elevator)
        (connected first_lobby kitchen) (connected kitchen first_lobby)
        (connected enterence elevator) (connected elevator enterence)

    )
    (:goal 
        (CoffeeRecieved cup)
    )

)