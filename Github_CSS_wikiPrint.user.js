// ==UserScript==
// @name        Github CSS wikiPrint
// @namespace   githubwikiprint
// @include     https://github.com/*/wiki
// @include     https://github.com/*/wiki/*
// @version     1
// @grant       none
// ==/UserScript==

var link = document.createElement('LINK');
link.rel = 'stylesheet';
link.href = 'https://github.com/eurodev/scripts/raw/master/github.css';
link.type = 'text/css';
link.media = 'print';
document.body.insertBefore(link, null);
