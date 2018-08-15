const votes = document.querySelector(".votes");
const voteBtn = document.querySelector("#vote-button");
const hasVoted = document.querySelector("#has-voted");

function upVote() {
  currentVotes = parseInt(votes.innerHTML);
  newVotes = currentVotes + 1;
  votes.innerHTML = toString(newVotes);
}

function alreadyVoted() {
  hasVoted.classList.remove("not-voted");
  hasVoted.classList.add("voted");
}
