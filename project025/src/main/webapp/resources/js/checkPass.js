document.addEventListener("DOMContentLoaded", function() {
  const btn1 = document.getElementById('updateInfo');
  const modal1 = document.getElementById('chk_modalWrap');
  const closeBtn1 = document.getElementById('chk_closeBtn');
  const closeBtn2 = document.getElementById('modal_cancel_button');

  btn1.addEventListener('click', function() {
    modal1.style.display = 'block';
  });

  closeBtn1.addEventListener('click', function() {
    modal1.style.display = 'none';
  });
  closeBtn2.addEventListener('click', function() {
    modal1.style.display = 'none';
  });

  window.addEventListener('click', function(event) {
    if (event.target === modal1) {
      modal1.style.display = 'none';
    }
  });
});