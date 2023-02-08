<cfscript>

	sleep( randRange( 1000, 5000 ) );

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h1>
			ColdFusion + Hotwire Navigation Progress Bar Demo
		</h1>

		<p>
			<a href="index.htm">Home</a> -
			<a href="products.htm"><strong>Products</strong></a> -
			<a href="about.htm">About</a>
		</p>

		<hr />

		<h2>
			Products
		</h2>

		<p>
			Copy, copy, copy, copy....
		</p>

	</cfoutput>
</cfmodule>
