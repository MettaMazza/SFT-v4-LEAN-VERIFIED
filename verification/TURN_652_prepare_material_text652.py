from pathlib import Path
import html,json
q=lambda v:json.dumps(v,ensure_ascii=False)
s='''import SFT.Chemistry.SourceText
namespace SFT.Materials.SourceText
open SFT.Host
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def entityTable : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in html.entities.html5.items())+']\n'
s+='def invalidRefs : List (Nat × String) := ['+','.join('('+str(k)+','+q(v)+')' for k,v in html._invalid_charrefs.items())+']\n'
s+='def invalidPoints : List Nat := '+repr(sorted(html._invalid_codepoints))+'\n'
s+='''
-- re.sub(r"<[^>]+>", " ", text): an empty <> is not a tag match.
def stripTags : Nat → List Char → List Char
 | 0, cs => cs
 | n+1, cs => match cs with
   | [] => []
   | c::rest =>
     if c == '<' then
       let body := rest.takeWhile (fun x => x != '>')
       let tail := rest.drop body.length
       if !body.isEmpty && !tail.isEmpty then ' ' :: stripTags n (tail.drop 1)
       else c :: stripTags n rest
     else c :: stripTags n rest

def decimal (c : Char) : Bool := 48 ≤ c.toNat && c.toNat ≤ 57
def hexadecimal (c : Char) : Bool := decimal c ||
 (65 ≤ c.toNat && c.toNat ≤ 70) || (97 ≤ c.toNat && c.toNat ≤ 102)
def digit (c : Char) : Nat :=
 if c.toNat ≤ 57 then c.toNat - 48 else if c.toNat ≤ 70 then c.toNat - 55 else c.toNat - 87

def numberValue (base : Nat) (cs : List Char) : Nat :=
 cs.foldl (fun n c => n * base + digit c) 0

def numericReplacement (n : Nat) : String :=
 match invalidRefs.find? (fun p => p.1 == n) with
 | some p => p.2
 | none =>
   if (55296 ≤ n && n ≤ 57343) || n > 1114111 then "�"
   else if invalidPoints.contains n then ""
   else String.ofList [Char.ofNat n]

def namedChar (c : Char) : Bool := !([9,10,12,32,60,38,35,59].contains c.toNat)

def namedReplacement (cs : List Char) : String :=
 match entityTable.find? (fun p => Text.equal p.1 (String.ofList cs)) with
 | some p => p.2
 | none =>
   let prefixes := (List.range cs.length).reverse.filter (fun n => n > 1)
   match prefixes.find? (fun n => entityTable.any (fun p => Text.equal p.1 (String.ofList (cs.take n)))) with
   | none => String.ofList ('&'::cs)
   | some n =>
     match entityTable.find? (fun p => Text.equal p.1 (String.ofList (cs.take n))) with
     | some p => Text.append p.2 (String.ofList (cs.drop n))
     | none => String.ofList ('&'::cs)

-- Returns replacement plus remaining input only when the original regexp matches.
def characterReference (cs : List Char) : Option (String × List Char) :=
 match cs with
 | [] => none
 | c::rest =>
   if c == '#' then
     let isHex := match rest with | h::_ => h == 'x' || h == 'X' | [] => false
     let body := if isHex then rest.drop 1 else rest
     let ds := body.takeWhile (if isHex then hexadecimal else decimal)
     if ds.isEmpty then none else
       let tail := body.drop ds.length
       let tail := if tail.head? == some ';' then tail.drop 1 else tail
       some (numericReplacement (numberValue (if isHex then 16 else 10) ds),tail)
   else
     let name := (cs.takeWhile namedChar).take 32
     if name.isEmpty then none else
       let tail := cs.drop name.length
       if tail.head? == some ';' then some (namedReplacement (name ++ [';']),tail.drop 1)
       else some (namedReplacement name,tail)

def unescapeChars : Nat → List Char → List Char
 | 0, cs => cs
 | n+1, cs => match cs with
   | [] => []
   | c::rest =>
     if c == '&' then
       match characterReference rest with
       | none => c :: unescapeChars n rest
       | some (replacement,tail) => Text.chars replacement ++ unescapeChars n tail
     else c :: unescapeChars n rest

def collapseSpace : List Char → Bool → List Char
 | [], _ => []
 | c::rest, pending =>
   if SFT.Chemistry.SourceText.whitespace c then collapseSpace rest true
   else if pending then ' ' :: c :: collapseSpace rest false
   else c :: collapseSpace rest false

def corpus (text : String) : String :=
 let cs := Text.chars text
 let stripped := stripTags cs.length cs
 let unescaped := String.ofList (unescapeChars stripped.length stripped)
 let folded := Text.chars (SFT.Chemistry.SourceText.casefold unescaped)
 String.ofList (collapseSpace (folded.dropWhile SFT.Chemistry.SourceText.whitespace) false)
end SFT.Materials.SourceText
'''
Path('work/constants-recovery/SFT/Materials/SourceText.lean').write_text(s)
