function sliderUpdated(event,ui) {
}

function getSliderValues() {
	return {boost:$("#boost").slider("value"),fuelmix:$("#fuelmix").slider("value"),gearchange:$("#gearchange").slider("value"),braking:$("#braking").slider("value"),drivetrain:$("#drivetrain").slider("value"),brakeforce:$("#brakeforce").slider("value")};
}

function setSliderValues(values) {
	$(".slider").each(function(){
		if(values[this.id]!=null) {
			$(this).slider("value",values[this.id]);
		}
	});
	sliderUpdated();
}

function menuToggle(bool,send=false) {
	if(bool) {
		$("body").show();
		$(".monitor-brand").css("top",$(".monitor").offset().top+$(".monitor").height()*1.075);
	} else {
		$("body").hide();
	}
	if(send){
		$.post('http://klaptop/togglemenu', JSON.stringify({state:false}));
	}
}

$(function(){
	$("body").hide();
	$(".monitor-brand").css("top",$(".monitor").offset().top+$(".monitor").height()*1.075);
	$("#monitorBrand").text(Config.monitorBrand);
	$("#appName").text(Config.appName);
	$("#boost").slider({min:0.1,value:0.25,step:0.01,max:0.60,change:sliderUpdated});
	$("#fuelmix").slider({min:0.8,value:1.0,step:0.01,max:1.2,change:sliderUpdated});
	$("#gearchange").slider({min:2,value:6,max:12,step:0.1,change:sliderUpdated});
	$("#braking").slider({value:0.5,max:1,step:0.01,change:sliderUpdated});
	$("#drivetrain").slider({value:0.5,max:1,step:0.01,change:sliderUpdated});
	$("#brakeforce").slider({min:1.5,value:2.25,max:3.0,step:0.01,change:sliderUpdated});
	$("#defaultbtn").click(function(){setSliderValues({boost:0.35,fuelmix:1.0,gearchange:6,braking:0.5,drivetrain:0.5,brakeforce:2.25});});
	$("#savebtn").click(function(){
		$.post('http://klaptop/save', JSON.stringify(getSliderValues()));
	});
	$("#darktoggle").click(function(){
		$(this).toggleClass("fa");
		$(this).toggleClass("far");
		$(".monitor").toggleClass("mon-light-bg");
		$(".monitor").toggleClass("mon-dark-bg");
	});
	$("#exitProgram").click(function(){
		menuToggle(false,true);
	});
	$("#shutDown").click(function(){
		menuToggle(false,true);
	});
	setInterval(() => {
		var today = new Date();
		var days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
		var time = days[today.getDay()] + " " + today.getHours() + ":" + (today.getMinutes().toString().length==1 ? "0"+today.getMinutes() : today.getMinutes());
		$("#toptime").text(time);
	}, 1000);
	document.onkeyup = function (data) {
        if (data.which == 27) {
            menuToggle(false,true);
        }
    };
	window.addEventListener('message', function(event){
		if(event.data.type=="togglemenu") {
			menuToggle(event.data.state,false);
			if(event.data.data!=null) {
				setSliderValues(event.data.data);
			}
		}
	});
});