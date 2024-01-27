"
i represent a type of card: repeat
"
Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
RepeatCard >> assertThatIsACard [

	^ true
]

{ #category : #creating }
RepeatCard >> createOwnAction [

	^ RepeatAction new
]

{ #category : #redoer }
RepeatCard >> createOwnRedoAction [

	^ RedoRepeatAction new
]

{ #category : #testing }
RepeatCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
