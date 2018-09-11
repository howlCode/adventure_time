<template>
  <div class="users">
    <form class="form-edit" @submit.prevent="update">
      <div class="help is-info" v-if="notice">{{ notice }}</div>
      <div class="help is-danger" v-if="error">{{ error }}</div>
      <div class="field">
        <label class="label">Email address - {{ user.email }}</label>
      </div>
      <div class="field">
        <select v-model="user.role" class="input" id="role">
          <option value='admin'>Admin</option>
          <option value='user'>User</option>
        </select>
      </div>
      <button type="submit" class="button is-primary">Update</button>
      <div>
        <router-link to="/admin/users">Users</router-link>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: "EditUsers",
  data() {
    return {
      error: "",
      notice: "",
      user: {}
    };
  },
  created() {
    this.checkSignedIn();
  },
  methods: {
    update() {
      this.$http.secured
        .patch(`/admin/users/${this.$route.params.id}`, {
          user: { role: this.user.role }
        })
        .then(response => this.updateSuccessful(response))
        .catch(error => this.updateFailed(error));
    },
    updateSuccessful(response) {
      this.notice = "User updated";
      this.error = "";
    },
    updateFailed(error) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        "";
      this.notice = "";
    },
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
      this.notice = "";
    },
    checkSignedIn() {
      if (this.$store.state.signedIn && this.$store.getters.isAdmin) {
        this.$http.secured
          .get(`/admin/users/${this.$route.params.id}`)
          .then(response => {
            if (this.$store.getters.currentUserId === response.data.id) {
              this.$router.replace("/");
              return;
            }
            this.user = response.data;
          })
          .catch(error => {
            this.setError(error, "Something went wrong");
          });
      } else {
        this.$router.replace("/");
      }
    }
  }
};
</script>