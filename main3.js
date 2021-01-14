const toggleBtn = document.querySelector('.sidebar-toggle');
const menu = document.querySelector('.sidebar');



toggleBtn.addEventListener('click', () => {
    menu.classList.toggle('active');
});
