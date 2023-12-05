"
I am the implementation of [Advent of Code 2023](https://adventofcode.com/2023)
"
Class {
	#name : 'AOC',
	#superclass : 'Object',
	#category : 'AOC2023',
	#package : 'AOC2023'
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

	^ aString lines inject: 0 into: [ :sum :line | sum + line minimumGame ]
]
