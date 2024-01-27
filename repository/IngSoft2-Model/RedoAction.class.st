"
I represent an action or play made on a game, by a redocard
"
Class {
	#name : #RedoAction,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoAction >> on: aZathuraGame by: anApplyingSpaceship to: aTarget with: aRedoCard [

	| lastCardPlayed actionRedo |
	lastCardPlayed := aZathuraGame lastCardPlayed.
	actionRedo := lastCardPlayed createOwnRedoAction.
	actionRedo
		on: aZathuraGame
		by: anApplyingSpaceship
		to: aTarget
		with: aRedoCard
]
