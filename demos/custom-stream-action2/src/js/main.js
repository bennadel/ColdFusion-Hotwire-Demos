
// Import core modules.
import * as Turbo from "@hotwired/turbo";
import { StreamActions } from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

/**
* I get the DocumentFragment to use as the Turbo Stream payload for the given Turbo Stream
* element. If no selector is provided, the original template is returned. If a selector is
* provided, a new fragment will be generated using the selector and returned.
*/
function getFragmentUsingSelector( turboStreamElement ) {

	var originalFragment = turboStreamElement.templateContent;
	var selector = turboStreamElement.getAttribute( "selector" );

	// If no selector is provided, use the entire template - this is the same behavior as
	// the relevant native action.
	if ( ! selector ) {

		return( originalFragment );

	}

	// Locate the desired sub-nodes within the template. In the vast majority of cases,
	// this will likely be a SINGLE root node. But, I'm using querySelectorAll() in order
	// to make the Stream action a bit more flexible.
	var nodes = originalFragment.querySelectorAll( selector );
	// Construct a new document fragment using the selected sub-nodes.
	var fragment = document.createDocumentFragment();
	fragment.append( ...nodes );

	return( fragment );

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

// In the following custom Turbo Stream actions, I basically went into the Turbo source
// code for StreamActions:
// --
// https://github.com/hotwired/turbo/blob/main/src/core/streams/stream_actions.ts
// --
// ... copied the logic, and replaced the raw .templateContent references with a call to
// extract the sub-tree of the template using the SELECTOR (and the Function above).

StreamActions.replaceWith = function() {

	this.targetElements.forEach(
		( targetElement ) => {

			targetElement.replaceWith( getFragmentUsingSelector( this ) );

		}
	);

}

StreamActions.updateWith = function() {

	this.targetElements.forEach(
		( targetElement ) => {

			targetElement.innerHTML = "";
			targetElement.append( getFragmentUsingSelector( this ) );

		}
	);

}

StreamActions.afterWith = function() {

	this.targetElements.forEach(
		( targetElement ) => {

			targetElement.parentElement?.insertBefore(
				getFragmentUsingSelector( this ),
				targetElement.nextSibling
			);

		}
	);

}

StreamActions.appendWith = function() {

	this.removeDuplicateTargetChildren();
	this.targetElements.forEach(
		( targetElement ) => {

			targetElement.append( getFragmentUsingSelector( this ) );

		}
	);

}

StreamActions.beforeWith = function() {

	this.targetElements.forEach(
		( targetElement ) => {

			targetElement.parentElement?.insertBefore(
				getFragmentUsingSelector( this ),
				targetElement
			);

		}
	);

}

StreamActions.prependWith = function() {

	this.removeDuplicateTargetChildren();
	this.targetElements.forEach(
		( targetElement ) => {

			targetElement.prepend( getFragmentUsingSelector( this ) );

		}
	);

}
