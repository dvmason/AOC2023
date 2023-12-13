Extension { #name : 'Point' }

{ #category : '*AOC2023' }
Point >> manhattanDistanceTo: aPoint [ 
	^ (self x - aPoint x) abs + (self y - aPoint y) abs
]
