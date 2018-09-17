<template>
  <form class="form-story" @submit.prevent="submitStory">
    <div class="has-text-centered" v-if="errors" v-for="(value, key) in errors" :key="key">
      <h2>Story Could Not Be Created:</h2>
        <p class="has-text-danger">{{ key.toUpperCase() }} - {{ value }}</p>
    </div>
    <div class="field">
      <label class="label" for="title">Title</label>
      <div class="control">
        <input v-model="title" type="title" class="input" id="title" placeholder="The Great Title">
      </div>
    </div>
    <div class="field">
      <label class="label" for="body">Story</label>
      <div class="control">
        <textarea v-model="body" class="textarea" id="body" rows="15" placeholder="Once upon a time..."></textarea>
      </div>
    </div>
    <button type="submit" class="button is-primary">Submit</button>
  </form>
</template>

<script>
export default {
  name: "StoryForm",
  data() {
    return {
      title: "",
      body: "",
      errors: ""
    };
  },
  created() {
    if (!this.$store.getters.isSignedIn) {
      this.$router.push({
        name: "Signin",
        params: { redirect: true }
      });
    }
  },
  methods: {
    submitStory() {
      this.$http.secured
        .post("/stories", { title: this.title, body: this.body })
        .then(response => this.submitSuccessful(response))
        .catch(error => this.submitFailed(error));
    },
    submitSuccessful(response) {
      this.errors = "";
      this.$router.replace("/");
    },
    submitFailed(error) {
      this.errors = error.response.data;
    }
  }
};
</script>

<style>
.form-story {
  width: 70%;
  max-width: 800px;
  margin: 0 auto;
  margin-top: 50px;
}
</style>
