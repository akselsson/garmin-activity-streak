using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class Streak {
    var start;
    var end;
    var isActive = false;

    static function empty() {
        return new Streak(null,null,false);
    }


    function initialize(start, end, isActive){
        if(start != null) {
            self.start = start;
        }
        if(end != null) {
            self.end = end;
        }
        self.isActive = isActive;
    }

    function length(){
        if(isEmpty()){
            return 0;
        }
        if(!isActive) {
            return 0;
        }
        var durationSeconds = end.subtract(start);
        var durationDays = durationSeconds.divide(3600*24);
        return durationDays.value() + 1;
    }

    function reset(day) {
        self.start = day;
        self.end = day;
        self.isActive = false;
    }

    function contains(date) {
        return date.lessThan(end);
    }

    function setActiveOn(day) {
        if(!isActive) {
            start = day;
            isActive = true;
        }
        end = day;
    }

    function add(other) {
        if(!other.isActive) {
            return;
        }
        //Both are active
        if(!intercepts(other)){
            return;
        }
        if(other.start.lessThan(start)){
            start = other.start;
        }
        if(other.end.greaterThan(end)){
            end = other.end;
        }
    }

    function intercepts(streak) {
        if(isEmpty()){
            return false;
        }
        if(start.compare(streak.start) <= 0 && end.compare(streak.start) >= -Gregorian.SECONDS_PER_DAY) {
            return true;
        }
        if(streak.start.compare(start) <= 0 && streak.end.compare(start) >= -Gregorian.SECONDS_PER_DAY) {
            return true;
        }
        return false;
    }

    function save(prefix){
        if(isEmpty()){
            Storage.deleteValue(prefix + "_start");
            Storage.deleteValue(prefix + "_end");
            Storage.deleteValue(prefix + "_isActive");
        }
        else {
            Storage.setValue(prefix + "_start",self.start.value());
            Storage.setValue(prefix + "_end",self.end.value());
            Storage.setValue(prefix + "_isActive",self.isActive);
        }

    }

    static function load(prefix){
        var start = Storage.getValue(prefix + "_start");
        var end = Storage.getValue(prefix + "_end");
        var isActive = Storage.getValue(prefix + "_isActive");
        if(start == null || end == null || isActive == null){
            return Streak.empty();
        }
        return new Streak(new Time.Moment(start),new Time.Moment(end), isActive);
    }

    function isEmpty(){
        return start == null || end == null;
    }
}