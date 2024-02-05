"
I represent a Dealer

"
Class {
	#name : #InfiniteDealer,
	#superclass : #Object,
	#instVars : [
		'typesOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
InfiniteDealer class >> assertValidTypes: aCollectionOfTypes [

	aCollectionOfTypes isNotEmpty ifFalse: [
		Error signal: 'Cannot create a card dealer with no types of cards ' ].
	aCollectionOfTypes do: [ :eachCard |
		eachCard assertThatIsACard ifFalse: [
			Error signal: 'Array contains an object that is not a Card' ] ]
]

{ #category : #initializing }
InfiniteDealer class >> ofTypes: aCollectionOfTypes [ 
	self assertValidTypes: aCollectionOfTypes.
 	^self new initializeWith: aCollectionOfTypes 
]

{ #category : #adding }
InfiniteDealer >> addToDiscardDeck: aCard [ 
]

{ #category : #dealing }
InfiniteDealer >> dealInitialCardsTo: aSpaceshipName [
	| randomcard1 randomcard2 aSpaceship|
	randomcard1 := self dealOne.
	randomcard2 := self dealOne.
	^ aSpaceship := Spaceship named: aSpaceshipName containing: { 
			         randomcard1  .
			         randomcard2  }.
]

{ #category : #dealing }
InfiniteDealer >> dealOne [

	| randomcard |
	randomcard := typesOfCards atRandom.
	^ randomcard
]

{ #category : #initialization }
InfiniteDealer >> initializeWith: aCollectionOfTypes [

	typesOfCards := aCollectionOfTypes
]
