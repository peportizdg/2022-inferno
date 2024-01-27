"
i represent a hand. a collection of cards owned by a specific spaceship in zathura game
"
Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'hand',
		'name',
		'cardsBeingApplied'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Spaceship class >> assertThatCollectionIsAllCards: aCollectionOfCards [

	(aCollectionOfCards anySatisfy: [ :card | card assertThatIsACard not ])
		ifTrue: [
			Error signal:
				'Cant have a hand containing anything but a type of card.' ]
]

{ #category : #'class initialization' }
Spaceship class >> named: aString containing: aCollectionOfCards [

	self assertThatCollectionIsAllCards: aCollectionOfCards.
	^ self new initialize: aString containing: aCollectionOfCards
]

{ #category : #playing }
Spaceship >> addPickedCardToHand: aCard [

	aCard assertThatIsACard.
	 hand addLast: aCard .
	^ aCard
]

{ #category : #playing }
Spaceship >> assertCardIsOnHand: cardToPlay [

	cardToPlay ifNil: [ 
		Error signal: 'Spaceship does not have a card of that type' ]
]

{ #category : #'editing keys' }
Spaceship >> cancel: aCardToBeCancelled [

	| cardToRemove |
	cardToRemove := cardsBeingApplied
		                detect: [ :eachCard |
		                eachCard isSameTypeAs: aCardToBeCancelled ]
		                ifNone: [
			                Error signal:
				                'Cant cancel a card not being applied to target spaceship.' ].
	cardsBeingApplied remove: cardToRemove
]

{ #category : #accessing }
Spaceship >> cardsBeingApplied [

	^ cardsBeingApplied
]

{ #category : #getter }
Spaceship >> cardsOnHand [

	^ hand size
]

{ #category : #cardUsing }
Spaceship >> getsApplied: aCard [

	cardsBeingApplied add: aCard
]

{ #category : #getter }
Spaceship >> hand [

	^ hand
]

{ #category : #initialization }
Spaceship >> initialize: aString containing: aCollectionOfCards [

	name := aString.
	hand := OrderedCollection new.
	cardsBeingApplied := OrderedCollection new.
	hand addAllFirst: aCollectionOfCards.
	^ self
]

{ #category : #accessing }
Spaceship >> name [

	^ name
]

{ #category : #playing }
Spaceship >> play: aCard [

	^ hand
		  detect: [ :eachCard | eachCard isSameTypeAs: aCard ]
		  ifFound: [ :cardToPlay | hand remove: cardToPlay ]
		  ifNone: [
		  Error signal: 'You cannot play a card you dont have in your hand.' ]
]

{ #category : #cardUsing }
Spaceship >> useCard: aCard on: targetSpaceship [

	self play: aCard.
	targetSpaceship getsApplied: aCard.
	^ aCard
]
