package iterMagic;

// module BoundIterator

    /*
        Used for bounding box iteration, calculates lo...hi iterator from 3 values. 
    */
    inline 
    function boundIterator3( a: Float, b: Float, c: Float ): IteratorRange {
        return if( a > b ){
            if( a > c ){ // a,b a,c
                (( b > c )? Math.floor( c ): Math.floor( b ))...Math.ceil( a );
            } else { // c,a,b
                Math.floor( b )...Math.ceil( c );
            }
        } else {
            if( b > c ){ // b,a, b,c 
                (( a > c )? Math.floor( c ): Math.ceil( a ))...Math.ceil( b );
            } else { // c,b,a
                Math.floor( a )...Math.ceil( c );
            }
        }
    }
    /*
        Used for bounding box iteration, calculates lo...hi iterator from 4 values. 
    */
    inline
    function boundIterator4( a: Float, b: Float, c: Float, d: Float ): IteratorRange {
        var min = Math.floor( a );
        var max = Math.ceil( a );
        if( b < min ){
            min = Math.floor( b );
        } else if( b > max ){
            max = Math.ceil( b );
        }
        if( c < min ){
            min = Math.floor( c );
        } else if( c > max ){
            max = Math.ceil( c );
        }
        if( d < min ){
            min = Math.floor( d );
        } else if( d > max ){
            max = Math.ceil( d );
        }
        return min...max;
    }

    /*
        Used for bounding box iteration, calculates lo...hi iterator
    */
    inline
    function boundIteratorX( pMin: Array<Float>, pMax: Array<Float> ): IteratorRange {
        var min = Math.floor( pMin[0] );
        var max = Math.ceil( pMax[0] );
        var v = 0.;
        for( i in 1...pMin.length ){
            v = pMin[ i ];
            if( v < min ){
                min = Math.floor( v );
            }
            v = pMax[ i ];
            if( v > max ){
                max = Math.ceil( v );
            }
        }
        return min...max;
    }

class BoundIterator {
    /**
       <font color="LightPink" font-weight:"Bold">boundIterator3</font> module level field
    **/
    public var _boundIterator3:( a: Float, b: Float, c: Float ) -> IteratorRange = boundIterator3;

    /**
       <font color="LightPink" font-weight:"Bold">fillGrad4RoundRectangle</font> module level field
    **/
    public var _boundIterator4:( a: Float, b: Float, c: Float, d: Float ) -> IteratorRange = boundIterator4;

    /**
       <font color="LightPink" font-weight:"Bold">boundIteratorX</font> module level field
    **/
    public var _boundIteratorX:( pMin: Array<Float>, pMax: Array<Float> ) -> IteratorRange = boundIteratorX;



}
