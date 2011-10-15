{include file='header.tpl' page="Places"}
{include file="all_css.tpl" css_form=true}
{include file="all_js.tpl" ajax=true dialog=true}

<div class="column doubleColumn rightMargin">
	<div class="contentBox">
		<div class="header clearfix">
			<div class="floatLeft">
				<fb:intl>Places</fb:intl>
			</div>
		</div>
		{* {include file='paginationPost.tpl' page="Places"} *}
		
		<div class="subheader clearfix">
			<span class="floatRight">
				<a href="{#appUrl#}places/create">Create a Place</a>
			</span>
		</div>
		<div class="inner noInnerMargins">
			<fb:iframe id="mapFrame" src="{#callbackUrl#}googlemap/placesindex" smartsize="false" frameborder="0" scrolling="no" style="height: 600px; width:100%;" />
			{*<iframe id="mapFrame" src="{#callbackUrl#}googlemap/placesindex" smartsize="false" frameborder="0" scrolling="no" style="height: 600px; width:100%;" /> *}
		</div>
	</div>	
</div>

<div class="column singleColumn leftMargin">

	{*<div class="contentBox">
		
		<div class="header clearfix">
			<fb:intl>Actions</fb:intl>
		</div>
		<div class="inner noInnerMargins items">
			<div style="margin: 10px 0px;" class="dh_new_media_shell">
			
				<a href="#" class="dh_new_media" style="width:130px; margin-bottom:5px; float:none;" onclick="checkIn(); return false;">
					<div class="tr">
						<div class="bl">
							<div class="br">
								<span style="background-image: none; margin-left:0px; padding-left:9px;"><fb:intl>Check in </fb:intl><span id="checkInText"></span></span>
							</div>
						</div>
					</div>
				</a>
				
			</div>
		</div>
	</div>*}

	<div class="contentBox">
		<div class="header clearfix">
			<fb:intl desc="Your Places">Your Places</fb:intl>
		</div>
		<div class="inner">
			{foreach from=$userPlaces item=userPlace}
				<div style="border-bottom: 1px dashed #CCCCCC; margin-bottom: 8px; padding-bottom: 8px;">
					<div class="name"><a href="{#appUrl#}group/view/{$userPlace.networkId}">{$userPlace.name|escape}</a></div>
					<div class="description">{$userPlace.description|escape}</div>
					{*<strong>Distance:</strong> 0.4km*}
				</div>
			{foreachelse}
				<fb:intl desc="No Places Avilable">No Places Avilable</fb:intl>.
			{/foreach} 
		</div>
	</div>

	
</div>

{include file='footer.tpl'}