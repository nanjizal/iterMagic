package iterMagic;
/**
    Like a normal IntIterator but allows access of start and max after construction and reuse.
**/
@:access(IntIterator.min, IntIterator.max )
class IntIterStart {
    public var start: Int;
    public var max: Int;
    public inline
    function new( min_: Int, max_: Int ){
        start = min_;
        max = max_;
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract IteratorRange( IntIterStart ) from IntIterStart {
    public static inline
    function startLength( min: Int, len: Int ): IteratorRange {
        return new IteratorRange( min, min + len - 1 );
    }
    public inline
    function new( min: Int, max: Int ){
        this = new IntIterStart( min, max );
    }
    @:from
    static inline
    public function fromIterator( ii: IntIterator ): IteratorRange {
        return new IteratorRange( ii.min, ii.max );
    }
    @:to
    function toIterStart():IteratorRange {
       return new IteratorRange( this.start, this.max );
    }
    public inline function iterator(){
        return this.start...this.max;
    }
    @:op(A + B) public static inline
    function adding( a: IteratorRange, b: IteratorRange ): IteratorRange {
      	return a.add( b );
    }
    public inline
    function add( b: IteratorRange ): IteratorRange {
        var begin: Int = Std.int( Math.min( this.start, b.max ) );
        var end = ( begin == this.start )? b.max: this.max;
        return new IteratorRange( begin, end );
    }
    public
    var length( get, set ): Int; 
    inline
    function get_length(): Int {
        return this.max - this.start;
    }
    inline
    function set_length( l: Int ): Int {
        this.max = l + this.start;
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
    public function isWithin( ir: IteratorRange ): Bool {
        return contains( ir.start ) && contains( ir.max );
    }
    inline
    public function moveRange( v: Int ){
        this.start += v;
        this.max += v;
    }
    @:op(A += B)
    public inline static
    function addAssign( a: IteratorRange, v: Int ){
        a.moveRange( v );
        return a;
    } 
    @:op(A -= B)
    public inline static
    function minusAssign( a: IteratorRange, v: Int ){
        return a+=-v;
    }
    inline
    public function ifContainMove( v: Int, amount: Int ): Bool {
        var ifHas = contains( v );
        if( ifHas ) moveRange( amount );
        return ifHas; 
    }
    @:to
    inline 
  	public function toString(): String {
        return Std.string( this.start ) + '...' + Std.string( this.max );
  	}
    public inline function map<A,B>(it:Iterable<A>,f:(item:A)->B):Array<B>{
        var count = 0;
        var arr = new Array<B>();
        for( i in it ){ 
           if( count >= this.start ) arr.push(f(i));
           if( count == this.max ) break;
           count++;
        }
        return arr;
    }

    public inline
    function filter<A>(it:Iterable<A>, f:(item:A) -> Bool):Array<A>{
        var count = 0;
        var arr = new Array<A>();
        for( i in it ){ 
           if( count >= this.start ) if( f(i) ) arr.push( i );
           if( count == this.max ) break;
           count++;
        }
        return arr;
     }
    public inline
    function find<T>(it:Iterable<T>, f:(item:T) -> Bool):Null<T>{
        var count = 0;
        var v = null;
        for( i in it ){ 
          if( count >= this.start ){
            if( f(i) ){
              v = i;
              break;
          }}
          if( count == this.max ) break;
          count++;
        }
        return v;
    }
    public inline
    function remapArray<A>( arr: Array<A>, f: (item:A)->A ): Array<A> {
        for( i in this.start...this.max ) arr[ i ] = f( arr[ i ] );
        return arr;
    }
    public inline
    function mapArray<A>( arr: Array<A>, f: (item:A)->A ): Array<A> {
        var arr2 = new Array<A>();
        var count = 0;
        for( i in this.start...this.max ){
            arr2[ count ] = f( arr[ i ] );
            count++;
        }
        return arr2;
    }
    
}
