import java.util.Arrays;
import java.util.stream.LongStream;
import java.lang.Math;

public class LevDist
{
/*    public static long levDist(String s1, String s2)
    {
        return levDist(s1.getBytes(), s2.getBytes());
    }
*/

    public static long levDist(byte[] s1, byte[] s2)
    {
        int m = s1.length;
        int n = s2.length;

        // Edge cases.
        if (m == 0) {
            return n;
        } else if (n == 0) {
            return m;
        }

        long[] v0 = LongStream.range(0, n + 1).toArray();
        long[] v1 = (long[])v0.clone();

        int i = 0, j;
        for (byte c1 : s1) {
            v1[0] = i + 1;

            j = 0;
            for (byte c2 : s2) {
                long substCost = (c1 == c2) ? v0[j] : (v0[j] + 1);
                long delCost = v0[j + 1] + 1;
                long insCost = v1[j] + 1;

                v1[j + 1] = Math.min(substCost, delCost);
                if (insCost < v1[j + 1]) {
                    v1[j + 1] = insCost;
                }

                ++j;
            }

            long[] temp = v0;
            v0 = v1;
            v1 = temp;

            ++i;
        }

        return v0[n];
    }

    public static void main(String[] args)
    {
        byte[] s1 = new byte[20000];
        byte[] s2 = s1;
        byte[] s3 = new byte[20000];

        Arrays.fill(s1, (byte) 'a');
        Arrays.fill(s3, (byte) 'b');

        long execTime = -System.nanoTime();

        System.out.println(levDist(s1, s2));
        System.out.println(levDist(s1, s3));

        execTime += System.nanoTime();

        System.err.printf("Finished in %.3fs%n", execTime / 1000000000.0);
    }
}