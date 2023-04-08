package iterMagic;

/* https://try.haxe.org/#fA431073
function main() {
    var iter = new EaseIterator().step(10).places(4).toTheTop().easing( sineInOut );
    for( i in iter ){
        trace( i );
    }
}
*/
// easing equations added to assist implementing EaseIterator
/*
The MIT License (MIT)

Copyright (c) 2014-2016 shohei909 and other tweenx contributors(https://github.com/shohei909/tweenx/graphs/contributors)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

final PI       = 3.1415926535897932384626433832795;
final PI_H     = 1.57079632679489661923132169163975;
final LN_2     = 0.6931471805599453;
final LN_2_10  = 6.931471805599453;
/*
 * LINEAR
 */
/** 1-order */
inline function linear(t:Float):Float{
    return t;
}

/*
 * SINE
 */
inline function sineIn(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        1 - Math.cos(t * PI_H);
    }
}
inline function sineOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        Math.sin(t * PI_H);
    }
}
inline function sineInOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        -0.5 * (Math.cos(PI * t) - 1);
    }
}
inline function sineOutIn(t:Float):Float {
    return  if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else if (t < 0.5) {
        0.5 * Math.sin((t * 2) * PI_H);
    } else {
        -0.5 * Math.cos((t * 2 - 1) * PI_H) + 1;
    }
}


/*
 * QUAD EASING
 */
/** 2-order */
inline function quadIn(t:Float):Float {
    return t * t;
}
/** 2-order */
inline function quadOut(t:Float):Float {
    return -t * (t - 2);
}
/** 2-order */
inline function quadInOut(t:Float):Float {
    return (t < 0.5) ? 2 * t * t : -2 * ((t -= 1) * t) + 1;
}
/** 2-order */
inline function quadOutIn(t:Float):Float {
    return (t < 0.5) ? -0.5 * (t = (t * 2)) * (t - 2) : 0.5 * (t = (t * 2 - 1)) * t + 0.5;
}


/*
 * CUBIC EASING
 */
/** 3-order */
inline function cubicIn(t:Float):Float {
    return t * t * t;
}
/** 3-order */
inline function cubicOut(t:Float):Float {
    return (t = t - 1) * t * t + 1;
}
/** 3-order */
inline function cubicInOut(t:Float):Float {
    return ((t *= 2) < 1) ?
        0.5 * t * t * t :
        0.5 * ((t -= 2) * t * t + 2);
}
/** 3-order */
inline function cubicOutIn(t:Float):Float {
    return 0.5 * ((t = t * 2 - 1) * t * t + 1);
}


/*
 * QUART EASING
 */
/** 4-order */
inline function quartIn(t:Float):Float {
    return (t *= t) * t;
}
/** 4-order */
inline function quartOut(t:Float):Float {
    return 1 - (t = (t = t - 1) * t) * t;
}
/** 4-order */
inline function quartInOut(t:Float):Float {
    return ((t *= 2) < 1) ? 0.5 * (t *= t) * t : -0.5 * ((t = (t -= 2) * t) * t - 2);
}
/** 4-order */
inline function quartOutIn(t:Float):Float {
    return (t < 0.5) ? -0.5 * (t = (t = t * 2 - 1) * t) * t + 0.5 : 0.5 * (t = (t = t * 2 - 1) * t) * t + 0.5;
}


/*
 * QUINT EASING
 */
/** 5-order */
inline function quintIn(t:Float):Float {
    return t * (t *= t) * t;
}
/** 5-order */
inline function quintOut(t:Float):Float {
    return (t = t - 1) * (t *= t) * t + 1;
}
/** 5-order */
inline function quintInOut(t:Float):Float {
    return ((t *= 2) < 1) ? 0.5 * t * (t *= t) * t : 0.5 * (t -= 2) * (t *= t) * t + 1;
}
/** 5-order */
inline function quintOutIn(t:Float):Float {
    return 0.5 * ((t = t * 2 - 1) * (t *= t) * t + 1);
}


/*
 * EXPO EASING
 */
inline function expoIn(t:Float):Float {
    return t == 0 ? 0 : Math.exp(LN_2_10 * (t - 1));
}
inline function expoOut(t:Float):Float {
    return t == 1 ? 1 : (1 - Math.exp(-LN_2_10 * t));
}
inline function expoInOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else if ((t *= 2) < 1) {
        0.5 * Math.exp(LN_2_10 * (t - 1));
    } else {
        0.5 * (2 - Math.exp(-LN_2_10 * (t - 1)));
    }
}
inline function expoOutIn(t:Float):Float {
    return if (t < 0.5) {
        0.5 * (1 - Math.exp(-20 * LN_2 * t));
    } else if (t == 0.5) {
        0.5;
    } else {
        0.5 * (Math.exp(20 * LN_2 * (t - 1)) + 1);
    }
}


/*
 * CIRC EASING
 */
inline function circIn(t:Float):Float {
    return if (t < -1 || 1 < t) 0 else 1 - Math.sqrt(1 - t * t);
}
inline function circOut(t:Float):Float {
    return if (t < 0 || 2 < t) 0 else Math.sqrt(t * (2 - t));
}
inline function circInOut(t:Float):Float {
    return if (t < -0.5 || 1.5 < t) 0.5 else if ((t *= 2) < 1)- 0.5 * (Math.sqrt(1 - t * t) - 1) else 0.5 * (Math.sqrt(1 - (t -= 2) * t) + 1);
}
function circOutIn(t:Float):Float {
    return if (t < 0) 0 else if (1 < t) 1 else if (t < 0.5) 0.5 * Math.sqrt(1 - (t = t * 2 - 1) * t) else -0.5 * ((Math.sqrt(1 - (t = t * 2 - 1) * t) - 1) - 1);
}


/*
 * BOUNCE EASING
 */
inline function bounceIn(t:Float):Float {
    return if ((t = 1 - t) < (1 / 2.75)) {
        1 - ((7.5625 * t * t));
    } else if (t < (2 / 2.75)) {
        1 - ((7.5625 * (t -= (1.5 / 2.75)) * t + 0.75));
    } else if (t < (2.5 / 2.75)) {
        1 - ((7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375));
    } else {
        1 - ((7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375));
    }
}
inline function bounceOut(t:Float):Float {
    return if (t < (1 / 2.75)) {
        (7.5625 * t * t);
    } else if (t < (2 / 2.75)) {
        (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75);
    } else if (t < (2.5 / 2.75)) {
        (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375);
    } else {
        (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375);
    }
}
inline function bounceInOut(t:Float):Float {
    return if (t < 0.5) {
        if ((t = (1 - t * 2)) < (1 / 2.75)) {
            (1 - ((7.5625 * t * t))) * 0.5;
        } else if (t < (2 / 2.75)) {
            (1 - ((7.5625 * (t -= (1.5 / 2.75)) * t + 0.75))) * 0.5;
        } else if (t < (2.5 / 2.75)) {
            (1 - ((7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375))) * 0.5;
        } else {
            (1 - ((7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375))) * 0.5;
        }
    } else {
        if ((t = (t * 2 - 1)) < (1 / 2.75)) {
            ((7.5625 * t * t)) * 0.5 + 0.5;
        } else if (t < (2 / 2.75))    {
            ((7.5625 * (t -= (1.5 / 2.75)) * t + 0.75)) * 0.5 + 0.5;
        } else if (t < (2.5 / 2.75))    {
            ((7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375)) * 0.5 + 0.5;
        } else {
            ((7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375)) * 0.5 + 0.5;
        }
    }
}
inline function bounceOutIn(t:Float):Float {
    return if (t < 0.5) {
        if ((t = (t * 2)) < (1 / 2.75)) {
            0.5 * (7.5625 * t * t);
        } else if (t < (2 / 2.75)) {
            0.5 * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75);
        } else if (t < (2.5 / 2.75)) {
            0.5 * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375);
        } else {
            0.5 * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375);
        }
    } else {
        if ((t = (1 - (t * 2 - 1))) < (1 / 2.75)) {
            0.5 - (0.5 * (7.5625 * t * t)) + 0.5;
        } else if (t < (2 / 2.75)) {
            0.5 - (0.5 * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75)) + 0.5;
        } else if (t < (2.5 / 2.75)) {
            0.5 - (0.5 * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375)) + 0.5;
        } else {
            0.5 - (0.5 * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375)) + 0.5;
        }
    }
}

final overshoot:Float = 1.70158;

/*
 * BACK EASING
 */
inline function backIn(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        t * t * ((overshoot + 1) * t - overshoot);
    }
}
inline function backOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        ((t = t - 1) * t * ((overshoot + 1) * t + overshoot) + 1);
    }
}
inline function backInOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else if ((t *= 2) < 1) {
        0.5 * (t * t * (((overshoot * 1.525) + 1) * t - overshoot * 1.525));
    } else {
        0.5 * ((t -= 2) * t * (((overshoot * 1.525) + 1) * t + overshoot * 1.525) + 2);
    }
}
inline function backOutIn(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else if (t < 0.5) {
        0.5 * ((t = t * 2 - 1) * t * ((overshoot + 1) * t + overshoot) + 1);
    } else {
        0.5 * (t = t * 2 - 1) * t * ((overshoot + 1) * t - overshoot) + 0.5;
    }
}

/*
 * ELASTIC EASING
 */
final amplitude:Float = 1;
final period:Float = 0.0003;
inline function elasticIn(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        var s:Float = period / 4;
        -(amplitude * Math.exp(LN_2_10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * PI) / period));
    }
}
inline function elasticOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        var s:Float = period / 4;
        Math.exp(-LN_2_10 * t) * Math.sin((t * 0.001 - s) * (2 * PI) / period) + 1;
    }
}
inline function elasticInOut(t:Float):Float {
    return if (t == 0) {
        0;
    } else if (t == 1) {
        1;
    } else {
        var s:Float = period / 4;

        if ((t *= 2) < 1) {
            -0.5 * (amplitude * Math.exp(LN_2_10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * PI) / period));
        } else {
            amplitude * Math.exp(-LN_2_10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * PI) / period) * 0.5 + 1;
        }
    }
}
inline function elasticOutIn(t:Float):Float {
    return if (t < 0.5) {
        if ((t *= 2) == 0) {
            0;
        } else {
            var s = period / 4;
            (amplitude / 2) * Math.exp(-LN_2_10 * t) * Math.sin((t * 0.001 - s) * (2 * PI) / period) + 0.5;
        }
    } else {
        if (t == 0.5) {
            0.5;
        } else if (t == 1) {
            1;
        } else {
            t = t * 2 - 1;
            var s = period / 4;
            -((amplitude / 2) * Math.exp(LN_2_10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * PI) / period)) + 0.5;
        }
    }
}
@:access(IntIterator.min, IntIterator.max )
class EaseIter {
    public var start = 0;
    public var max = .1;
    public var step: Float = 0;
  	public var value: Float = 0.;
    var count = 0;
    public var includeMax:Bool = false;
    var cropTo: Null<Float> = null;
    var ease: Null<Float -> Float> = null;
    var finish: Null<Void -> Void> = null; 
    public inline
    function new(){}
}
@:transitive
@:access( IntIterator.min, IntIterator.max )
@:access( EaseIter.includeMax )
@:access( EaseIter.cropTo )
@:access( EaseIter.count )
@:access( EaseIter.value )
@:access( EaseIter.finish )
@:access( EaseIter.ease )
@:forward
abstract EaseIterator( EaseIter ) from EaseIter {
    public inline function step( count_: Int ): EaseIterator {
        this.step = 1./count_;
        this.value = 0.;
        this.max = count_;
        return abstract;
    }
    public inline
    function new(){
        this = new EaseIter();
    }
    public inline
    function hasNext() {
        var out = if( this.includeMax ){
            this.count++ < this.max + this.step;
        } else {
            this.count++ < this.max;
        }
        if( !out && this.finish != null ) this.finish();
        return out;
    }
    public inline
    function next():Float {
      	if( this.cropTo != null ){
            this.value = crop( this.start + (this.count-1) * this.step );
        } else {
            this.value = this.start + (this.count-1) * this.step;
        }
        return if( this.ease == null ) {
            this.value;
        } else {
            if( this.cropTo != null ){
                crop( this.ease( this.value ) );
            } else {
                this.ease( this.value );
            }
        };
    }
  	inline function crop( val: Float ){
        return Std.int( val*this.cropTo)/this.cropTo;	
  	}
    public inline
    function toTheTop() {
		  this.includeMax = true;
		  return abstract;
    }
  	public inline
    function places( n: Int ){
		this.cropTo = Math.pow( 10, n );
        return abstract;
  	}
  	public inline
    function reset(){
        this.count = 0;
        this.value = 0.;
        return abstract;
  	}
    public inline
  	function easing( ease_: Float -> Float ){
        this.ease = ease_;
        return abstract;
  	}
    /* example use
    var iter = new EaseIterator().step(10).toTheTop().easing( sineInOut );
    var pos: IteratorRange = 10...20;
    for( i in iter ){
        trace( EaseIterator.change( i, 10, 20 ) );
    }
    */
    public static inline
    function change( i: Float, start: Float, end: Float ){
        return i*(end-start)+start;
    }
    /* example use
    function main() {
    var ease = new EaseIterator().step(10).toTheTop().easing( sineInOut );
    var pos: IteratorRange = 10...20;
    for( i in ease ){
        var x = ease.changeEase( 10, 20, sineInOut );
        var y = ease.changeEase( 10, 20, circInOut );
        trace( 'v ' + x + ' ' + y );
        trace( EaseIterator.change( i, 10, 20 ) );
      }
    }
    */
    public inline
    function changeEase( x0: Float, x1: Float, easeFunc: Float->Float ){
        return easeFunc( this.value )*(x1-x0)+x0;
    }
    public inline
    function finished( finish_: Void->Void ){
        this.finish = finish_;
        return abstract;
    }
}