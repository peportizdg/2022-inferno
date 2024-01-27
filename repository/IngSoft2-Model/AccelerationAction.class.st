"
I represent an action or play made by an acceleration card.
"
Class {
	#name : #AccelerationAction,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AccelerationAction >> on: aZathuraGame by: aSpaceship to: aFleet with: anAccelerationCard [

	aZathuraGame
		currentSpaceshipPlaysCard: anAccelerationCard
		playedBy: aSpaceship
]
