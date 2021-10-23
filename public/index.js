/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */

/** @type ElmPagesInit */
export default {
  load: async function (elmLoaded) {
    const app = await elmLoaded;
    console.log("App loaded", app);
    app.ports.trackAnalytics.subscribe(payload => {
      console.log(payload);
  const tests = JSON.parse(localStorage.getItem('ab-tests'));
    app.ports.storeTests.subscribe(payload => {
      localStorage.setItem('ab-tests', JSON.stringify(payload));
    });
  },
  flags: function () {
    return "You can decode this in Shared.elm using Json.Decode.string!";
  },
};
