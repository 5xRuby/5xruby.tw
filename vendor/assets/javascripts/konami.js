$(document).bind('keydown', detectKonamiCommand);

var konamiTimer,
konamiLog = [],
keyMap = {37: '←', 38: '↑', 39: '→', 40: '↓', 65: 'A', 66: 'B'};

function detectKonamiCommand(e) {
	clearTimeout(konamiTimer);

	konamiLog.push(keyMap[e.keyCode]);
	if (konamiLog.join('').indexOf('↑↑↓↓←→←→BA') !== -1) {
		document.body.style.webkitTransition = 'all 1s ease-in-out';
		document.body.style.webkitTransitionDuration = '1s';
		document.body.style.webkitTransform='scaleX(-1)'
		konamiLog = [];
	}

	konamiTimer = setTimeout(function() {
		// console.log('clear');
		konamiLog = [];
	}, 800);
}