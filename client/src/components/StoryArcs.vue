<template>
  <section class="section">
    <div class="container">
      <div class="columns is-multiline">
        <div class="column is-half" v-for="unVotedArc in unVotedArcs" :key="unVotedArc.id">
          <div class="message is-warning unvoted-arcs">
          <header class="message-header">
            <span class="is-italic is-pulled-right">
              Written by: {{ unVotedArc.user.nickname }} 
            </span>
            <p class="is-pulled-right">Arc by: <span class="votes">Vote: UP | DOWN</span>
            </p>
          </header>
          <div class="message-body">
            {{ textTruncate(unVotedArc.body, 200) }} ...
          </div>
          </div>
        </div>
      </div>
      <div class="message">
        <header class="message-header">
          <p class="message-header-title">{{ story.title }}</p>
          <span class="is-italic is-pulled-right">
          Written by: {{ story.user.nickname }}
          </span>
        </header>
        <div class="message-body story-text">
          <p>{{ story.body }} ...</p>
        </div>
      </div>
      <h2 class="subtitle">The story continued...</h2>
      <div class="voted-arcs" v-for="arc in story.arcs" :key="arc.id">
       <div class="message">
         <header class="message-header">
          <span class="votes has-text-danger">votes</span>
          <span class="is-italic is-pulled-right">
            Written by: {{ arc.user.nickname }}
          </span>
        </header>
        <div class="message-body">
          {{ arc.body }} ...
        </div>
       </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: "StoryArcs",
  data() {
    return {
      story: "",
      unVotedArcs: [
        {
          id: 1,
          body: "please pick me",
          user: {
            nickname: "example_user"
          }
        },
        {
          id: 2,
          body: "no no no please pick me",
          user: {
            nickname: "another_example_user"
          }
        }
      ]
    };
  },
  created() {
    this.$http.plain
      .get(`/stories/${this.$route.params.id}`)
      .then(response => {
        this.story = response.data;
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
    }
  }
};
</script>