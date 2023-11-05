package iterMagic;
/* 
  Basic data structure to work with images made of Int, does not provide color specific manipulation.
*/
import haxe.ds.GenericStack; // assess to GenericCell
import haxe.ds.Vector;

typedef Bytes = haxe.io.Bytes;
typedef ArrInt = Array<Int>;
typedef U32Arr = haxe.io.UInt32Array;
typedef VecInt = haxe.ds.Vector<Int>;
typedef StackInt = haxe.ds.GenericStack<Int>;

enum abstract ImageType(Int) {
	var BYTES;
	var ARRAY;
	var UINT32ARRAY;
	var VECTOR;
	var GENERICSTACK;
}
/* example use
function main() {
  var a: Img<ArrInt> = Img.arrInt( 5, 5 );
  var v: Img<VecInt> = Img.vecInt( 5, 5 );
  var b: Img<Bytes>  = Img.bytes( 5, 5 );
  var u: Img<U32Arr> = Img.u32arr( 5, 5 );
  var s: Img<StackInt> = Img.stackInt( 5, 5 );
  a[3]=1;
  v[2]=2;
  b[4]=6;
  u[7]=7;
  s[1]=3;
  trace( a[3] );
  trace( v[2] );
  trace( b[4] );
  trace( u[7] );
  trace( s[1] );
  trace( s.toString() );
  //for( i in a )	trace( i );
  trace('array');
  a.traceGrid();
  trace('vector');
  v.traceGrid();
  trace('array content now in vector');
  Img.copyFromTo( a, v );
  v.traceGrid();
}
*/ 

interface Iimg<T> {
  public var count: Int;
  public var width: Int;
  public var height: Int;
  public var length: Int;
  public function set( index: Int, value:Int ): Int;
	public function get( index: Int): Int;
  public function zero( len: Int ): T;
  public function size( width: Int, height: Int ): T;
}

class ArrIntImg implements Iimg<ArrInt> {
  var data: ArrInt;
  public var count   = 0;
  public var width:  Int;
  public var height: Int;
  public var length: Int;
  public function new() {
  }
  public inline
  function set( index: Int, value: Int ): Int {
		data[ index ] = value;
    return value;
  }
  public inline
  function get( index: Int ): Int {
		return data[ index ];
  }
  public inline
  function zero( len :Int ): ArrInt {
    for( i in 0...len ) data[i] = 0;
    return this.data;
  }
  public inline
  function size( width: Int, height: Int ): ArrInt {
    this.width  = width;
    this.height = height;
    data        = [];
    length      = Std.int( width*height );
    return zero( length );
  }
}
class VecIntImg implements Iimg<VecInt>{
  var data:VecInt;
  public var count   = 0;
  public var width:  Int;
  public var height: Int;
  public var length: Int;
	public function new() {}
  public inline
  function set( index: Int, value: Int ): Int {
		data[ index ] = value;
    return value;
  }
  public inline
  function get( index: Int ): Int {
		return data[ index ];
  }
  public inline
  function zero( len :Int ): VecInt {
    for( i in 0...len ) data[ i ] = 0;
    return this.data;
  }
  public inline
  function size( width: Int, height: Int ): VecInt {
    this.width  = width;
    this.height = height;
    length      = Std.int( width*height );
    data        = new Vector( length );
    return zero( length );
  }
}
class BytesImg implements Iimg<Bytes>{
  var data:Bytes;
  public var count   = 0;
  public var width:  Int;
  public var height: Int;
  public var length: Int;
	public function new(){}
  public inline
  function set( index: Int, value: Int ): Int {
		this.data.setInt32(Std.int(index * 4), value);
		return value;
	}
  public inline
  function get( index: Int ): Int {
		return ( this.data.getInt32( Std.int( index * 4 ) ) );
	}
  public inline
  function zero( len :Int ): Bytes {
		var w = 0;
		for( y in 0...this.height ) {
			for( x in 0...this.width ) {
				this.data.set( w++, 0 );
				this.data.set( w++, 0 );
				this.data.set( w++, 0 );
				this.data.set( w++, 0 );
			}
		}
    return data;
  }
  public inline
  function size( width: Int, height: Int ): Bytes {
    this.width  = width;
    this.height = height;
    length      = Std.int( width*height );
    this.data   = haxe.io.Bytes.alloc( length*4 );
    return zero( length );
  }
}
class U32ArrImg implements Iimg<U32Arr> {
  var data:U32Arr;
  public var count   = 0;
  public var width:  Int;
  public var height: Int;
  public var length: Int;
	public function new(){}
  public inline
  function set( index: Int, value: Int ): Int {
		data[ index ] = value;
    return value;
  }
  public inline
  function get( index: Int ): Int {
		return data[ index ];
  }
  public inline
  function zero( len :Int ): U32Arr{
    for( i in 0...len ) data[ i ] = 0;
    return this.data;
  }
  public inline
  function size( width: Int, height: Int ): U32Arr {
    this.width  = width;
    this.height = height;
    length      = Std.int( width*height );
    this.data   = new haxe.io.UInt32Array( length );
    return zero( length );
  }
}
class StackIntImg implements Iimg<StackInt> {
  var data:StackInt;
  public var count   = 0;
  public var width:  Int;
  public var height: Int;
  public var length: Int;
	public function new(){}
	public inline function set( index: Int, value: UInt ):UInt {
		var l = this.data.head;
		var prev:GenericCell<Int> = null;
		for( i in 0...index ) {
			prev = l;
			l = l.next;
		}
    if( prev == null ){
      this.data.head = new GenericCell<Int>( value, l.next );
      l = null;
    } else {
      prev.next = new GenericCell<Int>( value, l.next );
      l = null;
    }
		return value;
	}
	public inline
  function get( index: Int ): UInt {
    var l = this.data.head;
		var prev:GenericCell<Int> = l;
    index += 1;
		for( i in 0...index ) {
			prev = l;
			l = l.next;
		}
		return prev.elt;
	}
	public inline
  function zero( len ) {
		var d = this.data;
		if( d.isEmpty() ) {
			for( i in 0...len ) d.add( 0 );
		} else {
			for( i in 0...len ) set( i, 0 );
		}
    return data;
	}
  public inline
  function size( width: Int, height: Int ): StackInt   {
    this.width  = width;
    this.height = height;
    length      = Std.int(width*height);
    this.data   = new haxe.ds.GenericStack<Int>();
    return zero( length );
  }
}
@:forward
@:multiType
abstract Img<T>( Iimg<T> ) {
	public function new( a:T );
	@:to static inline
	function toArrIntImg( t: Iimg<ArrInt>
                      , s: Null<ArrInt> = null ): ArrIntImg {
		var arrI = new ArrIntImg();
		return arrI;
  }
  @:to static inline
	function toVecIntImg( t: Iimg<VecInt>
                      , s: Null<VecInt> = null ): VecIntImg {
  	var vec = new VecIntImg( );
    return vec;
  }
  @:to static inline
  function toBytesImg( t: Iimg<Bytes>
                     , s: Null<Bytes> = null ): BytesImg {
    var byt = new BytesImg( );
    return byt;
  }
  @:to static inline
  function toU32ArrImg( t: Iimg<U32Arr>
                      , s: Null<U32Arr> = null ): U32ArrImg {
  	var u32a = new U32ArrImg( );
    return u32a;
  }
  @:to static inline
  function toStackIntImg( t: Iimg<StackInt>
                        , s: Null<StackInt> = null ): StackIntImg {
  	var sInt = new StackIntImg( );
    return sInt;
  }
  public static inline
	function arrInt( width: Int, height: Int ){
		var a = new Img<ArrInt>( null );
  	a.size( width, height );
  	return a;
	}
  public static inline
	function vecInt( width: Int, height: Int ){
		var v = new Img<VecInt>( null );
  	v.size(width,height);
  	return v;
	}
  public static inline
	function bytes( width: Int, height: Int ){
		var b = new Img<Bytes>( null );
  	b.size(width,height);
  	return b;
  }
  public static inline
	function u32arr( width: Int, height: Int ){
		var b = new Img<U32Arr>( null );
  	b.size(width,height);
  	return b;
  }
  public static inline
	function stackInt( width: Int, height: Int ){
		var b = new Img<StackInt>( null );
  	b.size(width,height);
  	return b;
  }
  @:arrayAccess
  public inline
  function set( index: Int, value: Int ): Int {
		return this.set( index, value );
  }
  @:arrayAccess
  public inline
  function get( index: Int ): Int {
		return this.get( index );
  }
  public inline
  function position( px: Float, py: Float ): Int {
		return Std.int( py * this.width + px );
	}
	public inline
  function toString() {
		var str = '[';
    for( i in 0...this.length ) str += Std.string( get(i) ) +',';
    return str.substr( 0, str.length - 1 ) + ']';
	}
  public inline
  function hasNext():Bool {
		return ( this.count < this.length );
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
  function traceGrid() {
		var count = 0;
    var str = '[ ';
    for( y in 0...this.height ){
      for( x in 0...this.width ){
				str += get( count++ ) +', ';
      }
      str = str.substr( 0, str.length - 2 );
      trace( str +' ]');
      str = '[ ';
    }
  }
  public static inline
  function copyFromTo<T,S>( a: Img<T>, b: Img<S> ) {
    for( i in 0...b.length ) b[ i ] = a[ i ];
    return b;
  }
  public static inline
  function copyToFrom<T,S>( a: Img<T>, b: Img<S> ) {
    for( i in 0...b.length ) a[ i ] = b[ i ];
    return a;
  }
}
