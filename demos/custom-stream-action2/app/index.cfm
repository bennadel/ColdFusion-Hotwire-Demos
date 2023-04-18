<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<div id="demo-container">
			<p class="original">
				To be changed via Turbo Streams.
			</p>
		</div>

		<!---
			Each of the following forms is going to POST to an end-point that returns a
			Turbo Stream element with a CUSTOM ACTION. These custom actions are named for
			the native Turbo Stream actions along with the suffix "With" (for example,
			"replace" becomes "repalceWith"). The custom actions allow for an additional
			attribute, "selector", which determines which elements within the TEMPLATE
			will be used in the DOM manipulation. For the sake of the demo, I'm providing
			these attributes via hidden inputs:
		--->
		<form method="post" action="stream.htm">
			<input type="hidden" name="action" value="prependWith" />
			<input type="hidden" name="selector" value=".prepend-with" />
			<button type="submit">
				Prepend With
			</button>
		</form>
		<form method="post" action="stream.htm">
			<input type="hidden" name="action" value="appendWith" />
			<input type="hidden" name="selector" value=".append-with" />
			<button type="submit">
				Append With
			</button>
		</form>
		<form method="post" action="stream.htm">
			<input type="hidden" name="action" value="updateWith" />
			<input type="hidden" name="selector" value=".update-with" />
			<button type="submit">
				Update With
			</button>
		</form>
		<form method="post" action="stream.htm">
			<input type="hidden" name="action" value="beforeWith" />
			<input type="hidden" name="selector" value=".before-with" />
			<button type="submit">
				Before With
			</button>
		</form>
		<form method="post" action="stream.htm">
			<input type="hidden" name="action" value="afterWith" />
			<input type="hidden" name="selector" value=".after-with" />
			<button type="submit">
				After With
			</button>
		</form>
		<form method="post" action="stream.htm">
			<input type="hidden" name="action" value="replaceWith" />
			<input type="hidden" name="selector" value=".replace-with" />
			<button type="submit">
				Replace With
			</button>
		</form>

	</cfoutput>
</cfmodule>
