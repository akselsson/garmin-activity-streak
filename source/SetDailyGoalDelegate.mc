using Toybox.WatchUi;
using Toybox.System;

class SetDailyGoalDelegate extends WatchUi.NumberPickerDelegate {
    hidden var mStreaks;
    function initialize(streaks) {
        NumberPickerDelegate.initialize();
        mStreaks = streaks;
    }

    function onNumberPicked(value) {
        System.println("Set Daily Goal " + value.value());
        mStreaks.setDailyGoal(value.value() / 60.0);
    }
}