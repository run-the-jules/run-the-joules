const modals = document.querySelectorAll('.modal');
const panels = document.querySelectorAll('.panel');

let friendBtn = document.getElementById("friends-btn");
let friendModal = document.querySelector(".friend-modal");
let closeFriendBtn = document.querySelector(".close-friends-btn");

function toggleOpen() {
  console.log('Open!');
  this.classList.toggle('open');
}

panels.forEach(panel => panel.addEventListener('click', toggleOpen));

friendBtn.onclick = function(){
  friendModal.style.display = "block"
}
closeFriendBtn.onclick = function(){
  friendModal.style.display = "none"
}


function closeUpShop(e){
  if(e.target == e.target){
    this.style.display = ("none")
  }
}

modals.forEach(modal => modal.addEventListener('click', closeUpShop));
