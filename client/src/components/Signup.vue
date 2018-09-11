<template>
  <form class="form-signup" @submit.prevent="signup">
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <div class="field">
      <label class="label" for="email">Email address</label>
      <div class="control">
        <input v-model="email" type="email" class="input" id="email" placeholder="email@example.com">
      </div>
    </div>
    <div class="field">
      <label class="label" for="nickname">Nickname</label>
      <div class="control">
        <input v-model="nickname" type="text" class="input" id="nickname" placeholder="StoryWriter101">
      </div>
    </div>
    <div class="field">
      <label class="label" for="password">Password</label>
      <div class="control">
        <input v-model="password" type="password" class="input" id="password" placeholder="Password">
      </div>
    </div>
    <div class="field">
      <label class="label" for="password">Password Confirmation</label>
      <div class="control">
        <input v-model="password_confirmation" type="password" class="input" id="password_confirmation" placeholder="Password Confirmation">
      </div>
    </div>
    <button type="submit" class="button is-primary">Sign up</button>
    <div>
      <router-link to="/signin">Sign in</router-link>
    </div>
  </form>
</template>

<script>
export default {
  name: "Signup",
  data() {
    return {
      email: "",
      nickname: "",
      password: "",
      password_confirmation: "",
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
    signup() {
      this.$http.plain
        .post("/signup", {
          email: this.email,
          nickname: this.nickname,
          password: this.password,
          password_confirmation: this.password_confirmation
        })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error));
    },
    signupSuccessful(response) {
      if (!response.data.csrf) {
        this.signupFailed(response);
        return;
      }
      this.$store.commit("setCurrentUser", {
        currentUser: meResponse.data,
        csrf: response.data.csrf
      });
      this.error = "";
      this.$router.replace("/");
    },
    signupFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "Something went wrong";
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
.form-signup {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>