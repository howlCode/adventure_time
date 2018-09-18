<template>
  <section class="section">
    <h1 class="title has-text-light">Welcome to Inscribed!</h1>
    <h2 class="subtitle has-text-light">Where Creativity and Community Meet</h2>
    <router-link v-if="!isSignedIn()" to="/signup" class="has-text-info">Sign Up Here</router-link>
    <div class="columns is-multiline">
      <div class="column is-full" v-for="arc in arcs" :key="arc.id">
        <div class="message" v-if="!isExpired(arc)">
          <header class="message-header">
            <p class="message-header-title has-text-centered"> 
              <i class="far fa-eye icon"></i><span class="clickable" @click="showStory(arc.story)">See the full story!</span>
              <i class="fab fa-readme icon"></i><span class="clickable" @click="showArc(arc)">Read the Story-Arc</span>
            </p>
            <span class="has-text-warning"><i class="fas fa-clock icon"></i>{{ arc.time_left }}</span>
          </header>
          <div class="message-body">
            <p>{{ textTruncate(arc.body, 175) }}</p>
            <span class="is-italic has-text-info">
              Written by: {{ arc.user.nickname }}
            </span>
            <VotingWidget v-bind:arc="arc"/>
          </div>
          <span class="mobile-clickable" @click="showStory(arc.story)">See the full story!</span>
          <span class="mobile-clickable" @click="showArc(arc)">Read the Story-Arc</span>
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

<style>
@media (min-width: 768px) {
  .icon {
    margin-right: 10px;
  }
  .mobile-clickable {
    display: none;
  }
}

@media (max-width: 768px) {
  .icon {
    display: none;
  }
  .message-header-title {
    margin-right: 0px;
    padding: 5px;
    display: none;
  }
  .mobile-clickable {
    padding: 10px;
    color: blue;
  }
}

.clickable {
  margin-right: 10px;
}
</style>