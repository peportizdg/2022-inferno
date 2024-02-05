"
I represent a finite card dealer, and i have a deck and a discard deck.
"
Class {
	#name : #FiniteDealer,
	#superclass : #Object,
	#instVars : [
		'deck',
		'discardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initializaition }
FiniteDealer class >> createFor: aDeckOfCards [

	^ self new initializeWith: aDeckOfCards
]

{ #category : #adding }
FiniteDealer >> addToDiscardDeck: aCard [

	discardDeck addLast: aCard
]

{ #category : #getters }
FiniteDealer >> amountOfCardsInDeck [

	^ deck size
]

{ #category : #dealing }
FiniteDealer >> amountOfDiscarded [

	^ discardDeck size
]

{ #category : #asserting }
FiniteDealer >> assertDeckIsNotEmpty [

	deck isEmptyOrNil ifTrue: [
		discardDeck isEmptyOrNil
			ifTrue: [ deck addLast: nil ]
			ifFalse: [
				deck := discardDeck shuffled.
				discardDeck := OrderedCollection new ] ]
]

{ #category : #dealing }
FiniteDealer >> dealInitialCardsTo: aSpaceshipName [

	| randomcard1 randomcard2 aSpaceship |
	randomcard1 := self dealOne.
	randomcard2 := self dealOne.
	^ aSpaceship := Spaceship named: aSpaceshipName containing: {
			                randomcard1.
			                randomcard2 }
]

{ #category : #dealing }
FiniteDealer >> dealOne [

	self assertDeckIsNotEmpty.
	^ deck removeLast
]

{ #category : #initialization }
FiniteDealer >> initializeWith: aDeckOfCards [

	deck := aDeckOfCards.
	discardDeck := OrderedCollection new
]
