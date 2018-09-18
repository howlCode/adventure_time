<template>
  <transition appear enter-active-class="animated fadeIn" leave-active-class="animated fadeOut">
  <form class="form-story-arc" @submit.prevent="submitStory">
    <div class="has-text-centered" v-if="errors" v-for="(value, key) in errors" :key="key">
      <h2>Story-Arc Could Not Be Created:</h2>
        <p class="has-text-danger">{{ key.toUpperCase() }} - {{ value }}</p>
    </div>
    <div class="field">
      <label class="label has-text-light" for="body">Story-Arc</label>
      <div class="control">
        <textarea v-model="body" class="textarea" id="body" rows="15" placeholder="Once upon a time..."></textarea>
      </div>
    </div>
    <button type="submit" class="button is-primary">Submit</button>
    <router-link to="/" class="button is-danger">Cancel</router-link>
  </form>
  </transition>
</template>

<script>
export default {
  name: "ArcForm",
  data() {
    return {
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
        .post(`/stories/${this.$route.params.id}/arcs`, {
          body: this.body,
          story_id: this.$route.params.id
        })
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
.form-story-arc {
  width: 70%;
  max-width: 800px;
  margin: 0 auto;
  margin-top: 50px;
}
</style>
