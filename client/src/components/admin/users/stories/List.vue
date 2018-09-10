<template>
  <div class="users">
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <h3>User Stories</h3>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>User ID</th>
          <th>Title</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="story in stories" :key="story.id" :story="story">
          <th>{{ story.id }}</th>
          <th>{{ story.user_id }}</th>
          <td>{{ story.title }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: "UserStoriesList",
  data() {
    return {
      error: "",
      stories: []
    };
  },
  created() {
    if (this.$store.state.signedIn && this.$store.getters.isAdmin) {
      this.$http.secured
        .get(`/admin/users/${this.$route.params.id}/stories`)
        .then(response => {
          this.stories = response.data;
        })
        .catch(error => {
          this.setError(error, "Something went wrong");
        });
    } else {
      this.$router.replace("/sigin");
    }
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    }
  }
};
</script>