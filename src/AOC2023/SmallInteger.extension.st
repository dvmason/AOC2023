Extension { #name : 'SmallInteger' }

{ #category : '*AOC2023' }
SmallInteger >> trialsBetterThan: time [ 
	| count |
	count := 0.
	1 to: self do: [ :n |
		n*(self-n) > time ifTrue: [ count := count + 1 ]
		 ].
	^ count
]
