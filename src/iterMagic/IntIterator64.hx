import haxe.Int64;
class IntIterator64 {
	var min:Int64;
	var max:Int64;

	/**
		Iterates from `min` (inclusive) to `max` (exclusive).
		If `max <= min`, the iterator will not act as a countdown.
	**/
	public inline function new(min:Int64, max:Int64) {
		this.min = min;
		this.max = max;
	}

	/**
		Returns true if the iterator has other items, false otherwise.
	**/
	public inline function hasNext() {
		return min < max;
	}

	/**
		Moves to the next item of the iterator.
		If this is called while hasNext() is false, the result is unspecified.
	**/
	public inline function next() {
		return min++;
	}
  
}
