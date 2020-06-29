import hljs from "highlight.js/lib/highlight";
import Analytics from "./analytics";
import "highlight.js/styles/github.css";
import elm from 'highlight.js/lib/languages/elm';
// we're just importing the syntaxes we want from hljs
// in order to reduce our JS bundle size
// see https://bjacobel.com/2016/12/04/highlight-bundle-size/
hljs.registerLanguage('elm', elm);

import "./style.css";
// @ts-ignore
window.hljs = hljs;
const { Elm } = require("./src/Main.elm");
const pagesInit = require("elm-pages");

// const fetchMetaData = field => {
//   const element = document.querySelector(`meta[name=${field}]`);

//   if (element) {
//     return element.getAttribute("content");
//   }
// };


pagesInit({
  mainElmModule: Elm.Main
}).then(app => {
  const analytics = new Analytics(
    "UA-158299232-1"
    // fetchMetaData("googleAnalyticsPropertyId") || "fake"
  );

  app.ports.trackAnalytics.subscribe(payload => {
    analytics[payload.action](payload.data);
  });
});


// global site tag
var gt = document.createElement('script');
gt.setAttribute('src',"https://www.googletagmanager.com/gtag/js?id=UA-158299232-1");
document.head.appendChild(gt);

// var ga = document.createElement('script');
// ga.setAttribute('src','./myscript.js');
// document.head.appendChild(ga);

// <script async src="https://www.googletagmanager.com/gtag/js?id=UA-158299232-1"></script>
