const DOMAIN: string = "nathanbraun.com";

type ElmPagesInit = {
  load: (elmLoaded: Promise<unknown>) => Promise<void>;
  flags: unknown;
};

const config: ElmPagesInit = {
  load: async function (elmLoaded) {
    await elmLoaded;
  },
  flags: function () {
    return "You can decode this in Shared.elm using Json.Decode.string!";
  },
};

export default config;

const pl: HTMLScriptElement = document.createElement('script');
pl.setAttribute('src', "/glib/js/script.js");
pl.setAttribute('data-domain', DOMAIN);
pl.setAttribute('data-api', "/glib/api/event");
document.head.appendChild(pl);
