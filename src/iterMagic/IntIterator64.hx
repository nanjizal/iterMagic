/**
 usage
```
function main(){
    for( i in ( 0...100: Int64Iter ) ) trace( i );
    for( i in ((0:Int64): Int64_)...((100:Int64):Int64_) ) trace( i );
}  
```
*/

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
@:transitive
@:forward
abstract Int64_( Int64 ) from Int64 to Int64 {
	@:op(A...B)
	public static function range(lhs:Int64_, rhs:Int64_):Int64Iter {
		return new Int64Iter( lhs, rhs );
	}
}

@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract Int64Iter( IntIterator64 ){
	public inline
	function new( min: Int64, max: Int64 ){
  		this = new IntIterator64( min, max );
  	}      
	// Throws an exception if cannot be represented in 32 bits.
  	@:from
  	static inline
  	public function fromIterator( ii: IntIterator ): Int64Iter {
  		return new Int64Iter( Int64.toInt( ii.min ), Int64.toInt( ii.max ) );
  	}
}
