Extension { #name : 'String' }

{ #category : '*AOC2023' }
String >> getDigitAt: index [

	| c p nums |
	c := '0123456789zottffssen' indexOf: (self at: index).
	c isZero ifTrue: [ ^ nil ].
	nums := #( '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'zero' 'one' 'two'
	           'three' 'four' 'five' 'six' 'seven' 'eight' 'nine' ).
	p := 0.
	[ index + p <= self size ] whileTrue: [
		(self at: index + p) = ((nums at: c) at: p + 1)
			ifTrue: [
				p := p + 1.
				p = (nums at: c) size ifTrue: [ ^ nums at: c - 1 % 10 + 1 ] ]
			ifFalse: [
				(c = 13 or: [ c = 15 or: [ c = 17 ] ])
					ifTrue: [ c := c + 1 ]
					ifFalse: [ ^ nil ] ] ].
	^ nil
]

{ #category : '*AOC2023' }
String >> minimumGame [

	| s1 dict prod |
	dict := {
		        ('red' -> 0).
		        ('green' -> 0).
		        ('blue' -> 0) } asDictionary.
	s1 := self splitOn: ':'.
	s1 last splitOn: ';' do: [ :display |
		display splitOn: ';' do: [ :show |
			show splitOn: ',' do: [ :pair |
				| number colour |
				number := pair substrings first asNumber.
				colour := pair substrings last.
				number > (dict at: colour) ifTrue: [ dict at: colour put: number ] ] ] ].
	prod := 0.
	dict keysAndValuesDo: [ :keys :value |
		value > 0 ifTrue: [
			prod := prod > 0
				        ifTrue: [ prod * value ]
				        ifFalse: [ value ] ] ].
	^ prod
]

{ #category : '*AOC2023' }
String >> validGame [

	| s1 dict |
	dict := {
					 ('red' -> 12).
					 ('green' -> 13).
					 ('blue' -> 14) } asDictionary.
	s1 := self splitOn: ':'.
	s1 last splitOn: ';' do: [ :display |
		display splitOn: ';' do: [ :show |
			show splitOn: ',' do: [ : pair | | number colour |
				number := pair substrings first asNumber.
				colour := pair substrings last.
				number > (dict at: colour)
					ifTrue: [ ^ 0 ] ] ] ].
	^ (s1 first splitOn: ' ') last asNumber
]
