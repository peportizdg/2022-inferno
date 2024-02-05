"
i represent a type of effect: wormhole
"
Class {
	#name : #Wormhole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Wormhole >> applyTo: aBoard by: aSpaceship [

	| wormholeNumber |
	wormholeNumber := -4.
	aBoard executeAWormholeTo: aSpaceship of: wormholeNumber
]
