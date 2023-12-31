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

{ #category : 'AdventOfCode' }
AOC class >> day04a: aString [

	| total |
	total := 0.
	aString linesDo: [ :line | | count | count := line lotteryTicket. 
		  count = 0 ifFalse: [ total := total + (2 raisedTo: count - 1) ] ].
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day04b: aString [

	| total lines counts |
	total := 0.
	lines := aString lines.
	counts := Array new: lines size withAll: 1.
	1 to: lines size do: [ :index |
		| count repeat |
		repeat := counts at: index. 
		count := (lines at: index) lotteryTicket.
		index + 1 to: index + count do: [ :i |
		counts at: i put: (counts at: i) + repeat ] ].
	^ counts sum 
]

{ #category : 'AdventOfCode' }
AOC class >> day05: aString init: init process: process [

	| source destination |
	aString linesDo: [ :line |
		line isEmpty ifFalse: [
			(line first: 6) = 'seeds:'
				ifTrue: [
					destination := init value:
						               (line substrings allButFirst collect: #asNumber) ]
				ifFalse: [
					line last = $:
						ifTrue: [ source := destination copy ]
						ifFalse: [
							| data sfirst slast delta |
							data := line substrings collect: #asNumber.
							sfirst := data second.
							slast := sfirst + data last - 1.
							delta := data first - sfirst.
							destination := process
								               value: destination
								               value: destination
								               value: (sfirst to: slast)
								               value: delta ] ] ] ].
	^ destination min
]

{ #category : 'AdventOfCode' }
AOC class >> day05a: aString [

	^ self
		  day05: aString
		  init: #yourself
		  process: [ :source :destination :range :delta |
			  source withIndexCollect: [ :each :index |
				  (each between: range first and: range stop) ifTrue: [
					  destination at: index put: each + delta ] ].
			  destination ]
]

{ #category : 'AdventOfCode' }
AOC class >> day05b: aString [

	^ self
		  day05: aString
		  init: [ :inputs |
			  | input |
			  input := ReadStream on: inputs.
			  Array streamContents: [ :s |
				  [ input atEnd ] whileFalse: [
					  | start count |
					  start := input next.
					  count := input next.
					  s nextPut: (start to: start + count - 1) ] ] ]
		  process: [ :source :destination :range :delta | self halt ]
]

{ #category : 'AdventOfCode' }
AOC class >> day06a: aString [

	^ ((aString lines first substrings allButFirst collect: #asNumber)
		   with:
		   (aString lines last substrings allButFirst collect: #asNumber)
		   collect: [ :time :dist | time trialsBetterThan: dist ])
		  inject: 1
		  into: [ :prod :each | prod * each ]
]

{ #category : 'AdventOfCode' }
AOC class >> day06b: aString [

	^ ('' join: aString lines first substrings allButFirst) asNumber
		   trialsBetterThan:
		   ('' join: aString lines last substrings allButFirst) asNumber

]

{ #category : 'AdventOfCode' }
AOC class >> day07a: aString [ 
	| hands total |
	hands := aString lines collect: [ :line| line substrings first camelCardValue-> line substrings last asNumber ].
	total := 0.
	(hands sort: [ :l :r | l key <= r key ]) doWithIndex: [ :hand :index | total := hand value * index + total ].
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day07b: aString [

	| hands total |
	hands := aString lines collect: [ :line |
		         line substrings first camelCardValueWithJoker
		         -> line substrings last asNumber ].
	total := 0.
	(hands sort: [ :l :r | l key <= r key ]) doWithIndex: [ :hand :index |
		total := hand value * index + total ].
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day08a: aString [

	| directions map count position |
	map := Dictionary new.
	aString linesDo: [ :line |
		line isEmpty ifFalse: [
			directions
				ifNil: [
					directions := line
						              collect: [ :char | 'LR' indexOf: char ]
						              as: Array ]
				ifNotNil: [
					| ss |
					ss := line substrings.
					map at: ss first put: {
							ss third allButFirst allButLast.
							ss last allButLast } ] ] ].
	count := 0.
	position := 'AAA'.
	[ true ] whileTrue: [
		directions do: [ :direction |
			'ZZZ' = position ifTrue: [ ^ count ].
			count := count + 1.
			position := (map at: position) at: direction ] ]
]

{ #category : 'AdventOfCode' }
AOC class >> day08b: aString [

	| directions map slowMap keys count position exits |
	slowMap := Dictionary new.
	aString linesDo: [ :line |
		line isEmpty ifFalse: [
			directions
				ifNil: [
					directions := line
						              collect: [ :char | 'LR' indexOf: char ]
						              as: Array ]
				ifNotNil: [
					| ss |
					ss := line substrings.
					slowMap at: ss first put: {
							ss third allButFirst allButLast.
							ss last allButLast } ] ] ].
	keys := slowMap keys.
	map := Array new: keys size.
	exits := keys collect: [ :key | key last = $Z ].
	slowMap keysAndValuesDo: [ :key :value |
		map at: (keys indexOf: key) put: {
				(keys indexOf: value first).
				(keys indexOf: value second) } ].
	count := 0.
	position := keys
		            select: [ :key | key last = $A ]
		            thenCollect: [ :key | keys indexOf: key ].
	[ true ] whileTrue: [
		directions do: [ :direction | | found |
			count := count + 1.
			found := true.
			position withIndexDo: [ :key :index | | next |
				next := (map at: key) at: direction.
				found := found & (exits at: next).
				position at: index put: next ].
			found ifTrue: [ ^ count ] ] ]
]

{ #category : 'AdventOfCode' }
AOC class >> day09a: aString [

	^ (aString lines collect: [: line | (line substrings collect: #asNumber) day09a]) sum
]

{ #category : 'AdventOfCode' }
AOC class >> day09b: aString [

	^ (aString lines collect: [: line | (line substrings collect: #asNumber) day09b]) sum
]

{ #category : 'AdventOfCode' }
AOC class >> day10a: aString [

	^ self new day10a: aString
]

{ #category : 'AdventOfCode' }
AOC class >> day10b: aString [

	| path |
	path := self new.
	path day10a: aString.
	self halt.
]

{ #category : 'AdventOfCode' }
AOC class >> day11a: aString expansion: expansion [

	| columnsUsed galaxies row offset offsets sum |
	galaxies := OrderedCollection new.
	row := 0.
	aString lines do: [ :line |
		| found |
		found := false.
		row := row + 1.
		row = 1 ifTrue: [
			columnsUsed := Array new: line size withAll: false ].
		line withIndexDo: [ :c :col |
			c = $# ifTrue: [
				found := true.
				columnsUsed at: col put: true.
				galaxies add: row @ col ] ].
		found ifFalse: [ row := row + expansion ] ].
	offset := 0.
	offsets := columnsUsed collect: [ :c |
		           c ifFalse: [ offset := offset + expansion ].
		           offset ].
	galaxies := galaxies collect: [ :g | g x @ (g y + (offsets at: g y)) ].
	sum := 0.
	galaxies
		combinations: 2
		atATimeDo: [ :a |
		sum := sum + (a first manhattanDistanceTo: a second) ].
	^ sum
]

{ #category : 'AdventOfCode' }
AOC class >> day13a: aString [

	| pattern total |
	pattern := OrderedCollection new.
	total := 0.
	aString linesDo: [ :line |
		line isEmpty
			ifTrue: [
				total := total + pattern day13a.
				pattern reset ]
			ifFalse: [ pattern add: line ] ].
	total := total + pattern day13a.
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day13b: aString [

	| pattern total |
	pattern := OrderedCollection new.
	total := 0.
	aString linesDo: [ :line |
		line isEmpty
			ifTrue: [
				total := total + pattern day13b.
				pattern reset ]
			ifFalse: [ pattern add: line ] ].
	total := total + pattern day13b.
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day14a: aString [ 
	| total |
	total := 0.
	aString lines transposed do: [ : col | | rollTo sizePlus1 |
		rollTo := 1.
		sizePlus1 := col size + 1.
		col withIndexDo: [ : each : index |
			each = $# ifTrue: [ rollTo := index +1 ].
			each = $O ifTrue: [ total := total + (sizePlus1 - rollTo). rollTo := rollTo + 1 ] ] ].
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day15a: aString [ 
	| total |
	total := 0.
	aString splitOn: $, do: [: string | total := total + string day15a].
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day15b: aString [

	| total boxes |
	total := 0.
	boxes := Array new: 256 streamContents: [ : s | 256 timesRepeat: [s nextPut: OrderedDictionary new ]].
	aString splitOn: $, do: [ :string | | box ss |
		ss := string splitOn: ((string last = $-) ifTrue: [$-] ifFalse: [$=]).
		box := boxes at: ss first day15a + 1.
		string last = $- ifTrue: [ box removeKey: string allButLast ifAbsent:[ ]] ifFalse: [ box at: ss first put: ss last asNumber ]].
	boxes withIndexDo: [: box : boxI | box withIndexDo: [: slot : slotI | total := total + (boxI * slotI * slot value)]].
	^ total
]

{ #category : 'AdventOfCode' }
AOC class >> day16a: aString [
self halt.
	^ (self new
		   day16a: aString lines
		   row: 1
		   col: 1
		   direction: #east
		   into: Set new) size
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

{ #category : 'AdventOfCode' }
AOC >> day10a: aString [

	| row col tRow tCol count mRow mCol moving |
	array := aString lines.
	array withIndexDo: [ :line :indexL |
		| temp |
		temp := line indexOf: $S.
		temp > 0 ifTrue: [
			row := indexL.
			col := temp ].
		array at: indexL put: line asArray ].
	moving := {
		          ($J -> #( -1 -1 )).
		          ($7 -> #( 1 -1 )).
		          ($F -> #( 1 1 )).
		          ($L -> #( -1 1 )) } asDictionary.
	#( #( -1 0 '7F|' ) #( 0 -1 'FL-' ) #( 0 1 'J7-' ) #( 1 0 'LJ|' ) )
		do: [ :direction |
			tRow := row + direction first.
			tCol := col + direction second.
			((tRow between: 1 and: array size) and: [
				 (tCol between: 1 and: (array at: tRow) size) and: [
					 (direction third indexOf: ((array at: tRow) at: tCol)) > 0 ] ])
				ifTrue: [
					self halt.
					(array at: row) at: col put: nil.
					count := 1.
					mRow := direction first.
					mCol := direction second.
					[ true ] whileTrue: [
						| c |
						c := (array at: tRow) at: tCol.
						(array at: tRow) at: tCol put: nil.
						moving
							at: c
							ifPresent: [ :move |
								mRow = 0
									ifTrue: [
										mCol := 0.
										mRow := move first.
										tRow := tRow + mRow ]
									ifFalse: [
										mRow := 0.
										mCol := move second.
										tCol := tCol + mCol ] ]
							ifAbsent: [
								$| = c ifTrue: [ tRow := tRow + mRow ].
								$- = c ifTrue: [ tCol := tCol + mCol ] ].
						count := count + 1.
						(tRow = row and: [ tCol = col ]) ifTrue: [ ^ count / 2 ] ] ] ]
]

{ #category : 'AdventOfCode' }
AOC >> day12a: aString [ 
	| pattern positions |
	pattern := aString substrings first.
	positions := (aString substrings last splitOn: ',') collect: #asNumber
]

{ #category : 'AdventOfCode' }
AOC >> day16a: arr row: row col: col direction: direction into: set [

	| c ns delta directions walked |
	row < 1 ifTrue: [ ^ set ].
	row > arr size ifTrue: [ ^ set ].
	col < 1 ifTrue: [ ^ set ].
	col > arr first size ifTrue: [ ^ set ].
	walked := false.
	c := (arr at: row) at: col.
	ns := #( north south ) includes: direction.
	delta := (#( south east ) includes: direction)
		         ifTrue: [ 1 ]
		         ifFalse: [ -1 ].
	(ns and: [ c = $- ]) ifTrue: [
		walked := true.
		self
			day16a: arr
			row: row
			col: col + 1
			direction: #east
			into: set.
		self
			day16a: arr
			row: row
			col: col - 1
			direction: #west
			into: set ].
	(ns not and: [ c = $| ]) ifTrue: [
		walked := true.
		self
			day16a: arr
			row: row + 1
			col: col
			direction: #south
			into: set.
		self
			day16a: arr
			row: row - 1
			col: col
			direction: #north
			into: set ].
	directions := #( #( north -1 0 ) #( east 0 1 ) #( south 1 0 )
	                 #( west 0 -1 ) ).
	c = $/ ifTrue: [
		| d |
		d := directions at: (#( east north west south ) indexOf: direction).
		walked := true.
		self
			day16a: arr
			row: row + d second
			col: col + d third
			direction: d first
			into: set ].
	c = $\ ifTrue: [
		| d |
		d := directions at: (#( west south east north ) indexOf: direction).
		walked := true.
		self
			day16a: arr
			row: row + d second
			col: col + d third
			direction: d first
			into: set ].
"	(set includes: row @ col) ifTrue: [ ^ set ]."
	walked ifFalse: [
		self
			day16a: arr
			row: (ns
					 ifTrue: [ row + delta ]
					 ifFalse: [ row ])
			col: (ns
					 ifTrue: [ col ]
					 ifFalse: [ col + delta ])
			direction: direction
			into: set ].
	set add: row @ col.
	^ set
]
