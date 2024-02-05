"
I represent an action made by a speed card or overload card, cards that deploy spaceship movement.
"
Class {
	#name : #MovementAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
MovementAction >> on: aZathuraInstance by: aSpaceshipName to: aTargetedSpaceship with: aMovementCard [

	aZathuraInstance assertItIsThatSpaceshipsTurn: aSpaceshipName.
	aZathuraInstance
		currentSpaceshipPlaysCard: aMovementCard
		applyTo: aTargetedSpaceship
		playedBy: aSpaceshipName
]
