<cfscript>

	param name="form.note" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	if ( form.submitted ) {

		if ( form.note.len() ) {

			application.notes.prepend( form.note );

			location(
				url = "index.htm?flashAddSuccess=true",
				addToken = false
			);

		}

		// To keep things simple, if the user tries to add a note, but provides no actual
		// content, I'm just going to take them back to the index page. This way, I don't
		// have to deal with form validation, which is beyond the scope of this demo.
		location( url = "index.htm", addToken = false );

	}

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Add Note
		</h2>

		<form method="post" action="add.htm">
			<input type="hidden" name="submitted" value="true" />

			<input type="text" name="note" autofocus size="30" />
			<button type="submit">
				Save
			</button>
			<a href="index.htm">
				Cancel
			</a>
		</form>

	</cfoutput>
</cfmodule>
