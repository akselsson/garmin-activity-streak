using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;

class RunstreakView extends Ui.View {

	hidden var mStreak;
    function initialize() {
        View.initialize();
        mStreak = new Runstreaks();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    		mStreak.load();
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
    		render(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }


    
    function render(dc){
    		var streak = mStreak.currentStreak;
    		var width = dc.getWidth();
    		var height = dc.getHeight();
    		
    		var xCenter = width / 2;
    		var yCenter = height / 2;
    		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
        if(streak == -1) {
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
