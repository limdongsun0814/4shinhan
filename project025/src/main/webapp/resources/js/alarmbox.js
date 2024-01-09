var btn = document.getElementById('img_btn');
const modal = document.getElementById('modalWrap');
const closeBtn = document.getElementById('closeBtn');



btn.onclick = function() {
  modal.style.display = 'block';
  getBreadAlarm();
}

closeBtn.onclick = function() {
  modal.style.display = 'none';
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}