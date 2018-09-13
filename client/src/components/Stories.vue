<template>
  <section class="section">
    <div class="nav-pages">
      <div class="has-text-left">
        <router-link class="button is-danger" to="/">Vote on New Story-Arcs!</router-link>
        <span class="spacer"></span>
        <router-link class="button is-info is-pulled-right" to="/new-story">Create a New Story</router-link>
      </div>
    </div>
      <div class="columns is-multiline">
        <div class="column is-full" v-for="story in stories" :key="story.id">     
          <div class="message main-story" @click="showStory(story)">
            <header class="message-header">
              <p class="message-header-title">{{ story.title }}</p>
              <p class="has-text-light">
                Arcs:
                <span class="has-text-danger">
                 {{ story.arcs.length }}
                </span>
              </p>
            </header>
            <div class="message-body">
              <p>{{ textTruncate(story.body, 175) }}</p>
              <span class="is-italic has-text-primary">
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
      this.$router.push({ path: `/stories/${storyId}` });
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
.nav-pages {
  margin-bottom: 15px;
}
.spacer {
  margin: 50px;
}

.vote-text {
  font-size: 1.2rem;
}
</style>