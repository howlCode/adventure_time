# Inscribed

## What is it?

Welcome to Inscribed! A community and vote-driven choose your own adventure style creativity platform. As a user, you can create new stories, and then other users can create a new story arc that will continue that story. The story-arcs are determined by a voting system in where each story-arc has a 24 hour voting window, the arc with the most votes is inscribed to the story and it continues on to the next arc.

Currently, [JWT_Sessions](https://github.com/tuwukee/jwt_sessions) is used for authentication. This allows the use of cookies to have stateful sessions based on JSON Web Tokens.

Please visit [Inscribed-Vue](https://github.com/howlCode/inscribed-vue) for information on the Vuejs project that serves as the frontend for the API.

## How can I use it?

The API has these unique endpoints:

_All are prefixed with /api/v1/_

'/stories' - Will grab all stories as one object

'/stories/:story_id' - Pulls an individual story

'/all_arcs' - Pulls ALL story-arcs for all stories

'/stories/:story_id/arcs/:arc_id' - Pulls an individual story-arc

'/stories/:story_id/arcs/:id/vote_up' - Registers an upvote with the current user on the story-arc

'/stories/:story_id/arcs/:id/vote_down' - Registers a downvote with the current user on the story-arc

'/profile/:id' - Pulls down a user's id and nickname + all submissions(stories, arcs)

### Model Methods

A story-arc has the following additional methods:

'expired' - Will inform you if the story-arc is older than 24hrs

'time_left' - Returns the date and time that the voting window closes(24hrs after creation)

'inscribed' - Returns if the story-arc was voted on or not

'winning_time' - When the arc was inscribed
