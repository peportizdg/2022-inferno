"
I represent an action or play made by an cancellation card.
"
Class {
	#name : #CancellationAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CancellationAction >> on: aZathuraGame by: applyingSpaceship to: aTarget with: aCancellationCard [

	aZathuraGame
		cancelCard: (aTarget at: 2)
		from: (aTarget at: 1)
		playedBy: applyingSpaceship
		with: aCancellationCard
]
