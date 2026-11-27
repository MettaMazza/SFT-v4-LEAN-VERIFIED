import SFT.Chemistry.AromaticRecurrenceAnalysis
import SFT.Chemistry.CoordinationAnalysis
import SFT.Chemistry.InternalEnergyCompositionSource
namespace SFT.Chemistry.AntiaromaticTables
open SFT.Host
open JointCorrelationTargets (field text)
open InorganicNetworkPrediction (get equal)
open AromaticRecurrenceAnalysis (array)
abbrev J := Canonical.Value
def byRole (rows : List J) (role : String) : Except String J :=
 match AromaticRecurrenceAnalysis.byRole rows role with
 | .ok row => .ok row
 | .error _ => .error (Text.append "ORG-004 role cardinality changed: " role)
def allTables (surface : J) : Except String (List (List (List String))) := do
 let first := get surface "complete_experimental_data_tables"
 let selected := if CoordinationAnalysis.truthy first then first else get surface "complete_gas_thermochemistry_tables"
 let tables ← match selected with
  | .null => throw "'NoneType' object is not iterable"
  | .array xs => pure xs
  | .text _ | .boolean _ | .integer _ | .object _ => array selected
 tables.mapM fun table => do
  (← array table).mapM fun row => do (← array row).mapM text
def sameStrings (a b : List String) : Bool :=
 a.length==b.length && (a.zip b).all (fun (x,y) => Text.equal x y)
def firstCellRows (surface : J) (label : String) : Except String (List (List String)) := do
 let tables ← allTables surface
 return tables.flatten.filter (fun row => match row with | [] => false | first::_ => Text.equal first label)
def tupleRepr (xs : List String) : String :=
 Text.join ["(",Text.intercalate ", " (xs.map SolidLocalGenerator.reprText),if xs.length==1 then "," else "",")"]
def table (surface : J) (header : List String) : Except String (List (List String)) := do
 let tables ← allTables surface
 let selected := tables.filter fun rows => match rows with
  | [] => false | first::_ => sameStrings (first.take header.length) header
 match selected with
 | [rows] => return rows
 | [] | _::_::_ => throw (Text.append "ORG-004 external table cardinality changed: " (tupleRepr header))
def itemAt {α : Type} : List α → Nat → Except String α
 | [],_ => .error "list index out of range"
 | a::_,0 => .ok a
 | _::as,n+1 => itemAt as n
def hundredths (value : String) : Except String Nat := do
 let (whole,part) ← (match AromaticMagnitude.splitDot (Text.chars value) [] with
  | [a,b] => .ok (a,b)
  | [] | [_] => .error "not enough values to unpack (expected 2, got 1)"
  | _::_::_::_ => .error "too many values to unpack (expected 2)" : Except String (String × String))
 if (Text.chars part).length != 2 || !AromaticMagnitude.digits whole || !AromaticMagnitude.digits part then
  throw "ORG-004 external magnitude is not exact positive hundredths"
 let w ← SolidLocalGenerator.integer whole
 let p ← SolidLocalGenerator.integer part
 let result := w*100+p
 if result<1 then throw "ORG-004 external magnitude is not positive"
 return result.toNat
def starts (starts value : String) : Bool :=
 Text.equal (String.ofList ((Text.chars value).take (Text.chars starts).length)) starts
end SFT.Chemistry.AntiaromaticTables
