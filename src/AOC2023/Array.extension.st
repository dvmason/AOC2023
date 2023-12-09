Extension { #name : 'Array' }

{ #category : '*AOC2023' }
Array >> day09a [
	(self allSatisfy: #isZero) ifTrue: [ ^ 0 ].
	^ self last + (self allButFirst with: self allButLast collect: [ : l : r | l - r ]) day09a
]

{ #category : '*AOC2023' }
Array >> day09b [

	(self allSatisfy: #isZero) ifTrue: [ ^ 0 ].
	^ self first
	  -
		  (self allButFirst with: self allButLast collect: [ :l :r | l - r ])
			  day09b
]
