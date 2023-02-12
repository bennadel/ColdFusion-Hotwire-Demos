<cfmodule template="./tags/page.cfm" section="home">
	<cfoutput>

		<h2>
			Welcome to Our Site!
		</h2>

		<p>
			Copy, copy, copy....
		</p>

		<h2>
			Framed Content
		</h2>

		<turbo-frame
			id="home-frame"
			src="frame.htm"
			data-turbo-permanent
			data-controller="perm-frame">
			<p>
				Frame content is eagerly-loading....
			</p>
		</turbo-frame>

	</cfoutput>
</cfmodule>
