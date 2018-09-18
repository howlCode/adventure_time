<template>
  <section class="section">
    <div class="columns is-multiline">
      <div class="column is-full" v-for="arc in arcs" :key="arc.id">
        <div class="message" v-if="!isExpired(arc)">
          <header class="message-header">
            <p class="message-header-title has-text-centered"> 
              <i class="far fa-eye icon"></i><span class="clickable" @click="showStory(arc.story)">See the full story!</span>
              <i class="fab fa-readme icon"></i><span class="clickable" @click="showArc(arc)">Read this Story Arc</span>
              <span class="has-text-warning"><i class="fas fa-clock icon"></i>{{ arc.time_left }}</span>
            </p>
          </header>
          <div class="message-body">
            <p>{{ textTruncate(arc.body, 175) }}</p>
            <span class="is-italic has-text-primary">
              Written by: {{ arc.user.nickname }}
            </span>
            <VotingWidget v-bind:arc="arc"/>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import VotingWidget from "@/components/widgets/VotingWidget";

export default {
  name: "VotingMain",
  data() {
    return {
      arcs: [],
      errors: ""
    };
  },
  created() {
    this.$http.plain
      .get("/all_arcs")
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
      const storyId = arc.story.id;
      this.$router.push({ path: `/stories/${storyId}/arcs/${arc.id}` });
    },
    newArc() {
      const storyId = this.story.id;
      this.$router.push({ path: `/story/${storyId}/new-arc` });
    },
    showStory(story) {
      const storyId = story.id;
      this.$router.push({ path: `/stories/${storyId}` });
    },
    isSignedIn() {
      return this.$store.getters.isSignedIn;
    },
    isExpired(arc) {
      return arc.expired;
    }
  },
  components: {
    VotingWidget
  }
};
</script>

<style lang="css">
.icon {
  margin-right: 10px;
}
.clickable {
  margin-right: 10px;
}
</style>