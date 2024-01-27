Class {
	#name : #GameToolsFactoryTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameToolsFactoryTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
GameToolsFactoryTest >> test01GTFCreatesACollectionOfSpotsOfGivenSize [

	| boardLayout amountOfSpots aDictionaryWithModificatorsAndItsProbabilities layoutCreator |
	amountOfSpots := 100.
	layoutCreator := GameToolsFactory new.
	aDictionaryWithModificatorsAndItsProbabilities := Dictionary new.
	aDictionaryWithModificatorsAndItsProbabilities at: SpeedUp put: 20.
	aDictionaryWithModificatorsAndItsProbabilities at: Wormhole put: 20.
	aDictionaryWithModificatorsAndItsProbabilities at: AtomicBomb put: 2.
	aDictionaryWithModificatorsAndItsProbabilities at: Moonwalk put: 10.
	aDictionaryWithModificatorsAndItsProbabilities at: Hyperjump  put: 8.
	aDictionaryWithModificatorsAndItsProbabilities at: CardPicker put: 10.
	boardLayout := layoutCreator createLayoutOf: amountOfSpots with: aDictionaryWithModificatorsAndItsProbabilities .
	self assert: boardLayout size equals: amountOfSpots
]

{ #category : #tests }
GameToolsFactoryTest >> test02GTFCreatesACollectionOfSpotsFilledWithSpeedUps [

	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator efectoEnSpot |
	anEffectCreator := GameToolsFactory new.
	amountOfSpots := 20.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: SpeedUp put: 100.

	boardLayout := anEffectCreator
		               createLayoutOf: amountOfSpots
		               with: aDictionaryWithEffectProbabilities.
	efectoEnSpot:=(boardLayout at: 2) effectAtSpot.
	self assert: (efectoEnSpot isKindOf: SpeedUp ) .
]

{ #category : #tests }
GameToolsFactoryTest >> test03GTFCreatesACollectionOfSpotsFilledWithAtomicBombs [

	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator efectoEnSpot |
	anEffectCreator := GameToolsFactory new.
	amountOfSpots := 20.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: AtomicBomb put: 100.

	boardLayout := anEffectCreator
		               createLayoutOf: amountOfSpots
		               with: aDictionaryWithEffectProbabilities.
	efectoEnSpot:=(boardLayout at: 2) effectAtSpot.
	self assert: (efectoEnSpot isKindOf: AtomicBomb ) .
]

{ #category : #tests }
GameToolsFactoryTest >> test04GTFCreatesACollectionOfSpotsFilledWithCardPickers [

	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator efectoEnSpot |
	anEffectCreator := GameToolsFactory new.
	amountOfSpots := 20.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: CardPicker  put: 100.

	boardLayout := anEffectCreator
		               createLayoutOf: amountOfSpots
		               with: aDictionaryWithEffectProbabilities.
	efectoEnSpot:=(boardLayout at: 2) effectAtSpot.
	self assert: (efectoEnSpot isKindOf: CardPicker  ) .
]

{ #category : #tests }
GameToolsFactoryTest >> test05GTFCreatesACollectionOfSpotsFilledWithWormHoles [

	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator efectoEnSpot |
	anEffectCreator := GameToolsFactory new.
	amountOfSpots := 20.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: Wormhole  put: 100.

	boardLayout := anEffectCreator
		               createLayoutOf: amountOfSpots
		               with: aDictionaryWithEffectProbabilities.
	efectoEnSpot:=(boardLayout at: 2) effectAtSpot.
	self assert: (efectoEnSpot isKindOf: Wormhole  ) .
]

{ #category : #tests }
GameToolsFactoryTest >> test06GTFCreatesACollectionOfSpotsFilledWithNoEffectsIfNotGivenElse [

	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator efectoEnSpot |
	anEffectCreator := GameToolsFactory new.
	amountOfSpots := 20.
	aDictionaryWithEffectProbabilities := Dictionary new.

	boardLayout := anEffectCreator
		               createLayoutOf: amountOfSpots
		               with: aDictionaryWithEffectProbabilities.
	efectoEnSpot:=(boardLayout at: 2) effectAtSpot.
	self assert: (efectoEnSpot isKindOf: NoEffect  ) .
]

{ #category : #tests }
GameToolsFactoryTest >> test07GTFCreatesACollectionOfSpotsFilledWithMoonwalk [

	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator efectoEnSpot |
	anEffectCreator := GameToolsFactory new.
	amountOfSpots := 20.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: Moonwalk   put: 100.

	boardLayout := anEffectCreator
		               createLayoutOf: amountOfSpots
		               with: aDictionaryWithEffectProbabilities.
	efectoEnSpot:=(boardLayout at: 2) effectAtSpot.
	self assert: (efectoEnSpot isKindOf: Moonwalk  ) .
]

{ #category : #tests }
GameToolsFactoryTest >> test08GTFCreatesAFiniteCardDealer [

	| aDealerCreator aDictionaryWithCardsAndItsProbabilities finiteDealer testCard amountOfCards|
	aDealerCreator := GameToolsFactory new.
	amountOfCards := 1.
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: SpeedCard put: 100.
	finiteDealer := aDealerCreator createDealerOf: amountOfCards with: aDictionaryWithCardsAndItsProbabilities.
	testCard := SpeedCard new.
	self assert: ((finiteDealer dealOne) isSameTypeAs: testCard).
]

{ #category : #tests }
GameToolsFactoryTest >> test09GTFCannotCreateDeckIfProbabilitiesDoNotAddOneHundred [

	| aDealerCreator aDictionaryWithCardsAndItsProbabilities finiteDealer  amountOfCards error errorMessage errorBlock|
	error := Error.
	errorMessage := 'Sum of probabilities is not 100 percent.'.
	aDealerCreator := GameToolsFactory new.
	amountOfCards := 1.
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: SpeedCard put: 90.
	errorBlock:= [  finiteDealer := aDealerCreator createDealerOf: amountOfCards with: aDictionaryWithCardsAndItsProbabilities]. 
	self should: errorBlock raise: error withMessage: errorMessage.

]

{ #category : #tests }
GameToolsFactoryTest >> test10GTFCannotCreateLayoutIfProbabilitiesAreMoreThanOneHundred [

	| factory aDictionaryWithEffectsAndItsProbabilities  amountOfEffects error errorMessage errorBlock layout|
	error := Error.
	errorMessage := 'Sum of probabilities is not 100 percent.'.
	factory := GameToolsFactory new.
	amountOfEffects := 1.
	aDictionaryWithEffectsAndItsProbabilities := Dictionary new.
	aDictionaryWithEffectsAndItsProbabilities at: SpeedUp put: 101.
	errorBlock := [layout := factory createLayoutOf: amountOfEffects with: aDictionaryWithEffectsAndItsProbabilities. ].
	self should: errorBlock raise: error  withMessage: errorMessage 
]
