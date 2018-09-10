<template>
  <nav class="navbar is-dark" aria-label="main navigation">
    <div class="navbar-brand">
      <router-link class="logo-link" to="/"><h1 id="logo">Adventure Time</h1></router-link>
      <a
        role="button"
        class="navbar-burger"
        aria-label="menu"
        aria-expanded="false"
      >
        <span class="is-light" aria-hidden="true" />
        <span aria-hidden="true" />
        <span aria-hidden="true" />
      </a>
    </div>
    <div class="navbar-menu">
      <div class="navbar-end">
        <div class="navbar-item">
          <div class="sign-out is-pulled-right">
            <router-link class="button is-info" v-if="showAdminLink()" to="/admin/users">Admin</router-link>
            <router-link v-if="signedIn()" class="button is-info" to="/stories/new">Create a New Story</router-link>
            <button v-if="signedIn()" class="button is-light" @click="signOut()">Sign out</button>
            <router-link v-if="!signedIn()" class="button is-primary" to="/signin">Sign in</router-link>
          </div>
        </div>
      </div>
    </div>
    <h2>{{ error }}</h2>
  </nav>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {
      error: ""
    };
  },
  methods: {
    signOut() {
      this.$http.secured
        .delete("/signin")
        .then(response => {
          this.$store.commit("unsetCurrentUser");
          this.$router.replace("/");
        })
        .catch(error => this.setError(error, "Cannot sign out"));
    },
    signedIn() {
      return this.$store.getters.isUser;
    },
    showAdminLink() {
      return this.$store.getters.isAdmin;
    },
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    }
  }
};
</script>

<style lang="css">
</style>