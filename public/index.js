/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */

/** @type ElmPagesInit */
export default {
  load: async function (elmLoaded) {
    const app = await elmLoaded;
    console.log("App loaded", app);
    app.ports.trackAnalytics.subscribe(payload => {
      switch (payload.action) {
        case "navigateToPage":
          console.log(payload.data);
          // trackPage(gtag, payload.data);
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

window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
});
