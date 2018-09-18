<template>
  <section class="section">
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
              <p>{{ textTruncate(story.body, 175) }}</p>
              <span class="is-italic has-text-info">
                Written by: {{ story.user.nickname }}
              </span>
            </div>
          </div>
        </div>
      </div>
  </section>
</template>

<script>
export default {
  name: "Stories",
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
    textTruncate(str, len, end) {
      if (!len && !end) return str;
      end = end || "...";
      return str.substr(0, len - end.length) + end;
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
    },
    isSignedIn() {
      return this.$store.getters.isSignedIn;
    }
  }
};
</script>

<style lang="css">
.vote-text {
  font-size: 1.2rem;
}
</style>