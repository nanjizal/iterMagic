package iterMagic;

class PolarIter{
    public var radius: UnitIterator;
    public var phi:    TauIterator;
    public var iter:   IntIterator;
    public inline
    function new( radius: UnitIterator, phi: TauIterator ){
        this.radius = radius;
        this.phi    = phi;
        iter = 0...Std.int( this.radius.count * this.phi.count );
    }
}
@:forward
abstract PolarIterator ( PolarIter ) from PolarIter to PolarIter {
    public inline
    function new( stepRadius: Float, steps: Float ){
        var radius = new UnitIterator();
        this.radius.step = stepRadius;
        this = new PolarIter( radius, new TauIterator( 0, 2*Math.PI, steps ) );
    }
    public inline
    function hasNext():Bool{
        return this.iter.hasNext();
    }
    public inline
  	function next():Int{
      var i = this.iter.next();
      if( this.radians.hasNext() ) {
        this.radius.next();
      } else {
        this.radius.reset();
        this.phi.next();
      }
      return i;
    }
    public var r( get, never ): Float;
    inline function get_r(): Float {
        return this.radius.value;
    } 
    public var theta( get, never ): Float;
    inline function get_theta(): Float {
        return this.phi.value;
    }
    public var cx( get, never ): Float;
    inline function get_cx(): Float {
        return r*Math.cos( theta );
    }
    public var cy( get, never ): Float;
    inline function get_cy(): Float {
        return r*Math.sin( theta );
    }
    public var x( get, never ): Float;
    inline function get_x(): Float {
        return 0.5*(cx+1);
    }
    public var y( get, never ): Float;
    inline function get_y(): Float {
        return 0.5(cy+1);
    }
    public inline 
    function sx( scale: Float ): Float {
        return scale*x;
    }
    public inline
    function sy( scale: Float ): Float {
        return scale*y;
    }
}