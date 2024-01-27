"
I represent an action or play made by an acceleration card.
"
Class {
	#name : #AccelerationAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AccelerationAction >> on: aZathuraGame by: aSpaceship to: aFleet with: anAccelerationCard [

	aZathuraGame
		currentSpaceshipPlaysCard: anAccelerationCard
		playedBy: aSpaceship
]
