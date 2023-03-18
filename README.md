# iterMagic
helpers for [IntIterator](https://api.haxe.org/IntIterator.html)
  
## StepIterator
Provides a step Iterator.     
    
```haxe
import iterMagic.StepIterator;
class Test {
    static function main() {
        // similar to Javascripts `for (let i = 0; i < 10; i+=2){}`
        for( i in ( 0...10: StepIterator ).step( 2 ) ) trace( i );
    }
}
```
[try.haxe > StepIterator](https://try.haxe.org/#Da90327f)

## Backwards
Provides a reverse Iterator.    
  
```haxe
// similar to Javascripts `for (let i = 9; i <= 0 ; i--){}`
function main() {
    for( i in (( 0...10 ): Backwards ) ) trace( i );
}
```
[try.haxe > Backwards](https://try.haxe.org/#Fd2bD912)  

## IntIterator64
Provides a Iterator for Int64.    
  
```haxe
import haxe.Int64;
function main(){
    for( i in ( 0...100: Int64Iter ) ) trace( i );
    for( i in ((0:Int64): Int64_)...((100:Int64):Int64_) ) trace( i );
}
```
[try.haxe > Backwards](https://try.haxe.org/#717E7641)
  
## IteratorRange
Provides a more flexible basic Iterator.  
```haxe
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
  
