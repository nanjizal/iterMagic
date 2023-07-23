package iterMagic;
typedef StringUpdate = ( String )->String;
abstract Stringy( String ) to String from String {
  public inline function new( s ) this = s;
  public var updater( get, never ): StringUpdate;
  inline function get_updater(): StringUpdate {
	final sReturn = function( s: String ): String {
      this = s;
      return s;
    }
    return sReturn;
  }
}
