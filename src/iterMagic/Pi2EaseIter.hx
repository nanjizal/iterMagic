package iterMagic;

import iterMagic.EaseIter;
import iterMagic.Pi2Iterator;

/*
// https://try.haxe.org/#9D75044D
class Test {
  static function main() {
    var start = -Math.PI;
    var end = Math.PI + Math.PI/2;
    var iter = new Pi2EaseIter( start, end ).step( 10 ).easing( sineInOut );
    for( i in iter ){
        trace( i );
    }
  }
}


17:28:45:811   Test.hx:672:,-3.141592653589793
17:28:45:814   Test.hx:672:,-3.103152531377734
17:28:45:815   Test.hx:672:,-2.991594951731752
17:28:45:816   Test.hx:672:,-2.817839947814959
17:28:45:817   Test.hx:672:,-2.598895870033028
17:28:45:817   Test.hx:672:,-2.356194490192345
17:28:45:818   Test.hx:672:,-2.113493110351661
17:28:45:819   Test.hx:672:,-1.8945490325697307
17:28:45:820   Test.hx:672:,-1.7207940286529373
17:28:45:821   Test.hx:672:,-1.6092364490069557
17:28:45:822   Test.hx:672:,-1.5707963267948966
*/

@:access(IntIterator.min, IntIterator.max )
class Pi2EasyIter {
    public var start        = 0;
    public var max          = .1;
    public var step         = 0.;
    public var startRadian  = 0.;
    public var deltaRadian  = 0.;
  	public var value        = 0.;
    var ease: Null<Float -> Float> = null;
    var finish: Null<Void -> Void> = null;
    var count               = 0;
    public var includeMax   = false;
    public inline
    function new(){}
}

@:transitive
@:access( IntIterator.min, IntIterator.max )
@:access( Pi2EasyIter.includeMax )
@:access( Pi2EasyIter.count )
@:access( Pi2EasyIter.startRadian )
@:access( Pi2EasyIter.deltaRadian )
@:access( Pi2EasyIter.finish )
@:access( Pi2EasyIter.ease )
@:access( Pi2EasyIter.value )
@:access( Pi2Iterator.small )
@:forward
abstract Pi2EaseIter( Pi2EasyIter ) from Pi2EasyIter {
    // step must be positive
    public inline function step( count_: Int ): Pi2EaseIter {
        if( count_ < 0. ) count_ = -count_;
        this.step = 1./count_;
        this.value = 0.;
        this.max = count_;
        return abstract;
    }
    public inline
    function new( start_: Float, end_: Float ){
        this = new Pi2EasyIter();
        var delta = Pi2Iterator.small( start_, end_ );
        this.startRadian = start_;
        this.deltaRadian = delta;
        abstract.toTheTop();
    }
    public inline
    function hasNext() {
        var out = if( this.includeMax ){
            this.count++ < this.max + this.step;
        } else {
            this.count++ < this.max;
        }
        if( !out && this.finish != null ) this.finish();
        return out;
    }
    public inline
    function easing( ease_: Float -> Float ){
      this.ease = ease_;
      return abstract;
    }
    public inline
    function next():Float {
        this.value = this.start + (this.count-1) * this.step;
        return this.ease( this.value )*this.deltaRadian + this.startRadian;
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
    function finished( finish_: Void->Void ){
        this.finish = finish_;
        return abstract;
    }
}