using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;
using Toybox.ActivityMonitor;

class Runstreaks {
	var currentStreak = -1;
	var activeMinutesLimit = 15;
	
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
	
	
}