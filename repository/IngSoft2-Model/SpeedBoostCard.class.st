"
I represent a SpeedBost Card
"
Class {
	#name : #SpeedBoostCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpeedBoostCard class >> assertThatIsACard [

	^ true
]

{ #category : #comparing }
SpeedBoostCard >> assertThatIsACard [

	^ true
]

{ #category : #creating }
SpeedBoostCard >> createOwnAction [

	^ SpeedBoostAction new
]

{ #category : #testing }
SpeedBoostCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
