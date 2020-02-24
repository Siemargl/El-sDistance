/*  Нахождение расстояния Левенштейна
	Версия для .NET 4.x, .NET.Core
*/
using System;
using System.Diagnostics;
using System.Linq;
using System.Text;

// need assembly System.Runtime.Extensions for NET 4.x

public class Program
{
	/*
	public static Int32 LevDist(string s1, string s2)
	{
		var ca1 = Encoding.UTF8.GetBytes(s1);
		var ca2 = Encoding.UTF8.GetBytes(s2);
		return LevDist(ca1, ca2);
	}*/

	public static Int32 LevDist(byte[] s1, byte[] s2)
	{
		var m = s1.Length;
		var n = s2.Length;

		// Edge cases.
		if (m == 0)
		{
			return n;
		}
		else if (n == 0)
		{
			return m;
		}

		Int32[] v0 = Enumerable.Range(0, n + 1).ToArray();
		var v1 = new Int32[n + 1];

		v0.CopyTo(v1, 0);

		for (var i = 0; i < m; ++i)
		{
			v1[0] = i + 1;

			for (var j = 0; j < n; ++j)
			{
				var substCost = (s1[i] == s2[j]) ? v0[j] : (v0[j] + 1);
				var delCost = v0[j + 1] + 1;
				var insCost = v1[j] + 1;

				v1[j + 1] = Math.Min(substCost, delCost);
				if (insCost < v1[j + 1])
				{
					v1[j + 1] = insCost;
				}
			}

			var temp = v0;
			v0 = v1;
			v1 = temp;
		}

		return v0[n];
	}

	public static int Main()
	{
		string s1 = new String('a', 20000);
//        string s2 = s1;
		string s3 = new String('b', 20000);
		byte[] b1 = Encoding.UTF8.GetBytes(s1);
		byte[] b2 = b1;
		byte[] b3 = Encoding.UTF8.GetBytes(s3);


		Stopwatch execTimer = new Stopwatch();
		execTimer.Start();

		Console.WriteLine(LevDist(b1, b2));
		Console.WriteLine(LevDist(b1, b3));

		execTimer.Stop();
		double execTime = execTimer.ElapsedMilliseconds / 1000.0;

		Console.WriteLine("Finished in {0}s", execTime);
//        Console.WriteLine($"Finished in {execTime:0.000}s");
		return 0;
	}
}