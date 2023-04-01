
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export class GameController extends Controller {

	static targets = [ "form", "autoUpdate" ];

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* When the board tick has been processed, I check to see if the user wants the next
	* board tick to be fired automatically.
	*/
	checkForAutoUpdate( event ) {

		if (
			! this.autoUpdateTarget.checked ||
			! event.params.interval
			) {

			return;

		}

		setTimeout(
			() => {

				// Before we attempt to tick forward the game play, let's make sure that
				// we actually have any living cells left on the board. If the board is
				// empty, there's no chance that anything will suddenly burst into life.
				if ( this.hasLivingCells() ) {

					this.formTarget.requestSubmit();

				} else {

					this.autoUpdateTarget.checked = false;

				}

			},
			event.params.interval
		);

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I determine if there are any living cells currently on the board.
	*/
	hasLivingCells() {

		return( !! this.formTarget.querySelector( ".board input[checked]" ) );

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "game", GameController );
