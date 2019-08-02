; -----------------------------------------------------
; Description: Problem 3.
; Date: 20.5.2019
; Change Log: 21.5.2019 - Adding first domain actions and predicates, first problem definitions.
;             10.7.2019 - Adding second and third problem definitions.
; -----------------------------------------------------
(define (problem TurnOnAC)
(:domain domainCS)

    (:objects 
        ; ---------------- Objects ------------------
        left_arm right_arm
        enterence elevator  
        kitchen first_lobby 
        second_lobby room209 room111
        up_button down_button
        ac_remote ac_209
        floor0 floor1 floor2
        brafman
    )
    (:init 
        ; ---------------- Init State --------------
        (robotIn room209) (robotIn floor2)
        (AtVision brafman)
        ; Locations
        (Location enterence) (Location kitchen) (Location first_lobby) (Location second_lobby) (Location room111) (Location room209) (Location elevator)
        ; Arms
        (Arm left_arm) (Arm right_arm) 
        (free left_arm) (free right_arm)
        ; Objects
        (AirConditioner ac_209) (ACRemote ac_remote)
        (Brafman brafman)
        (Object ac_remote)
        ; Elevator
        (Elevator elevator) (ElevatorUpButton up_button) (ElevatorDownButton down_button)
        ; Floors
        (Floor floor0) (Floor floor1) (Floor floor2)
        (FloorAbove floor0 floor1) (FloorAbove floor0 floor2) (FloorAbove floor1 floor2)
        ; Objects Locations
        (atLocation ac_209 room209)
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
        (connected first_lobby room111) (connected room111 first_lobby)
        (connected enterence elevator) (connected elevator enterence)

        (oneof (atLocation ac_remote room111) (atLocation ac_remote room111)) 

    )
    (:goal 
      (AC_On ac_209)
    )

)