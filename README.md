# Inscribed

## What is it?

Welcome to Inscribed! A community and vote-driven choose your own adventure style creativity platform. As a user, you can create new stories, and then other users can create a new story arc that will continue that story. The story-arcs are determined by a voting system in where each story-arc has a 24 hour voting window, the arc with the most votes is inscribed to the story and it continues on to the next arc.

## How can I use it?

Please visit [Inscribed](http://www.example.com) for a visual example I've created using the API.

The API has these unique endpoints:

_All are prefixed with /api/v1/_

'/stories' - Will grab all stories as one object

'/all_arcs' - Pulls ALL story-arcs for all stories

'/stories/:story_id' - Pulls an individual story

'/stories/:story_id/arcs/:arc_id' - Pulls an individual story-arc

### Model Methods

A story-arc has the following additional methods:

'expired' - Will inform you if the story-arc is older than 24hrs

'time_left' - Returns the date and time that the voting window closes(24hrs after creation)

'inscribed' - #TODO Returns if the story-arc was voted on or not
