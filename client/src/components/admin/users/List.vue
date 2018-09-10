<template>
  <div class="users">
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <h3>Users</h3>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Email</th>
          <th>Role</th>
          <th v-if="showStoriesLink()">Stories</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.id" :user="user">
          <th>{{ user.id }}</th>
          <td>{{ user.email }}</td>
          <td>{{ user.role }}</td>
          <router-link :to="`/admin/users/${user.id}/todos`">
            <i class="fa fa-list-ul"></i>
          </router-link>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: "UsersList",
  data() {
    return {
      error: "",
      users: []
    };
  },
  created() {
    if (
      this.$store.state.signedIn &&
      (this.$store.getters.isAdmin || this.$store.getters.isManager)
    ) {
      this.$http.secured
        .get("/admin/users")
        .then(response => {
          this.users = response.data;
        })
        .catch(error => {
          this.setError(error, "Something went wrong");
        });
    } else {
      this.$router.replace("/signin");
    }
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    },
    showStoriesLink() {
      return this.$store.getters.isAdmin;
    }
  }
};
</script>
