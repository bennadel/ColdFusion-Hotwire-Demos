<cfscript>

	items = [
		{ id: 1, name: "Item One" },
		{ id: 2, name: "Item Two" },
		{ id: 3, name: "Item Three" }
	];

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Welcome to My Site
		</h2>

		<!--- There is a PARENT CONTROLLER on the list. --->
		<ul
			data-controller="parent"
			data-action="child:hello->parent##logEvent">

			<cfloop item="item" array="#items#">

				<!--- There is a CHILD CONTROLLER on each list item. --->
				<li
					data-controller="child"
					data-child-id-value="#encodeForHtmlAttribute( item.id )#">

					#encodeForHtml( item.name )#

					<!---
						Even though we are inside the CHILD controller scope, we are still
						technically in the SCOPE of the PARENT controller as well. As
						such, we can reach outside of the child scope and trigger actions
						on the parent controller. In this case, we're going to include
						child-related data as PARAMS on the triggered event.
					--->
					<button
						data-action="parent##logAction"
						data-parent-child-id-param="#encodeForHtmlAttribute( item.id )#"
						data-parent-child-data-param="#encodeForHtmlAttribute( serializeJson( item ) )#">
						Trigger Parent Action
					</button>

					<!---
						We can also emit / trigger / broadcast / dispatch events from the
						CHILD controller up the DOM tree (like any non-custom event). The
						PARENT controller can then listen for these events in its own
						action bindings.
					--->
					<button data-action="child##emitEvent">
						Emit Child Event
					</button>
				</li>

			</cfloop>

		</ul>

	</cfoutput>
</cfmodule>
