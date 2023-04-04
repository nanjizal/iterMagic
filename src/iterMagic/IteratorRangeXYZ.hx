package iterMagic;
import iterMagic.IteratorRange;
import IntIterator;
/*
// https://try.haxe.org/#f8642288
function main() {
    //var range: IteratorRangeXYZ = { outer: 5...10, inner: 6...11 };
    var range: IteratorRangeXYZ = { x: 5, w: 4, y: 6, h: 4, z: 24, d: 6 };
    for( v in range ){
        trace( range.x, range.y, range.z );
    }
    trace("Haxe is great!");
}
*/
@:access(IntIterator.min, IntIterator.max )
class IntIterXYZ {
    public var x:      Int;
    public var y:      Int;
    public var z:      Int;
    public var xMax:   Int;
    public var yMax:   Int;
    public var zMax:   Int;
    public var xReset: Int;
    public var yReset: Int;
    public var zReset: Int;
    public var iter:   IntIterator;
    public inline
    function new( xRange_: IteratorRange, yRange_: IteratorRange, zRange_: IteratorRange ){
        x = xRange_.start;
        y = yRange_.start-1;
        z = zRange_.start-1;
        xReset = x;
        yReset = y;
        zReset = z;
        xMax = xRange_.max -2;
        yMax = yRange_.max -2;
        zMax = zRange_.max -2;
        iter = 0...Std.int( xRange_.length*yRange_.length*zRange_.length );
    }
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:forward
abstract IteratorRangeXYZ( IntIterXYZ ) from IntIterXYZ {
	public inline
    function new( xRange: IteratorRange, yRange: IteratorRange, zRange: IteratorRange ){
        this = new IntIterXYZ( xRange, yRange, zRange );
    }
    @:from
    static inline
    public function fromIterator3D( three: { outer: IntIterator, middle: IntIterator, inner: IntIterator } ): IteratorRangeXYZ {
        return new IteratorRangeXYZ( three.outer, three.middle, three.inner );
    }
    @:from
    static inline
    public function fromRect3D( r: { x: Int, w: Int, y: Int, h: Int, z: Int, d: Int } ): IteratorRangeXYZ {
        var xmax = r.x + r.w + 1;
        var ymax = r.y + r.h + 1;
        var zmax = r.z + r.d + 1;
        return new IteratorRangeXYZ( r.x...xmax, r.y...ymax, r.z...zmax );
    }
    public inline
    function hasNext():Bool{
        return this.iter.hasNext();
    }
    public inline
  	function next():Int{
        var i = this.iter.next();
        if( this.z > this.zMax ){
            this.z = this.zReset;
            if( this.y > this.yMax ){
                this.y = this.yReset;
                this.x++;
            }
            this.y++;
        }
        this.z++;
        return i;
    }
    public
    var length( get, never ): Int; 
    inline
    function get_length(): Int {
        return this.iter.max - 0;
    }
    inline
    public function contains( x: Int, y: Int, z: Int ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) )
            && ( z > ( this.zReset - 1 ) && ( z < this.zMax ) );
    }
    inline
    public function containsF( x: Float, y: Float, z: Float ): Bool {
        return ( x > ( this.xReset - 1 ) && ( x < this.xMax ) ) 
            && ( y > ( this.yReset - 1 ) && ( y < this.yMax ) )
            && ( z > ( this.zReset - 1 ) && ( z < this.zMax ) );
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
}