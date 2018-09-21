<template>
  <section class="section">
    <transition appear enter-active-class="animated fadeIn">
    <h1 class="title has-text-light">Welcome to Inscribed!</h1>
    </transition>
    <h2 class="subtitle has-text-light">Where Creativity and Community Meet</h2>
    <p class="margin-bottom"><router-link v-if="!$isSignedIn()" to="/signup" class="button is-small is-info">Sign Up Here</router-link></p>
    <transition appear enter-active-class="animated slideInUp">
      <div class="columns is-multiline">
        <div class="column is-full" v-for="story in stories" :key="story.id">     
          <div class="message hover-story" @click="showStory(story)">
            <header class="message-header">
              <p class="message-header-title">{{ story.title }}</p>
              <p class="has-text-light">
                Arcs:
                <span class="has-text-info">
                 {{ story.arcs.length }}
                </span>
              </p>
            </header>
            <div class="message-body">
              <p>{{ $textTruncate(story.body, 175) }}</p>
              <span class="is-italic has-text-info">
                Written by: {{ story.user.nickname }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </section>
</template>

<script>
export default {
  name: "Main",
  data() {
    return {
      stories: []
    };
  },
  created() {
    this.$http.plain
      .get("/stories")
      .then(response => {
        this.stories = response.data;
      })
      .catch(error => this.setError(error, "Something went wrong"));
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    },
    showStory(story) {
      const storyId = story.id;
      this.$router.push({
        path: `/stories/${storyId}`
      });
    },
    newArc() {
      const storyId = this.story.id;
      this.$router.push({ path: `/story/${storyId}/new-arc` });
    }
  }
};
</script>

<style lang="css">
.vote-text {
  font-size: 1.2rem;
}
.margin-bottom {
  margin-bottom: 10px;
}
</style>