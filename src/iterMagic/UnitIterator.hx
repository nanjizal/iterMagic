package iterMagic;
/*
// https://try.haxe.org/#4aC54d24
function main() {
  var iter = new UnitIterator().step(10);
  for( i in iter ){
    trace( iter.value );
  }
}
*/
@:access(IntIterator.min, IntIterator.max )
class UnitIter {
    public var start = 0;
    public var max = 1;
    public var step: Float = 0;
  	public var value: Float = 0.;
    public var count = 0;
    public inline
    function new(){}
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract UnitIterator( UnitIter ) from UnitIter {
    public inline function step( count_: Int ): UnitIterator {
        this.step = 1./count_;
        this.value = 0.;
        this.max = count_;
		return this;
	}
    public inline
    function new(){
		this = new UnitIter();
	}
    public inline
    function hasNext() {
        return this.count++ < this.max;
    }
    public inline
    function next():Float {
        this.value += this.step;
        return this.value;
    }
}