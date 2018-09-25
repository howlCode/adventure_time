<template>
  <transition appear enter-active-class="animated fadeIn">
  <section class="section">
    <div class="has-text-centered" v-if="noStory()">
      <h1 class="title has-text-light">Loading...</h1>
    </div>
    <h2 class="subtitle has-text-light">The story began...
    <button @click="newArc" class="button is-primary is-pulled-right is-hidden-mobile">Submit a New Story-Arc</button></h2>
    <button @click="newArc" class="button is-small is-primary is-shown-mobile">Submit New Story-Arc</button>
        <div class="message">
          <header class="message-header">
            <p class="message-header-title">{{ story.title }}</p>
            <span class="is-italic is-pulled-right">
            Written by: {{ story.user.nickname }}
            </span>
          </header>
          <div class="message-body story-text">
            <p>{{ story.body }}</p>
          </div>
        </div>
      <h2 class="subtitle has-text-light" v-if="!noArcs()">The story continued...</h2>
      <div class="columns is-multiline" v-if="!noArcs()" v-for="arc in arcs" :key="arc.id">
        <div class="column is-full" v-if="(arc.inscribed)">
          <div class="message">
            <header class="message-header">
              <span class="votes has-text-danger">Won With {{ arc.get_upvotes.length }} Votes on {{ arc.winning_time }}</span>
              <span class="is-italic is-pulled-right">
                Written by: {{ arc.user.nickname }}
              </span>
            </header>
            <div class="message-body">
              {{ arc.body }} ...
            </div>
          </div>
        </div>
        <div class="column is-full" v-if="(!arc.inscribed)">
          <div class="message is-warning">
            <header class="message-header">
              <p class="message-header-title has-text-centered"> 
                <i class="fab fa-readme icon"></i><span class="clickable" @click="showArc(arc)">Read the Story-Arc</span>
              </p>
              <span class="has-text-danger"><i class="fas fa-clock icon"></i>{{ arc.time_left }}</span>
            </header>
            <div class="message-body">
              <p>{{ $textTruncate(arc.body, 175) }}</p>
              <span class="is-italic has-text-info">
                Written by: {{ arc.user.nickname }}
              </span>
              <VotingWidget v-bind:arc="arc"/>
            </div>
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
  name: "StoryArcs",
  components: {
    VotingWidget
  },
  data() {
    return {
      story: "",
      arcs: ""
    };
  },
  created() {
    this.$http.plain
      .get(`/stories/${this.$route.params.id}`)
      .then(response => {
        this.story = response.data;
      })
      .catch(error => this.setError(error, "Something went wrong"));
    this.$http.plain
      .get(`/stories/${this.$route.params.id}/arcs/`)
      .then(response => {
        this.arcs = response.data;
      })
      .catch(error => this.setError((error, "Something went wrong")));
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
    },
    newArc() {
      this.$router.push(`/stories/${this.story.id}/new-arc`);
    },
    showArc(arc) {
      const storyId = arc.story.id;
      this.$router.push({ path: `/stories/${storyId}/arcs/${arc.id}` });
    },
    noStory() {
      if (this.story.length === 0) {
        return true;
      }
    },
    noArcs() {
      if (this.arcs.length === 0) {
        return true;
      }
    }
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
  .is-shown-mobile {
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
  .mobile-clickable:hover {
    cursor: pointer;
  }
  .is-shown-mobile {
    margin-bottom: 10px;
  }
}

.clickable {
  margin-right: 10px;
}
</style>
