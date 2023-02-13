<cfmodule template="./tags/page.cfm" section="home">
	<cfoutput>

		<h2>
			Welcome to Our Site!
		</h2>

		<p>
			Copy, copy, copy....
		</p>

		<h3>
			Check Out Our Products
		</h3>

		<ul class="products">
			<cfloop index="productID" from="101" to="110">
				<li
					data-controller="hover-preload"
					data-hover-preload-delay-value="500"
					class="products__item">

					<a
						href="product.htm?id=#productID#"
						data-hover-preload-target="link"
						class="products__link">
						Product #ucase( productID )#
					</a>
				</li>
			</cfloop>
		</ul>

	</cfoutput>
</cfmodule>
