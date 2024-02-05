"
i represent an effect creator
"
Class {
	#name : #GameToolsFactory,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #randomCreation }
GameToolsFactory >> arrayOfJumpsCreator [

	| arrayOfJumps arraySize |
	arraySize := 10 atRandom.
	arrayOfJumps := OrderedCollection new.
	arraySize timesRepeat: [
		arrayOfJumps add: (Parsec distanceOf: 15 atRandom) ].
	^ arrayOfJumps
]

{ #category : #assertions }
GameToolsFactory >> assertAmountIsMoreThanZero: anAmountOfSpots [

	anAmountOfSpots > 0 ifFalse: [
		Error signal:
			'Cannot create a layout or deck with size zero or lower.' ]
]

{ #category : #layoutCreation }
GameToolsFactory >> assertCorrectProbabilities: aDictionaryWithEffectsAndItsProbabilities [

	(aDictionaryWithEffectsAndItsProbabilities values anySatisfy: [ :prob |
		 prob < 0 or: [ prob > 100 ] ]) ifTrue: [
		self error:
			'Invalid probabilities. Probabilities must be between 0 and 100.' ]
]

{ #category : #assertions }
GameToolsFactory >> assertProbabilitiesArePositive: eachProbability [

	eachProbability > 0 ifFalse: [ 
		Error signal: 'Effect or Cards probability cannot be zero or lower.' ]
]

{ #category : #asserting }
GameToolsFactory >> assertSumOfProbabilitiesIsOneHundred: sumOfProbabilities [

	sumOfProbabilities = 100 ifFalse: [
		Error signal: 'Sum of probabilities is not 100 percent.' ]
]

{ #category : #assertions }
GameToolsFactory >> assertSumOfProbabilitiesIsOneHundredOrLess: sumOfProbabilities [

	sumOfProbabilities <= 100 ifFalse: [
		Error signal: 'Sum of probabilities exceeds 100 percent.' ]
]

{ #category : #creation }
GameToolsFactory >> createDealerFor: anAmountOfCards using: aDictionaryWithCardsAndItsProbabilities [

	| deck dealer |
	deck := self
		        randomDeckCreatorOf: anAmountOfCards
		        with: aDictionaryWithCardsAndItsProbabilities.
	dealer := FiniteDealer createFor: deck.
	^ dealer
]

{ #category : #dealerCreation }
GameToolsFactory >> createDealerOf: anAmountOfObjects with: aDictionaryWithModificatorsAndItsProbabilities [

	| sumOfProbabilities |
	sumOfProbabilities := 0.
	self assertAmountIsMoreThanZero: anAmountOfObjects.
	aDictionaryWithModificatorsAndItsProbabilities valuesDo: [
		:eachProbability |
		self assertProbabilitiesArePositive: eachProbability.
		sumOfProbabilities := sumOfProbabilities + eachProbability ].
	self assertSumOfProbabilitiesIsOneHundred: sumOfProbabilities.
	self assertCorrectProbabilities:
		aDictionaryWithModificatorsAndItsProbabilities.
	^ self
		  createDealerFor: anAmountOfObjects
		  using: aDictionaryWithModificatorsAndItsProbabilities
]

{ #category : #layoutCreation }
GameToolsFactory >> createLayoutFor: anAmountOfSpots using: aDictionaryWithEffectsAndItsProbabilities [

	| layout remainingProbability noEffect |
	layout := OrderedCollection new.
	remainingProbability := 100.
	aDictionaryWithEffectsAndItsProbabilities associationsDo: [
		:association |
		| effect probability numberOfSpots |
		effect := association key.
		probability := association value.

		probability := probability min: remainingProbability.

		numberOfSpots := probability * anAmountOfSpots / 100 rounded.

		numberOfSpots timesRepeat: [
			| spotEffect |
			spotEffect := (effect class canUnderstand: #createWith:)
				              ifTrue: [
				              effect createWith: (self specialCreatorFor: effect) ]
				              ifFalse: [ effect new ].

			layout addLast: (Spot createWith: spotEffect) ].

		remainingProbability := remainingProbability - probability ].
	noEffect := NoEffect new.
	remainingProbability timesRepeat: [
		layout addLast: (Spot createWith: noEffect) ].
	layout shuffle.

	^ layout
]

{ #category : #creation }
GameToolsFactory >> createLayoutOf: anAmountOfObjects with: aDictionaryWithModificatorsAndItsProbabilities [

	| sumOfProbabilities |
	sumOfProbabilities := 0.
	self assertAmountIsMoreThanZero: anAmountOfObjects.
	aDictionaryWithModificatorsAndItsProbabilities valuesDo: [ :eachProbability | 
		self assertProbabilitiesArePositive: eachProbability.
		sumOfProbabilities := sumOfProbabilities + eachProbability ].
	self assertSumOfProbabilitiesIsOneHundredOrLess: sumOfProbabilities.
	self assertCorrectProbabilities:
		aDictionaryWithModificatorsAndItsProbabilities.
	^ self
		  createLayoutFor: anAmountOfObjects
		  using: aDictionaryWithModificatorsAndItsProbabilities
]

{ #category : #randomCreation }
GameToolsFactory >> moonwalkNumberCreator [

	^ 10 atRandom
]

{ #category : #creation }
GameToolsFactory >> randomDeckCreatorOf: anAmountOfCards with: aDictionaryWithCardsAndItsProbabilities [

	| deck |
	deck := OrderedCollection new: anAmountOfCards.
	aDictionaryWithCardsAndItsProbabilities associationsDo: [
		:association |
		| card probability numberOfCards newCard |
		card := association key.
		probability := association value.
		numberOfCards := probability * anAmountOfCards / 100 rounded.
		numberOfCards timesRepeat: [
			newCard := card new.
			deck addLast: newCard ].
		deck shuffle ].
	^ deck
]

{ #category : #layoutCreation }
GameToolsFactory >> specialCreatorFor: anEffect [

	anEffect class = Moonwalk class ifTrue: [
		^ self moonwalkNumberCreator ].
	anEffect class = Hyperjump class ifTrue: [
		^ self arrayOfJumpsCreator ]
]
