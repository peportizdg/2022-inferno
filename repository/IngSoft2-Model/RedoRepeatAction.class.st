"
I represent a redo action made by a redo card when the last card played was a repeat card
"
Class {
	#name : #RedoRepeatAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoRepeatAction >> on: aZathuraGame by: applyingSpaceship to: aTargetedSpaceship with: aRedoCard [

	aZathuraGame
		redoRepeatCardPlayedBy: applyingSpaceship
		applyTo: aTargetedSpaceship
		with: aRedoCard
]
