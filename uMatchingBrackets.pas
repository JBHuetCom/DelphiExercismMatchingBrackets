unit uMatchingBrackets;

interface

  type
    TMatchingBrackets = class
      class function IsPaired(AExpression : string) : boolean;
    end;

implementation

  uses
    SysUtils, StrUtils;

{ TMatchingBrackets }

  class function TMatchingBrackets.IsPaired(AExpression: string): boolean;
    var
      i, Brackets, Braces, Parentheses : integer;
      Order : string;
    begin
      Brackets := 0;
      Braces := 0;
      Parentheses := 0;
      Order := '';
      Result := TRUE;
      for i := Low(AExpression) to High(AExpression) do
        begin
          case AExpression[i] of
            '[' :
              begin
                Inc(Brackets);
                Order := Order + '[';
              end;
            ']' :
              begin
                Dec(Brackets);
                if (Brackets < 0) OR (Length(Order) > 0) AND (Order[High(Order)] <> '[') then
                  begin
                    Result := FALSE;
                    exit;
                  end
                else
                  Order := LeftStr(Order, Length(Order) - 1);
              end;
            '{' :
              begin
                Inc(Braces);
                Order := Order + '{';
              end;
            '}' :
              begin
                Dec(Braces);
                if (Braces < 0) OR (Length(Order) > 0) AND (Order[High(Order)] <> '{') then
                  begin
                    Result := FALSE;
                    exit;
                  end
                else
                  Order := LeftStr(Order, Length(Order) - 1);
              end;
            '(' :
              begin
                Inc(Parentheses);
                Order := Order + '(';
              end;
            ')' :
              begin
                Dec(Parentheses);
                if (Parentheses < 0) OR (Length(Order) > 0) AND (Order[High(Order)] <> '(') then
                  begin
                    Result := FALSE;
                    exit;
                  end
                else
                  Order := LeftStr(Order, Length(Order) - 1);
              end;
          end;
        end;
      if (Brackets <> 0) OR (Braces <> 0) OR (Parentheses <> 0) then
        Result := FALSE;
    end;

end.
