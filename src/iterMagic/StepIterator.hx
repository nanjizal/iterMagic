import iterMagic;
@:access(IntIterator.min, IntIterator.max )
class IntIterStep {
    public var start: Int;
    public var max: Int;
    public var step: Int;
  	public var count: Int;
    public function new( min_: Int, max_: Int, step_: Int = 1 ){
        start = min_;
      	count = min_;
        max = max_;
      	if( step_ < 0 || step_ > this.max ) throw 'illegal step';
        step = step_;
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract StepIterator( IntIterStep ) from IntIterStep {
    public static inline
    function startLength( min: Int, len: Int ): StepIterator {
        return new StepIterator( min, min + len - 1 );
    }
    public inline function step( step_: Int ): StepIterator {
      if( step_ < 0 || step_ > this.max ) throw 'illegal step';
			this.step = step_;
      return this;
    }
    public inline
    function new( min: Int, max: Int ){
        this = new IntIterStep( min, max );
    }
	  public inline function hasNext() {
		    return this.count < this.max - ( this.step - 1 );
	  }
	  public inline function next() {
        this.count += this.step;
		    return this.count;
	  }
    @:from
    static inline
    public function fromIterator( ii: IntIterator ): StepIterator {
        return new StepIterator( ii.min, ii.max );
    }
    @:to
    function toIterStart():StepIterator {
       return new StepIterator( this.start, this.max );
    }
    public inline function iterator(){
        return this.start...this.max;
    }
    @:op(A + B) public static inline
    function adding( a:StepIterator, b: StepIterator ): StepIterator {
      	return a.add( b );
    }
    public inline
    function add( b: StepIterator ): StepIterator {
        var begin: Int = Std.int( Math.min( this.start, b.max ) );
        var end = ( begin == this.start )? b.max: this.max;
        return new StepIterator( begin, end );
    }
    public
    var length( get, set ): Int; 
    inline
    function get_length(): Int {
        return this.max - this.start + 1;
    }
    inline
    function set_length( l: Int ): Int {
        this.max = l - 1;
        return l;
    }
    inline
    public function contains( v: Int ): Bool {
        return ( v > ( this.start - 1 ) && ( v < this.max + 1 ) );
    }
    inline
    public function containsF( v: Float ): Bool {
        return ( v > ( this.start - 1 ) && ( v < this.max + 1 ) );
    }
    inline
    public function isWithin( ir: StepIterator ): Bool {
        return contains( ir.start ) && contains( ir.max );
    }
    inline
    public function moveRange( v: Int ){
        this.start += v;
        this.max += v;
    }
    @:op(A += B)
    public inline static
    function addAssign( a: StepIterator, v: Int ){
        a.moveRange( v );
        return a;
    } 
    @:op(A -= B)
    public inline static
    function minusAssign( a: StepIterator, v: Int ){
        return a+=-v;
    }
    inline
    public function ifContainMove( v: Int, amount: Int ): Bool {
        var ifHas = contains( v );
        if( ifHas ) moveRange( amount );
        return ifHas; 
    }
}
