"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAOC2023',
	#superclass : 'PackageManifest',
	#category : 'AOC2023-Manifest',
	#package : 'AOC2023',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SequenceableCollection #day13b #false)) #'2023-12-18T11:04:15.33509-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleExcessiveArgumentsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AOC #day16a:row:col:direction:into: #false)) #'2023-12-18T20:25:53.389937-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#AOC)) #'2023-12-05T13:24:36.882733-05:00') #(#(#RGMetaclassDefinition #(#'AOC class' #AOC)) #'2023-12-08T09:23:57.867201-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleModifiesCollectionRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SequenceableCollection #day13b #false)) #'2023-12-18T11:04:02.909578-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleSearchingLiteralRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#String #getDigitAt: #false)) #'2023-12-04T23:36:02.853189-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleSelfSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#AOCTest)) #'2023-12-05T11:34:53.447728-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleSendsUnknownMessageToGlobalRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#AOCTest)) #'2023-12-05T11:29:41.548966-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AOCTest #test04 #false)) #'2023-12-05T11:29:51.70724-05:00') #(#(#RGClassDefinition #(#AOCTest)) #'2023-12-05T11:31:35.675449-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'AOC class' #AOC)) #'2023-12-04T23:56:04.901629-05:00') )
]

{ #category : 'code-critics' }
ManifestAOC2023 class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'AOC class' #day01b: #true)) #'2023-12-04T23:56:10.46045-05:00') #(#(#RGMetaclassDefinition #(#'AOC class' #AOC)) #'2023-12-06T18:14:30.416368-05:00') #(#(#RGMethodDefinition #(#AOC #day10a: #false)) #'2023-12-11T12:18:13.903972-05:00') )
]
