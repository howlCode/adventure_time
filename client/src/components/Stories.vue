<template>
    <section class="section">
      <div class="container">
        <div class="columns">
          <div class="column" v-for="story in stories" :key="story.id">
            <div class="message is-medium main-story">
              <header class="message-header">
                <p class="message-header-title">{{ story.title }}</p>
                <p class="has-text-danger">
                  Arcs:
                  <span class="has-text-light">
                    1
                  </span>
                </p>
              </header>
              <div class="message-body">
                <p>{{ textTruncate(story.body, 200) }}</p>
                <span class="is-italic is-pulled-right">
                -- {{ story.user_id }}
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
    if (!localStorage.signedIn) {
      this.$router.replace("/");
    } else {
      this.$http.secured
        .get("/stories")
        .then(response => {
          this.stories = response.data;
        })
        .catch(error => this.setError(error, "Something went wrong"));
    }
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
    }
  }
};
</script>

<style lang="css">
</style>