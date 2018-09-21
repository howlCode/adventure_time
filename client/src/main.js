import Vue from "vue";
import App from "./App";
import router from "./router";
import { store } from "./store";
import VueAxios from "vue-axios";
import { securedAxiosInstance, plainAxiosInstance } from "./backend/axios";
import { textTruncate, isSignedIn } from "./utils";
require("./assets/sass/main.scss");

Vue.prototype.$textTruncate = textTruncate;
Vue.prototype.$isSignedIn = isSignedIn;

Vue.config.productionTip = false;
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
});

/* eslint-disable no-new */
new Vue({
  el: "#app",
  router,
  store,
  securedAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: "<App/>"
});
