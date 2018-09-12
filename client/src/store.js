import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    currentUser: {},
    signedIn: false,
    csrf: null
  },
  getters: {
    isSignedIn(state) {
      return state.signedIn;
    },
    currentUserId(state) {
      return state.currentUser && state.currentUser.id;
    }
  },
  mutations: {
    setCurrentUser(state, { currentUser, csrf }) {
      state.currentUser = currentUser;
      state.signedIn = true;
      state.csrf = csrf;
    },
    unsetCurrentUser(state) {
      state.currentUser = {};
      state.signedIn = false;
      state.csrf = null;
    },
    refresh(state, csrf) {
      state.signedIn = true;
      state.csrf = csrf;
    }
  },
  plugins: [createPersistedState()]
});
