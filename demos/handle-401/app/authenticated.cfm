<cfscript>

	// For the sake of simplicity, all the "logged-in" pages will be rendered as this
	// page, using the "v" value to differentiate. 
	param name="url.v" type="string" default="home";

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Page For #encodeForHtml( url.v.ucfirst() )#
		</h2>
		<p>
			<a href="authenticated.htm?v=home">Home</a> &mdash;
			<a href="authenticated.htm?v=activity">Activity</a> &mdash;
			<a href="authenticated.htm?v=profile">Profile</a> &mdash;
			<a href="oops.htm">Oops Page</a>
		</p>
		<p>
			This is the <strong>page content</strong> for
			<mark>[ #encodeForHtml( url.v )# ]</mark>.
		</p>

		<!---
			FRAME LEVEL page navigation options. These are all the same links; however,
			since they are defined inside a Turbo Frame, the are automatically scoped to
			the Turbo Frame instead of using a top-level navigation.
		--->
		<turbo-frame id="my-frame">
			<h3>
				Inside A Turbo Frame
			</h3>
			<p>
				<a href="authenticated.htm?v=home">Home</a> &mdash;
				<a href="authenticated.htm?v=activity">Activity</a> &mdash;
				<a href="authenticated.htm?v=profile">Profile</a> &mdash;
				<a href="oops.htm">Oops Page</a>
				( <a href="oops.htm?useStream=true">with Stream</a> )
			</p>
			<p>
				This is the <strong>frame content</strong> for
				<mark>[ #encodeForHtml( url.v )# ]</mark>.
			</p>
		</turbo-frame>

	</cfoutput>
</cfmodule>
