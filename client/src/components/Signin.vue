<template>
  <div class="has-text-centered">
    <h1 id="logo">Adventure Time</h1>

  <form class="form-signin" @submit.prevent="signin">
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <div class="field">
      <label class="label" for="email">Email address</label>
      <div class="control">
        <input v-model="email" type="email" class="input" id="email" placeholder="email@example.com">
      </div>
    </div>
    <div class="field">
      <label class="label" for="password">Password</label>
      <div class="control">
        <input v-model="password" type="password" class="input" id="password" placeholder="Password">
      </div>
    </div>
    <button type="submit" class="button is-primary">Sign in</button>
    <div>
      <router-link to="/signup">Sign up</router-link>
    </div>
  </form>
    </div>
</template>

<script>
export default {
  name: "Signin",
  data() {
    return {
      email: "",
      nickname: "",
      password: "",
      error: ""
    };
  },
  created() {
    this.checkSignedIn();
  },
  updated() {
    this.checkSignedIn();
  },
  methods: {
    signin() {
      this.$http.plain
        .post("/signin", { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error));
    },
    signinSuccessful(response) {
      if (!response.data.csrf) {
        this.signinFailed(response);
        return;
      }
      localStorage.csrf = response.data.csrf;
      localStorage.signedIn = true;
      this.error = "";
      this.$router.replace("/stories");
    },
    signinFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "";
      delete localStorage.csrf;
      delete localStorage.signedIn;
    },
    checkSignedIn() {
      if (localStorage.signedIn) {
        this.$router.replace("/stories");
      }
    }
  }
};
</script>

<style lang="css">
.form-signin {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>
