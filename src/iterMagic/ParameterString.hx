package iterMagic;
import haxe.io.UInt32Array;
import iterMagic.TauIterator;

@:transient
@:forward
abstract ParameterString(String) from String to String {
    public inline
    function new( v: String ){
        this = v;
    }
    @:from
    public static inline
    function fromFloat( f: Float ): ParameterString {
        return Std.string( f );
    }
    @:to
    public inline
    function toFloat():Float {
        return Std.parseFloat( this );
    }
    @:from
    public static inline
    function fromInt( i: Int ): ParameterString {
        return Std.string( i );
    }
    @:to
    public inline
    function toInt():Int {
        return Std.parseInt( this );
    }
    @:from
    public static inline
    function fromUInt( u: UInt ): ParameterString {
        return Std.string( u );
    }
    @:to
    public inline
    function toUInt(): UInt {
        var v: Int = toInt();
        if( v < 0 ) v = 0;
        return ( cast v: UInt );
    }
    @:from
    public static inline
    function fromBool( b: Bool ): ParameterString {
        return Std.string( b );
    }
    @:to
    public inline
    function toBool():Bool {
        return ( StringTools.trim( this ).toLowerCase() == 'true' )? true: false;
    }
    @:from
    public static inline
    function fromPoints( af: Array<Float> ): ParameterString {
        return '['+af.join(',')+']';
    }
    @:to
    public inline
    function toPoints():Array<Float> {
        var str = this.split('[')[1].split(']')[0];
        return [ for( n in str.split(',') ) Std.parseFloat( n )  ]; 
    }
    @:from
    public static inline
    function fromArrayInt( af: Array<Int> ): ParameterString {
        return '['+af.join(',')+']';
    }
    @:to
    public inline
    function toArrayInt():Array<Int> {
        var str = this.split('[')[1].split(']')[0];
        return [ for( n in str.split(',') ) Std.parseInt( n )  ]; 
    }
    @:from
    public static inline
    function fromBoolPattern( bp: Array<Bool> ): ParameterString {
        return '['+bp.join(',')+']';
    }
    @:to
    public inline
    function toBoolPattern():Array<Bool> {
        var str = this.split('[')[1].split(']')[0];
        return [ for( v in str.split(',') ){
            var bools = StringTools.trim( v ).toLowerCase();
            ( bools == 'true' || bools == '1' )? true: false;
        } ];
    }
    @:from
    public static inline
    function fromUInt32Array( u32: haxe.io.UInt32Array ): ParameterString {
        var arr = new Array<Int>();
        for( i in 0...u32.length ) arr[i] = u32.get( i );
        return '['+arr.join(',')+']';
    }
    @:to
    public inline
    function toUInt32Array(): UInt32Array {
        var str = this.split('[')[1].split(']')[0];
        var values = str.split(',');
        var u32 = new UInt32Array( values.length );
        for( i in 0...u32.length ){
            var v: ParameterString = values[i];
            var u: UInt = v;
            u32.set( i, u );
        }
        return u32;
    }
    /**
     * @param r 
     * @return ParameterString
     * stored as degrees string. 
     */
    public static inline
    function fromRadian( r: Float ): ParameterString {
        var degree: Float = ( r == 0 )? 0: 180*r/Math.PI;
        return Std.string( r );
    }
    public inline
    function toRadian():Float {
        var degree: Float = abstract;
        var r = tauLimit( ( degree == 0 )? 0: Math.PI*degree/180 );
        return r;
    }
  	public inline
  	function toDegree():Float {
		var r = toRadian();
        return if( r == 0 ){
			0;
        } else {
			r*180/Math.PI;
        }
      
  	}
}