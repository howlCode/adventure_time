<template>
  <div class="is-pulled-right">
    <span v-if="errors">Error: {{ errors }}</span>
    <span @click="voteUp(arc)" class="button is-primary"><i class="fas fa-arrow-up"></i></span>
    <span class="vote-text has-text-primary">  {{ arc.get_upvotes.length }} </span>
    <span @click="voteDown(arc)" class="button is-danger"><i class="fas fa-arrow-down"></i></span>
    <span class="vote-text has-text-danger">  {{ arc.get_downvotes.length }} </span>
  </div>
</template>

<script>
export default {
  name: "VotingWidget",
  props: ["arc"],
  data() {
    return {
      errors: ""
    };
  },
  methods: {
    voteUp(arc) {
      this.$http.secured
        .put(`/stories/${arc.story.id}/arcs/${arc.id}/vote_up`)
        .then(response => this.voteSuccessful(response))
        .catch(error => this.voteFailed(error));
    },
    voteDown(arc) {
      this.$http.secured
        .put(`/stories/${arc.story.id}/arcs/${arc.id}/vote_down`)
        .then(response => this.voteSuccessful(response))
        .catch(error => this.voteFailed(error));
    },
    voteSuccessful(response) {
      this.errors = "";
    },
    voteFailed(error) {
      this.errors = error.response.data;
    }
  }
};
</script>

<style scoped>
.vote-text {
  font-size: 1.7rem;
  margin-left: 5px;
  margin-right: 5px;
}
</style>
