<cfscript>

	param name="url.flashAddSuccess" type="boolean" default=false;
	param name="url.flashDeleteSuccess" type="boolean" default=false;

	if ( url.flashAddSuccess ) {

		request.newToasts.append( "Your note has been added! &##x1f4aa;" );

	}

	if ( url.flashDeleteSuccess ) {

		request.newToasts.append( "Your note has been deleted! &##x1f525;" );

	}

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Notes
		</h2>

		<p>
			<a href="add.htm">Add note</a>
		</p>

		<cfif application.notes.len()>

			<ul>
				<cfloop index="i" item="note" array="#application.notes#">
					<li>
						#encodeForHtml( note )#
						&mdash;
						<a href="delete.htm?index=#i#">Delete</a>
					</li>
				</cfloop>
			</ul>

		</cfif>

	</cfoutput>
</cfmodule>
