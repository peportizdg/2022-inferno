"
I represent a test class, like dealer, but it gives one of each card not at random so it can be tested. I must be passed the exact amount of cards to be dealed and once dealed to a spaceship, it will be deleted from types.
"
Class {
	#name : #LoadedDealer,
	#superclass : #Object,
	#instVars : [
		'discardDeck',
		'deck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDealer class >> assertValidTypes: aCollectionOfTypes [ 
	aCollectionOfTypes isNotEmpty ifFalse:[ 
					Error signal:
			'Cannot create a card dealer with no types of cards ' ].
			aCollectionOfTypes do: [:eachCard | 
			(eachCard assertThatIsACard) ifFalse: [
				Error signal: 'Array contains an object that is not a Card'
			]].
]

{ #category : #initializing }
LoadedDealer class >> ofTypes: aCollectionOfTypes [ 
	self assertValidTypes: aCollectionOfTypes.
 	^self new initializeWith: aCollectionOfTypes 
]

{ #category : #adding }
LoadedDealer >> addToDiscardDeck: aCard [ 
	discardDeck addLast: aCard.
]

{ #category : #getters }
LoadedDealer >> amountOfCardsInDeck [
	^ deck size
]

{ #category : #dealing }
LoadedDealer >> amountOfDiscarded [
	^ discardDeck size.
]

{ #category : #asserting }
LoadedDealer >> assertDeckIsNotEmpty [

	deck isEmptyOrNil ifTrue: [
		discardDeck isEmptyOrNil
			ifTrue: [ deck addLast: nil ]
			ifFalse: [
				deck := discardDeck shuffled.
				discardDeck := OrderedCollection new ] ]
]

{ #category : #dealing }
LoadedDealer >> dealInitialCardsTo: aSpaceshipName [
    | card1 card2 aSpaceship availableCards |
    
    card1 := deck at: 1.
    card2 := deck at: 2.
    availableCards := deck copy. 
    aSpaceship := Spaceship named: aSpaceshipName containing: { 
        card1. 
        card2.
    }.
    availableCards := availableCards copyWithoutAll: { card1. card2 }.
    deck := availableCards.
    ^ aSpaceship.


]

{ #category : #dealing }
LoadedDealer >> dealOne [
	self assertDeckIsNotEmpty.
	^ deck removeLast.
]

{ #category : #initialization }
LoadedDealer >> initializeWith: aCollectionOfTypes [
	deck := aCollectionOfTypes.
	discardDeck := OrderedCollection new.
]
