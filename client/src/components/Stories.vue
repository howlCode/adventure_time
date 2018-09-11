<template>
  <section class="section">
    <div class="container">
      <div class="columns is-multiline">
        <div class="column is-half" v-for="story in stories" :key="story.id">
          <div class="message is-medium main-story" @click="showStory(story)">
            <header class="message-header">
              <p class="message-header-title">{{ story.title }}</p>
              <p class="has-text-danger">
                Arcs Needing Votes:
                <span class="has-text-light">
                  {{ story.arcs.length }}
                </span>
              </p>
              <p class="has-text-danger">
                Arcs:
                <span class="has-text-light">
                  {{ story.arcs.length }}
                </span>
              </p>
            </header>
            <div class="message-body">
              <p>{{ textTruncate(story.body, 200) }}</p>
              <span class="is-italic is-pulled-right">
              Written by: {{ story.user.nickname }}
              </span>
            </div>
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
    }
  }
};
</script>

<style lang="css">
</style>
