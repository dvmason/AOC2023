"
I am the implementation of [Advent of Code 2023](https://adventofcode.com/2023)
"
Class {
	#name : 'AOC',
	#superclass : 'Object',
	#instVars : [
		'array'
	],
	#category : 'AOC2023-Base',
	#package : 'AOC2023',
	#tag : 'Base'
}

{ #category : 'AdventOfCode' }
AOC class >> day01a: aString [

	^ aString lines inject: 0 into: [ :sum :line |
		  | first last |
		  line do: [ :c |
			  c isDigit ifTrue: [
				  last := c.
				  first ifNil: [ first := c ] ] ].
		  sum + (first asString , last asString) asNumber ]
]

{ #category : 'AdventOfCode' }
AOC class >> day01b: aString [

	^ aString lines inject: 0 into: [ :sum :line |
		  | first last |
		  1 to: line size do: [ :index |
			  (line getDigitAt: index) ifNotNil: [ : s |
				  last := s.
				  first ifNil: [ first := s ] ] ].
		  sum + (first,last) asNumber ] 
]

{ #category : 'AdventOfCode' }
AOC class >> day02a: aString [

	^ aString lines inject: 0 into: [ :sum :line | sum + line validGame ]
]

{ #category : 'AdventOfCode' }
AOC class >> day02b: aString [

	^ aString lines
		  inject: 0
		  into: [ :sum :line | sum + line minimumGame ]
]

{ #category : 'AdventOfCode' }
AOC class >> day03a: aString [ 
	^ self new day03a: aString
]

{ #category : 'AdventOfCode' }
AOC class >> day03b: aString [

	^ self new day03b: aString
]

{ #category : 'accessing' }
AOC >> anySpecialsAroundRow: row col: col [ 
	(1 max: row-1) to: (array size min: row+1) do: [ : r | | rval |
		rval := array at: r.
		(1 max: col-1) to: (rval size min: col+1) do: [ : c |
			(rval at: c) isDigit ifFalse: [ (rval at: c) = $. ifFalse: [ ^ true ] ]
		]
	].
	^ false
]

{ #category : 'AdventOfCode' }
AOC >> day03a: aString [

	| total |
	total := 0.
	array := aString lines.
	array withIndexDo: [ :line :row |
		| digits foundSpecial |
		foundSpecial := false.
		digits := '' writeStream.
		1 to: line size do: [ :col | | c |
			c := (array at: row) at: col.
			c isDigit
				ifTrue: [ (self anySpecialsAroundRow: row col: col) ifTrue: [ foundSpecial := true ]. digits nextPut: c ]
				ifFalse: [ foundSpecial ifTrue: [ total := total + digits contents asNumber ].
					foundSpecial := false.
					digits := '' writeStream ] ].
			foundSpecial ifTrue: [ total := total + digits contents asNumber ]
			 ].
		^ total
]

{ #category : 'AdventOfCode' }
AOC >> day03b: aString [

	| total numbers |
	total := 0.
	array := aString lines.
	numbers := Dictionary new.
	array withIndexDo: [ :line :row |
		| digits first last |
		digits := '' writeStream.
		first := 0. last := -1.
		line withIndexDo: [ :c :col |
			c isDigit
				ifTrue: [
					digits nextPut: c.
					last := col.
					first = 0 ifTrue: [ first := col ] ]
				ifFalse: [
					first to: last do: [ :n |
					numbers at: row @ n put: digits contents ].
					digits := '' writeStream.
					first := 0. last := -1 ] ].
		first to: last do: [ :n | numbers at: row @ n put: digits contents ] ].
	array withIndexDo: [ :line :row |
		line withIndexDo: [ :char :col |
			char = $* ifTrue: [ | set |
				set := Set new.
				row - 1 to: row + 1 do: [ :r | col - 1 to: col + 1 do: [ :c | (numbers at: r@c ifPresent: [:s| set add: s]) ] ].
				set size = 2 ifTrue: [ total := total + (set asArray inject: 1 into: [:p :e| p*e asNumber]) ] ] ] ].
	^ total
]
