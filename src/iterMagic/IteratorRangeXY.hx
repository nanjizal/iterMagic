package iterMagic;
import iterMagic.IteratorRange;
import IntIterator;
/*
function main() {
    //var range: IteratorRangeYX = { outer: 5...10, inner: 6...11 };
    var range: IteratorRangeYX = { x: 5, w: 4, y: 6, h: 4 };
    for( v in range ){
          trace( range.x, range.y );
    }
    trace("Haxe is great!");
}
*/
@:access(IntIterator.min, IntIterator.max )
class IntIterXY {
    public var x:      Int;
    public var y:      Int;
    public var xMax:   Int;
    public var yMax:   Int;
    public var xReset: Int;
    public var yReset: Int;
    public var iter:   IntIterator;
    public inline
    function new( xRange_: IteratorRange, yRange_: IteratorRange ){
        x = xRange_.start;
        y = yRange_.start-1;
        xReset = x;
        yReset = y;
        xMax = xRange_.max -2;
        yMax = yRange_.max -2;
        iter = 0...Std.int( xRange_.length*yRange_.length );
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract IteratorRangeXY( IntIterXY ) from IntIterXY {
	public inline
    function new( xRange: IteratorRange, yRange: IteratorRange ){
        this = new IntIterXY( xRange, yRange );
    }
    @:from
    static inline
    public function fromIterator2D( two: { outer: IntIterator, inner: IntIterator } ): IteratorRangeXY {
        return new IteratorRangeXY( two.outer, two.inner );
    }
    @:from
    static inline
    public function fromRect2D( r: { x: Int, w: Int, y: Int, h: Int } ): IteratorRangeXY {
        var xmax = r.x + r.w + 1;
        var ymax = r.y + r.h + 1;
        return new IteratorRangeXY( r.x...xmax, r.y...ymax );
    }
    @:from
    static inline
    public function fromRect2Df( r: { x: Float, w: Float, y: Float, h: Float } ): IteratorRangeXY {
        var xmax = Std.int( r.x + r.w + 1 );
        var ymax = Std.int( r.y + r.h + 1 );
        return new IteratorRangeXY( Std.int( r.x )...xmax, Std.int( r.y)... ymax );
    }
    public inline
    function hasNext():Bool{
        return this.iter.hasNext();
    }
    public inline
  	function next():Int{
      var i = this.iter.next();
      if( this.y > this.yMax ){
        this.y = this.yReset;
        this.x++;
      }
      this.y++;
      return i;
    }
    public
    var length( get, never ): Int; 
    inline
    function get_length(): Int {
        return this.iter.max - 0;
    }
    inline
    public function contains( x: Int, y: Int ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) );
    }
    inline
    public function containsF( x: Float, y: Float ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) );
    }
    inline
    public function getRangeX(): IteratorRange {
    	return ( ( this.xReset...(this.xMax-1) ): IteratorRange );
    }
    inline
    public function getRangeY(): IteratorRange {
        return ( ( this.yReset...(this.yMax-1) ): IteratorRange );
    }
}

@:access(IntIterator.min, IntIterator.max )
class IntIterYX {
    public var x:      Int;
    public var y:      Int;
    public var xMax:   Int;
    public var yMax:   Int;
    public var xReset: Int;
    public var yReset: Int;
    public var iter:   IntIterator;
    public inline
    function new( xRange_: IteratorRange, yRange_: IteratorRange ){
        x = xRange_.start - 1;
        y = yRange_.start;
        xReset = x;
        yReset = y;
        xMax = xRange_.max -2;
        yMax = yRange_.max -2;
        iter = 0...Std.int( xRange_.length*yRange_.length );
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract IteratorRangeYX( IntIterYX ) from IntIterYX {
	public inline
    function new( xRange: IteratorRange, yRange: IteratorRange ){
        this = new IntIterYX( xRange, yRange );
    }
    @:from
    static inline
    public function fromIterator2D( two: { outer: IntIterator, inner: IntIterator } ): IteratorRangeYX {
        return new IteratorRangeYX( two.outer, two.inner );
    }
    @:from
    static inline
    public function fromRect2D( r: { x: Int, w: Int, y: Int, h: Int } ): IteratorRangeYX {
        var xmax = r.x + r.w + 1;
        var ymax = r.y + r.h + 1;
        return new IteratorRangeYX( r.x...xmax, r.y...ymax );
    }
    @:from
    static inline
    public function fromRect2Df( r: { x: Float, w: Float, y: Float, h: Float } ): IteratorRangeYX {
        var xmax = Std.int( r.x + r.w + 1 );
        var ymax = Std.int( r.y + r.h + 1 );
        return new IteratorRangeYX( Std.int( r.x )...xmax, Std.int( r.y)... ymax );
    }
    public inline
    function hasNext():Bool{
        return this.iter.hasNext();
    }
    public inline
    function next():Int{
        var i = this.iter.next();
        if( this.x > this.xMax ){
            this.x = this.xReset;
            this.y++;
        }
        this.x++;
        return i;
    }
    public
    var length( get, never ): Int; 
    inline
    function get_length(): Int {
        return this.iter.max - 0;
    }
    inline
    public function contains( x: Int, y: Int ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) );
    }
    inline
    public function containsF( x: Float, y: Float ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) );
    }
    inline
    public function getRangeX(): IteratorRange {
        return ( ( this.xReset...(this.xMax-1) ): IteratorRange );
    }
    inline
    public function getRangeY(): IteratorRange {
        return ( ( this.yReset...(this.yMax-1) ): IteratorRange );
    }
}