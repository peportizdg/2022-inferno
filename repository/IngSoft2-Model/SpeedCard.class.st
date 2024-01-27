"
i represent a type of card, speed
"
Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertions }
SpeedCard >> assertThatIsACard [

	^ true
]

{ #category : #boosting }
SpeedCard >> boost [

	effect := effect * 2
]

{ #category : #creating }
SpeedCard >> createOwnAction [

	^ MovementAction new
]

{ #category : #redoer }
SpeedCard >> createOwnRedoAction [

	^ RedoMovementAction new
]

{ #category : #playing }
SpeedCard >> effectOnPlay [

	^ effect
]

{ #category : #initialization }
SpeedCard >> initialize [

	effect := 1
]

{ #category : #testing }
SpeedCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
