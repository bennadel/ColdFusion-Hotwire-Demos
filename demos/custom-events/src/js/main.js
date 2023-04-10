
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export class EmojiController extends Controller {

	/**
	* I emit the "emoji" event for the associated hex-encoded code-points.
	*/
	emitEmoji( event ) {

		var codepoints = event.target.dataset.hex
			.split( " " )
			.map(
				( hex ) => {

					return( parseInt( hex, 16 ) );

				}
			)
		;

		this.dispatch(
			"emoji",
			{
				detail: {
					emoji: String.fromCodePoint( ...codepoints ),
					hex: event.target.dataset.hex,
					codepoints: codepoints
				}
			}
		);

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "emoji", EmojiController );
