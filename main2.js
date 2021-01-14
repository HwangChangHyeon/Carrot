const toggleBtn = document.querySelector('.header__toogleBtn');
const menu = document.querySelector('.header__menu');
const menu2 = document.querySelector('.header__menu2');
const icons = document.querySelector('.header__signin');
const button = document.querySelector('.buttona0');
const button1 = document.querySelector('.buttona1');
const button2 = document.querySelector('.buttona2');
const button3 = document.querySelector('.buttona3');
const button4 = document.querySelector('.buttona4');
const subdiv = document.querySelector('.subdiv0');
const subdiv1 = document.querySelector('.subdiv1');
const subdiv2 = document.querySelector('.subdiv2');
const subdiv3 = document.querySelector('.subdiv3');
const subdiv4 = document.querySelector('.subdiv4');


toggleBtn.addEventListener('click', () => {
    menu2.classList.toggle('active');
    icons.classList.toggle('active');
});

button.addEventListener('click', () => {
	subdiv.classList.toggle('active');
});
button1.addEventListener('click', () => {
	subdiv1.classList.toggle('active');
});

button2.addEventListener('click', () => {
	subdiv2.classList.toggle('active');
});

button3.addEventListener('click', () => {
	subdiv3.classList.toggle('active');
});

button4.addEventListener('click', () => {
	subdiv4.classList.toggle('active');
});



