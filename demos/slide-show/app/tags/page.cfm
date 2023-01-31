<!---
	Since we're wrapping the generated content, we only care about the end-mode tag
	execution. If we're in the start mode, just exit.
--->
<cfif ( thistag.executionMode == "start" )>

	<cfexit method="exitTemplate" />

</cfif>

<!--- In end-mode tag execution, wrap (and override) the generated content. --->
<cfsavecontent variable="thistag.generatedContent">
	<cfoutput>

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
			<!--- <meta name="turbo-cache-control" content="no-preview" /> --->
			<title>
				ColdFusion + Hotwire Slide Show Demo
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
			<base href="#request.appPath#/hotwire.cfm/" />

			<!---
				CAUTION: Since I'm setting the base-href to route through a ColdFusion
				file, our static assets have to use root-absolute paths so that they
				bypass the base tag settings.
			--->
			<script src="#request.appPath#/dist/main.js" defer async></script>
			<link rel="stylesheet" type="text/css" href="#request.appPath#/dist/main.css"></link>
		</head>
		<body>

			#thistag.generatedContent#

			<hr />

			<p>
				Page loaded at #timeFormat( now(), "HH:mm:ss.l" )#
			</p>

		</body>
		</html>

	</cfoutput>
</cfsavecontent>
