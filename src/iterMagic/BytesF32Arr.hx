package iterMagic;
/*
function main() {
  trace("Haxe is great!");
  var bf = new BytesF32Arr( 10 );
  bf.x[0] = 100.;
  bf.y[1] = 120.;
  trace( bf );
  trace( bf.y[1] );
  trace( bf.vec(0) );
  for( v in bf ) trace( v );
}
*/
@:structInit 
class PointXYZ{
	public var x: Float;
  public var y: Float;
  public var z: Float;
  inline
  public function new( x: Float, y: Float, z: Float ){
		this.x = x;
    this.y = y;
    this.z = z;
  }
  @:keep
  inline
  public function toString(): String {
    return '{ x: $x, y: $y, z: $z }';
  }
}
typedef BytesFloat = haxe.io.Bytes;
interface IPoints<T> {
    public var count: Int;
    public var length: Int;
    public function set( index: Int, value: Float ): Float;
    public function get( index: Int ): Float;
    public function zero( len: Int ): T;
}
class BytesF32Arr_ implements IPoints<BytesFloat>{
    var data: BytesFloat;
    public var count   = 0;
    public var length: Int;
    public function new(){}
    public inline
    function set( index: Int, value: Float ): Float {
        this.data.setFloat(Std.int(index * 4), value);
        return value;
    }
    public inline
    function get( index: Int ): Float {
        return ( this.data.getFloat( Std.int( index * 4 ) ) );
    }
    public inline
    function zero( len :Int ): BytesFloat {
        for( i in 0...this.length ) {
          this.data.setFloat( Std.int(i * 4), 0 );
        }
        return data;
    }
}
@:access( BytesF32Arr_.data )
abstract BytesF32Arr( BytesF32Arr_ ) from BytesF32Arr_ to BytesF32Arr {
  public inline
  function new( len: Int ){
		this = new BytesF32Arr_();
    this.length = len;
    this.data   = BytesFloat.alloc( this.length*4 );
    this.zero(len*3);
  }
  public inline function data(): BytesFloat {
		return this.data;
  }
  public var x( get, never ): XPoints;
  inline function get_x(): XPoints {
      return ( abstract: XPoints );
  }
  public var y( get, never ): YPoints;
  inline function get_y(): YPoints {
      return ( abstract: YPoints );
  }
  public var z( get, never ): ZPoints;
  inline function get_z(): ZPoints {
      return ( abstract: ZPoints );
  }
  public var length( get, never ): Int;
  inline function get_length(): Int {
		return Std.int( this.length/3 );
  }
  public inline 
  function xyz( index: Int, x_: Float, y_: Float, z_: Float ){
		abstract.x[index] = x_;
    abstract.y[index] = y_;
    abstract.z[index] = z_;
  }
  public inline 
  function vec( index: Int ): PointXYZ {
    return { x: abstract.x[index]
           , y: abstract.y[index]
           , z: abstract.z[index] };
  }
  @:arrayAccess
  public inline
  function set( index: Int, v: PointXYZ ): PointXYZ {
      xyz( index, v.x, v.y, v.z );
      return v;
  }
  @:arrayAccess
  public inline
  function get( index: Int ): PointXYZ {
      return vec(index);
  }
  public inline
  function hasNext():Bool {
      return ( this.count < length );
  }
  public inline
  function next() {
      return get( this.count++ );
  }
  public inline
  function resetCount(){
      this.count = 0;
  }
  public inline
  function toString():String{
    var str = '[';
    for( i in 0...length ){
      str +=      abstract.x[i] 
          + ' ' + abstract.y[i]
          + ' ' + abstract.z[i] + ',';
    }
    trace( 'length ' + length );
    str = str.substr( 0, str.length-1 );
    str += ']';
    return str;
  }
}
@:access( BytesF32Arr.data )
abstract XPoints( BytesF32Arr ) from BytesF32Arr to BytesF32Arr {
  public function new( bf32: BytesF32Arr ){
		this = bf32;
  }
  @:arrayAccess
  public inline
  function set( index: Int, value: Float ): Float {
      this.data().setFloat(Std.int(index * 4 * 3), value);
      return value;
  }
  @:arrayAccess
  public inline
  function get( index: Int ): Float {
      return ( this.data().getFloat( Std.int( index * 4 * 3 ) ));
  }
}
@:access( BytesF32Arr.data )
abstract YPoints( BytesF32Arr ) from BytesF32Arr to BytesF32Arr {
  public function new( bf32: BytesF32Arr ){
		this = bf32;
  }
  @:arrayAccess
  public inline
  function set( index: Int, value: Float ): Float {
      this.data().setFloat(Std.int(index * 4 * 3 + 4 ), value);
      return value;
  }
  @:arrayAccess
  public inline
  function get( index: Int ): Float {
      return ( this.data().getFloat( Std.int( index * 4 * 3 + 4 ) ));
  }
}
@:access( BytesF32Arr.data )
abstract ZPoints( BytesF32Arr ) from BytesF32Arr to BytesF32Arr {
  public function new( bf32: BytesF32Arr ){
		this = bf32;
  }
  @:arrayAccess
  public inline
  function set( index: Int, value: Float ): Float {
      this.data().setFloat(Std.int(index * 4 * 3 + 8 ), value);
      return value;
  }
  @:arrayAccess
  public inline
  function get( index: Int ): Float {
      return ( this.data().getFloat( Std.int( index * 4 * 3 + 8 ) ));
  }
}
