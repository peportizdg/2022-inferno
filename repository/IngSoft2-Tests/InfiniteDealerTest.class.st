Class {
	#name : #InfiniteDealerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
InfiniteDealerTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #asserting }
InfiniteDealerTest >> test01ADealerCanBeCreatedWithAtLeastOneTypeOfCard [

	| aCollectionOfTypes cardDealer |
	aCollectionOfTypes := { SpeedCard new. }.
	cardDealer := InfiniteDealer ofTypes: aCollectionOfTypes.
	self assert: (cardDealer dealOne) assertThatIsACard .
]

{ #category : #asserting }
InfiniteDealerTest >> test02ADealerCannotBeCreatedWithAnEmptyArrayOfTypes [

	| aCollectionOfTypes cardDealer error errorMessage |
	aCollectionOfTypes := { SpeedCard new. }.
	cardDealer := [InfiniteDealer ofTypes: aCollectionOfTypes].
	error := Error.
	errorMessage := 'Cannot create a card dealer with no types of cards '.
	self should: cardDealer raise: error withMessage: errorMessage.
]

{ #category : #asserting }
InfiniteDealerTest >> test03ADealerCannotBeCreatedWithAnArrayThatContainsAnythingButCards [

	| aCollectionOfTypes cardDealer error errorMessage |
	aCollectionOfTypes := { SpeedCard new. Die new. }.
	cardDealer := [InfiniteDealer ofTypes: aCollectionOfTypes].
	error := Error.
	errorMessage := 'Array contains an object that is not a Card '.
	self should: cardDealer raise: error withMessage: errorMessage.
]

{ #category : #asserting }
InfiniteDealerTest >> test04ADealerReturnsARandomCardIfIntializedWithSeveralTypes [

	| aCollectionOfTypes cardDealer |
	aCollectionOfTypes := { SpeedCard new. OverloadCard  new. }.
	cardDealer := [InfiniteDealer ofTypes: aCollectionOfTypes].
	cardDealer := InfiniteDealer ofTypes: aCollectionOfTypes.
	self assert: (cardDealer dealOne) assertThatIsACard .
]

{ #category : #asserting }
InfiniteDealerTest >> test05ADealerReturnsSpaceshipWithInitialHandSetted [

	| aCollectionOfTypes cardDealer |
	aCollectionOfTypes := { SpeedCard new. OverloadCard  new. }.
	cardDealer := [InfiniteDealer ofTypes: aCollectionOfTypes].
	cardDealer := InfiniteDealer ofTypes: aCollectionOfTypes.
	self assert: (cardDealer dealInitialCardsTo: 'Razor Crest' ) cardsOnHand equals: 2.
]
