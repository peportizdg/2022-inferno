Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
ZathuraTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
ZathuraTest >> test01AGameOfZathuraInfernoCanBePlayedByTurnsTilFinishedWithRandomlyGeneratedBoardLayoutAndDies [

	| aCollectionOfSpaceships aBoard aCollectionOfSpots anEffectCreator lengthInParsecs aDiceCup aCollectionOfDice zathura aDie1 aDie2  aDictionaryWithEffectProbabilities aCardDealer |
	anEffectCreator := GameToolsFactory new.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: SpeedUp put: 20.
	aDictionaryWithEffectProbabilities at: Wormhole put: 20.
	aDictionaryWithEffectProbabilities at: AtomicBomb put: 2.
	aDictionaryWithEffectProbabilities at: Moonwalk put: 10.
	aDictionaryWithEffectProbabilities at: Hyperjump put: 8.
	aDictionaryWithEffectProbabilities at: CardPicker put: 10.
	aCollectionOfSpots := anEffectCreator
		                      createLayoutOf: 1000
		                      with: aDictionaryWithEffectProbabilities.

	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	lengthInParsecs := 100.
	aCardDealer := InfiniteDealer ofTypes: { 
			               SpeedCard new.
			               OverloadCard new. 
								RepeatCard new.
								RedoCard new.
								CancellationCard new.
								SpeedBoostCard new.
								AccelerationCard new}.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: lengthInParsecs
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := Die with: 7.
	aDie2 := Die with: 6.
	aCollectionOfDice := { 
		                     aDie1.
		                     aDie2 }.
	aDiceCup := DiceCup with: aCollectionOfDice.

	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard.
	[ zathura hasGameFinished ] whileFalse: [ zathura playNextTurn ].
	self assert: zathura hasGameFinished
]

{ #category : #tests }
ZathuraTest >> test02MovementByAnEffectDoesNotTriggerAnotherEffect [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
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
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.

	zathura := Zathura playWith: aDiceCup over: aBoard.
	expectedPosition := 6.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'Millenium Falcon'.
	self assert: positionOfSpaceship spotNumber equals: expectedPosition
]

{ #category : #tests }
ZathuraTest >> test03NoEffectDoesNotMovesAnySpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 5.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'Millenium Falcon'.
	self assert: positionOfSpaceship spotNumber equals: 6
]

{ #category : #tests }
ZathuraTest >> test04SpeedUpMovesASpaceshipFourSpotsForward [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'Millenium Falcon'.
	self assert: positionOfSpaceship spotNumber equals: 6
]

{ #category : #tests }
ZathuraTest >> test05WormHoleMovesASpaceshipFourSpotsBackwards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: Wormhole new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 5.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'Millenium Falcon'.
	self assert: positionOfSpaceship spotNumber equals: 2
]

{ #category : #tests }
ZathuraTest >> test06AtomicBombMovesAllTheSpacehipsToTheStartOfSameLap [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceshipA firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipB positionOfSpaceshipC exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: AtomicBomb new.


	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 2.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.

	positionOfSpaceshipA := zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipB := zathura positionOf: 'Millenium Falcon'.
	positionOfSpaceshipC := zathura positionOf: 'Razor Crest'.
	self assert: positionOfSpaceshipA spotNumber equals: 1.
	self assert: positionOfSpaceshipB spotNumber equals: 1.
	self assert: positionOfSpaceshipC spotNumber equals: 1
]

{ #category : #tests }
ZathuraTest >> test07ZathuraCanReturnFinalRankingsInCorrectOrder [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot  chequeoRankings exampleCardOne exampleCardTwo  firstExpectedPosition secondExpectedPosition thirdExpectedPosition aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	firstExpectedPosition := Position at: 1 on: 1.
	secondExpectedPosition := Position at: 0 on: 6.
	thirdExpectedPosition := Position at: 0 on: 6.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	chequeoRankings := zathura rankingOfSpaceships.
	self assert: (chequeoRankings at:1) name equals: 'Millenium Falcon'.
]

{ #category : #tests }
ZathuraTest >> test08PlayNextTurnDoesNotAllowSpaceshipToPlayWhenNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition seventhSpot error errorMessage invalidTurn exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp new.
	seventhSpot := Spot createWith: NoEffect new.

	error := Error.
	errorMessage := 'Cannot move that spaceship as it is not its turn.'.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot.
		                      seventhSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	expectedPosition := 7.
	invalidTurn := [zathura playTurn: 'SC30 StarFighter' ].
	self should: invalidTurn raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test09MoonwalkMovesEveryOtherSpaceshipAnAmountOfSpotsBackwards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceshipA firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipB positionOfSpaceshipThatTriggeredTheMoonwalk exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: (Moonwalk createWith: 1).

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 2.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.

	positionOfSpaceshipThatTriggeredTheMoonwalk := zathura positionOf: 'Millenium Falcon'.
	positionOfSpaceshipB := zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipA := zathura positionOf: 'Razor Crest'.
	self assert: positionOfSpaceshipA spotNumber equals: 2.
	self assert: positionOfSpaceshipB spotNumber equals: 2.
	self
		assert: positionOfSpaceshipThatTriggeredTheMoonwalk spotNumber
		equals: 5
]

{ #category : #tests }
ZathuraTest >> test10HyperJumpsMakesFirstJumpSeventeenLightyearsForward [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipThatJumps arrayOfJumps exampleCardOne exampleCardTwo   aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.

	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: {
			(Lightyear distanceOf: 17).
			(Parsec distanceOf: 4).
			(Parsec distanceOf: 6) }.
	secondSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).

	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	positionOfSpaceshipThatJumps := zathura positionOf:
		                                'Millenium Falcon'.
	self assert: positionOfSpaceshipThatJumps spotNumber equals: 5
]

{ #category : #tests }
ZathuraTest >> test11ZathuraDealsTwoCardsToEachSpaceshipToStart [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot spaceshipCards1 spaceshipCards2 exampleCardOne exampleCardTwo aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	spaceshipCards1 := (zathura handOf: 'Razor Crest').
	spaceshipCards2 := (zathura handOf: 'Millenium Falcon').
	self assert: spaceshipCards1 size equals: 2.
	self assert: spaceshipCards2 size equals: 2.
	
]

{ #category : #tests }
ZathuraTest >> test12SpaceshipCannotPlayCardIfItDoesNotHasItInHisHand [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse  aCardDealer |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use a card that is not present in that spaceships hand'.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	invalidCardUse := [
	                  zathura
		                  play: CancellationCard new
		                  by: 'Millenium Falcon'
		                  affecting: 'SC30 StarFighter' ].
	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test13AssertASpaceshipAppliesOverloadToAnotherOneAndDecreasesItsRollByTwo [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot exampleCardOne exampleCardTwo cardToPlay aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	cardToPlay := OverloadCard new.
	zathura
		play: cardToPlay
		by: 'Razor Crest'
		affecting: 'Millenium Falcon'.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 1
]

{ #category : #tests }
ZathuraTest >> test14AssertASpaceshipAppliesSpeedToAnotherOneAndIncreasesItsRollByOne [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot exampleCardOne exampleCardTwo cardToPlay aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.}.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	cardToPlay := SpeedCard new.
	zathura
		play: cardToPlay
		by: 'Razor Crest'
		affecting: 'Millenium Falcon'.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 4
]

{ #category : #tests }
ZathuraTest >> test15AssertASpaceshipAppliesAccelerationAndIncreasesRollByOneForEveryone [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot cardToPlay aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               AccelerationCard  new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay := AccelerationCard new.
	zathura accelerateAllWith: cardToPlay playedBy: 'Millenium Falcon'. "milenium acelera el juego"
	zathura playNextTurn. "milenium va al 3"
	zathura playNextTurn. " razor va al 3"
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 3.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 3.
	
]

{ #category : #tests }
ZathuraTest >> test16AssertASpaceshipCanRemoveAnOverloadCardUsingACancelationCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot  cardToPlay cardToPlay2 aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               CancellationCard new.
			               OverloadCard new.
								CancellationCard new.
			               OverloadCard new  }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	"millenium va a spot 2"
	zathura playNextTurn.
	"razor va a spot 2. queda turno de millenium"
	cardToPlay := OverloadCard new.
	"le aplica la overload"
	zathura
		play: cardToPlay
		by: 'Millenium Falcon'
		affecting: 'Razor Crest'.
	cardToPlay2 := CancellationCard new.
	zathura playNextTurn.
	"milenium se mueve a 3 y pasa el turno"
	zathura play: cardToPlay2 by: 'Razor Crest' affecting: {'Razor Crest'. cardToPlay }.
	"razor crest se aplica a si mismo una cancelacion para quitarse el overload "
	zathura playNextTurn. "razor se mueve a 3"
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 3.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 3.
	
]

{ #category : #tests }
ZathuraTest >> test17AssertASpaceshipUsesRepeatCardAndLastTriggeredEffectIsDoneAgainToItself [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               RepeatCard new.}.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := RepeatCard new.
	zathura
		play: cardToPlay
		by: 'Millenium Falcon'
		affecting: 'Millenium Falcon'.

	self
		assert: (zathura positionOf: 'Millenium Falcon') spotNumber
		equals: 5
]

{ #category : #tests }
ZathuraTest >> test18AssertASpaceshipRedoesSpeedCardUsingARedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot exampleCardOne exampleCardTwo fifthdSpot cardToPlay aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               SpeedCard new.
			               RedoCard new.
								SpeedCard new.
			               RedoCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := SpeedCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn."millenium se mueve al 1"
	cardToPlay := SpeedCard new.
	"razor se aplica a si mismo la speed card, aumentando su tirada en 1"
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.
	cardToPlay := RedoCard new.
	"razor se aplica a si mismo una reedo, aumentando su tirada en 1 mas osea 3"
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 4.
]

{ #category : #tests }
ZathuraTest >> test19AssertASpaceshipRedoesAccelerationCardUsingRedoCard [

| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot exampleCardOne exampleCardTwo fifthdSpot cardToPlay aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               AccelerationCard new.
			               RedoCard new.
								AccelerationCard new.
			               RedoCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := SpeedCard new.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn."millenium se mueve al 2"
	cardToPlay := AccelerationCard new.
	"razor acelera todo el juego"
	zathura accelerateAllWith: cardToPlay  playedBy: 'Razor Crest'.
	cardToPlay := RedoCard new.
	"razor repite carta, acelerando el juego una vez mas"
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.
	zathura playNextTurn. "razor mueve de 1 a 4"
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 4.
]

{ #category : #tests }
ZathuraTest >> test20AssertASpaceshipRedoesCancellationCardUsingRedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot aCardDealer cardToPlay cardToCancel |
	aCardDealer := LoadedDealer ofTypes: {
								RedoCard new.
								CancellationCard new.
			               OverloadCard new.
								SpeedCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay := OverloadCard new.
	"Millenium le aplica overload a razor crest"
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay := SpeedCard new.
	"en el mismo turno milenium se aplica a si mismo un speed"
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: 'Millenium Falcon'.
	"millenium se mueve a 3"
	zathura playNextTurn.
	"ahora, en el turno de razor crest, se cancela el speed del falcon"
	cardToPlay := CancellationCard new.
	cardToCancel := SpeedCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: {'Millenium Falcon'. cardToCancel }.
	cardToPlay := RedoCard new.
	cardToCancel := OverloadCard new.
	"en ese mismo turno hace un redo de la ultima carta para cancelar el overload
	aplicado sobre si mismo"
	zathura play: cardToPlay by: 'Razor Crest' affecting:  { 'Razor Crest'. cardToCancel. }.
	"se juega el turno entonces como ya no deberia tener efectos aplicados se moveria al 2"
	zathura playNextTurn .
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 2.
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 3.
	
]

{ #category : #tests }
ZathuraTest >> test21AssertASpaceshipRedoesRepeatCardUsingARedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               RepeatCard new.
								RedoCard new.
								RepeatCard new.
								RedoCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	"millenium pisa el speedUp effect y va a spot 1 lap 1"
	zathura playNextTurn.
	cardToPlay := RepeatCard new.
	"razor crest juega repeat card sobre si mismo, yendo a spot 5 lap 0"
	zathura
		play: cardToPlay
		by: 'Razor Crest'
		affecting: 'Razor Crest'.
	"luego tira un redo sobre si mismo , rehaciendo el speedup effecto, yendo a spot 3 lap 1"
	cardToPlay := RedoCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 4.
	self assert: (zathura positionOf: 'Razor Crest') lapNumber equals: 1.
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 1.
	self assert: (zathura positionOf: 'Millenium Falcon') lapNumber equals: 1.
]

{ #category : #tests }
ZathuraTest >> test22SpaceshipCanAskWhatCardsItHasInHand [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot  fifthdSpot spaceshipHand aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	spaceshipHand := zathura showCardsOnHandFor: 'Millenium Falcon'.
	self assert: spaceshipHand size equals: 2.
	
]

{ #category : #tests }
ZathuraTest >> test23CardPickerDealsARandomCardToTheTriggeringSpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot spaceshipHand aCardDealer |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: CardPicker new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn.
	spaceshipHand := zathura showCardsOnHandFor: 'Millenium Falcon'.
	self assert: spaceshipHand size equals: 3.
]

{ #category : #tests }
ZathuraTest >> test24SpaceshipCannotPlayPermanentCardWhenItIsNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse cardToUse aCardDealer |
	aCardDealer := InfiniteDealer ofTypes: {
			               SpeedCard new.
			               OverloadCard new }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use permanent card if it is not this spaceships  turn.'.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToUse := AccelerationCard new.
	invalidCardUse := [
	                  zathura
		                  currentSpaceshipPlaysCard: cardToUse
		                  playedBy: 'Razor Crest' ].

	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test25SpaceshipCannotUseRedoOfPermanentCardWhenItIsNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse cardToUse aCardDealer aRedoCard |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	aRedoCard := RedoCard new.
	error := Error.
	errorMessage := 'Cannot use redo card on a permanent if it is not this spaceships  turn.'.
	aCardDealer := LoadedDealer ofTypes: {
			               AccelerationCard new.
								RedoCard new.
								AccelerationCard new.
								RedoCard new.
								AccelerationCard new.
								RedoCard new.}.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToUse := AccelerationCard new.
	zathura
		currentSpaceshipPlaysCard: cardToUse
		playedBy: 'Millenium Falcon'.
	invalidCardUse := [
	                  zathura
		                  redoLastCardPlayedBy: 'SC30 StarFighter'
		                  with: aRedoCard ].
	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test26SpaceshipCannotUseRedoCardIfNoCardHasBeenPlayedYet [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse aCardDealer aRedoCard |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use redo card if nobody has played a card yet'.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aCardDealer := InfiniteDealer ofTypes: {
			               RedoCard new. }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	aRedoCard := RedoCard new.
	invalidCardUse := [
	                  zathura
		                  redoLastCardPlayedBy: 'Millenium Falcon'
		                  with: aRedoCard ].

	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test27SpaceshipCanCancelAnAccelerationCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot aCardDealer cardToUse1 cardsBeingAppliedToAllSpaceships spaceshipHand cardToUse2|
	aCardDealer := LoadedDealer ofTypes: {
			               AccelerationCard new.
			               CancellationCard new.
								AccelerationCard new.
			               CancellationCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.}.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToUse1 := AccelerationCard new.
	"millenium juega la acceleration"
	zathura accelerateAllWith: cardToUse1 playedBy: 'Millenium Falcon'.
	"luego la elimino de la flota"
	cardToUse2 := CancellationCard new.
	zathura cancelFleetCard: cardToUse1 with: cardToUse2 playedBy: 'Millenium Falcon'.
	cardsBeingAppliedToAllSpaceships := (aBoard getFleet) cardsBeingApplied .
	spaceshipHand := zathura showCardsOnHandFor: 'Millenium Falcon'.
	self assert: cardsBeingAppliedToAllSpaceships size equals: 0.
	self assert: spaceshipHand size equals: 0.
]

{ #category : #tests }
ZathuraTest >> test31AssertASpaceshipUsingSpeedBostOnASpeedCardDuplicatesItsEffect [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer cardToBoost |
	aCardDealer := LoadedDealer ofTypes: {
			               SpeedCard new.
			               SpeedBoostCard new.			               
								SpeedCard new.
			               SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := SpeedCard new.
	zathura play: cardToBoost by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay := SpeedBoostCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: {
			'Razor Crest'.
			cardToBoost }.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 4
]

{ #category : #tests }
ZathuraTest >> test32AssertASpaceshipUsingSpeedBostOnAOverloadDuplicatesItsEffect [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer cardToBoost |
	aCardDealer := LoadedDealer ofTypes: {
			               OverloadCard  new.
			               SpeedBoostCard new.			               
								OverloadCard new.
			               SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 5.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := OverloadCard new.
	zathura play: cardToBoost by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay := SpeedBoostCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: {
			'Razor Crest'.
			cardToBoost }.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 2.
]

{ #category : #tests }
ZathuraTest >> test33AssertASpaceshipUsingSpeedBostOnAccelerationCardDuplicatesItsEffect [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer cardToBoost |
	aCardDealer := LoadedDealer ofTypes: {
			               AccelerationCard new.
			               SpeedBoostCard new.			               
								AccelerationCard new.
			               SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := AccelerationCard new.
	zathura accelerateAllWith: cardToBoost  playedBy: 'Millenium Falcon'.
	cardToPlay := SpeedBoostCard new.
	zathura boostFleetCard: cardToBoost with: cardToPlay playedBy: 'Millenium Falcon'.
	zathura playNextTurn. "mf se mueve a 4"
	zathura playNextTurn. "razor crest se mueve a 4"
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 4.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 4.
]

{ #category : #tests }
ZathuraTest >> test34AssertThatIsNotPossibleToBoostInstantCards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot cardToBoost fifthdSpot cardToPlay aCardDealer errorBlock errorMessage error |
	aCardDealer := LoadedDealer ofTypes: {
			               RepeatCard new.
			               SpeedBoostCard new.
								RepeatCard new.
			               SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := RepeatCard new.
	zathura play: cardToBoost by: 'Razor Crest' affecting: 'Razor Crest'.
	cardToPlay := SpeedBoostCard new.
	errorBlock := [
	              zathura
		              play: cardToPlay
		              by: 'Razor Crest'
		              affecting: {
				              'General'.
				              cardToBoost } ].
	errorMessage := 'Cannot apply boost to instant card'.
	error := Error.
	self should: errorBlock raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test35AssertASpaceshipUsingSpeedBostOnAccelerationCardCanBeDuplicatedTwice [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer cardToBoost |
	aCardDealer := LoadedDealer ofTypes: {
			               AccelerationCard new.
			               SpeedBoostCard new.			               
			               AccelerationCard new.
								SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := AccelerationCard new.
	zathura accelerateAllWith: cardToBoost  playedBy: 'Millenium Falcon'.
	cardToPlay := SpeedBoostCard new.
	zathura boostFleetCard: cardToBoost with: cardToPlay playedBy: 'Millenium Falcon'.
	zathura playNextTurn. "mf se mueve a 4"
	zathura boostFleetCard: cardToBoost with: cardToPlay playedBy: 'Razor Crest'. "razor crest boostea tambien"
	zathura playNextTurn. "razor crest se mueve de 1 5 lugares, a spot 1 lap 1"
	self assert: (zathura positionOf: 'Millenium Falcon') spotNumber equals: 4.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 1.
	self assert: (zathura positionOf: 'Razor Crest') lapNumber equals: 1.
]

{ #category : #tests }
ZathuraTest >> test36AssertASpaceshipUsingSpeedBostOnSpeedCardCanBeDuplicatedTwice [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer cardToBoost |
	aCardDealer := LoadedDealer ofTypes: {
			               SpeedCard new.
			               SpeedBoostCard new.			               
			               SpeedCard new.
								SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := SpeedCard new.
	zathura play: cardToBoost by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay := SpeedBoostCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: {
			'Razor Crest'.
			cardToBoost }.
	zathura playNextTurn. "mf se mueve a 2"
	zathura play: cardToPlay by: 'Razor Crest' affecting: {
			'Razor Crest'.
			cardToBoost }. 
	zathura playNextTurn. "razor crest se mueve de 1 5 lugares, a spot 1 lap 1"
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 1.
	self assert: (zathura positionOf: 'Razor Crest') lapNumber equals: 1.
]

{ #category : #tests }
ZathuraTest >> test39AssertASpaceshipCannotPlayAnAccelerationCardOnSpecificShip [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer errorBlock errorMessage error |
	aCardDealer := InfiniteDealer ofTypes: {
			               AccelerationCard new.}.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay := AccelerationCard new.
	errorBlock := [
	              zathura
		              play: cardToPlay
		              by: 'Razor Crest'
		              affecting: 'Razor Crest' ].
	errorMessage := 'Cannot play that card on that target!.'.
	error := Error.
	self should: errorBlock raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test40WhenRanOutOfCardsTheDeckRenovatesItselfFromTheDiscardDeck [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot  fifthdSpot  aDictionaryWithCardsAndItsProbabilities aCardDealer toolsCreator cardToPlay |
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: RepeatCard put: 100.
	toolsCreator := GameToolsFactory new.
	aCardDealer := toolsCreator
		               createDealerOf: 4
		               with: aDictionaryWithCardsAndItsProbabilities.
	firstSpot := Spot createWith: CardPicker new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: CardPicker new.
	fourthdSpot := Spot createWith: CardPicker new.
	fifthdSpot := Spot createWith: CardPicker new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 5
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn. "mf pisa el speedup"
	zathura playNextTurn. "rc pisa el speedup"
	cardToPlay := RepeatCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'. "speedupea y se descarta"
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'. "speedupea y se juega y se descarta"
	self assert: ((aBoard dealer) amountOfDiscarded) equals: 2.
	zathura playNextTurn. "millenium vuelve a pisar speedup"
	zathura playNextTurn. "razor crest intenta pickear carta reseteando el discard, y agarrando una"
	self assert: ((aBoard dealer) amountOfCardsInDeck) equals: 1.
	self assert: ((aBoard dealer) amountOfDiscarded) equals: 0.
]

{ #category : #tests }
ZathuraTest >> test41WhenRanOutOfCardsTheDeckAndDiscardIsEmptyTooCardPickEffectDoesNotPickAny [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot  fifthdSpot  aDictionaryWithCardsAndItsProbabilities aCardDealer toolsCreator spaceshipHand |
	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: RepeatCard put: 100.
	toolsCreator := GameToolsFactory new.
	aCardDealer := toolsCreator
		               createDealerOf: 4
		               with: aDictionaryWithCardsAndItsProbabilities.
	firstSpot := Spot createWith: CardPicker new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: CardPicker new.
	fourthdSpot := Spot createWith: CardPicker new.
	fifthdSpot := Spot createWith: CardPicker new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 5
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn. "mf pisa el speedup"
	zathura playNextTurn. "rc pisa el speedup"
	"no se juega ninguna carta entonces no hay ninguna en discard deck ni deck"
	self assert: ((aBoard dealer) amountOfDiscarded) equals: 0.
	self assert: ((aBoard dealer) amountOfCardsInDeck) equals: 0.
	zathura playNextTurn. "mf pisa un card picker pero no hay cartas"
	spaceshipHand := zathura showCardsOnHandFor: 'Millenium Falcon'.
	self assert: spaceshipHand size equals: 2. "no agarra una tercera"
]

{ #category : #tests }
ZathuraTest >> test42PlayingAnOverloadCardAndThenCancellingSendsThoseTwoToDiscardDeck [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay1 cardToPlay2 aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               OverloadCard new.
			               CancellationCard new.
								OverloadCard new.
			               CancellationCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay1 := OverloadCard new.
	zathura play: cardToPlay1 by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay2 := CancellationCard new.
	zathura play: cardToPlay2 by: 'Millenium Falcon' affecting: {
			'Razor Crest'.
			cardToPlay1 }.
	self assert: aBoard dealer amountOfDiscarded equals: 2.
]

{ #category : #tests }
ZathuraTest >> test43PlayingASpeedCardAndThenCancellingSendsThoseTwoToDiscardDeck [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay1 cardToPlay2 aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               SpeedCard new.
			               CancellationCard new.
								SpeedCard new.
			               CancellationCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay1 := SpeedCard new.
	zathura play: cardToPlay1 by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay2 := CancellationCard new.
	zathura play: cardToPlay2 by: 'Millenium Falcon' affecting: {
			'Razor Crest'.
			cardToPlay1 }.
	self assert: aBoard dealer amountOfDiscarded equals: 2.
]

{ #category : #tests }
ZathuraTest >> test44PlayingASpeedBoostCardSendsJustOneToDiscardDeck [
| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay aCardDealer cardToBoost |
	aCardDealer := LoadedDealer ofTypes: {
			               OverloadCard  new.
			               SpeedBoostCard new.			               
								OverloadCard new.
			               SpeedBoostCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 5.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToBoost := OverloadCard new.
	zathura play: cardToBoost by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay := SpeedBoostCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: {
			'Razor Crest'.
			cardToBoost }.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: aBoard dealer amountOfDiscarded equals: 1
]

{ #category : #tests }
ZathuraTest >> test45PlayingARedoCardSendsJustOneToDiscardDeck [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay1 cardToPlay2 aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               SpeedCard new.
			               RedoCard new.
								SpeedCard new.
			               RedoCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay1 := SpeedCard new.
	zathura play: cardToPlay1 by: 'Millenium Falcon' affecting: 'Razor Crest'.
	cardToPlay2 := RedoCard new.
	zathura play: cardToPlay2 by: 'Millenium Falcon' affecting: 'Razor Crest'.
	self assert: aBoard dealer amountOfDiscarded equals: 1.
]

{ #category : #tests }
ZathuraTest >> test46PlayingARepeatCardSendsJustOneToDiscardDeck [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay1 aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               RepeatCard new.
			               RepeatCard new.
								RepeatCard new.
			               RepeatCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay1 := RepeatCard  new.
	zathura play: cardToPlay1 by: 'Millenium Falcon' affecting: 'Razor Crest'.
	self assert: aBoard dealer amountOfDiscarded equals: 1.
]

{ #category : #tests }
ZathuraTest >> test47PlayingAMovementCardWithOutCancellingDoesNotSendsItToTheDiscardDeck [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot fifthdSpot cardToPlay1 aCardDealer |
	aCardDealer := LoadedDealer ofTypes: {
			               OverloadCard new.
			               OverloadCard new.
								OverloadCard new.
			               OverloadCard new. }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := {
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	cardToPlay1 := OverloadCard new.
	zathura play: cardToPlay1 by: 'Millenium Falcon' affecting: 'Razor Crest'.
	self assert: aBoard dealer amountOfDiscarded equals: 0.
	self assert: (aBoard getSpaceshipByName: 'Razor Crest') cardsBeingApplied size equals: 1.
]

{ #category : #tests }
ZathuraTest >> test48AGameOfZathuraInfernoWithAFiniteDeckRunsOutOfCardsIfNeverPlayed [

	| aCollectionOfSpaceships aBoard aCollectionOfSpots toolsCreator lengthInParsecs aDiceCup aCollectionOfDice zathura aDie1 aDie2 aDictionaryWithEffectProbabilities aCardDealer aDictionaryWithCardsAndItsProbabilities errorBlock errorMessage error |
	toolsCreator := GameToolsFactory new.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: SpeedUp put: 20.
	aDictionaryWithEffectProbabilities at: Wormhole put: 20.
	aDictionaryWithEffectProbabilities at: AtomicBomb put: 2.
	aDictionaryWithEffectProbabilities at: Moonwalk put: 10.
	aDictionaryWithEffectProbabilities at: Hyperjump put: 8.
	aDictionaryWithEffectProbabilities at: CardPicker put: 10.
	aCollectionOfSpots := toolsCreator
		                      createLayoutOf: 1000
		                      with: aDictionaryWithEffectProbabilities.

	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	lengthInParsecs := 100.

	aDictionaryWithCardsAndItsProbabilities := Dictionary new.
	aDictionaryWithCardsAndItsProbabilities at: SpeedCard put: 15.
	aDictionaryWithCardsAndItsProbabilities at: OverloadCard put: 15.
	aDictionaryWithCardsAndItsProbabilities at: CancellationCard put: 15.
	aDictionaryWithCardsAndItsProbabilities at: RedoCard put: 10.
	aDictionaryWithCardsAndItsProbabilities at: SpeedBoostCard put: 15.
	aDictionaryWithCardsAndItsProbabilities at: RepeatCard put: 15.
	aDictionaryWithCardsAndItsProbabilities at: AccelerationCard put: 15.
	aCardDealer := toolsCreator
		               createDealerOf: 100
		               with: aDictionaryWithCardsAndItsProbabilities.

	aBoard := Board
		          with: aCollectionOfSpots
		          and: lengthInParsecs
		          playedFor: 3
		          by: aCollectionOfSpaceships
		          dealtBy: aCardDealer.
	aDie1 := Die with: 7.
	aDie2 := Die with: 6.
	aCollectionOfDice := {
		                     aDie1.
		                     aDie2 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	errorBlock := [
	              [ zathura hasGameFinished ] whileFalse: [
		              zathura playNextTurn ] ].
	errorMessage := 'Cannot pull a card as the deck is empty'.
	error := Error.
	self should: errorBlock raise: error withMessage: errorMessage
]
