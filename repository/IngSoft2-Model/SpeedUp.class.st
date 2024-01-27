"
i represent a type of effect: speedup
"
Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedUp >> applyTo: aBoard by: aSpaceship [

	| speedUpNumber |
	speedUpNumber := 4.
	aBoard executeASpeedUpTo: aSpaceship of: speedUpNumber
]
