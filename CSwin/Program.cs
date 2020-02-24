/*  Нахождение расстояния Левенштейна
	Версия для Windows.Native, Elements.Island
*/

public class Program
{
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

		//Int32[] v0 = Enumerable.Range(0, n + 1).ToArray();  // dont compile
		var v0 = new Int32[n + 1];
		for (var i = 0; i <= n; ++i) v0[i] = i;
//        foreach(ref var v in v0) v = cc++;  //  dont compile

		var v1 = new Int32[n + 1];
		Array.Copy(v0, v1, n+1);

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
		string s1 = String.FromRepeatedChar('a', 20000);
//        string s2 = s1;
		string s3 = String.FromRepeatedChar('b', 20000);
		byte[] b1 = Encoding.UTF8.GetBytes(s1);
		byte[] b2 = b1;
		byte[] b3 = Encoding.UTF8.GetBytes(s3);

		StopWatch execTimer = new StopWatch();
		execTimer.Start();

		Console.WriteLine(LevDist(b1, b2));
		Console.WriteLine(LevDist(b1, b3));

		execTimer.Stop();
		double execTime = execTimer.ElapsedMilliseconds / 1000.0;

		Console.WriteLine(execTime / 10); // bug in island - 10x
		return 0;
	}
}