using Toybox.Application.Storage;
using Toybox.Time;

class Streak {
	var start;
	var end;
	var isActive = false;
	static var empty = new Streak(null,null,false);

	
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
			return -1;
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
	
	function save(prefix){
		Storage.setValue(prefix + "_start",self.start.value());
		Storage.setValue(prefix + "_end",self.end.value());	
		Storage.setValue(prefix + "_isActive",self.isActive);	
		
	}
	
	static function load(prefix){
		var start = Storage.getValue(prefix + "_start");
		var end = Storage.getValue(prefix + "_end");
		var isActive = Storage.getValue(prefix + "_isActive");
		if(start == null || end == null || isActive == null){
			return empty;
		}		
		return new Streak(new Time.Moment(start),new Time.Moment(end), isActive);
	}
	
	function isEmpty(){
		return start == null || end == null;
	}
}