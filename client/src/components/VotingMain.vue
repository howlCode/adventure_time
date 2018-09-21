<template>
  <transition appear enter-active-class="animated fadeIn">
  <section class="section">
    <div class="has-text-centered" v-if="noArcs()">
      <h1 class="title has-text-light">No Story-Arcs to Vote On!</h1>
      <router-link to="/stories" class="has-text-primary subtitle">Get Writing!</router-link>
    </div>
    <div class="columns is-multiline">
      <div class="column is-full" v-for="arc in arcs" :key="arc.id" v-if="!isExpired(arc)">
        <div class="message">
          <header class="message-header">
            <p class="message-header-title has-text-centered"> 
              <i class="far fa-eye icon"></i><span class="clickable" @click="showStory(arc.story)">See the full story!</span>
              <i class="fab fa-readme icon"></i><span class="clickable" @click="showArc(arc)">Read the Story-Arc</span>
            </p>
            <span class="has-text-warning"><i class="fas fa-clock icon"></i>{{ arc.time_left }}</span>
          </header>
          <div class="message-body">
            <p>{{ $textTruncate(arc.body, 175) }}</p>
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
  </transition>
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
    isExpired(arc) {
      return arc.expired;
    },
    noArcs() {
      let expired = [];
      this.arcs.map(arc => {
        if (arc.expired == true) {
          expired.push(arc);
        }
      });
      if (this.arcs.length === 0 || this.arcs.length === expired.length) {
        return true;
      }
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