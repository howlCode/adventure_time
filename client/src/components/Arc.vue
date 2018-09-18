<template>
  <section class="section">
    <div class="container">
      <div class="message">
        <header class="message-header">
          <p class="message-header-title">Written by: {{ arc.user.nickname }}</p>
          <span class="has-text-danger"><i class="fas fa-clock icon"></i>{{ arc.time_left }}</span>
        </header>
        <div class="message-body story-text">
          <p>{{ arc.body }} <VotingWidget v-f="!arc.expired" v-bind:arc="arc" /></p>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import VotingWidget from "@/components/widgets/VotingWidget";

export default {
  name: "Arc",
  data() {
    return {
      arc: ""
    };
  },
  created() {
    this.$http.plain
      .get(
        `/stories/${this.$route.params.story_id}/arcs/${this.$route.params.id}`
      )
      .then(response => {
        this.arc = response.data;
      })
      .catch(error => this.setError(error, "Something went wrong"));
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    }
  },
  components: {
    VotingWidget
  }
};
</script>

<style>
.icon {
  margin-right: 10px;
}
</style>
