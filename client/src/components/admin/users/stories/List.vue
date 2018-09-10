<template>
  <div class="users">
    <div class="help is-danger" v-if="error">{{ error }}</div>
    <h3>User Stories</h3>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>User ID</th>
          <th>Title</th>
          <th>Manage</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="story in stories" :key="story.id" :story="story">
          <th>{{ story.user_id }}</th>
          <td>{{ story.title }}</td>
          <td><button @click="deleteStory(story)" class="button is-danger is-small">Delete</button></td>
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
    },
    deleteStory(story) {
      this.$http.secured
        .delete(`/stories/${story.id}`)
        .then(response => {
          this.error = response.data;
        })
        .catch(error => {
          this.setError(error, "Something went wrong");
        });
    }
  }
};
</script>
