component
	output = false
	hint = "I provide game play methods for Conway's Game of Life."
	{

	/**
	* I initialize the Game of Life with the given cell keys. Each key is a composite of
	* the "x,y" coordinate of a living cell within the infinite canvas of biodiversity.
	*/
	public void function init(
		numeric minX = 0,
		numeric maxX = 15,
		numeric minY = 0,
		numeric maxY = 15,
		array cellKeys = []
		) {

		// As the board grows and shrinks, we never want the visual rendering to shrink
		// below a certain boundary.
		variables.boardMinX = arguments.minX;
		variables.boardMaxX = arguments.maxX;
		variables.boardMinY = arguments.minY;
		variables.boardMaxY = arguments.maxY;
		variables.currentState = stateNew( cellKeys );

		// The rules of the game are based on the number of living / dead cells around a
		// given cell. To make those calculations easier, this collection represents the
		// {x,y} delta for each neighboring cell.
		variables.neighborOffsets = [
			{ x: -1 , y: -1 },
			{ x: 0  , y: -1 },
			{ x: 1  , y: -1 },
			{ x: -1 , y: 0 },
			{ x: 1  , y: 0 },
			{ x: -1 , y: 1 },
			{ x: 0  , y: 1 },
			{ x: 1 ,  y: 1 }
		];

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the current state of the game board.
	*/
	public struct function getState() {

		return({
			minX: currentState.minX,
			maxX: currentState.maxX,
			minY: currentState.minY,
			maxY: currentState.maxY,
			cellIndex: currentState.cellIndex.copy()
		});

	}


	/**
	* I move the state of the board ahead by one life-tick.
	*/
	public void function tick() {

		// We don't want to change the state of the current board while we are examining
		// it as doing so may corrupt further checks within the algorithm. As such, we're
		// going to build-up a new state and then swap it in for the current state.
		var nextState = stateNew();
		// The game requires us to look at both the living cells and the dead cells (that
		// are around the living cells). Since dead cells aren't explicitly tracked in the
		// state of the board itself - there are an infinite number of dead cells - we
		// need to track the dead cells that are around the living cells that we inspect.
		var deadCellIndex = [:];

		for ( var key in currentState.cellIndex ) {

			var cell = stateGetCell( currentState, key );

			// Living cells remain alive if they have 2 or 3 living neighbors.
			if (
				( cell.livingNeighbors.len() == 2 ) ||
				( cell.livingNeighbors.len() == 3 )
				) {

				stateActivateCell( nextState, key );

			}

			// Track the dead neighbors around the living cell so that we can explore them
			// once we are done processing the living cells.
			for ( var deadKey in cell.deadNeighbors ) {

				deadCellIndex[ deadKey ] = true;

			}

		}

		// Now that we've located any relevant dead cells (neighboring living cells), we
		// can see if any of them need to spring to life.
		for ( var key in deadCellIndex ) {

			var cell = stateGetCell( currentState, key );

			// If the cell is dead, then it becomes alive if it has 3 living neighbors.
			if ( cell.livingNeighbors.len() == 3 ) {

				stateActivateCell( nextState, key );

			}

		}

		// Swap in the new game state.
		currentState = nextState;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I activate the cell for the given key (marking it as alive).
	*/
	private void function stateActivateCell(
		required struct state,
		required string key
		) {

		var coordinates = key.listToArray();
		var x = fix( coordinates[ 1 ] );
		var y = fix( coordinates[ 2 ] );

		state.cellIndex[ key ] = true;
		state.minX = min( state.minX, x );
		state.maxX = max( state.maxX, x );
		state.minY = min( state.minY, y );
		state.maxY = max( state.maxY, y );

	}


	/**
	* I get the cell (and some contextual info) for the given key.
	*/
	private struct function stateGetCell(
		required struct state,
		required string key
		) {

		var coordinates = key.listToArray();
		var x = fix( coordinates[ 1 ] );
		var y = fix( coordinates[ 2 ] );

		var cell = {
			x: x,
			y: y,
			livingNeighbors: [],
			deadNeighbors: []
		};

		for ( var offset in neighborOffsets ) {

			var neighborX = ( cell.x + offset.x );
			var neighborY = ( cell.y + offset.y );
			var neighborKey = "#neighborX#,#neighborY#";

			if ( state.cellIndex.keyExists( neighborKey ) ) {

				cell.livingNeighbors.append( neighborKey );

			} else {

				cell.deadNeighbors.append( neighborKey );

			}

		}

		return( cell );

	}


	/**
	* I create a new state data model. If initial keys are provided, they will be used to
	* activate cells in the new state.
	*/
	private struct function stateNew( array cellKeys = [] ) {

		// Instead of keeping a two-dimensional array of the entire board, we're just
		// going to keep an index of the living cells based on a composite key of the
		//"x,y" magnitudes. The VALUE of the entry doesn't matter.
		var state = {
			cellIndex: [:],
			minX: boardMinX,
			maxX: boardMaxX,
			minY: boardMinY,
			maxY: boardMaxY
		};

		for ( var key in cellKeys ) {

			stateActivateCell( state, key );

		}

		return( state );

	}

}
