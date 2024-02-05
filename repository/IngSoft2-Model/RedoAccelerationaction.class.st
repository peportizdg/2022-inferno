"
I represent an action or play made by an redo card, when the last card played was an acceleration card
"
Class {
	#name : #RedoAccelerationAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoAccelerationAction >> on: aZathuraGame by: applyingSpaceship to: aTarget with: aRedoCard [

	aZathuraGame redoLastCardPlayedBy: applyingSpaceship with: aRedoCard
]
