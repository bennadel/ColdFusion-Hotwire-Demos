<cfscript>

	param name="form.cells" type="array" default=[];
	param name="form.autoUpdate" type="boolean" default=false;
	param name="form.submitted" type="boolean" default=false;

	// On every page request, we're going to initialize the Game of Life with the
	// currently submitted cells.
	game = new lib.GameOfLife(
		minX = -10,
		maxX = 10,
		minY = -10,
		maxY = 10,
		cellKeys = form.cells
	);

	// If this is a form-submission, move the evolution of the game forward 1-tick.
	if ( form.submitted ) {

		game.tick();

	}

	state = game.getState();

	// If the form is set to auto-update, but there are no living cells left on the board,
	// disable the auto-update. Subsequent requests won't change the board in any way.
	if ( form.autoUpdate && state.cellIndex.isEmpty() ) {

		form.autoUpdate = false;

	}

	// If this request is a form submission via Turbo Drive , then we cannot simply re-
	// render the form - Turbo Drive requires either a redirect, an error, or a Turbo
	// Stream. As such, we're going to have to REPLACE the board with a stream action
	// rather than update the whole page.
	if ( request.isPost && request.turbo.isStream ) {

		include "./_board.stream.cfm";
		exit;

	}

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<form
			method="post"
			action="index.htm"
			data-controller="game"
			data-action="turbo:submit-end->game##checkForAutoUpdate"
			data-game-interval-param="500"
			data-game-target="form">

			<input type="hidden" name="submitted" value="true" />

			<div class="controls">
				<button type="submit">
					Increment Game Play
				</button>

				<label for="auto-update">
					<input
						id="auto-update"
						type="checkbox"
						name="autoUpdate"
						value="true"
						data-game-target="autoUpdate"
						<cfif form.autoUpdate>checked</cfif>
					/>
					Auto update
				</label>

				<a href="index.htm">
					Reset
				</a>
			</div>

			<cfinclude template="./_board.cfm" />

		</form>

		<!---
			Graceful degradation: If Hotwire Turbo Drive is not managing the game play,
			then we want to fall-back to using vanilla JavaScript to automatically submit
			the board. If on any subsequent page load, the Turbo Drive script kicks-in,
			it will hook into the `requestSubmit()` life-cycle, take over, and this script
			will no longer be relevant.
		---> 
		<cfif form.autoUpdate>
			<script type="text/javascript">

				var form = document.querySelector( "form" );

				setTimeout(
					() => {

						form.requestSubmit();

					},
					form.dataset.gameIntervalParam
				);

			</script>
		</cfif>

	</cfoutput>
</cfmodule>
