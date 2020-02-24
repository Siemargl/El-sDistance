/*  Test memory management strategies
	https://docs.elementscompiler.com/Compiler/BackEnds/Island/LifeTimeStrategies/
*/
namespace Native_GCvsARC
{
	class Resource
	{
		private int No;
		public Resource(int i)
		{
			No = i;
			Console.WriteLine($"Created {No}");
		}
		~Resource()
		{
			Console.WriteLine($"Destroyed {No}");
		}

	}

	static class Program
	{
		Manual<Resource> man;

		public void fARC()
		{
			var arc1 = new RC<Resource>(1);
			var arc2 = new RC<Resource>(2);
		}
		public void fGC()
		{
			var o1 = new Resource(3);
			var o2 = new Resource(4);
		}


		public static Int32 Main(string[] args)
		{
			Console.WriteLine("Manual objects create");
			man = new Manual<Resource>(777);

			Console.WriteLine("ARC objects create");
			fARC();
			Console.WriteLine("GC objects create");
			fGC();

			Console.WriteLine("Manual objects destroy");
			Manual.Free(man);

			Console.WriteLine("Prog out");
			GC.GC_gcollect();
			return 0;
		}
	}
}