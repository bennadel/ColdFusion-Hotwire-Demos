<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Bouncing Back to Home
		</h2>

		<p>
			<!--- Required for restoration visits - see note below. --->
			<a href="index.htm">Go back to home</a> &rarr;
		</p>

		<!---
			CAUTION: If the user returns to this page through a restoration visit (ie,
			hitting the browser's BACK BUTTON), this Turbo-Stream element will no longer
			be here since it is removed during the stream evaluation. As such, it is
			important to provide the manual link above.
			--
			Also, by adding [data-action="replace"], we can override the current history
			entry, somewhat preventing the back button problem.
		--->
		<turbo-stream
			action="visit"
			data-url="index.htm">
		</turbo-stream>

	</cfoutput>
</cfmodule>
