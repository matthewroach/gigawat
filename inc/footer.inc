

</div><!--- container - set in header.inc --->

<div class="row footer">
	<div class="col6 colcenter">
    <cfoutput>

		<ul class="nav tright">
			<li class="left">&copy; <a href="#APPLICATION.url#/" title="gigaw.at">gigaw.at</a></li>
			<li><a href="#APPLICATION.url#/?/about" title="About">About</a></li>
      <li><a href="#APPLICATION.url#/?/faq" title="FAQ">FAQ</a></li>
			<li><a href="http://twitter.com/gigaw_at" title="Gigatwat on Twitter">@gigaw_at</a></li>
		</ul>

    </cfoutput>
	</div>
</div>


  <cfset commonJs = [
      "/a/libs/jquery/jquery-1.8.2.js",
      "/a/libs/jqplugins/jquery.zclip.min.js",
      "/a/js/shorten.js"
    ]>
  <cfjavascript src="#commonJs#" MINIMIZE="true" path="/" />

  <cfif (isDefined( "extraJs" ) ) >
    <cfjavascript src="#extraJs#" MINIMIZE="true" path="/" />
  </cfif>

</body>
</html>
