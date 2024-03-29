; -----------------------------------------------------
; Description: Problem 1.
; Date: 20.5.2019
; Change Log: 21.5.2019 - Adding first domain actions and predicates, first problem definitions.
; -----------------------------------------------------
(define (problem SubmitAssignment)
(:domain domainCS)
    ; ------------- Objects -------------------
    (:objects 
        left_arm right_arm
        locker1 locker2 locker3 locker4 locker5
        room007 locker_room enterence 
        door007
        autometaAssignment
    )
    ; ------------ Init State ----------------
    (:init 
        ; Robot is in 007, looking at the door.
        (robotIn room007) 
        (AtVision door007)
        ; Locations
        (Location locker_room) (Location enterence) (Location room007) 
        ; Objects
        (Assignment autometaAssignment)
        (Object autometaAssignment)
        (Locker locker1) (Locker locker2) (Locker locker3) (Locker locker4) (Locker locker5)
        ; Arms
        (Arm left_arm) (Arm right_arm) 
        (free left_arm) (free right_arm)
        ; Objects locations
        (atLocation locker1 locker_room) (atLocation locker2 locker_room) (atLocation locker3 locker_room) (atLocation locker4 locker_room) (atLocation locker5 locker_room)
        (atLocation autometaAssignment room007) (atLocation door007 room007)
        ; Movement Graph
        (connected locker_room enterence) (connected enterence locker_room) (connected enterence room007) (connected room007 enterence)  
    )
    (:goal 
        (atLocker autometaAssignment locker4)
    )
)