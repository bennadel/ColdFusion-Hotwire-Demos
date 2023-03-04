<cfscript>

	param name="request.context.clearBanner" type="boolean" default=false;

	if ( request.context.clearBanner ) {

		application.bannerText = "";

		// If this request is not being scoped to a Turbo Frame (ie, Turbo Drive has not
		// yet taken over the page navigation), let's redirect the user back to the
		// homepage where ColdFusion will render the EMPTY banner.
		if ( ! request.turbo.isFrame ) {

			location( url = "index.htm", addToken = false );

		}

	}

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<!---
			These linked assets only matter if the Banner page is being rendered directly.
			If this page is being loaded as part of a Turbo Frame request, none of these
			assets will be loaded - only the matching Turbo Frame content within the body
			will be extracted and rendered within the calling context.
		--->
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" type="text/css" href="#request.appPath#/dist/main.css"></link>
	</head>
	<body>

		<!---
			If this Banner page is rendered directly, we want to you "_top" as the target
			so that the processing of the banner executes outside of any frame scoping
			(and will redirect back to the main page).
		--->
		<turbo-frame id="banner" target="_top">

			<cfmodule template="./banner_content.cfm" />

		</turbo-frame>

	</body>
	</html>

</cfoutput>
