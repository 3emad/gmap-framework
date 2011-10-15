<script type="text/javascript">
	var appUrl = "{#appUrl#}";
	var callbackUrl = "{#callbackUrl#}";
	var colorfrom = '#ff7';
	var default_duration = 1750;
	{literal}
	function highlight(ele, type, seconds){
		// will change to jQuery animate
		if(seconds === undefined){
			seconds = default_duration;
		}
				
		if(type !== undefined){
			switch(type){
				case 'error': colorfrom = '#f77'; break;
				case 'success': colorfrom = '#7f7'; break;
			}
		}
		colorto = ele.getStyle('color');
		Animation(ele).to('background','#fff').from('background', colorfrom ).duration(seconds).go();
	}
	{/literal}

	
</script>

{if isset($dialog)}
{literal}
<script type="text/javascript">
	/*
	// jQuery Function 
	function $(id) {
		var element = document.getElementById(id);
		if (element == undefined || element == null)
			element = document.createElement();
		return element;
	}*/

	// Animate
	function hide(id, animate) {
		if (animate)
			return Animation($(id)).to('height', '0px').to('opacity', 0).hide()
					.go();
		return $(id).setStyle('display', 'none');
	}

	function show(id, animate) {
		if (animate)
			return Animation($(id)).to('height', 'auto').from('0px').to(
					'opacity', 1).from(0).blind().show().go();
		return $(id).setStyle('display', '');
	}

	// onConfirm
	function confirm(text, context, ok, cancel, pop) {
		if (ok === undefined)
			ok = 'OK';
		if (cancel === undefined)
			cancel = 'Cancel';

		var dialog;
		if (!(pop === undefined)){
			dialog = new Dialog(Dialog.DIALOG_POP);
			dialog.showChoice(text, '', ok, cancel);
		}else{
			if (context) {
				dialog = new Dialog(Dialog.DIALOG_CONTEXTUAL);
				dialog.setContext(context).showChoice(text, '', ok, cancel);
			} else {
				dialog = new Dialog(Dialog.DIALOG_POP);
				dialog.showChoice(text, '', ok, cancel);
			}
		}

		dialog.onconfirm = function() {
			if (context.getTagName() == 'FORM')
				context.submit();
			else if (context.getTagName() == 'A')
				document.setLocation(context.getHref());
		};
		return false;
	}

	// Dialog Box
	function dialog(id, js_str, title, width) {
		var dialog = new Dialog();
		if (width)
			dialog.setStyle('width', width);

		dialog.showChoice(title, js_str).onconfirm = function() {
			var form = $(id);
			if (form)
				form.submit();
			return true;
		}
		return false;
	}

	// Dialog Msg Form
	function dialogMsgForm(id, js_str, title, width) {
		var dialog = new Dialog();
		if (width)
			dialog.setStyle('width', width);
		dialog.showMessage(title, js_str, 'Okay').onconfirm = function() {
			var form = $(id);
			if (form)
				form.submit();
			return true;
		}
		return false;
	}

	// Dialog Msg
	function dialogMsg(js_str, title, width) {
		var dialog = new Dialog()
		if (width)
			dialog.setStyle('width', width);
		dialog.showMessage(title, js_str, 'Close').onconfirm = function() {
			return true;
		}
		return false;
	}

	// Just a msg
	function debug(text) {
		dialogMsg(text, 'DEBUG');
	}
</script>
{/literal}
{/if}

{if isset($publishPermssions)}
<script type="text/javascript">
{literal}
function publishPermssions(){
	Facebook.showPermissionDialog('publish_stream, read_stream');
}
{/literal}
</script>
{/if}

{if isset($streamPublish)}
<script type="text/javascript">
{literal}
var stream_user_message;
var stream_url;
function publishStream(target_id, url, attachment, user_message_prompt, action_links, default_user_text)
{
       if (url === undefined || url == null || url == "")
               url = "{/literal}{#appUrl#}{literal}";
				// arguments
       if (user_message_prompt === undefined || user_message_prompt == null || user_message_prompt == "")
               user_message_prompt = "Tell your friends about {/literal}{#appName#}{literal}";

				// variable initilized on the global scope
       if(stream_user_message !== undefined)
    	   user_message_prompt = stream_user_message;

       if(stream_url !== undefined)
    	   url = stream_url;
				
       if (default_user_text === undefined || default_user_text == null || default_user_text == "")
               default_user_text = "";

       if (target_id === undefined){
       		target_id = null;   // all users
       }

       if (attachment === undefined){
    	   attachment = null;
      }

      //Facebook.streamPublish(default_user_text, attachment, action_links, target_id, user_message_prompt, newsfeed_callback);
      Facebook.streamPublish(default_user_text, attachment, action_links, target_id, user_message_prompt, newsfeed_callback);
      //return false;
}

function streamInit(user_message, url, action_links, user_id, attachment, default_text){
	if(shareTemp){
		publishStream( user_id, url, attachment, user_message, action_links, default_text);
	}
}

var shareTemp = false;
// Emad: Yeah i know this is NOT THE WAY but that @$(*#& setInnerFBML and BETA setInnerXHTML is not replacing strings!
var eleO = document.getElementById('shareTempO');
var eleX = document.getElementById('shareTempX');
function shareCheck(){
	if(shareTemp){
		shareTemp = false;
		eleO.setStyle('display','none');
		eleX.setStyle('display','block');
		highlight(eleX);
	}else{
		shareTemp = true;
		eleX.setStyle('display','none');
		eleO.setStyle('display','block');
		highlight(eleO);
	}
	return false;
}

{/literal}
</script>
{/if}

{if isset($ajax)}
<script type="text/javascript">
{literal}
var ajax;
var html;
function init_ajax(div,html,indicator){

	//http://static.ak.fbcdn.net/images/loaders/indicator_blue_large.gif
	if(indicator == undefined){
		document.getElementById(div).setInnerXHTML('<div id="indicator" style="text-align:center; margin: auto;"><div><img src="{/literal}{#spinnerUrl#}{literal}" /></div></div>');
	}else{
		if(indicator.length > 10){
			document.getElementById(div).setInnerXHTML(indicator);
		}
	}

	ajax = new Ajax();
  ajax.responseType = Ajax.FBML;
  ajax.requireLogin = true;
	ajax.ondone = function(data){
		if(html === undefined){
			document.getElementById(div).setInnerFBML(data);
		}
		document.getElementById(div).setInnerXHTML(html);
	};
}

function ajaxtion(url, target) {
		init_ajax(target);
    ajax.post(url);
}

{/literal}
</script>
{/if}


{if isset($js_tabs)}
<script type="text/javascript" src="{#callbackUrl#}js/tabs.js?1.21"></script>
{/if}

{if isset($gmaps)}
<script type="text/javascript" 
	src="http://maps.google.com/maps/api/js?sensor=true">
</script>
<script type="text/javascript"
	src="http://code.google.com/apis/gears/gears_init.js">
</script>
<!-- http://www.maxmind.com/app/javascript_city -->
<script type="text/javascript"
	src="http://j.maxmind.com/app/geoip.js">
</script>
<script type="text/javascript">
	{if isset($user.location.latitude)}
		var userDefined = new google.maps.LatLng({$user.location.latitude},{$user.location.longitude});
	{else}
		var userDefined = new google.maps.LatLng(geoip_latitude(),geoip_longitude());
	{/if}
</script>
<script type="text/javascript" src="{#callbackUrl#}js/gmaps.js?1.5"></script>
{/if}


{if isset($js_status)}
<script type="text/javascript">
{* {#callbackUrl#}profile/changestatus *}

{* PLEASE CHECK index/index.tpl for the template of the variable passed and usage *}
{literal}

var id;

function setcursor(e) {
	e.focus();
	e.setValue(e.getValue() + '');
}

function clearstatus(x) {
	document.getElementById('statusbox'+x).setInnerXHTML('<i>Please wait...</i>');
}

function setStatus(x) {
	id = x;
	{/literal}{if $output.locale|strstr:'en' == $output.locale}{literal}
	document.getElementById('statustext'+x).setValue('is ');
	{/literal}{else}{literal}
	document.getElementById('statustext'+x).setValue('');
	{/literal}{/if}{literal}
}

function clearPetStatus(id,petId,petName,relation){
	indicator = '';
	init_ajax('statusbox'+id,undefined,indicator);
	
	urlGenerated = '?dbuid='+escape(petId)+'&currentrelation='+escape(relation)+'&petname='+escape(petName)+'&petnum='+escape(id)+'&statustext';
	ajax.post("{/literal}{#callbackUrl#}{literal}profile/changestatus"+urlGenerated);
	document.getElementById('statustext'+id).setValue('What\'s on '+petName+'\'s mind?');
}
{/literal}
</script>
{/if}

{if isset($js_newsfeed)}
<script type="text/javascript">
{literal}

var links = [];

function globalSNewsFeed(url, attachment, user_message_prompt, default_user_text, action_links){
       if (url === undefined || url == null || url == "")
               url = "{/literal}{#appUrl#}{literal}";
       if (user_message_prompt === undefined || user_message_prompt == null || user_message_prompt == "")
               user_message_prompt = "Tell your friends about {/literal}{#appName#}{literal}";
       if (default_user_text === undefined || default_user_text == null || default_user_text == "")
               default_user_text = "";
       var target_id = null;   // all users
			
       Facebook.streamPublish(default_user_text, attachment, action_links, target_id, user_message_prompt, newsfeed_callback);
      return false;
}

function newsfeed_callback(post_id, exception)
{
	//console.log('successful');
}

function streamIt(elem){
	globalSNewsFeed(elem.url,elem.attachment,null, elem.message,elem.action_links );
}

</script>
{/literal}
{/if}