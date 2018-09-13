<template>
  <section>
    <nav class="navbar is-dark" aria-label="main navigation">
      <div class="navbar-brand">
        <i class="far fa-star"></i><router-link class="logo-link" to="/"><h1 id="logo">Adventure Time</h1></router-link>
        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>
      <div class="navbar-menu">
        <div class="navbar-start">
          <i class="far fa-thumbs-up nav-icon has-text-primary"></i>
          <router-link class="navbar-item" to="/">Vote on New Story-Arcs!</router-link>
          <i class="far fa-eye nav-icon has-text-info"></i>
          <router-link class="navbar-item" to="/stories">See All Stories</router-link>
          <i class="fas fa-edit nav-icon has-text-danger"></i>
          <router-link class="navbar-item" to="/new-story">Create a New Story</router-link>
        </div>
        <div class="navbar-end">
          <div class="navbar-item">
            <button v-if="isSignedIn()" class="button is-light" @click="signOut()">Sign out</button>
            <router-link v-if="!isSignedIn()" class="button is-primary" to="/signin">Sign in</router-link>
          </div>
        </div>
      </div>
      <h2>{{ error }}</h2>
    </nav>
  </section>
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
    isSignedIn() {
      return this.$store.getters.isSignedIn;
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
.navbar {
  margin-bottom: -10px;
}
.navbar-brand h1 {
  margin-right: 50px;
}
.spacer {
  margin-top: 20px;
}
.nav-pages {
  margin-bottom: -30px;
}
.fa-star {
  margin-top: 5px;
  margin-left: 10px;
  margin-right: 10px;
}
.nav-icon {
  margin-top: 20px;
}
</style>