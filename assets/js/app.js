// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html";
import { Socket } from "phoenix";
import NProgress from "nprogress";
import { LiveSocket } from "phoenix_live_view";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start());
window.addEventListener("phx:page-loading-stop", info => NProgress.done());

function syntaxHighlight(json) {
  if (typeof json != "string") {
    json = JSON.stringify(json, undefined, 2);
  }
  json = json
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
  return json.replace(
    /("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g,
    function(match) {
      var cls = "number";
      if (/^"/.test(match)) {
        if (/:$/.test(match)) {
          cls = "key";
        } else {
          cls = "string";
        }
      } else if (/true|false/.test(match)) {
        cls = "boolean";
      } else if (/null/.test(match)) {
        cls = "null";
      }
      return '<span class="' + cls + '">' + match + "</span>";
    }
  );
}

function isJsonString(jsonString) {
  // This function below ('printError') can be used to print details about the error, if any.
  // Please, refer to the original article (see the end of this post)
  // for more details. I suppressed details to keep the code clean.
  //
  let printError = function(error, explicit) {
    console.log(
      `[${explicit ? "EXPLICIT" : "INEXPLICIT"}] ${error.name}: ${
        error.message
      }`
    );
  };

  try {
    JSON.parse(jsonString);
    return true; // It's a valid JSON format
  } catch (e) {
    return false; // It's not a valid JSON format
  }
}

function prettyPrinting() {
  var instances = document.getElementsByClassName("json");
  for (let instance of instances) {
    let content = instance.innerHTML;
    if (isJsonString(content)) {
      try {
        let obj = JSON.parse(content);
        content = JSON.stringify(JSON.parse(obj), undefined, 4);
        instance.innerHTML = syntaxHighlight(content);
        instance.style.whiteSpace = "pre";
      } catch (e) {
        return false; // It's not a valid JSON format
      }
    }
  }
}

let Hooks = {};

Hooks.PrettyPrint = {
  mounted() {
    prettyPrinting();
  },
  updated() {
    prettyPrinting();
  }
};

// connect if there are any LiveViews on the page

let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks
});
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket;
