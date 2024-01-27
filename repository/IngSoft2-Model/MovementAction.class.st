"
I represent an action made by a speed card
"
Class {
	#name : #MovementAction,
	#superclass : #Object,
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
