package iterMagic;

import iterMagic.EaseIter;
import iterMagic.Pi2Iterator;

/*
// https://try.haxe.org/#9D75044D
class Test {
  static function main() {
    var start = -Math.PI;
    var end = Math.PI + Math.PI/2;
    var targetStep = Math.PI/18;
    var iter = new Pi2EaseIter( start, end, targetStep ).easing( sineInOut );
    for( i in iter ){
        trace( i );
    }
  }
}

17:12:53:630   Test.hx:673:,-3.141592653589793
17:12:53:633   Test.hx:673:,-3.0942273487157324
17:12:53:634   Test.hx:673:,-2.957844388898811
17:12:53:635   Test.hx:673:,-2.748893571891069
17:12:53:636   Test.hx:673:,-2.4925774500092657
17:12:53:637   Test.hx:673:,-2.219811530375424
17:12:53:638   Test.hx:673:,-1.963495408493621
17:12:53:639   Test.hx:673:,-1.7545445914858786
17:12:53:640   Test.hx:673:,-1.6181616316689575
17:12:53:641   Test.hx:673:,-1.5707963267948966
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
    inline function step( count_: Int ): Pi2EaseIter {
        if( count_ < 0. ) count_ = -count_;
        this.step = 1./count_;
        this.value = 0.;
        this.max = count_;
        return abstract;
    }
    public inline
    function new( start_: Float, end_: Float, targetStep: Float ){
        this = new Pi2EasyIter();
        var delta = Pi2Iterator.small( start_, end_ );
        this.startRadian = start_;
        var steps = Std.int( delta/targetStep );
        this.deltaRadian = delta;
        abstract.step( steps ).toTheTop();
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