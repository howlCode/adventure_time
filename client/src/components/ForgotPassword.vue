<template>
  <form class="form-forgot-password" @submit.prevent="submit">
    <div class="help is-info" v-if="notice">{{ notice }}</div>
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <div class="field">
      <label class="label" for="email">Email address</label>
      <div class="control">
        <input v-model="email" type="email" class="input" id="email" placeholder="email@example.com">
      </div>
    </div>
    <button type="submit" class="button is-primary">Reset Password</button>
    <div>
      <router-link to="/signin">Sign in</router-link>
      <br />
      <router-link to="/signup">Sign up</router-link>
    </div>
  </form>
</template>

<script>
export default {
  name: "ForgotPassword",
  data() {
    return {
      email: "",
      error: "",
      notice: ""
    };
  },
  methods: {
    submit() {
      if (this.email) {
        this.$http.plain
          .post("/password_resets", { email: this.email })
          .then(() => this.submitSuccessful())
          .catch(error => this.submitFailed(error));
      } else {
        this.notice = "Please input an email.";
      }
    },
    submitSuccessful() {
      this.notice = "Email with password reset instructions has been sent.";
      this.error = "";
      this.email = "";
    },
    submitFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "";
    }
  }
};
</script>

<style>
.form-forgot-password {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>
