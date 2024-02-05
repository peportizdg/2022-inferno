"
I represent an action or play made by an aredo card when the last card played was a cancelattion card.
"
Class {
	#name : #RedoCancellationAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoCancellationAction >> on: aZathuraGame by: applyingSpaceship to: aTarget with: aRedoCard [

	aZathuraGame
		redoCancelationCard: (aTarget at: 2)
		from: (aTarget at: 1)
		PlayedBy: applyingSpaceship
		with: aRedoCard
]
