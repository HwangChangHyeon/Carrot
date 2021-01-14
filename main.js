const toggleBtn = document.querySelector('.header__toogleBtn');
const menu = document.querySelector('.header__menu');
const icons = document.querySelector('.header__signin');



toggleBtn.addEventListener('click', () => {
    menu.classList.toggle('active');
    icons.classList.toggle('active');
});




