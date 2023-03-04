<cfcontent type="text/vnd.turbo-stream.html; charset=utf-8" />
<cfoutput>

	<!--- Refresh the banner Turbo Frame. --->
	<turbo-stream
		action="visit"
		data-url="banner.htm"
		data-frame="banner">
	</turbo-stream>

	<!--- Redirect to the main page. --->
	<turbo-stream
		action="visit"
		data-url="index.htm">
	</turbo-stream>

</cfoutput>
