import SFT.Host.Canonical
namespace SFT.Mathematics.CalculatorCompleteJSON
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 100000
def indent (depth : Nat) : String := String.ofList (List.replicate (2*depth) ' ')
mutual
 def pretty (depth : Nat) : Value → String
 | .array xs => if xs.isEmpty then "[]" else Text.join ["[\n",Text.intercalate ",\n" (prettyValues (depth+1) xs),"\n",indent depth,"]"]
 | .object xs => if xs.isEmpty then "{}" else Text.join ["{\n",Text.intercalate ",\n" ((sortFields (prettyFields (depth+1) xs)).map Prod.snd),"\n",indent depth,"}"]
 | .text x => quote x
 | .integer x => render (.integer x)
 | .boolean x => if x then "true" else "false"
 | .null => "null"
 def prettyValues (depth : Nat) : List Value → List String
 | [] => []
 | x::xs => Text.append (indent depth) (pretty depth x) :: prettyValues depth xs
 def prettyFields (depth : Nat) : List (String × Value) → List (String × String)
 | [] => []
 | (k,v)::xs => (k,Text.join [indent depth,quote k,": ",pretty depth v]) :: prettyFields depth xs
end
def document (v : Value) : String := Text.append (pretty 0 v) "\n"
def field (v : Value) (key : String) : Value := match v with
 | .object fields => ((fields.find? (fun kv => Text.equal kv.1 key)).map Prod.snd).getD .null
 | .text _ | .integer _ | .boolean _ | .null | .array _ => .null
end SFT.Mathematics.CalculatorCompleteJSON
