component
	output = false
	hint = "I provide a light-weight quote rotator."
	{

	/**
	* I initialize the quote service.
	*/
	public void function init() {

		variables.quotes = [
			{ id: 1, text: "This is a fun quote (1)." },
			{ id: 2, text: "Another great quote worth sharing (2)." },
			{ id: 3, text: "So much good quotes to be shared (3)." }
		];

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the given quote, or a random quote if no index is provided.
	*/
	public struct function getQuote( numeric index = 0 ) {

		var quoteCount = quotes.len();

		if ( ! index || ! quotes.isDefined( index ) ) {

			index = randRange( 1, quoteCount );

		}

		var quote = quotes[ index ].duplicate();

		// Augment the quote with the prev/next IDs for easier navigation logic.
		quote.prevID = ( index == 1 )
			? quoteCount
			: ( index - 1 )
		;
		quote.nextID = ( index == quoteCount )
			? 1
			: ( index + 1 )
		;

		return( quote );

	}

}
