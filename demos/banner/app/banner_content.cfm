<cfoutput>

	<cfif application.bannerText.len()>

		<div class="banner">
			<p class="banner__text">
				#encodeForHtml( application.bannerText )#
			</p>
			<a href="banner.htm?clearBanner=true" class="banner__close">
				Close
			</a>
		</div>

	</cfif>

	<!--- We do not expect this tag to have a body. --->
	<cfexit method="exitTag" />

</cfoutput>
