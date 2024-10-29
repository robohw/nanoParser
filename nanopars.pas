 program nanoParser; { keyword, number, operator, string, label}
                     { Usage: nanoPars.exe < input.txt >output.txt } 
 uses  SysUtils;
 const 
   Keys: array[0..4] of string = ('IF', 'JUMP', 'PRINT', 'RETURN','INPUT');
 var
 line: string;   

 function IsKey(const Value: string): Boolean;
 var
   j: Integer;
 begin
   IsKey := False;
   for j := Low(Keys) to High(Keys) do
     if Keys[j] = Value then
     begin
       IsKey := True;
       Exit;
     end;
 end;
 
 procedure Tokenize(line: string);
 var
   i: Integer;
   Curr: string;
 begin
   i := 1;
   Line := Upcase(line);
   while i <= Length(line) do
   begin
     Curr := '';          
     case line[i] of     
       'A'..'Z':
         begin
           while (i <= Length(line)) and (line[i] in ['A'..'Z']) do
           begin
             Curr := Curr + line[i];
             Inc(i);
           end;
           if IsKey(Curr) then WriteLn('Kywrd: ', Curr) else WriteLn('IDent: ',  Curr);
         end;
         
       '0'..'9', '-':
         begin
           if line[i] = '-' then
           begin
             Curr := '-';
             Inc(i);
           end;
           while (i <= Length(line)) and (line[i] in ['0'..'9']) do
           begin
             Curr := Curr + line[i];
             Inc(i);
           end;
           if (Curr[1]='-') and (length(Curr)=1) then Writeln('MthOp: ',Curr) else WriteLn('Num: ', Curr);
         end;
         
       '+', '*', '/':
         begin
           WriteLn('MthOp: ', line[i]);
           Inc(i);
         end;
         
       '<', '=', '>' :
         begin
           WriteLn('LogOp: ', line[i]);
           Inc(i);
         end;
         
       '"':
         begin
           Inc(i); // Skip opening 
           while (i <= Length(line)) and (line[i] <> '"') do
           begin
             Curr := Curr + line[i];
             Inc(i);
           end;
           Inc(i); // Skip closing 
           WriteLn('Strng: "', Curr, '"');
         end;
         
       '.':
         begin           
           while (i <= Length(line)) and (line[i] <> ' ') do
           begin
             Curr := Curr + line[i];
             Inc(i);
           end;
           Inc(i); 
           WriteLn('Label: ', Curr);
         end;
       else
         Inc(i); // Skip 
     end;
   end;
 end;
  
 // --- MAIN ------------------------------------------------
 begin 
   while not EOF(input) do 
   begin
     readln(line); 
     Tokenize(line);
   end;
 end.

