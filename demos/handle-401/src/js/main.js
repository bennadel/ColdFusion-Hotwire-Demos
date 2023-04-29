
// Import core modules.
import { StreamActions } from "@hotwired/turbo";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

/**
* I support Turbo.visit() stream actions.
*/
StreamActions.visit = function() {

	var url = this.dataset.url;
	var action = ( this.dataset.action || "advance" );
	var frame = ( this.dataset.frame || undefined );

	Turbo.visit(
		url,
		{
			action: action,
			frame: frame
		}
	);

}
