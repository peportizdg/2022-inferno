"
I represent a type of card: redo
"
Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #assertions }
RedoCard >> assertThatIsACard [

	^ true
]

{ #category : #creating }
RedoCard >> createOwnAction [

	^ RedoAction new
]

{ #category : #testing }
RedoCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
