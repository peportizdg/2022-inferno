Class {
	#name : #FiniteDealerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
FiniteDealerTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [ 

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #asserting }
FiniteDealerTest >> test01AFiniteDeckOfOneCardCanBeCreated [ 

	| aDeckCreator aDictionaryWithCardsAndItsProbabilities finiteDeck testCard |
	aDeckCreator := GameToolsFactory new.
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: SpeedCard put: 100.
	finiteDeck := aDeckCreator createDealerOf: 1 with: aDictionaryWithCardsAndItsProbabilities.
	testCard := SpeedCard new.
	self assert: ((finiteDeck dealOne) isSameTypeAs: testCard).
]

{ #category : #asserting }
FiniteDealerTest >> test02AFiniteDeckCanDealInitialHandsToASpaceship [ 

	| aDeckCreator aDictionaryWithCardsAndItsProbabilities finiteDeck testCard testCard2 |
	aDeckCreator := GameToolsFactory new.
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: SpeedCard put: 50.
	aDictionaryWithCardsAndItsProbabilities at: OverloadCard put: 50.
	finiteDeck := aDeckCreator createDealerOf: 100 with: aDictionaryWithCardsAndItsProbabilities.
	testCard := SpeedCard new.
	testCard2 := OverloadCard new.
	self assert: (finiteDeck dealInitialCardsTo: 'Razor Crest') cardsOnHand  equals:2
]

{ #category : #asserting }
FiniteDealerTest >> test03AFiniteDeckDecreasesInAmountOfCardsIfDealingThem [ 

	| aDeckCreator aDictionaryWithCardsAndItsProbabilities finiteDeck aHand |
	aDeckCreator := GameToolsFactory new.
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: SpeedCard put: 100.

	finiteDeck := aDeckCreator createDealerOf: 10 with: aDictionaryWithCardsAndItsProbabilities.
	aHand := finiteDeck dealInitialCardsTo: 'Razor Crest' .
	self assert: (finiteDeck amountOfCardsInDeck ) equals: 8.
	self assert: (finiteDeck amountOfDiscarded) equals: 0.
	self assert: (aHand cardsOnHand) equals: 2.
]
