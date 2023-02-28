<cfscript>

	param name="request.context.id" type="string";

	if ( request.isPost ) {

		application.noteService.deleteNote( request.context.id );

		location( url = "index.htm", addToken = false );

	}

	note = application.noteService.getNote( request.context.id );

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Delete Note
		</h2>

		<form method="post" action="delete.htm">
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( note.id )#" />

			<p>
				Delete this note?
			</p>

			<blockquote>
				#encodeForHtml( note.text )#
			</blockquote>

			<p>
				<button type="submit">
					Delete Note
				</button>
				<a href="index.htm">
					Cancel
				</a>
			</p>
		</form>

	</cfoutput>
</cfmodule>

