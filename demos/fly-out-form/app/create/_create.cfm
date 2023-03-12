<!---
	When rendered as a top-level request, we can render the form AS-IS. However, if we're
	rendering inside a Turbo Frame (ie, we're trancluding the form into another page), we
	have to render the form inside a like-named Turbo Frame so that Hotwire can merge the
	results back into the live page.
	--
	NOTE: In a more robust architecture, this could be implemented much more seamlessly as
	a layout selection, such as a "standard" layout vs a "fly-out" layout. However, to
	keep things as simple as possible, I'm rendering both types of layouts right here in
	the same template so that we can see the mechanics at play.
--->
<cfif request.turbo.isFrame>


	<turbo-frame id="fly-out-frame">
		<div class="fly-out">
			<div class="fly-out__content">

				<!--- !!! Reused Form UI !!! --->
				<cfinclude template="_form.cfm" />

			</div>
			<a href="index.htm" class="fly-out__backdrop">
				Close
			</a>
		</div>
	</turbo-frame>


<!--- Standard page layou, non-frame version. --->
<cfelse>


	<cfmodule template="../tags/page.cfm">

		<!--- !!! Reused Form UI !!! --->
		<cfinclude template="_form.cfm" />

	</cfmodule>


</cfif>
