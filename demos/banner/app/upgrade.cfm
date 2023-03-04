<cfscript>

	if ( request.isPost ) {

		application.bannerText = "Your upgrade has been processed!";

		// If the current request can support a Turbo Stream response, it means that Turbo
		// Drive has taken over the page navigation. In that case, we will execute the
		// REDIRECT using our custom Turbo Stream "visit" action so that we can refresh
		// both the top-level page and the banner's Turbo Frame.
		if ( request.turbo.isStream ) {

			include "./upgrade_stream.cfm";
			exit;

		// If this is a normal top-level page action, then let's redirect back to the main
		// page as per usual and let ColdFusion render the newly-define banner content.
		} else {

			location( url = "index.htm", addToken = false );

		}

	}

</cfscript>
<cfmodule template="./tags/page.cfm" section="upgrade">
	<cfoutput>

		<h2>
			Upgrade Your Subscription
		</h2>

		<form method="post" action="upgrade.htm">
			<button type="submit">
				Upgrade for <em>just</em> $9.99!
			</button>
		</form>

	</cfoutput>
</cfmodule>
