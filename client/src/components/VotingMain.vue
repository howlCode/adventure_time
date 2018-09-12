<template>
  <section class="section">
    <div class="nav-pages">
      <div class="has-text-left">
        <router-link class="button is-dark" to="/">See All Stories</router-link>
        <span class="spacer"></span>
        <router-link class="button is-info is-pulled-right" to="/new-story">Create a New Story</router-link>
      </div>
    </div>
      <div class="columns is-multiline">
        <div class="column is-full" v-for="arc in arcs" :key="arc.id">     
          <div class="message main-story" @click="showArc(arc)">
            <header class="message-header">
              <p class="message-header-title">See the full story!</p>
              <p class="has-text-light">
                Votes:
                <span class="has-text-danger">
                 2 (to be arcs.votes.length)
                </span>
              </p>
            </header>
            <div class="message-body">
              <p>{{ textTruncate(arc.body, 175) }}</p>
              <span class="is-italic has-text-primary">
                Written by: {{ arc.user.nickname }}
              </span>
              <span class="is-pulled-right">
                <span class="vote-text">Vote:</span> <span class="button is-small is-primary">UP</span> <span class="button is-small is-warning">DOWN</span>
              </span>
            </div>
          </div>
        </div>
      </div>
  </section>
</template>

<script>
export default {
  name: "VotingMain",
  data() {
    return {
      arcs: []
    };
  },
  created() {
    this.$http.plain
      .get("/arcs")
      .then(response => {
        this.arcs = response.data;
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
    showArc(arc) {
      const arcId = arc.id;
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

