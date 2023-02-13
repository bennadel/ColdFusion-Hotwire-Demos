<cfscript>

	param name="url.id" type="string";

	// Adding a sleep to exaggerate the benefits of preloading the content.
	sleep( 500 );

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Product #encodeForHtml( url.id )#
		</h2>

		<p>
			Copy, copy, copy....
		</p>

		<script type="text/javascript">

			// Logging the render time so that we can see CACHED vs LIVE rendering.
			console.log(
				"Product #encodeForJavaScript( url.id )# rendered at",
				new Date().toLocaleTimeString()
			);

		</script>

	</cfoutput>
</cfmodule>
