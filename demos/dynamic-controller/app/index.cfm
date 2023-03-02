<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Welcome to My Site
		</h2>

		<div id="dyno">
			This is static content.
		</div>

		<p>
			<a href="javascript:( dyno.dataset.controller = 'dynamic-controller' );void(0);">
				Attach Controller
			</a>
		</p>

	</cfoutput>
</cfmodule>
