<template>
  <transition appear enter-active-class="animated fadeIn" leave-active-class="animated fadeOut">
  <form class="form-reset-password" @submit.prevent="reset">
    <div class="help is-info" v-if="notice">{{ notice }}</div>
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <div class="field">
      <label class="label has-text-light" for="password">New Password</label>
      <div class="control">
        <input v-model="password" type="password" class="input" id="password" placeholder="Password">
      </div>
    </div>
    <div class="field">
      <label class="label has-text-light" for="password">Password Confirmation</label>
      <div class="control">
        <input v-model="password_confirmation" type="password" class="input" id="password_confirmation" placeholder="Password Confirmation">
      </div>
    </div>
    <button type="submit" class="button is-primary">Reset password</button>
    <div>
      <router-link to="/singin" class="has-text-info">Sign in</router-link>
    </div>
  </form>
  </transition>
</template>

<script>
export default {
  name: "ResetPassword",
  data() {
    return {
      password: "",
      password_confirmation: "",
      error: "",
      notice: ""
    };
  },
  created() {
    this.checkPasswordToken();
  },
  methods: {
    reset() {
      if (!this.password) {
        this.notice = "Please input new password";
      } else if (!this.password_confirmation) {
        this.notice = "Please confirm your new password";
      } else {
        this.$http.plain
          .patch(`/password_resets/${this.$route.params.token}`, {
            password: this.password,
            password_confirmation: this.password_confirmation
          })
          .then(response => this.resetSuccessful(response))
          .catch(error => this.resetFailed(error));
      }
    },
    resetSuccessful(response) {
      this.notice =
        "Your password has been reset successfully! Please sign in with your new password.";
      this.error = "";
      this.password = "";
      this.password_confirmation = "";
    },
    resetFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "Something went wrong";
      this.notice = "";
    },
    checkPasswordToken() {
      this.$http.plain
        .get(`/password_resets/${this.$route.params.token}`)
        .catch(error => {
          this.resetFailed(error);
          this.$router.replace("/");
        });
    }
  }
};
</script>

<style>
.form-reset-password {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>
