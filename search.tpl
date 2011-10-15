{include file="all_css.tpl"}
{include file='header.tpl' page="Places"}
{include file="all_js.tpl" ajax=true dialog=true}

<div class="column doubleColumn rightMargin">
	<div class="contentBox">
		<div class="header clearfix">
			<div class="floatLeft">
				<fb:intl>Places</fb:intl>
			</div>
		</div>
		{include file='paginationPost.tpl' page="Places"}
		
		<div class="inner noInnerMargins">
			<fb:iframe src="{#callbackUrl#}googlemap/placessearch?ptlat={$output.network.location.latitude}&ptlong={$output.network.location.longitude}&ptzoom={$output.network.location.mapZoom}" smartsize="false" frameborder="0" scrolling="no" style="height: 500px; width:100%;" />
		</div>
	</div>	
</div>

<div class="column singleColumn leftMargin">
	<div class="contentBox">
		<div class="header clearfix">
			<fb:intl>Places Around you</fb:intl>
		</div>
		<div class="inner noInnerMargins">
			Content here
		</div>
	</div>
	
	<div class="contentBox">
		<div class="header clearfix">
			<fb:intl>Places Friend Places</fb:intl>
		</div>
		<div class="inner noInnerMargins">
			Content here
		</div>
	</div>		
	
</div>


{include file='footer.tpl'}