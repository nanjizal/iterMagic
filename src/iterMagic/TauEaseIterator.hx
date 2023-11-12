package iterMagic;
import iterMagic.EaseIterator;
class TauEaseIter {
    public var tauIter: TauIterator;
    public var ease: Null<Float -> Float> = null;
    public inline 
    function new( tauIter: TauIter ){
        this.tauIter = tauIter;
    }
}
@:transitive
@:forward
abstract TauEaseIterator {
    public inline
    function new( min: Float, max: Float, steps: Int ){
        this = new TauIter( tauLimit( min, true ), tauLimit( max, true ), step );
    }
    public inline
    function hasNext(): Bool {
        return this.tauIter.hasNext();
    }
    public inline
    function next():Float {
        var n = this.tauIter.iter.next();
        var hasFinish = false;
        this.value = if( n == 1. ){
            hasFinish = true;
            this.end;
        } else {
            tauLimit( this.tauIter.start + this.ease( n * this.stepSize ), true );
        }
        if( hasFinish && finish != null ) finish();
        return this.value;
    }
    public inline
    function easing( ease_: Float -> Float ){
      this.ease = ease_;
      return abstract;
    }
    public inline
    function finished( finish_: Void->Void ){
        this.tauIter.finish = finish_;
        return abstract;
    }
}
