using Toybox.WatchUi as Ui;
using Toybox.ActivityMonitor;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;

class RunstreakView extends Ui.View {

	hidden var mStreak;
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    		mStreak = getCurrentStreak();
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
    		renderStreak(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    	function getCurrentStreak(){
    		var activeMinutesLimit = 15;
    
    		var lastSynced = Storage.getValue("lastSynced");
    		var lastSyncStreak = Storage.getValue("streak");
    		var today = Time.today().value();
    		Storage.setValue("lastSynced",today);
    		
    		var currentDay = ActivityMonitor.getInfo();	
    		var isActiveToday = 	currentDay.activeMinutesDay.total >= activeMinutesLimit;
    		var hist = ActivityMonitor.getHistory();
    		if (hist.size() == 0 && !isActiveToday){
    			return -1;
    		}
    		var streak = isActiveToday ? 1 : 0;
    	
    		for (var i = 0; i < hist.size(); i++) {
    			// check hist[i].activeMinutes.startOfDay
    			if (hist[i].activeMinutes.total < activeMinutesLimit) {
    				return streak;
    			} 
    			streak = streak + 1;
    		}
    		return streak;
    }
    
    function renderStreak(dc){
    		var streak = mStreak;
    		var width = dc.getWidth();
    		var height = dc.getHeight();
    		
    		var xCenter = width / 2;
    		var yCenter = height / 2;
    		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
        if(streak == 1) {
        		dc.drawText(xCenter, yCenter, Graphics.FONT_LARGE, "NO DATA", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
        		return;
        }
        
        var text = streak.toString();
        var textFont = Graphics.FONT_NUMBER_HOT;     
        var headingFont = Graphics.FONT_XTINY;  
        var textHeight = dc.getFontHeight(textFont);
        var headingHeight = dc.getFontHeight(headingFont);
        var margin = textHeight * 0.2;
       
        dc.drawText(xCenter, yCenter - textHeight / 2 - headingHeight - margin, headingFont, "Current streak", Graphics.TEXT_JUSTIFY_CENTER);
       	dc.drawText(xCenter, yCenter, textFont, text, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(xCenter, yCenter + textHeight / 2 + margin, headingFont, "days", Graphics.TEXT_JUSTIFY_CENTER);
        
        
    }

}
