Class {
	#name : #TurnControllerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnControllerTest >> test01TurnControllerKeepsTrackOfTurns [

	| aTurnController spaceshipsPositions initialPosition exampleCardOne exampleCardTwo razorCrest sc30StarFighter milleniumFalcon |
	initialPosition := Position at: 0 on: 1.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	razorCrest := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	sc30StarFighter := Spaceship named: 'SC30 StarFighter' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	milleniumFalcon := Spaceship named: 'Millenium Falcon' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.

	spaceshipsPositions := Dictionary new: 3.
	spaceshipsPositions at: razorCrest put: initialPosition.
	spaceshipsPositions at: sc30StarFighter put: initialPosition.
	spaceshipsPositions at: milleniumFalcon put: initialPosition.
	aTurnController := TurnController with: spaceshipsPositions.
	self
		assert: (aTurnController activeSpaceship) name
		equals: 'Millenium Falcon'
]

{ #category : #tests }
TurnControllerTest >> test02CanChangeActiveSpaceshipToTheNextOne [

	| aTurnController spaceshipsPositions initialPosition exampleCardOne exampleCardTwo razorCrest sc30StarFighter milleniumFalcon |
	initialPosition := Position at: 0 on: 1.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	razorCrest := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	sc30StarFighter := Spaceship named: 'SC30 StarFighter' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	milleniumFalcon := Spaceship named: 'Millenium Falcon' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.

	spaceshipsPositions := Dictionary new: 3.
	spaceshipsPositions at: razorCrest put: initialPosition.
	spaceshipsPositions at: sc30StarFighter put: initialPosition.
	spaceshipsPositions at: milleniumFalcon put: initialPosition.
	aTurnController := TurnController with: spaceshipsPositions.
	aTurnController nextSpaceshipInLine.
	self assert: (aTurnController activeSpaceship) name equals: 'Razor Crest'
]

{ #category : #tests }
TurnControllerTest >> test03CanChangeToFirstSpacehipWhenReachedTheLastOne [

	| aTurnController spaceshipsPositions initialPosition exampleCardOne exampleCardTwo razorCrest sc30StarFighter milleniumFalcon |
initialPosition := Position at: 0 on: 1.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	razorCrest := Spaceship named: 'Razor Crest' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	sc30StarFighter := Spaceship named: 'SC30 StarFighter' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	milleniumFalcon := Spaceship named: 'Millenium Falcon' containing: { 
			         exampleCardOne.
			         exampleCardTwo }.

	spaceshipsPositions := Dictionary new: 3.
	spaceshipsPositions at: razorCrest put: initialPosition.
	spaceshipsPositions at: sc30StarFighter put: initialPosition.
	spaceshipsPositions at: milleniumFalcon put: initialPosition.
	aTurnController := TurnController with: spaceshipsPositions.
	aTurnController nextSpaceshipInLine.
	aTurnController nextSpaceshipInLine.
	aTurnController nextSpaceshipInLine.
	self
		assert: (aTurnController activeSpaceship) name
		equals: 'Millenium Falcon'
]
