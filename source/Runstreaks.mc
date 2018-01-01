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
	
		var lastSynced = Storage.getValue("lastSynced");
    		var lastSyncStreak = Storage.getValue("streak");
    		var today = Time.today().value();
    		Storage.setValue("lastSynced",today);
    		
    		var currentDay = ActivityMonitor.getInfo();	
    		var isActiveToday = 	currentDay.activeMinutesDay.total >= activeMinutesLimit;
    		var hist = ActivityMonitor.getHistory();
    		if (hist.size() == 0 && !isActiveToday){
    			return;
    		}
    		currentStreak = isActiveToday ? 1 : 0;
    	
    		for (var i = 0; i < hist.size(); i++) {
    			// check hist[i].activeMinutes.startOfDay
    			if (hist[i].activeMinutes.total < activeMinutesLimit) {
    				return;
    			} 
    			currentStreak = currentStreak + 1;
    		}
	}
	
	function appendHistory(streak){
		
		var hist = ActivityMonitor.getHistory();
		if(hist.size() == 0){
			return;
		}
		
		if(streak == null) {
			var lastDay = hist[hist.size() -1 ];
			//TODO: Correct this
			streak = new Streak(lastDay.startOfDay,lastDay.startOfDay);
		}
		for (var i = hist.size()-1; i > 0; i--) {
			var element = hist[i];
			var day = element.startOfDay;
			if (day.value() < streak.end) {
				continue;
			}
    			if (element.activeMinutes.total < activeMinutesLimit) {
    				streak = new Streak(day,day);
    			}
    			streak.setEnd(day);
    		}
	}
	
	
}