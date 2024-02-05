"
i represent a type of card: cancellation

"
Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #assertions }
CancellationCard >> assertThatIsACard [

	^ true
]

{ #category : #creating }
CancellationCard >> createOwnAction [

	^ CancellationAction new
]

{ #category : #redoer }
CancellationCard >> createOwnRedoAction [

	^ RedoCancellationAction new
]

{ #category : #testing }
CancellationCard >> isSameTypeAs: aCard [

	^ self class = aCard class
]
