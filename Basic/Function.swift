// 基本
func hello() {
	print("hellowrold")
}
hello() // 実行

// 引数
func hoge1( a : Int ) {
	print( a )	
}

// 戻り値あり
func returnFunction() -> Int {
	return 123
}
print( returnFunction() ) // 実行

// 引数付き戻り値あり
func pai( num: Float ) -> String {
	if ( num == 3.14 ) {
		return( "円周率です" )
	} else {
		return( "円周率ではないです" )
	}
}
print( pai( num : 3.14 ) ) //実行

// 複数の引数
func sum( a : Int, b : Int ) {
	print( a + b )
}
sum( a : 1, b : 2 ) // 実行

// 可変数引数
func fuc( a : Int... ) {
	// 引数の値は配列とし格納される
	print( a[0] )
	print( a[1] )
}
fuc( a : 100, 200 )

// デフォルト引数
func defFunc( a : Int = 300 ) {
	print( a + 1)	
}
defFunc()

// 複数の戻り値 タプル
func compareNumber( arr : [Int] ) -> ( top : Int, end : Int ) {
	let top = arr[0]
	let end = arr[2]
	
	return ( top, end )
}
var result = compareNumber( arr : [2, 5, 9] )
print( result.top, result.end )  

// オーバーロード
func func1() {
	print( 100 )
}

func func1( a : Int ){
	print( a )
}

func func1( b : Int ){
	print( b ) 
}

func1()
func1( a : 200 )
func1( b : 300 )
