// ==UserScript==
// @name        Github CSS wikiPrint Crononauta
// @namespace   githubwikiprintcrono
// @include     https://github.com/crononauta/*/wiki
// @include     https://github.com/crononauta/*/wiki/*
// @version     1
// @grant       none
// ==/UserScript==

var style = document.createElement('STYLE');
style.type = 'text/css';
style.media = 'print';
style.innerHTML = '.pagehead, #header, #footer, .gollum-minibutton, #gollum-footer, #markdown-help, #ajax-error-message, #logo-popup, #footer-push { \
  display: none; \
} \
\
#wrapper #wiki-wrapper #head h1 { \
  background: url("http://crononauta.com/themes/crononauta.com/images/logo-crononauta.png") no-repeat scroll 0 0; \
  display: block; \
  margin: 5px 0 0; \
  padding: 20px 70px 0; \
}';
document.body.insertBefore(style, null);
