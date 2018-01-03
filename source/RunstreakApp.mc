using Toybox.Application as App;

class RunstreakApp extends App.AppBase {
    hidden var mStreak;

    function initialize() {
        AppBase.initialize();
        mStreak = new Runstreaks();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new RunstreakView(mStreak), new RunstreakDelegate(mStreak) ];
    }

}