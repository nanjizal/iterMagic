package iterMagic;
typedef BoolUpdate = ( Bool )->Bool;
abstract Booly( Bool ) to Bool from Bool {
  public inline function new( b ) this = b;
  public var updater( get, never ): BoolUpdate;
  inline function get_updater(): BoolUpdate {
    final bReturn = function( b: Bool ): Bool {
      this = b;
      return b;
    }
    return bReturn;
  }
}
