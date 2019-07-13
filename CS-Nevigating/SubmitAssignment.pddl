(define (problem SubmitAssignment)
(:domain domainCS)

    (:objects 
        left_arm right_arm
        locker1 locker2 locker3 locker4 locker5
        room007 locker_room enterence 
        door007
        autometaAssignment
    )
    (:init 
        (robotIn room007) 
        (AtVision door007)
        (Location locker_room) (Location enterence) (Location room007) 
        (Assignment autometaAssignment)
        (Object autometaAssignment)
        (Locker locker1) (Locker locker2) (Locker locker3) (Locker locker4) (Locker locker5)
        (Arm left_arm) (Arm right_arm) 
        (free left_arm) (free right_arm)
        (atLocation locker1 locker_room) (atLocation locker2 locker_room) (atLocation locker3 locker_room) (atLocation locker4 locker_room) (atLocation locker5 locker_room)
        (atLocation autometaAssignment room007) (atLocation door007 room007)
        (connected locker_room enterence) (connected enterence locker_room) (connected enterence room007) (connected room007 enterence)  
    )
    (:goal 
        (atLocker autometaAssignment locker4)
    )

)