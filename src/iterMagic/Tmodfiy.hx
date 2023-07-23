package iterMagic;
typedef Tupdate<T> = ( T )->T;
abstract Tmodify<T>( T ) to T from T {
  public inline function new( t ) this = t;
  public var updater( get, never ): Tupdate<T>;
  inline function get_updater(): Tupdate<T> {
		return function( t: T ): T {
      this = t;
      return t;
    }
  }
}

// too messy but interesting..
class Tstruct<T> {
  public var t:T;
  public var update: Tupdate<T>;
  public function new( t: T ){
     this.t = t;
  }
}

@:forward
abstract Tmodify2<T>(Tstruct<T>){
  public inline function new(t: T ){
    this = new Tstruct<T>( t );
    this.update = createUpdate();
  }
  public inline function createUpdate(): Tupdate<T> {
	return function(t:T):T {
		this.t = t;
		return t;
	}
  }
  @:to
  public function toTmodify(): T{
    var s = this;
    return s.t;
  }
  @:from
  public static inline function fromTmodify<T>( t: T ): Tmodify2<T> {
	return new Tmodify2<T>(t);
  } 
}
/*
function main() {
	var i:Tmodify2<Int> = 0;
	plus1( i );
	trace( (i:Int ) );
}

function plus1(i:Tmodify2<Int> ) {
	i.update( (i:Int) + 1 );
}
*/
