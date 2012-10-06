// ==UserScript==
// @name        Github CSS wikiPrint
// @namespace   githubwikiprint
// @include     https://github.com/*/wiki
// @include     https://github.com/*/wiki/*
// @version     1
// @grant       none
// ==/UserScript==

var style = document.createElement('STYLE');
style.type = 'text/css';
style.media = 'print';
style.innerHTML = '.pagehead, #header, #footer, .gollum-minibutton, #gollum-footer, #markdown-help, #ajax-error-message, #logo-popup, #footer-push { \
  display: none; \
};
document.body.insertBefore(style, null);
