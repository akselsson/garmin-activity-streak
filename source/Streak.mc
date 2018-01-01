using Toybox.Application.Storage;
using Toybox.Time;

class Streak {
	var start;
	var end;

	
	function initialize(start, end){
		self.start = start;
		self.end = end;		
	}
	
	function length(){
		var startMoment = new Time.Moment(start);
		var endMoment = new Time.Moment(end);
		var durationSeconds = endMoment - startMoment;
		var durationDays = durationSeconds / 3600 / 24;
		return durationDays;
	}
	
	function save(prefix){
		Storage.setValue(prefix + "_start",self.start);
		Storage.setValue(prefix + "_end",self.end);
		
	}
	
	static function load(prefix){
		var start = Storage.getValue(prefix + "_start");
		var end = Storage.getValue(prefix + "_end");		
		return new Streak(start,end);
	}
}