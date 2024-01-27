"
I represent an action or play made by an redo card, when the last card played was an acceleration card
"
Class {
	#name : #RedoAccelerationaction,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoAccelerationaction >> on: aZathuraGame by: applyingSpaceship to: aTarget with: aRedoCard [

	aZathuraGame redoLastCardPlayedBy: applyingSpaceship with: aRedoCard
]
