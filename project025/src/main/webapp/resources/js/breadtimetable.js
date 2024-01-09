const bread_btn = document.getElementById('bread_img_btn');
const bread_modal = document.getElementById('bread_modalWrap');
const bread_closeBtn = document.getElementById('bread_closeBtn');

bread_btn.onclick = function() {
  bread_modal.style.display = 'block';
}
bread_closeBtn.onclick = function() {
  bread_modal.style.display = 'none';
}

window.onclick = function(event) {
  if (event.target == bread_modal) {
    bread_modal.style.display = "none";
  }
}