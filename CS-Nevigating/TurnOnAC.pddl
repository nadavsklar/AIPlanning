(define (problem TurnOnAC)
(:domain domainCS)

    (:objects 
        left_arm right_arm
        enterence elevator  
        kitchen first_lobby 
        second_lobby room209 room111
        up_button down_button
        ac_remote ac_209
        floor0 floor1 floor2
        
        ;********;
        brafman
        ;********;
    )
    (:init 
        (robotIn room209) (robotIn floor2)
        (AtVision brafman)
        (Location enterence) (Location kitchen) (Location first_lobby) (Location second_lobby) (Location room111) (Location room209) (Location elevator)
        (Arm left_arm) (Arm right_arm) 
        (free left_arm) (free right_arm)
        (AirConditioner ac_209) (ACRemote ac_remote)
        (Brafman brafman)
        (Object ac_remote)
        (Elevator elevator) (ElevatorUpButton up_button) (ElevatorDownButton down_button)
        
        (Floor floor0) (Floor floor1) (Floor floor2)
        (FloorAbove floor0 floor1) (FloorAbove floor0 floor2) (FloorAbove floor1 floor2)

        (atLocation ac_209 room209) (atLocation ac_remote room111)
        (atLocation brafman room209) (atLocation up_button elevator) (atLocation down_button elevator)

        (atFloor second_lobby floor2)
        (atFloor first_lobby floor1)
        (atFloor enterence floor0)

        (connected room209 second_lobby) (connected second_lobby room209)
        (connected second_lobby elevator) (connected elevator second_lobby)
        (connected elevator first_lobby) (connected first_lobby elevator)
        (connected first_lobby kitchen) (connected kitchen first_lobby)
        (connected first_lobby room111) (connected room111 first_lobby)
        (connected enterence elevator) (connected elevator enterence)

    )
    (:goal 
       ;  (forall (?ac - AirConditioner) (AC_On ?ac))
      (AC_On ac_209)
    )

)