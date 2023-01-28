<cfif ( thistag.executionMode == "end" )>

	<cfsavecontent variable="thistag.generatedContent">
		
		<!doctype html>
		<html lang="en">
		<head>
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1" />
			<!---
				The "no-preview" directive tells Turbo Drive to not show a cached version
				during an "application visit" (ie, clicking a link, submitting a form);
				but, that caching can still be used for "restore visits" (ie, hitting the
				browser's back button).
			--->
			<meta name="turbo-cache-control" content="no-preview" />
			<title>
				Hello World - ColdFusion + Hotwire
			</title>

			<!---
				CAUTION: Since Hotwire Turbo Drive needs to work with ".htm" files, I'm
				configuring the base HREF to apply relative paths as the PATH_INFO after
				the "hotwire.cfm" file (which doesn't exist). The onRequest() event
				handler (in Application.cfc) will then dynamically execute the
				corresponding ".cfm" file by swapping the ".htm" file-extension with a
				".cfm" file-extension.
				--
				NOTE: This is just for a local demo - I would not use this approach in a
				production setting (I'd use more robust URL rewriting).
			--->
			<cfoutput>
				<base href="#request.appPath#/hotwire.cfm/" />
			</cfoutput>

			<!---
				CAUTION: Since I'm setting the base-href to route through a ColdFusion
				file, our static assets have to use root-absolute paths so that they
				bypass the base tag settings.
			--->
			<cfoutput>
				<script src="#request.appPath#/dist/main.js" defer async></script>
				<link rel="stylesheet" type="text/css" href="#request.appPath#/dist/main.css"></link>
			</cfoutput>
		</head>
		<body>

			<div
				data-controller="m1-header"
				data-m1-header-active-class="m1-header--active"
				data-action="
					mouseenter->m1-header#activate
					mouseleave->m1-header#deactivate
				"
				class="m1-header">
				<span class="m1-header__cfml">
					Lucee CFML
				</span>
				<span class="m1-header__operator">
					+
				</span>
				<span class="m1-header__hotwire">
					Hotwire
				</span>
				<span class="m1-header__operator">
					=
				</span>
				<span class="m1-header__yay">
					Yay!<span data-m1-header-target="yay"></span>
				</span>
			</div>

			<cfoutput>
				#thistag.generatedContent#
			</cfoutput>
			
			<hr />

			<cfoutput>
				<p>
					Page loaded at #timeFormat( now(), "HH:mm:ss" )#
				</p>
			</cfoutput>

		</body>
		</html>

	</cfsavecontent>

</cfif>
