"
I represent an action. An action is a series of movements or card applyments/removers that happen when a card is played in a zathura game. Each card create a different type of action.
"
Class {
	#name : #Action,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Action >> on: aZathuraGame by: aSpaceship to: aFleet with: anAccelerationCard [

	self subclassResponsibility 
]
