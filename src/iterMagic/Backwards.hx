package iterMagic;
import iterMagic.IteratorRange;
/*
class Test {
    static function main() {
        for( i in (( 0...10 ): Backwards ) ) trace( i );
    }
}
*/
@:transitive
@:access( IntIterator.min, IntIterator.max )
abstract Backwards( IntIterStart ) from IntIterStart {
    public inline
    function new( min: Int, max: Int ){
        this = new IntIterStart( min, max );
    }
    @:from
    static inline
    public function fromIterator( ii: IntIterator ): Backwards {
        return new Backwards( ii.min, ii.max );
    }
    @:to
    function toIterStart():Backwards {
        return new Backwards( this.start, this.max );
    }
    public inline function hasNext() {
        return this.max > this.start;
    }
    public inline function next() {
        return ( this.max-- -1 );
    }
}
