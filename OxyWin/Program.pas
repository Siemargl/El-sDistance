/*  Нахождение расстояния Левенштейна
    Версия для Windows.Native, Elements.Island
*/
{$R-}
namespace OxyPas;
uses
  RemObjects.Elements.RTL.Delphi;  // AnsiString

type
  Program = class
  public

    class function levDist(const s1: AnsiString; const s2: AnsiString): LongInt;
    begin
    var m, n: Integer;
    var i, j: Integer;
    var c1, c2: AnsiChar;
    var v0, v1, temp: array of LongInt;
    var substCost, delCost, insCost: LongInt;
      m := s1.Length;
      n := s2.Length;

      // Edge cases.
      if m = 0 then
        exit(n)
      else if n = 0 then
        exit(m);

      v0 := new LongInt[n+1];
      for i := 0 to n do
        v0[i] := i;
      v1 := new LongInt[n+1];
      Array.Copy(v0, v1, n+1);

      for i := 0 to s1.Length - 1 do
        begin
          c1 := s1[i+1];
          v1[0] := i + 1;

          for j := 0 to s2.Length - 1 do
            begin
              c2 := s2[j+1];
              substCost := v0[j];
              if c1 <> c2 then
                inc(substCost);
              delCost := v0[j+1] + 1;
              insCost := v1[j] + 1;

              if substCost < delCost then
                v1[j+1] := substCost
              else
                v1[j+1] := delCost;
              if insCost < v1[j+1] then
                v1[j+1] := insCost;

            end;

          temp := v0;
          v0 := v1;
          v1 := temp;
        end;

      Result := v0[n];
    end;

    class method Main(args: array of String): Int32;
    begin
/* // impossible slow, also win10 >> win7
    var i: Integer;
    var s1, s2, s3: AnsiString;
    //var startTime, execTime: TDateTime;
      s1 := '';
      s3 := '';
      for i := 1 to 20000 do
        begin
          s1 := s1 + 'a';
          s3 := s3 + 'b';
        end;
      s2 := s1;
*/
      var s1 := new AnsiString(AnsiChar('a'), 20000);
      var s2 := s1;
      var s3 := new AnsiString(AnsiChar('b'), 20000);

      writeLn('Start Distance');
      var startTime := new StopWatch();
      startTime.Start();
//      startTime := Now; // dont work


      writeLn(levDist(s1, s2));
      writeLn(levDist(s1, s3));

      startTime.Stop();
      var execTime := startTime.ElapsedMilliseconds/10000.0; // Error 10x
      writeLn($'Finished in {execTime}s');
      end;
    end; //class

end. // namespace