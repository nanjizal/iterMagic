package iterMagic;
/* 
  Basic data structure to work with images made of Int, does not provide color specific manipulation.
*/
import haxe.ds.GenericStack; // assess to GenericCell
import haxe.ds.Vector;

typedef BytesInt = haxe.io.Bytes;
typedef ArrInt = Array<Int>;
typedef U32Arr = haxe.io.UInt32Array;
typedef VecInt = haxe.ds.Vector<Int>;
typedef StackInt = haxe.ds.GenericStack<Int>;

enum abstract ImageType(Int) {
    var BYTES_INT;
    var ARRAY_INT;
    var U32_ARR;
    var VECTOR_INT;
    var STACK_INT;
    function toString(){
      return switch( abstract ){
            case BYTES_INT:
              'BYTES_INT';
            case ARRAY_INT:
              'ARRAY_INT';
            case U32_ARR:
              'U32_ARR';
            case VECTOR_INT:
              'VECTOR_INT';
            case STACK_INT:
              'STACK_INT';
      }
    }
}

enum RawImageData {
	RawBytesImg( b: BytesInt );
  RawArrImg( a: ArrInt );
  RawU32Img( u: U32Arr );
	RawVecImg( v: VecInt );
  RawStackImg( s: StackInt );
}
/*
// example use     
function main() {
  var a = new Picture( 5, 5, ARRAY_INT );
  var v = new Picture( 5, 5, VECTOR_INT );
  var b = new Picture( 5, 5, BYTES_INT );
  var u = new Picture( 5, 5, U32_ARR );
  var s = new Picture( 5, 5, STACK_INT );
  var picture = new Picture( 5, 5 );
  trace( picture.img.check() );
  var picture2 = new Picture( 5, 5, VECTOR_INT );
  trace( picture2.img.check() );
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
  trace( s.imgToString() );
  //for( i in a )	trace( i );
  trace('array');
  a.traceGrid();
  trace('vector');
  v.traceGrid();
  trace('array content now in vector');
  Picture.fromTo( a, v );
  v.traceGrid();
  trace( v.imageTypeString() );
  rawTrace( v );
}
function rawTrace( p: Picture ){
  trace('raw trace');
	switch( p.raw ){
		case RawBytesImg( b ):
      trace( 'BytesInt data ' + b );
    case RawArrImg( a ):
      trace( 'ArrInt data ' + a );
    case RawU32Img( u ):
      trace( 'U32Arr data ' + u );
    case RawVecImg( v ):
      trace( 'VecInt data ' + v );
    case RawStackImg( s ):
      trace( 'StackInt data ' + s );
  }
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
    public function setRaw( d: RawImageData ): RawImageData;
    public function getRaw(): RawImageData;
}
class ArrIntImg implements Iimg<ArrInt> {
    var data: ArrInt;
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
  public function setRaw( d: RawImageData ): RawImageData {
    var dataD: Null<ArrInt> = switch( d ){
		case RawArrImg( a ):
      	    if( a.length == data.length ){
				a;
    	    } else {
               var diff = a.length - data.length;
               if( diff > 0 ){
                  throw new haxe.Exception('ArrInt is too long $diff');
    		   } else if( diff < 0 ){
			     throw new haxe.Exception('ArrInt is too short $diff');
    		   }
      		   null;
    		}
      case _:
        var notA  = d;
      	throw new haxe.Exception('can not accept incorrect RawImageData $notA');
        null;
    }
    if( dataD != null ) data = dataD;
    return d;
  }
  public function getRaw(): RawImageData {
		return RawArrImg( data );
  }
}          
      
class VecIntImg implements Iimg<VecInt>{
    var data: VecInt;
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
  public function setRaw( d: RawImageData ): RawImageData {
      var dataD: Null<VecInt> = switch( d ){
		case RawVecImg( v ):
      	    if( v.length == data.length ){
				v;
    	    } else {
                var diff = v.length - data.length;
      		    if( diff > 0 ){
    				throw new haxe.Exception('VecInt is too long $diff');
    			} else if( diff < 0 ){
    				throw new haxe.Exception('VecInt is too short $diff');
    			}
                null;
    		}
          case _:
            var notV  = d;
      	    throw new haxe.Exception('can not accept incorrect RawImageData $notV');
            null;
        }
        if( dataD != null ){data = dataD;
        return d;
    }
    public function getRaw(): RawImageData {
		return RawVecImg( data );
    }
}
class BytesImg implements Iimg<BytesInt>{
    var data: BytesInt;
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
    function zero( len :Int ): BytesInt {
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
    function size( width: Int, height: Int ): BytesInt {
        this.width  = width;
        this.height = height;
        length      = Std.int( width*height );
        this.data   = BytesInt.alloc( length*4 );
        return zero( length );
    }
    public function setRaw( d: RawImageData ): RawImageData {
        var dataD: Null<BytesInt> = switch( d ){
			case RawBytesImg( b ):
      	        if( b.length == data.length ){
					b;
    		    } else {
                    var diff = b.length - data.length;
      		        if( diff > 0 ){
					    throw new haxe.Exception('BytesInt is too long $diff');
    			    } else if( diff < 0 ){
					    throw new haxe.Exception('BytesInt is too short $diff');
    			    }
     		        null;
    		    }
            case _:
                var notB  = d;
      	        throw new haxe.Exception('can not accept incorrect RawImageData $notB');
                null;
        }
        if( dataD != null ) data = dataD;
        return d;
    }
    public function getRaw(): RawImageData {
		return RawBytesImg( data );
    }
}
class U32ArrImg implements Iimg<U32Arr> {
    var data: U32Arr;
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
    public function setRaw( d: RawImageData ): RawImageData {
        var dataD: Null<U32Arr> = switch( d ){
			case RawU32Img( u ):
      	        if( u.length == data.length ){
					u;
    		    } else {
                    var diff = u.length - data.length;
      		        if( diff > 0 ){
						throw new haxe.Exception('U32Arr is too long $diff');
    			    } else if( diff < 0 ){
						throw new haxe.Exception('U32Arr is too short $diff');
    			    }
                    null;
    		    }
            case _:
                var notU  = d;
      	        throw new haxe.Exception('can not accept incorrect RawImageData $notU');
                null;
        }
        if( dataD != null ) data = dataD;
        return d;
    }
    public function getRaw(): RawImageData {
		return RawU32Img( data );
    }
}
class StackIntImg implements Iimg<StackInt> {
    var data: StackInt;
    public var count   = 0;
    public var width:  Int;
    public var height: Int;
    public var length: Int;
    public function new(){}
    public inline function set( index: Int, value: UInt ):UInt {
        var l = this.data.head;
        var prev: GenericCell<Int> = null;
        for( i in 0...index ) {
            prev = l;
            l = l.next;
        }
        l = if( prev == null ){
            this.data.head = new GenericCell<Int>( value, l.next );
            null;
        } else {
            prev.next = new GenericCell<Int>( value, l.next );
            null;
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
    public function setRaw( d: RawImageData ): RawImageData {
    	var dataD: Null<StackInt> = switch( d ){
			case RawStackImg( s ):
                var l = 0;
                for( i in s.iterator() ) l++;
                if( l == this.length ){
					s;
    		    } else {
                    var diff = l - length;
      		        if( diff > 0 ){
					    throw new haxe.Exception('StackInt is too long $diff');
    			    } else if( diff < 0 ){
					    throw new haxe.Exception('StackInt is too short $diff');
    			    }
                    null;
    		    }
              case _:
                  var notS  = d;
      	          throw new haxe.Exception('can not accept incorrect RawImageData $notS');
                  null;
            }
            if( dataD != null ) data = dataD;
        }
        return d;
    }
    public function getRaw(): RawImageData {
		return RawStackImg( data );
    }
}
class Pic {
    public var img: ImgMulti<Dynamic>;
    public inline function new(){}
}
@:transient
@:forward
abstract Picture( Pic ) from Pic to Pic {
    public inline function new( width: Int, height: Int,imageType: ImageType = U32_ARR ){
        this = new Pic();
        this.img = cast ImgMulti.create( width, height, imageType );
    }
    @:arrayAccess
    public inline
    function set( index: Int, value: Int ): Int {
        return this.img.set( index, value );
    }
    @:arrayAccess
    public inline
    function get( index: Int ): Int {
        return this.img[ index ];
    }
    public static inline
    function fromTo( a: Picture, b: Picture ) {
        for( i in 0...b.img.length ) b.img[ i ] = a.img[ i ];
        return b;
    }
    public static inline
    function toFrom( a: Picture, b: Picture ) {
        for( i in 0...b.img.length ) a.img[ i ] = b.img[ i ];             
        return a;
    }
  	public var raw( get, set ): RawImageData;
    private inline
    function get_raw(): RawImageData {
	    return this.img.getRaw();
    }
  	private inline
  	function set_raw( d: RawImageData ): RawImageData {
	    return this.img.setRaw( d );
    }
    public inline function traceGrid(){
        this.img.traceGrid();
    }
    public inline function imgToString(){
        return this.img.toString();
    }
    public inline function imageTypeString(){
        return this.img.check();
    }
    public inline
    function position( px: Float, py: Float ): Int {
        return this.img.position( px, py );
    }
}
@:transient
@:forward
abstract Img<T>( ImgMulti<T> ) from ImgMulti<T> {	
    public inline function new( width: Int, height: Int, imageType: ImageType ){
        this = cast ImgMulti.create( width, height, imageType );
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
    public static inline
    function fromTo<T,S>( a: Img<T>, b: Img<S> ) {
        for( i in 0...b.length ) b[ i ] = a[ i ];
        return b;
    }
    public static inline
    function toFrom<T,S>( a: Img<T>, b: Img<S> ) {
        for( i in 0...b.length ) a[ i ] = b[ i ];
        return a;
    }
}   
@:transitive
@:forward
@:multiType
abstract ImgMulti<T>( Iimg<T> ) {
    public static inline
    function create( width: Int, height: Int, imageType: ImageType = U32_ARR ): ImgMulti<Dynamic>{
        return switch(  imageType ){
                    case BYTES_INT:
                        ImgMulti.bytes( width, height );
                    case ARRAY_INT:
                        ImgMulti.arrInt( width, height );
                    case U32_ARR:
                        ImgMulti.u32arr( width, height );
                    case VECTOR_INT:
                        ImgMulti.vecInt( width, height );
                    case STACK_INT:
                        ImgMulti.stackInt( width, height );
        };
    }
    public inline
    function check(): Null<ImageType> {
        var v: Null<ImageType> = if( this is ArrIntImg ){
            ARRAY_INT;
        } else if( this is VecIntImg ){
            VECTOR_INT;
        } else if( this is BytesImg ){
            BYTES_INT;
        } else if( this is U32ArrImg ){
            U32_ARR;
        } else if( this is StackIntImg ){
            STACK_INT;
        } else {
            null;
        }
        return v;
    }      
    public function new( a: T );
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
    function toBytesImg( t: Iimg<BytesInt>
                       , s: Null<BytesInt> = null ): BytesImg {
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
        var a = new ImgMulti<ArrInt>( null );
        a.size( width, height );
        return a;
    }
    public static inline
    function vecInt( width: Int, height: Int ){
        var v = new ImgMulti<VecInt>( null );
        v.size(width,height);
        return v;
    }
    public static inline
    function bytes( width: Int, height: Int ){
        var b = new ImgMulti<BytesInt>( null );
        b.size(width,height);
        return b;
    }
    public static inline
    function u32arr( width: Int, height: Int ){
        var b = new ImgMulti<U32Arr>( null );
        b.size(width,height);
        return b;
    }
    public static inline
    function stackInt( width: Int, height: Int ){
        var b = new ImgMulti<StackInt>( null );
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
    function setRaw( d: RawImageData ): RawImageData{
		return this.setRaw( d );
    }      
    public inline
    function getRaw( ): RawImageData{
		return this.getRaw();
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
    function fromTo<T,S>( a: ImgMulti<T>, b: ImgMulti<S> ) {
        for( i in 0...b.length ) b[ i ] = a[ i ];
        return b;
    }
    public static inline
    function toFrom<T,S>( a: ImgMulti<T>, b: ImgMulti<S> ) {
        for( i in 0...b.length ) a[ i ] = b[ i ];
        return a;
    }
}
