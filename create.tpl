{include file='header.tpl' page="Places"}
{include file="all_css.tpl" css_form=true}
{include file="all_js.tpl"}

<fb:iframe id="mapFrame" src="{#callbackUrl#}googlemap/placescreate" smartsize="false" frameborder="0" scrolling="no" style="height: 1250px; width:100%;" />
{* <iframe id="mapFrame" src="{#callbackUrl#}googlemap/placescreate" smartsize="false" frameborder="0" scrolling="no" style="height: 500px; width:100%;" /> *}

{include file='footer.tpl'}