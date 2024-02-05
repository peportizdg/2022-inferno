"
I represent a fleet. An object created to store the cards that apply to every spaceship.
"
Class {
	#name : #Fleet,
	#superclass : #Object,
	#instVars : [
		'cardsBeingApplied'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Fleet class >> create [

	^ self new initializeFleet
]

{ #category : #'editing keys' }
Fleet >> cancel: anFleetCard [

	| cardToRemove |
	cardToRemove := cardsBeingApplied
		                detect: [ :eachCard |
		                eachCard isSameTypeAs: anFleetCard ]
		                ifNone: [
		                Error signal:
			                'Cant cancel a card not being applied to fleet.' ].
	cardsBeingApplied remove: cardToRemove
]

{ #category : #accessing }
Fleet >> cardsBeingApplied [

	^ cardsBeingApplied
]

{ #category : #cardUsing }
Fleet >> getsApplied: aCard [

	cardsBeingApplied add: aCard
]

{ #category : #initialization }
Fleet >> initializeFleet [

	cardsBeingApplied := OrderedCollection new
]
