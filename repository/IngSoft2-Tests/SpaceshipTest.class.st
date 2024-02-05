Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
SpaceshipTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
SpaceshipTest >> test01ASpaceshipCanBeCreatedWithANameAndTwoCards [

	| aSpaceship exampleCardOne exampleCardTwo  |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	self assert: aSpaceship name equals: 'Razor Crest'
]

{ #category : #tests }
SpaceshipTest >> test02ACardCanBeAddedToASpaceshipHand [

	| aSpaceship exampleCardOne exampleCardTwo cardToAdd |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	cardToAdd := AccelerationCard new.
	aSpaceship addPickedCardToHand: cardToAdd.
	self assert: aSpaceship cardsOnHand equals: 3.
]

{ #category : #tests }
SpaceshipTest >> test03ASpaceshipCanReturnACardThatIsPresentInThatHand [

	| aSpaceship testHand exampleCardOne exampleCardTwo typeOfCardToTake testCard |
	testHand := Array new: 2.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	testCard := SpeedCard new.
	testHand at: 1 put: exampleCardOne.
	testHand at: 2 put: exampleCardTwo.
	typeOfCardToTake := SpeedCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	self
		assert: ((aSpaceship play: typeOfCardToTake) isSameTypeAs: testCard)
]

{ #category : #tests }
SpaceshipTest >> test04CardIsRemovedFromSpaceshipHandWhenPlayed [

	| aSpaceship exampleCardOne exampleCardTwo cardToPlay |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	cardToPlay := SpeedCard new.
	aSpaceship play: cardToPlay.
	self assert: aSpaceship cardsOnHand equals: 1
]

{ #category : #tests }
SpaceshipTest >> test05AnObjectIsNotAddedToSpaceshipsHandUnlessItIsACard [

	| aSpaceship exampleCardOne exampleCardTwo cardToAdd aCollectionOfSpots firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot aCollectionOfSpaceships aCardDealer errorBlock errorMsg error |
	aCardDealer := InfiniteDealer ofTypes: { SpeedCard new. OverloadCard new. }.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'testShipOne'. 'testShipTwo' }.
	cardToAdd := Board
		             with: aCollectionOfSpots
		             and: 100
		             playedFor: 3
		             by: aCollectionOfSpaceships
		             dealtBy: aCardDealer.
	errorBlock := [aSpaceship addPickedCardToHand: cardToAdd.].
	errorMsg := 'Instance of board did not understand assertThatIsACard'.
	error := Error.
	self should: errorBlock raise: error withMessage: errorMsg.
]

{ #category : #tests }
SpaceshipTest >> test06PlayingACardNotInThatSpaceshipHandRaisesAnError [

	| aSpaceship testHand exampleCardOne exampleCardTwo typeOfCardToTake testCard invalidMove error errorMsg |
	testHand := Array new: 2.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := SpeedCard  new.
	testCard := SpeedCard new.
	testHand at: 1 put: exampleCardOne.
	testHand at: 2 put: exampleCardTwo.
	typeOfCardToTake := OverloadCard new.
	error:= Error.
	errorMsg :='You cannot play a card you don''t have in your hand.'.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	invalidMove := [ aSpaceship play: typeOfCardToTake  ].
	self should: invalidMove raise: error withMessage: errorMsg 
]

{ #category : #tests }
SpaceshipTest >> test07ACardCanBeAppliedByASpaceshipToAnotherSpaceship [

	| aSpaceship exampleCardOne exampleCardTwo  targetSpaceship |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	targetSpaceship:= Spaceship named: 'Millenium Falcon' containing: { 
		exampleCardOne. 
		exampleCardTwo. }.
	aSpaceship useCard: exampleCardOne on: targetSpaceship.
	self assert: aSpaceship cardsOnHand equals: 1.
	self assert: (targetSpaceship cardsBeingApplied size) equals: 1.
]

{ #category : #tests }
SpaceshipTest >> test08ACardCanBeAppliedByASpaceshipOnItself [

	| aSpaceship exampleCardOne exampleCardTwo |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	aSpaceship useCard: exampleCardOne on: aSpaceship.
	self assert: aSpaceship cardsOnHand equals: 1.
	self assert: (aSpaceship cardsBeingApplied size) equals: 1.
]

{ #category : #tests }
SpaceshipTest >> test09ACardCanBeAppliedByASpaceshipToEntireFleet [

	| aSpaceship exampleCardOne exampleCardTwo testFleet |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aSpaceship := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	testFleet := Fleet create.
	aSpaceship useCard: exampleCardOne on: testFleet.
	self assert: aSpaceship cardsOnHand equals: 1.
	self assert: (testFleet cardsBeingApplied size) equals: 1.
]
