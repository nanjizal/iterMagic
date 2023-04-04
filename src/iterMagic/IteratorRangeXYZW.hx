package iterMagic;
import iterMagic.IteratorRange;
import IntIterator;

@:access(IntIterator.min, IntIterator.max )
class IntIterXYZW {
    public var x:      Int;
    public var y:      Int;
    public var z:      Int;
    public var w:      Int;
    public var xMax:   Int;
    public var yMax:   Int;
    public var zMax:   Int;
    public var wMax:   Int;
    public var xReset: Int;
    public var yReset: Int;
    public var zReset: Int;
    public var wReset: Int;
    public var iter:   IntIterator;
    public inline
    function new( xRange_: IteratorRange, yRange_: IteratorRange, zRange_: IteratorRange, wRange_: IteratorRange ){
        x = xRange_.start;
        y = yRange_.start-1;
        z = zRange_.start-1;
        w = wRange_.start-1;
        xReset = x;
        yReset = y;
        zReset = z;
        wReset = w;
        xMax = xRange_.max -2;
        yMax = yRange_.max -2;
        zMax = zRange_.max -2;
        wMax = wRange_.max -2;
        iter = 0...Std.int( xRange_.length*yRange_.length*zRange_.length*wRange_.length );
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract IteratorRangeXYZW( IntIterXYZW ) from IntIterXYZW {
	public inline
    function new( xRange: IteratorRange, yRange: IteratorRange, zRange: IteratorRange ){
        this = new IntIterXYZW( xRange, yRange, zRange );
    }
    @:from
    static inline
    public function fromIterator4D( four: { outer: IntIterator, middleOuter: IntIterator, middleInner: IntIterator, inner: IntIterator } ): IteratorRangeXYZW {
        return new IteratorRangeXYZW( four.outer, four.middleOuter, four.middleInner, four.inner );
    }
    @:from
    static inline
    public function fromRect4D( r: { x: Int, w: Int, y: Int, h: Int, z: Int, d: Int, w: Int, v: Int } ): IteratorRangeXYZW {
        var xmax = r.x + r.w + 1;
        var ymax = r.y + r.h + 1;
        var zmax = r.z + r.d + 1;
        var vmax = r.w + r.v + 1;
        return new IteratorRangeXYZW( r.x...xmax, r.y...ymax, r.z...zmax, r.x...wmax );
    }
    public inline
    function hasNext():Bool{
        return this.iter.hasNext();
    }
    public inline
  	function next():Int{
        var i = this.iter.next();
        if( this.w > this.wMax ){
            this.w = this.wReset;
            if( this.z > this.zMax ){
                this.z = this.zReset;
                if( this.y > this.yMax ){
                    this.y = this.yReset;
                    this.x++;
                }
                this.y++;
            }
            this.z++;
        }
        this.w++;
        return i;
    }
    public
    var length( get, never ): Int; 
    inline
    function get_length(): Int {
        return this.iter.max - 0;
    }
    inline
    public function contains( x: Int, y: Int, z: Int, w: Int ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) )
            && ( z > ( this.zReset - 1 ) && ( z < this.zMax ) )
            && ( w > ( this.wReset - 1 ) && ( w < this.wMax ) );
    }
    inline
    public function containsF( x: Float, y: Float, z: Float ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) )
            && ( z > ( this.zReset - 1 ) && ( z < this.zMax ) )
            && ( w > ( this.wReset - 1 ) && ( w < this.wMax ) );
    }
    inline
    public function getRangeX(): IteratorRange {
    	return ( ( this.xReset...(this.xMax-1) ): IteratorRange );
    }
    inline
    public function getRangeY(): IteratorRange {
        return ( ( this.yReset...(this.yMax-1) ): IteratorRange );
    }
    public function getRangeZ(): IteratorRange {
        return ( ( this.zReset...( this.zMax-1) ): IteratorRange );
    }
    public function getRangeW(): IteratorRange {
        return ( ( this.wReset...( this.wMax-1) ): IteratorRange );
    }
}