"
I am a Glorp driver that interfaces with UDBC-SQLite directly.
"
Class {
	#name : #GlorpSQLite3Driver,
	#superclass : #DatabaseDriver,
	#instVars : [
		'inTxn',
		'txnGuard'
	],
	#category : 'GlorpSQLite3'
}

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> basicExecuteSQLString: aString [
	^ self basicExecuteSQLString: aString binding: #() 
]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> basicExecuteSQLString: aString binding: aBinding [

	^ GlorpCursoredStream on: 
		(GlorpSQLite3ResultSet new 
			connection: connection;
			on: (connection execute: aString with: aBinding);
			yourself)
	
]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> beginTransaction [

	txnGuard critical: [
		inTxn ifFalse: [
			connection beginTransaction.
			inTxn := true ]]
]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> commitTransaction [

	txnGuard critical: [
		inTxn ifTrue: [
			connection commitTransaction.
			inTxn := false ]]


]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> connect: aLogin [
	^ connection := UDBCSQLite3Connection openOn: aLogin host, aLogin databaseName
]

{ #category : #initialization }
GlorpSQLite3Driver >> initialize [
	
	super initialize.
	inTxn := false.
	txnGuard := Semaphore forMutualExclusion
]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> isConnected [
	^ connection isOpen
]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> logout [
	connection close
]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> rollbackTransaction [

	txnGuard critical: [
		inTxn ifTrue: [
			connection rollbackTransaction.
			inTxn := false ]]


]

{ #category : #'glorp-API' }
GlorpSQLite3Driver >> rowCount [
	^ connection changes
	
"20160513, pierce: There are five senders of #rowCount, four of which are explicitly related to unbound execution, which this driver doesn't use. Fifth sender is AbstractReadQuery>>deleteFromDatabaseWithParameters: and SQLite's C API documentation at http://sqlite.org/c3ref/changes.html shows that returning #changes here is appropriate."

"20160605, pierce: With bound execution, apparently Glorp doesn't send this message to this object."
]
