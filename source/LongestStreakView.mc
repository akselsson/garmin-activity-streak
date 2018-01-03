using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;

class LongestStreakView extends Ui.View {

    hidden var mStreak;
    function initialize(runstreaks) {
        View.initialize();
        mStreak = runstreaks;
    }

    function onLayout(dc) {
    }

    function onShow() {
    }


    function onUpdate(dc) {
        View.onUpdate(dc);
        render(dc);
    }

    function onHide() {
    }

    function render(dc){
        var streak = mStreak.longestStreak.length();
        var width = dc.getWidth();
        var height = dc.getHeight();

        var xCenter = width / 2;
        var yCenter = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        if(streak == -1) {
            dc.drawText(xCenter, yCenter, Graphics.FONT_LARGE, "NO DATA", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
            return;
        }

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        var text = streak.toString();
        var textFont = Graphics.FONT_NUMBER_HOT;
        var headingFont = Graphics.FONT_XTINY;
        var textHeight = dc.getFontHeight(textFont);
        var headingHeight = dc.getFontHeight(headingFont);
        var margin = textHeight * 0.2;

        dc.drawText(xCenter, yCenter - textHeight / 2 - headingHeight - margin, headingFont, "Longest streak", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(xCenter, yCenter, textFont, text, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

        //var subtext = mStreak.percentCompleteToday >= 1 ?
        //  "Today: Done!" :
        //  "" +(mStreak.percentCompleteToday * mStreak.activeMinutesLimit).toLong() + "/" + mStreak.activeMinutesLimit.toLong() + " minutes\ntoday";
        dc.drawText(xCenter, yCenter + textHeight / 2 + margin, headingFont, "days", Graphics.TEXT_JUSTIFY_CENTER);
    }
}