"
Abstract class that represents a card to be played in a game of zathura.
"
Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Card >> assertThatIsACard [

	^ true
]

{ #category : #creating }
Card >> createOwnAction [
    "Abstract method - to be implemented by concrete subclasses"
    self subclassResponsibility.
]

{ #category : #applying }
Card >> createOwnRedoAction [
	^ self subclassResponsibility
]

{ #category : #testing }
Card >> isSameTypeAs: aCard [

	^ self class = aCard class
]
