"
I represent a redo action made by a redo card when the last card played was a speed card
"
Class {
	#name : #RedoMovementAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoMovementAction >> on: aZathuraGame by: anApplyingSpaceship to: aTarget with: aRedoCard [

	aZathuraGame
		redoLastCardPlayedBy: anApplyingSpaceship
		applyTo: aTarget
		with: aRedoCard
]
