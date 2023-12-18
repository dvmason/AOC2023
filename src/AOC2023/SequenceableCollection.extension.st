Extension { #name : 'SequenceableCollection' }

{ #category : '*AOC2023' }
SequenceableCollection >> day13a [
	^ self mirrorPosition ifNil: [
					          (self transposed mirrorPosition ifNil: [0])* 100 ]
]

{ #category : '*AOC2023' }
SequenceableCollection >> day13a: previous [

	^ self mirrorPosition ifNil: [
		  (self transposed mirrorPosition ifNil: [ 0 ]) * 100 ] ifNotNil: [ : new | new = previous ifTrue: [ (self transposed mirrorPosition ifNil: [ 0 ]) * 100 ] ]
]

{ #category : '*AOC2023' }
SequenceableCollection >> day13b [

	| day13a |
	day13a := self day13a.
	self do: [ :row |
		1 to: row size do: [ :col |
			| original day13b |
			original := row at: col.
			row at: col put: (original = $.
					 ifTrue: [ $# ]
					 ifFalse: [ $. ]).
			day13b := self day13a: day13a.
			day13b isZero ifFalse: [
				day13b = day13a ifFalse: [
					self halt.
					^ day13b ] ].
			row at: col put: original ] ].
	self halt
]

{ #category : '*AOC2023' }
SequenceableCollection >> mirrorPosition [

	| positions |
	positions := Set new.
	self do: [ :each | each mirrorsInto: positions ].
	^ positions
		  detect: [ :position |
		  self allSatisfy: [ :row | row mirroredAt: position ] ]
		  ifNone: [ nil ] 
]

{ #category : '*AOC2023' }
SequenceableCollection >> mirroredAt: position [ 
	1 to: (position min: self size - position) do: [ :index| (self at: position - index + 1) = (self at: position + index) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : '*AOC2023' }
SequenceableCollection >> mirrorsInto: aCollection [ 
	1 to: self size - 1 do: [ :index| (self mirroredAt: index) ifTrue: [ aCollection add: index ] ]
]

{ #category : '*AOC2023' }
SequenceableCollection >> transposed [
	^ self first asArray collectWithIndex: [ : ignored : index |
		self first class streamContents: [ :s| self do: [ :each| s nextPut: (each at: index) ] ] ]
]
