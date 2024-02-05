"
i represent a type of card: overload
"
Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertions }
OverloadCard >> assertThatIsACard [

	^ true
]

{ #category : #boosting }
OverloadCard >> boost [

	effect := effect * 2
]

{ #category : #creating }
OverloadCard >> createOwnAction [

	^ MovementAction new
]

{ #category : #redoer }
OverloadCard >> createOwnRedoAction [

	^ RedoMovementAction new
]

{ #category : #effect }
OverloadCard >> effectOnPlay [

	^ effect.
]

{ #category : #initialization }
OverloadCard >> initialize [

	effect := -2
]

{ #category : #testing }
OverloadCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
