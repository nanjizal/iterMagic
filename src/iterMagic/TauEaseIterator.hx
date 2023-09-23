package iterMagic;

class TauEaseIter {
    public var tauIter: TauIterator;
    public var delta:   Float;
    public var ease: Null<Float -> Float> = null;
    public var finish: Null<Void -> Void> = null;
    public inline 
    function new( tauIter: TauIter ){
        this.tauIter = tauIter;
    }
}
@:transitive
@:forward
abstract TauEaseIter {
    public inline function step( count_: Int ): TauIterator {
        this.iter.iter= (new UnitIterator()).step( count_ ).toTheTop();
        this.delta = smallest( this.start, this.end );
        return abstract;
    }
    public inline
    function new( min: Float, max: Float, steps: Int ){
        this = new TauIter( tauLimit( min, true ), tauLimit( max, true ) );
        step( steps );
    }
    public inline
    function hasNext(): Bool {
        return this.tauIter.hasNext();
    }
    public inline
    function next():Float {
        var n = this.iter.iter.next();
        var hasFinished = false;
        this.value = if( n == 1. ){
            hasFinished = true;
            this.end;
        } else {
            tauLimit( this.iter.start + this.ease( n ) * this.delta, true );
        }
        if( hasFinished == true && this.iter.finish != null ) this.iter.finish();
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
