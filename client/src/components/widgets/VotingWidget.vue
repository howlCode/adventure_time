<template>
  <div v-if="isSignedIn()" class="is-pulled-right">
    <span class="help is-danger msg" v-if="errors">{{ errors }} </span>
    <span v-if="unVoted(arc)" @click="voteUp(arc)" class="button is-primary"><i class="fas fa-arrow-up"></i></span>
    <span class="vote-text has-text-primary">  {{ votesFor }} </span>
    <span v-if="unVoted(arc)" @click="voteDown(arc)" class="button is-danger"><i class="fas fa-arrow-down"></i></span>
    <span class="vote-text has-text-danger">  {{ votesAgainst }}</span>
  </div>
  <div v-else class="is-pulled-right">
    <router-link to="/signin" class="button is-primary is-small">Sign in to vote!</router-link>
  </div>
</template>

<script>
export default {
  name: "VotingWidget",
  props: ["arc"],
  data() {
    return {
      votesFor: "",
      votesAgainst: "",
      errors: ""
    };
  },
  created() {
    this.votesFor = this.arc.get_upvotes.length;
    this.votesAgainst = this.arc.get_downvotes.length;
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
      this.votesFor = response.data.arc.get_upvotes.length;
      this.votesAgainst = response.data.arc.get_downvotes.length;
      this.errors = response.data.message;
    },
    voteFailed(error) {
      this.errors = error.data.error;
    },
    unVoted(arc) {
      if (arc.inscribed === false) {
        return true;
      }
    },
    isSignedIn() {
      return this.$store.getters.isSignedIn;
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
.msg {
  margin-top: -15px;
}
</style>
