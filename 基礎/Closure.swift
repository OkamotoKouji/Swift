/* 定義
{ ( 引数名 : 引数の型 ) -> 戻り値の型 in
	処理
}
*/

let closure1 = { () -> Void in print( "closure!" ) }
closure1() // 実行

//戻り値がVoid型なら、()にすることもできる
let closure2 = { () -> () in print( "クロージャー" ) }
closure2()

// 引数と戻り値は推論が効くので、省略することができる
let closure3 = { print( "クロージャー３" ) }
closure3()

// 引数
let sum = { ( num1 : Int, num2 : Int ) -> Void in print( num1 + num2 ) }
sum( 1, 2 )

// 戻り値
let pai = { () -> Float in return 3.14 }
print( pai() )

// 引数と戻り値
//処理が短文の場合は 戻り値の型 と return を省略できる
let sum2 = { ( num1 : Int, num2 : Int )  in  
	num1 + num2
}
print( sum2( 2, 3 ) )

// あらかじめ宣言することができる
//宣言
let sum3 : ( Int, Int ) -> Int
//代入
sum3 = { ( num1, num2 ) in num1 + num2 }
print( sum3( 15, 5 ) )

// 引数名の省略
let sum4 : ( Int, Int ) -> Int
sum4 = { $0 + $1 }
print( sum4( 25, 5 ) )
