using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;

class ActiveStreakView extends Ui.View {

    hidden var mStreak;
    function initialize(runstreaks) {
        View.initialize();
        mStreak = runstreaks;
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
        var streak = mStreak.currentStreak.length();
        var width = dc.getWidth();
        var height = dc.getHeight();

        var arcMax = width > height ? height : width;

        var xCenter = width / 2;
        var yCenter = height / 2;

        var progressColor = mStreak.percentCompleteToday >= 1 ? Graphics.COLOR_GREEN : Graphics.COLOR_ORANGE;
        var progressDegress = mStreak.percentCompleteToday >= 1 ? 360 : 360 * mStreak.percentCompleteToday;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(progressColor, progressColor);
        for(var i = 1 ; i<= 7; i++) {
            dc.drawArc(xCenter, yCenter, arcMax / 2 - i, 1, 90, (90 - progressDegress.toLong()) % 360);
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);


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



class ActiveStreakDelegate extends Ui.BehaviorDelegate {
        hidden var mStreak;
        function initialize(runstreaks) {
            BehaviorDelegate.initialize();
            mStreak = runstreaks;
        }

        function onKey(evt) {
            if (evt.getKey() == Ui.KEY_ENTER) {
                Ui.pushView(new LongestStreakView(mStreak), new Ui.InputDelegate(),
                            Ui.SLIDE_LEFT);
                return true;
            }
            return false;
        }

        function onMenu() {
            Ui.pushView(new Rez.Menus.MainMenu(), new MainMenuDelegate(mStreak), Ui.SLIDE_UP);
            return true;
        }
}
