"
I represent a redo action made by a speedbost card.
"
Class {
	#name : #RedoSpeedBostAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoSpeedBostAction >> on: aZathuraGame by: applyingSpaceship to: aTarget with: aRedoCard [

	aZathuraGame
		redoSpeedBostCard: (aTarget at: 2)
		from: (aTarget at: 1)
		playedBy: applyingSpaceship
		with: aRedoCard
]
