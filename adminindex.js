var a = document.getElementById("user").value
var b = document.getElementById("admin").value
var c = document.getElementById("content").value

var data = [
	{'tool':'유저 ID 개수', 'skill': a , 'color':'#00b6f5'},
	{'tool':'관리자 ID 개수', 'skill': b, 'color':'#ffc763'},
	{'tool':'게시글 개수', 'skill': c, 'color':'#b3d22e'}
];

$('.user').each(function(){
	var color = data[0].color;
	$(this).children('h2').css('color',color).text(data[0].tool);
	
	var bar = $(this).children('strong');
	
	bar.css('background-color', color);
	bar.delay(10000*0).animate({'width':data[0].skill*6 + '%'},{
		duration:2000,
		step:function( now ){
			$(this).text(Math.round(now/6) + '개')
		}
	});
});

$('.admin').each(function(){
	var color = data[1].color;
	$(this).children('h2').css('color',color).text(data[1].tool);
	
	var bar = $(this).children('strong');
	
	bar.css('background-color', color);
	bar.delay(10000*0).animate({'width':data[1].skill*6 + '%'},{
		duration:2000,
		step:function( now ){
			$(this).text(Math.round(now/6)+ '개')
		}
	});
});

$('.content').each(function(){
	var color = data[2].color;
	$(this).children('h2').css('color',color).text(data[2].tool);
	
	var bar = $(this).children('strong');
	
	bar.css('background-color', color);
	bar.delay(10000*0).animate({'width':data[2].skill*6 + '%'},{
		duration:2000,
		step:function( now ){
			$(this).text(Math.round(now/6)+ '개')
		}
	});
});