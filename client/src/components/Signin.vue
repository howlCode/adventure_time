<template>
  <form class="form-signin" @submit.prevent="signin">
    <h1 class="has-text-danger" v-if="redirect">You must be logged in to do that!</h1>
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
      <br />
      <router-link to="/forgot_password">Forgot Password</router-link>
    </div>
  </form>
</template>

<script>
export default {
  name: "Signin",
  props: ["redirect"],
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
      this.$http.plain
        .get("/me")
        .then(meResponse => {
          this.$store.commit("setCurrentUser", {
            currentUser: meResponse.data,
            csrf: response.data.csrf
          });
          this.error = "";
          this.$router.replace("/");
        })
        .catch(error => this.signinFailed(error));
    },
    signinFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "";
      this.$store.commit("unsetCurrentUser");
    },
    checkSignedIn() {
      if (this.$store.state.signedIn) {
        this.$router.replace("/");
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
