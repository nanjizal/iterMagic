package iterMagic;
/*
function main() {
	for (i in (0...10 : BackwardStep).step(2).fromTheTop()) trace(i);
}
*/		
@:access(IntIterator.min, IntIterator.max)
class IntIterStepBack {
    public var start: Int;
    public var max:   Int;
    public var step:  Int;
    public var count: Int;
    public var includeMax:Bool = false;
    public inline function new( min_:Int, max_:Int, step_:Int = 1 ) {
        start = min_;
        count = min_ - step_ - 1;
        max = max_;
        if( step_ < 0 || step_ > this.max ) throw 'illegal step';
        step = step_;
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:access( IntIterStepBack.step )
abstract BackwardStep( IntIterStepBack ) from IntIterStepBack {
	public inline function new( min: Int, max: Int ) {
		this = new IntIterStepBack( min, max );
	}
	@:from
	static inline
    public function fromIterator( ii: IntIterator ):BackwardStep {
		return new BackwardStep( ii.min, ii.max );
	}
	@:to
	function toIterStart():BackwardStep {
		return new BackwardStep( this.start, this.max );
	}

	public inline
    function hasNext() {
		return if( this.includeMax ) {
			this.count < this.max;
		} else {
			this.count < this.max - this.step;
		}
	}
	public inline
    function next() {
		this.count += this.step;
		return if( this.includeMax ){
			this.max - this.count;
		} else {
			this.max - this.count - this.step;
		}
	}
	public inline
    function step( step_:Int ): BackwardStep {
		if( step_ < 0 || step_ > this.max ) throw 'illegal step';
		this.step = step_;
		return abstract;
	}
	public inline
    function fromTheTop() {
		this.includeMax = true;
		return abstract;
	}
}