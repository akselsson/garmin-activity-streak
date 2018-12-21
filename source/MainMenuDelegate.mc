using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Time;

class MainMenuDelegate extends Ui.MenuInputDelegate {

    hidden var mStreaks;
    function initialize(streaks) {
        MenuInputDelegate.initialize();
        mStreaks = streaks;
    }

    function onMenuItem(item) {
        if (item == :SetDailyGoal) {
            var duration = new Time.Duration(mStreaks.activeMinutesLimit*60);
            System.println("Start daily goal picker with value: " + duration.value());
            Ui.pushView(
                new WatchUi.NumberPicker(Ui.NUMBER_PICKER_TIME, duration),
                new SetDailyGoalDelegate(mStreaks),
                Ui.SLIDE_UP
            );
            return true;
        }
        return false;
    }
}
