<template>
<transition appear enter-active-class="animated fadeIn">
  <section class="section">
    <div class="container">
      <h1 class="title has-text-light has-text-centered">{{ profile.user.nickname }}'s profile</h1>
      <h2 class="subtitle has-text-light">Submitted Stories:</h2>
      <div class="columns is-multiline">
        <div class="column is-full" v-for="story in profile.stories" :key="story.id">
          <div class="message clickable hover-story" @click="showStory(story)">
            <header class="message-header">
              <div class="message-header-title">
                {{ story.title }}
              </div>
            </header>
            <div class="message-body">
              {{ $textTruncate(story.body, 175) }}
            </div>
          </div>
        </div>
      </div>
      <h2 class="subtitle has-text-light">Submitted Story-Arcs:</h2>
      <div class="columns is-multiline">
        <div class="column is-full" v-for="arc in profile.arcs" :key="arc.id">
          <div class="message" @click="showArc(arc)">
            <header class="message-header">
              <div class="message-header-title arc-header-title">
                <i class="fab fa-readme icon"></i><span class="clickable" @click="showStory(arc.story)">See the full story!</span>
                <i class="fab fa-readme icon"></i><span class="clickable" @click="showArc(arc.story)">Read the Story-Arc</span>
              </div>
            </header>
            <div class="message-body">
              {{ arc.body }}
            </div>
              <span class="mobile-clickable has-text-info" @click="showStory(arc.story)">See the full story!</span>
              <span class="mobile-clickable has-text-info" @click="showArc(arc)">Read the Story-Arc</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</transition>
</template>

<script>
export default {
  name: "UserProfile",
  data() {
    return {
      profile: ""
    };
  },
  created() {
    this.$http.plain
      .get(`/profile/${this.$route.params.id}`)
      .then(response => {
        this.profile = response.data;
      })
      .catch(error => this.setError(error, "Something went wrong"));
  },
  methods: {
    setError(error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text;
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
}

@media (max-width: 768px) {
  .icon {
    display: none;
  }
  .arc-header-title {
    margin-right: 0px;
    padding: 5px;
    display: none;
  }
  .mobile-clickable {
    padding: 10px;
  }
  .mobile-clickable:hover {
    cursor: pointer;
  }
}

.clickable {
  margin-right: 10px;
}
</style>
