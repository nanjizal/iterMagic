package iterMagic;
typedef FloatUpdate = ( Float )->Float;
abstract Floaty( Float ) to Float from Float {
  public inline function new( f ) this = f;
  public var updater( get, never ): FloatUpdate;
  inline function get_updater(): FloatUpdate {
	  final fReturn = function( f: Float ): Float {
      this = f;
      return f;
    }
    return fReturn;
  }
}
