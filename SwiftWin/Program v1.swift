/*  Нахождение расстояния Левенштейна
	Версия для Windows.Native, Elements.Island
*/
 class Program {
	 public static func LevDist(_ s1: UInt8[], _ s2: UInt8[]) -> Int32! {
		 var m = s1.Length
		 var n = s2.Length
		 //  Edge cases.
		 if m == 0 {
			 return n
		 } else {
			 if n == 0 {
				 return m
			 }
		 }

		 var range = Range(0 ... (n + 1))
		 var v0: Swift.Array<Int64> = range.GetSequence()

		 var v1 = Swift.Array<Int64>(v0);
//         var v1 = v0;    // must copy, but make a ref

/* // variant with Int32, but without Range
		 var v0 = Swift.Array<Int32>(capacity: n + 2);
		 for i in 0...n+1 { v0.insert(i, at:  i) }

		 var v1 = Swift.Array<Int32>(v0);
*/

		 var i = 0
		 while i < m {
			 v1[0] = i + 1
			 var j = 0
			 while j < n {
				 var substCost = (s1[i] == s2[j] ? v0[j] : v0[j] + 1)
				 var delCost = v0[j + 1] + 1
				 var insCost = v1[j] + 1
				 v1[j + 1] = Math.Min(substCost, delCost)
				 if insCost < v1[j + 1] {
					 v1[j + 1] = insCost
				 }
				 inc(j)
			 }var temp = v0
			 v0 = v1
			 v1 = temp
			 inc(i)
		 }return v0[n]
	 }
 }


var b1 = [UInt8](repeating: 61 as! UInt8, count: 20000)
var b2: UInt8[] = b1
var b3 = Swift.Array<UInt8>(repeating: UInt8(63), count: 20000)

print("Start Distance");

var execTimer: StopWatch! = StopWatch()
execTimer.Start()

print(Program.LevDist(b1, b2))
print(Program.LevDist(b1, b3))

execTimer.Stop()

var execTime: Float64 = execTimer.ElapsedMilliseconds / 1000.0 / 10

print(execTime, "s")
return 0