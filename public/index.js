/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */

const trackPage = function(gtag, url) {
  gtag("event", 'page_view', {'page_path': url});
};

/** @type ElmPagesInit */
export default {
  load: async function (elmLoaded) {
    const app = await elmLoaded;

    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('config', "UA-158299232-1", {
      'send_page_view': false,
    });
    gtag('js', new Date());

    app.ports.trackAnalytics.subscribe(payload => {
      switch (payload.action) {
        case "navigateToPage":
          trackPage(gtag, payload.data);

          var isso = document.createElement('script');
          isso.setAttribute('src',"https://isso.nathanbraun.com/js/embed.min.js");
          isso.setAttribute('data-isso',"https://isso.nathanbraun.com");
          // isso.setAttribute('src',"http://localhost:8001/js/embed.min.js");
          // isso.setAttribute('data-isso',"http://localhost:8001");
          isso.setAttribute('data-isso-avatar',"false");
          document.head.appendChild(isso);


      }
    });

  app.ports.storeTests.subscribe(payload => {
      localStorage.setItem('ab-tests', JSON.stringify(payload));
    });
  },

  flags: function () {
    const tests = JSON.parse(localStorage.getItem('ab-tests'));
    return tests;
  },
};

var gt = document.createElement('script');
gt.setAttribute('src',"https://www.googletagmanager.com/gtag/js?id=UA-158299232-1");
document.head.appendChild(gt);

var pl = document.createElement('script');
pl.setAttribute('src',"/js/script.js");
pl.setAttribute('data-domain',"nathanbraun.com");
document.head.appendChild(pl);

var isso = document.createElement('script');
isso.setAttribute('src',"https://isso.nathanbraun.com/js/embed.min.js");
isso.setAttribute('data-isso',"https://isso.nathanbraun.com");
// isso.setAttribute('src',"http://localhost:8001/js/embed.min.js");
// isso.setAttribute('data-isso',"http://localhost:8001");
isso.setAttribute('data-isso-avatar',"false");
document.head.appendChild(isso);

// <script defer data-domain="nathanbraun.com" src="https://plausible.io/js/plausible.js"></script>

window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
});


