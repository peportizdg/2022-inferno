"
I represent the action made by a speedBoost card.
"
Class {
	#name : #SpeedBoostAction,
	#superclass : #Action,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedBoostAction >> on: aZathuraGame by: anApplyingSpaceship to: aTarget with: aSpeedBostCard [

	aZathuraGame
		boostCard: (aTarget at: 2)
		from: (aTarget at: 1)
		playedBy: anApplyingSpaceship
		with: aSpeedBostCard
]
