using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;
using Toybox.ActivityMonitor;


class Runstreaks {
	var currentStreak = -1;
	var isCompletedToday = false;
	var activeMinutesLimit = 15;
	 
	//TODO: Store Longest streak
	function load(){
		var streak = Streak.load("current");
		//var streak = Streak.empty();
		var historyStreak = streakFromHistory();
		
		streak.add(historyStreak);
		streak.save("current");
		
		var todayStreak = streakFromToday();
		isCompletedToday = todayStreak.isActive;
		streak.add(todayStreak);
		currentStreak = streak.length();
	}
	
	
	function streakFromToday() {
		var s = Streak.empty();
		var currentDay = ActivityMonitor.getInfo();	
		var isActiveToday = 	currentDay.activeMinutesDay.total >= activeMinutesLimit;
		if(isActiveToday) {	
			s.setActiveOn(Time.today());
		}
		return s;
	}
	
	function streakFromHistory(){
		var streak = Streak.empty();
		var hist = ActivityMonitor.getHistory();
		for (var i = hist.size()-1; i >= 0; i--) {
			
			var element = hist[i];
			var day = element.startOfDay;
			
    			if (element.activeMinutes.total > activeMinutesLimit) {
    				streak.setActiveOn(day);
    			}
    			else {
    				streak.reset(day);
    			}	
    		}
    		return streak;
	}
	
	
}