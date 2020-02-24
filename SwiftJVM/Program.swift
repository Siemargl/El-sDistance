/*  Нахождение расстояния Левенштейна
	Версия для JRE
*/
import java.util

class Program {
	public static func LevDist(_ s1: [UInt8], _ s2: [UInt8]) -> Int32! { // differ from Native Swift
//        var m = s1.length  // differ from Native Swift
//        var n = s2.length
		let m = s1.count
		let n = s2.count
		//  Edge cases.
		if m == 0 {
			return n
		} else {
			if n == 0 {
				return m
			}
		}

		var range = Range(0 ... (n + 1))
		var v0: Array<Int64> = range.GetSequence()

//        var v1 = Array<Int64>(v0);  // copy refs in JVM, not in Native
//        var v1 : Array<Int64> = v0.clone() as! Array<Int64>;  // dont work too. WTF (
//        var v1 = v0 // copy ref, but in Swift must copy values
		var v1: Array<Int64> = range.GetSequence()  // works, but slow

		var i = 0
		while i < m {
			v1[0] = i + 1
			var j = 0
			while j < n {
				let substCost = (s1[i] == s2[j] ? v0[j] : v0[j] + 1)
				let delCost = v0[j + 1] + 1
				let insCost = v1[j] + 1
				v1[j + 1] = substCost < delCost ? substCost : delCost
//                 v1[j + 1] = Math.Min(substCost, delCost)
				if insCost < v1[j + 1] {
					v1[j + 1] = insCost
				}
				j += 1
			}
			let temp = v0; v0 = v1; v1 = temp // copy refs
			i += 1
		}
		return v0[n]
	}
}


var b1 = [UInt8](repeating: 61 as! UInt8, count: 20000)
var b2: [UInt8] = b1   // differ from Native
var b3 = Swift.Array<UInt8>(repeating: UInt8(63), count: 20000)

print("Start Distance")

var execTime = -System.nanoTime();

print(Program.LevDist(b1, b2))
print(Program.LevDist(b1, b3))

execTime += System.nanoTime();

System.err.printf("Finished in %.3fs%n", execTime / 1000000000.0);

return 0