"
I represent the abstract class of Effect. a series of effects are loaded into an specific spot, and modifies spaceships positions.
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Effect >> applyTo: aBoard by: aSpaceship [
	
	self subclassResponsibility.
]
