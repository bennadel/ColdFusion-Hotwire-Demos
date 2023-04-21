<cfscript>

	if ( request.isPost ) {

		application.noteService.deleteAllNotes();

		location( url = "index.htm", addToken = false );

	}

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Delete All Notes
		</h2>

		<form method="post" action="clear.htm">
			<p>
				Are you sure you want to delete all notes?
			</p>
			<p>
				<button type="submit">
					Delete All Notes
				</button>
				<a href="index.htm">
					Cancel
				</a>
			</p>
		</form>

	</cfoutput>
</cfmodule>

