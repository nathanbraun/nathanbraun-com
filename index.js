import hljs from "highlight.js/lib/highlight";
// import Analytics from "./analytics";
import "highlight.js/styles/github.css";
import elm from 'highlight.js/lib/languages/elm';

// we're just importing the syntaxes we want from hljs
// in order to reduce our JS bundle size
// see https://bjacobel.com/2016/12/04/highlight-bundle-size/
hljs.registerLanguage('elm', elm);

import "./style.css";

const isPrerendering = navigator.userAgent.indexOf("Headless") >= 0;

// @ts-ignore
window.hljs = hljs;
const { Elm } = require("./src/Main.elm");
const pagesInit = require("elm-pages");

const trackPage = function(gtag, url) {
  gtag("event", 'page_view', {'path_path': url});
};

pagesInit({
  mainElmModule: Elm.Main
}).then(app => {

  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('config', "UA-158299232-1", {
    'send_page_view': false,
  });
  gtag('js', new Date());

  // watch for any analytics events
  app.ports.trackAnalytics.subscribe(payload => {
    switch (payload.action) {
      case "navigateToPage":
        trackPage(gtag, payload.data);
    }
  });
});


// global site tag
var gt = document.createElement('script');
gt.setAttribute('src',"https://www.googletagmanager.com/gtag/js?id=UA-158299232-1");

// only load if prerendering
if (!isPrerendering) {
  document.head.appendChild(gt);
};


// var ga = document.createElement('script');
// ga.setAttribute('src','./myscript.js');
// document.head.appendChild(ga);

// <script async src="https://www.googletagmanager.com/gtag/js?id=UA-158299232-1"></script>
