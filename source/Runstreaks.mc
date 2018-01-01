using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;
using Toybox.ActivityMonitor;

class Runstreaks {
	var currentStreak = -1;
	var activeMinutesLimit = 15;
	
	
	
	//TODO: Store current streak 
	//TODO: Check that there are no gaps against current streak
	//TODO: Store Longest streak
	
	function load(){
		var streak = Streak.load("current");
		appendHistory(streak);
		streak.save("current");
		appendToday(streak);
		currentStreak = streak.length();
	
		
	}
	
	function appendToday(streak) {
		var currentDay = ActivityMonitor.getInfo();	
		var isActiveToday = 	currentDay.activeMinutesDay.total >= activeMinutesLimit;
		if(isActiveToday) {
			streak.setActiveOn(Time.today());
		}
	}
	
	function appendHistory(streak){
		
		var hist = ActivityMonitor.getHistory();
		if(hist.size() == 0){
			return;
		}
		
		if(streak.isEmpty()) {
			var lastDay = hist[hist.size() -1 ];
			//TODO: Correct this
			streak.reset(lastDay.startOfDay);
		}
		for (var i = hist.size()-1; i > 0; i--) {
			var element = hist[i];
			var day = element.startOfDay;
			if (streak.contains(day)) {
				continue;
			}
    			if (element.activeMinutes.total > activeMinutesLimit) {
    				streak.setActiveOn(day);
    			}
    			else {
    				streak.reset(day);
    			}
    			
    		}
	}
	
	
}