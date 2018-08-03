# Adventure Time

An app that follows the "choose-your-own adventure" theme but with a user-voting system twist. A user can start a story, and submit a potential new arc for the story, other users can then vote on that arc and other user-submitted arcs to determine the next iteration of the adventure.

## MODELS:

USER - Oauth for session mgmnt. has_many stories. has_many arcs. has_many votes
--SCHEMA: ?

STORY - belongs_to USER. has_many votes. has_many arcs
--SCHEMA: title:string, body:text

ARC - belongs_to USER, STORY. has_many votes
--SCHEMA: body:text

VOTE - belongs_to USER, STORY, ARC
--SCHEMA: casted_vote:boolean
