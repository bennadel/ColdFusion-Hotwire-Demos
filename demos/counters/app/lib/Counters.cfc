component
	output = false
	hint = "I provide a collection of incrementing counters. These are NOT intended to be thread-safe, and are just for a demo."
	{

	/**
	* I initialize an empty collection of counters.
	*/
	public void function init() {

		variables.counters = [:];

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I add a new counter. The new counter is returned.
	*/
	public struct function addCounter() {

		var id = createUuid();
		var counter = counters[ id ] = {
			id: id,
			value: 0
		};

		return( counter.copy() );

	}


	/**
	* I return the collection of counters.
	*/
	public array function getAll() {

		var asArray = counters.keyArray().map(
			( id ) => {

				return( counters[ id ].copy() );

			}
		);

		return( asArray );

	}


	/**
	* I increment the given counter. The existing counter is returned.
	*/
	public struct function incrementCounter( required string id ) {

		var counter = counters[ id ];
		counter.value++;

		return( counter.copy() );

	}


	/**
	* I remove the given counter. The removed counter is returned.
	*/
	public struct function removeCounter( required string id ) {

		var counter = counters[ id ];
		counters.delete( id );

		return( counter );

	}

}
