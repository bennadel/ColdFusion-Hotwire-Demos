<cfscript>

	param name="url.index" type="numeric";
	param name="form.submitted" type="boolean" default=false;

	// Protect against invalid data.
	if ( ! application.notes.isDefined( url.index ) ) {

		location( url = "index.htm", addToken = false );

	}

	if ( form.submitted ) {

		application.notes.deleteAt( url.index );

		location(
			url = "index.htm?flashDeleteSuccess=true",
			addToken = false
		);

	}

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Delete Note
		</h2>

		<blockquote>
			#encodeForHtml( application.notes[ url.index ] )#
		</blockquote>

		<form method="post" action="delete.htm?index=#encodeForUrl( url.index )#">
			<input type="hidden" name="submitted" value="true" />

			<button type="submit" autofocus>
				Delete
			</button>
			<a href="index.htm">
				Cancel
			</a>
		</form>

	</cfoutput>
</cfmodule>
