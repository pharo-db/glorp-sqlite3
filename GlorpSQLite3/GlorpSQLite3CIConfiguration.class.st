"
I am a configuration for continuous integration.
"
Class {
	#name : #GlorpSQLite3CIConfiguration,
	#superclass : #Object,
	#category : 'GlorpSQLite3'
}

{ #category : #configuration }
GlorpSQLite3CIConfiguration >> configureSqlite3 [

	PharoDatabaseAccessor DefaultDriver: GlorpSQLite3Driver.
	GlorpDatabaseLoginResource current: nil.
	GlorpDatabaseLoginResource defaultLogin: self defaultLogin
	
]

{ #category : #private }
GlorpSQLite3CIConfiguration >> defaultLogin [

	^ Login new 
			database: UDBCSQLite3Platform new;
			host: SmalltalkImage current imagePath asFileReference	 parent fullName,
						FileSystem disk delimiter asString;
			port: '';
			username: '';
			password: '';
			databaseName: 'sodbxtestu.db';
			yourself	
]
