(function(){window.AwesomeShareButtons={openUrl:function(e){return window.open(e),!1},share:function(e){var t,o,r,n,a,s;switch(r=$(e).data("site"),n=encodeURIComponent($(e).parent().data("title")||""),o=encodeURIComponent($(e).parent().data("img")||""),s=encodeURIComponent($(e).parent().data("url")||""),0===s.length&&(s=encodeURIComponent(location.href)),r){case"email":location.href="mailto:?to=&subject="+n+"&body="+s;break;case"twitter":AwesomeShareButtons.openUrl("https://twitter.com/home?status="+n+": "+s);break;case"facebook":AwesomeShareButtons.openUrl("http://www.facebook.com/sharer.php?u="+s);break;case"google_plus":AwesomeShareButtons.openUrl("https://plus.google.com/share?url="+s);break;case"delicious":AwesomeShareButtons.openUrl("http://www.delicious.com/save?url="+s+"&title="+n+"&jump=yes&pic="+o);break;case"pinterest":AwesomeShareButtons.openUrl("http://www.pinterest.com/pin/create/button/?url="+s+"&media="+o+"&description="+n);break;case"tumblr":t=function(t){var o;if(o=$(e).attr("data-"+t))return encodeURIComponent(o)},a=function(){var e,r,a,c;return r=t("type")||"link",e=function(){switch(r){case"text":return"title="+(n=t("title")||n);case"photo":return n=t("caption")||n,c=t("source")||o,"caption="+n+"&source="+c;case"quote":return a=t("quote")||n,c=t("source")||"","quote="+a+"&source="+c;default:return n=t("title")||n,s=t("url")||s,"name="+n+"&url="+s}}(),"/"+r+"?"+e},AwesomeShareButtons.openUrl("http://www.tumblr.com/share"+a())}return!1}}}).call(this);