package iterMagic;
// Provides an iterator over radians, always rotates the shortest distance.
/*
// https://try.haxe.org/#8BCfD43e
function main() {
    var start = -Math.PI;
    var end = Math.PI + Math.PI/2;
    trace( 'end ' + Pi2Iterator.pi2pi(end) );
    var targetStep = Math.PI/18;
    var iter = new Pi2Iterator( start, end, targetStep );
    for( i in iter ){
        trace( i );
    }
}
*/
@:access(IntIterator.min, IntIterator.max )
class Pi2Iter {
    public var start = 0;
    public var max = .1;
    public var step: Float = 0;
    public var startRadian = 0.;
    public var stepFactor =0.;
  	public var value: Float = 0.;
    var count = 0;
    public var includeMax:Bool = false;
    public inline
    function new(){}
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:access( Pi2Iter.includeMax )
@:access( Pi2Iter.count )
@:access( Pi2Iter.startRadian )
@:access( Pi2Iter.stepFactor )
@:access( Pi2Iter.value )
@:forward
abstract Pi2Iterator( Pi2Iter ) from Pi2Iter {
    // step must be positive
    inline function step( count_: Int ): Pi2Iterator {
        if( count_ < 0. ) count_ = -count_;
        this.step = 1./count_;
        this.value = 0.;
        this.max = count_;
        return abstract;
    }
    public inline
    function new( start_: Float, end_: Float, targetStep: Float ){
        this = new Pi2Iter();
        var delta = small( start_, end_ );
        this.startRadian = start_;
        var steps = Std.int( delta/targetStep );
        var stepRotation = delta/steps;
        abstract.step( steps ).toTheTop();
    	this.stepFactor = stepRotation * steps;
    }
    public inline
    function hasNext() {
        return if( this.includeMax ){
            this.count++ < this.max + this.step;
        } else {
            this.count++ < this.max;
        }
    }
    public inline
    function next():Float {
        this.value = this.start + (this.count-1) * this.step;
        return this.startRadian+( this.value *this.stepFactor );
    }
    public inline
    function toTheTop() {
        this.includeMax = true;
        return abstract;
    }
    public inline
    function reset(){
        this.count = 0;
        this.value = 0.;
        return abstract;
    }
    public inline
    static function pi2pi( angle: Float ): Float {
        return if( angle <= Math.PI && angle > -Math.PI ){
            angle;
        } else {
            var a = ( angle + Math.PI ) % ( 2 * Math.PI );
            ( a >= 0 )? a - Math.PI: a + Math.PI;
        }
    }
    inline public
    static function zeroto2pi( angle: Float ): Float {
        return if( angle >= 0 && angle > Math.PI ){
            angle;
        } else {
            var a = angle % ( 2 * Math.PI );
            return ( a >= 0 )? a : ( a + 2 * Math.PI );
        }  
    }
    inline
    static function small( a: Float, b: Float ): Float {
        var fa: Float = zeroto2pi( a );
        var fb: Float = zeroto2pi( b );
        var theta = Math.abs( fa - fb );
        var smallest = ( theta <= Math.PI ); // smallest or equal!
        var clockwise = a < b;
        var dif = ( clockwise )? theta: -theta;
        return if( smallest ) {
            dif;
        } else {
            ( clockwise )? -( 2 * Math.PI - theta ): 2 * Math.PI - theta;
        }
    }
}