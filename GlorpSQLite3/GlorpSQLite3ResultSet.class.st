"
I am a Glorp result set. I wrap a UDBCSQLite3ResultSet.
"
Class {
	#name : #GlorpSQLite3ResultSet,
	#superclass : #Object,
	#instVars : [
		'rows',
		'rowStream',
		'command',
		'connection'
	],
	#category : 'GlorpSQLite3'
}

{ #category : #streaming }
GlorpSQLite3ResultSet >> atEnd [
	^ rowStream atEnd
]

{ #category : #accessing }
GlorpSQLite3ResultSet >> connection: aConnection [
	connection := aConnection
]

{ #category : #streaming }
GlorpSQLite3ResultSet >> next [
	^ rowStream next
]

{ #category : #factory }
GlorpSQLite3ResultSet >> on: anSQLite3ResultSet [

	rows := anSQLite3ResultSet rows.
	rowStream := ReadStream on: rows.
	anSQLite3ResultSet close.
	^ self
	
]

{ #category : #accessing }
GlorpSQLite3ResultSet >> rowCount [
	^ connection changes
]

{ #category : #streaming }
GlorpSQLite3ResultSet >> upToEnd [
	^ rowStream upToEnd
]
