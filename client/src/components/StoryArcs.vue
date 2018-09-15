<template>
  <section class="section">
    <div class="container">
      <h2 class="subtitle">The story began...
      <button @click="newArc" class="button is-primary is-pulled-right">Submit a New Story-Arc</button></h2>
      <div class="message">
        <header class="message-header">
          <p class="message-header-title">{{ story.title }}</p>
          <span class="is-italic is-pulled-right">
          Written by: {{ story.user.nickname }}
          </span>
        </header>
        <div class="message-body story-text">
          <p>{{ story.body }} ...</p>
        </div>
      </div>
      <div class="voted-arcs" v-for="arc in story.arcs" :key="arc.id">
       <h2 class="subtitle">The story continued...</h2>
       <div class="message">
         <header class="message-header">
          <span class="votes has-text-danger">votes</span>
          <span class="is-italic is-pulled-right">
            Written by: {{ arc.user.nickname }}
          </span>
        </header>
        <div class="message-body">
          {{ arc.body }} ...
        </div>
       </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: "StoryArcs",
  data() {
    return {
      story: ""
    };
  },
  created() {
    this.$http.plain
      .get(`/stories/${this.$route.params.id}`)
      .then(response => {
        this.story = response.data;
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
    newArc() {
      this.$router.push(`/stories/${this.story.id}/new-arc`);
    }
  }
};
</script>

<style>
</style>
