<cfscript>

	counters = application.counters.getAll();

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h1>
			ColdFusion + Hotwire Turbo Stream Demo
		</h1>

		<div id="counters">
			<cfloop item="counter" array="#counters#">

				<!---
					The key to using Turbo Streams (from what I am understanding) is that
					you have to create modular view components such that the rendering
					logic for a given piece of UI (user interface) is centralized. This
					way, it's easy to render a given view from a variety of places without
					duplicating the view logic. Here, we're rendering our Counter using a
					ColdFusion custom tag.
				--->
				<cfmodule
					template="counter.cfm"
					counter="#counter#">
				</cfmodule>

			</cfloop>
		</div>

		<form method="post" action="add.htm">
			<button type="submit">
				Add New Counter
			</button>
		</form>

	</cfoutput>
</cfmodule>
