"
i represent a type of card: acceleration
"
Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertions }
AccelerationCard >> assertThatIsACard [

	^ true
]

{ #category : #boosting }
AccelerationCard >> boost [

	effect := effect * 2
]

{ #category : #creating }
AccelerationCard >> createOwnAction [

	^ AccelerationAction new
]

{ #category : #applying }
AccelerationCard >> createOwnRedoAction [

	^ RedoAccelerationAction new
]

{ #category : #assertions }
AccelerationCard >> effectOnPlay [

	^ effect.
]

{ #category : #initialization }
AccelerationCard >> initialize [

	effect := 1
]

{ #category : #testing }
AccelerationCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
