using Toybox.Application as App;

class StreakApp extends App.AppBase {
    hidden var mStreaks;

    function initialize() {
        AppBase.initialize();
        mStreaks = new StreakRepository();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new ActiveStreakView(mStreaks), new ActiveStreakDelegate(mStreaks) ];
    }

}