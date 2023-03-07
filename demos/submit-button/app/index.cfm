<cfscript>

	if ( request.isPost ) {

		// Sleeping to give us time to observe the busy-state of the submit button.
		sleep( 2000 );
		location( url = "index.htm?signed=true", addToken = false );

	}

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Welcome to My Site
		</h2>

		<form method="post" action="index.htm">
			<p>
				<textarea
					name="message"
					placeholder="Sign my guest book :)"
					rows="3"
					cols="40"
				></textarea>
			</p>
			<p>
				<!---
					When the form is being submitted, Turbo Drive will automatically
					disable THE ACTIVE SUBMISSION BUTTON as well as apply the "submits
					with" text if the directive is present on the targeted submission
					button. All other submission buttons remain active and unchanged in
					their rendering while the form is being processed.
				--->
				<button
					type="submit"
					data-turbo-submits-with="Submitting..."
					class="submit-button">
					Submit
				</button>
				<button
					type="submit"
					data-turbo-submits-with="Submitting..."
					class="submit-button">
					Submit
				</button>
			</p>
		</form>

	</cfoutput>
</cfmodule>
