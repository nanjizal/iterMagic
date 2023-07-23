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
