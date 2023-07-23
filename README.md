# iterMagic
helpers for [IntIterator](https://api.haxe.org/IntIterator.html)
  
## StepIterator
Provides a step Iterator.     
    
```haxe
import iterMagic.StepIterator;
function main() {
    // similar to Javascripts `for (let i = 0; i < 10; i+=2){}`
    for( i in ( 0...10: StepIterator ).step( 2 ) ) trace( i );
}
```
[try.haxe > StepIterator](https://try.haxe.org/#Da90327f)

## Backwards
Provides a reverse Iterator.    
  
```haxe
// similar to Javascripts `for (let i = 9; i <= 0 ; i--){}`
import iterMagic.Backwards;
function main() {
    for( i in (( 0...10 ): Backwards ) ) trace( i );
}
```
[try.haxe > Backwards](https://try.haxe.org/#Fd2bD912)  

## IntIterator64
Provides a Iterator for Int64.    
  
```haxe
import haxe.Int64;
import iterMagic.*;
function main(){
    for( i in ( 0...100: Int64Iter ) ) trace( i );
    for( i in ((0:Int64): Int64_)...((100:Int64):Int64_) ) trace( i );
}
```
[try.haxe > Backwards](https://try.haxe.org/#717E7641)
  
## IteratorRange
Provides a more flexible basic Iterator.  
```haxe
import iterMagic.IteratorRange;
function main() {
    var iterRange: IteratorRange = 0...10;
    iterRange.start = 5;
    for( i in iterRange ) trace( i );
    trace( '7 is within iterRange : ' + iterRange.contains( 7 ) );
    trace( '6.5 is within iterRange: ' + iterRange.containsF( 7.5 ) );
    trace( ' 6...9 is within iterRange : ' + iterRange.isWithin( 6...9 ) );
    iterRange += 6;
    trace( ' move IterRange by +6 ' );
    for( i in iterRange ) trace( i );
    trace( ' move IterRange by -6 ' );
    iterRange -= 6;
    for( i in iterRange ) trace( i );
    trace( 'iterRange.length ' + iterRange.length );
    iterRange.length = 4;
    trace( 'reduce length to 4');
    for( i in iterRange ) trace( i );
}
```
[try.haxe > IteratorRange](https://try.haxe.org/#4e9e85e4)  
  
## BoundIterator
Provide a way to calculate the min and max, used with iteratating over triangles and quads points
```haxe
function main() {
    var bound3: IteratorRange = boundIterator3( 5.4, 3., 10 );
    trace( bound3.start );
    trace( bound3.max );
    trace( bound3 );
    var bound4: IteratorRange = boundIterator4( 12., 5.4, 3., 10 );
    trace( bound4.start );
    trace( bound4.max );
    trace( bound4 );
}
```
[try.haxe > BoundIterator](https://try.haxe.org/#2bc3902a)  
  
## IteratorRangeXY && IteratorRangeYX
Provides a way to iterate over a rectange of points.
```haxe
function main() {
  //var range: IteratorRangeYX = { outer: 5...10, inner: 6...11 };
  var range: IteratorRangeYX = { x: 5, w: 4, y: 6, h: 4 };
  for( v in range ){
		trace( range.x, range.y );
  }
  trace("Haxe is great!");
}

```
[try.haxe > IteratorRangeXY](https://try.haxe.org/#935d2aA2)
  
## UnitIterator  
Provides a way to iterate from 0 to 1  
`concluding` includes 1  
`places` denotes number of decimal places, for steps of 0.1 setting places to 1 improves iter value.  
`reset` resets the iterator for reuse.  

```haxe
  // https://try.haxe.org/#4aC54d24
function main() {
    var iter = new UnitIterator().step(10).places(1).concluding();
    for( i in iter ){
        if( iter.value > 0.5 ) break;
        trace( iter.value );
    }
    iter.reset();
    for( i in iter ){
        trace( iter.value );
    }
}
```
[try.haxe > UnitIterator](https://try.haxe.org/#4aC54d24)
  
## BackwardStep  
`formTheTop` allows from the max value  
```haxe
function main() {
	for (i in (0...10 : BackwardStep).step(2).fromTheTop()) trace(i);
}
```
[try.haxe > BackardStep](https://try.haxe.org/#C08D1E55)
  
## EaseIterator
These could be used in an event loop, or the for loop can be used to create an array of values.

```haxe
function main() {
    var ease = new EaseIterator().step(10).toTheTop().easing( sineInOut );
    for( i in iter ){
        trace( EaseIterator.change( i, 10, 20 ) );
    }
}
```
  
```haxe
function main() {
    var ease = new EaseIterator().step(10).toTheTop();
    ease.finished( function(){ trace( 'complete' ); } );
    for( i in ease ){
        var x = ease.changeEase( 10, 20, sineInOut );
        var y = ease.changeEase( 10, 20, circInOut );
        trace( 'v ' + x + ' ' + y );
    }
}
```
  
## Pi2Iterator
Provides an iterator over radians, always rotates the shortest distance.
  
```haxe
function main() {
    var start = -Math.PI;
    var end = Math.PI + Math.PI/2;
    trace( 'end ' + Pi2Iterator.pi2pi(end) );
    var targetStep = Math.PI/18;
    var iter = new Pi2Iterator( start, end, targetStep );
    for( i in iter ){
        trace( i );
    }
}
```
output
```

15:44:02:094   Test.hx:7:,end -1.5707963267948966
15:44:02:097   Test.hx:11:,-3.141592653589793
15:44:02:097   Test.hx:11:,-2.9670597283903604
15:44:02:100   Test.hx:11:,-2.792526803190927
15:44:02:102   Test.hx:11:,-2.6179938779914944
15:44:02:103   Test.hx:11:,-2.443460952792061
15:44:02:106   Test.hx:11:,-2.2689280275926285
15:44:02:107   Test.hx:11:,-2.0943951023931957
15:44:02:108   Test.hx:11:,-1.9198621771937625
15:44:02:109   Test.hx:11:,-1.7453292519943295
15:44:02:112   Test.hx:11:,-1.5707963267948966
```

## Pi2EaseIter
Provides an ease iterator for use with Radians, always rotates shortest distance.
```haxe
// https://try.haxe.org/#9D75044D
class Test {
  static function main() {
    var start = -Math.PI;
    var end = Math.PI + Math.PI/2;
    var iter = new Pi2EaseIter( start, end).step(10).easing( sineInOut );
    for( i in iter ){
        trace( i );
    }
  }
}
```
```
17:28:45:811   Test.hx:672:,-3.141592653589793
17:28:45:814   Test.hx:672:,-3.103152531377734
17:28:45:815   Test.hx:672:,-2.991594951731752
17:28:45:816   Test.hx:672:,-2.817839947814959
17:28:45:817   Test.hx:672:,-2.598895870033028
17:28:45:817   Test.hx:672:,-2.356194490192345
17:28:45:818   Test.hx:672:,-2.113493110351661
17:28:45:819   Test.hx:672:,-1.8945490325697307
17:28:45:820   Test.hx:672:,-1.7207940286529373
17:28:45:821   Test.hx:672:,-1.6092364490069557
17:28:45:822   Test.hx:672:,-1.5707963267948966
```
  
## Updater
Spicy way to return muliple values. Will add overhead but useful for prototyping ideas with.
  
```haxe
// https://try.haxe.org/#97149E52
function main() {
    var f: Floaty = 10.;
    var i: Inty = 0;
    var b: Null<Booly> = null;
    var s: Stringy = '';
    floatTupleReturn( b.updater, f.updater, i.updater, s.updater );
    trace( f );
    trace( b );
    trace( i );
    trace( s );
}

function floatTupleReturn(  updateBool:   BoolUpdate
                          , updateFloat:  FloatUpdate
                          , updateInt:    IntUpdate
                          , updateString: StringUpdate ){
   updateBool( true );
   updateFloat( 12. );
   updateInt( 100 );
   updateString( 'hi' );
}
```

## Tmodify
Similar to Update entry above but wraps any class for similar use.
```haxe
// https://try.haxe.org/#76DBF147
function main() {
    var f: Tmodify<Float> = 10.;
    var i: Tmodify<Int> = 0;
    var b: Tmodify<Null<Bool>> = null;
    var s: Tmodify<String> = '';
    floatTupleReturn( b.updater, f.updater, i.updater, s.updater );
    trace( f );
    trace( b );
    trace( i );
    trace( s );
}

function floatTupleReturn(  updateBool:   Tupdate<Null<Bool>>
                          , updateFloat:  Tupdate<Float>
                          , updateInt:    Tupdate<Int>
                          , updateString: Tupdate<String> ){
	 updateBool( true );
   updateFloat( 12. );
   updateInt( 100 );
   updateString( 'hi' );
}
```
