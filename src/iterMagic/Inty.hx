package iterMagic;
typedef IntUpdate = ( Int )->Int;
abstract Inty( Int ) to Int from Int {
  public inline function new( s ) this = s;
  public var updater( get, never ): IntUpdate;
  inline function get_updater(): IntUpdate {
    final iReturn = function( i: Int ): Int {
      this = i;
      return i;
    }
    return iReturn;
  }
}
