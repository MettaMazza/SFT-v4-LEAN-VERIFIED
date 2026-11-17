import SFT.Chemistry.NuclearElectronicCell
import SFT.Chemistry.NuclearElectronicSource
namespace SFT.Chemistry.NuclearElectronicAnalysis
open SFT.Host SFT.Physics.CapabilityValues
open NuclearElectronicSource (J Target atNat)
open NuclearElectronicCell (cellForm signedPrefix)
structure Row where
 targetId : String
 species : String
 stateCells : List String
 isotopes : List String
 weight : String
 retained : J

def designator (row : Row) : String :=
 String.ofList (((Text.chars (row.stateCells.headD "")).dropWhile whitespace).takeWhile (fun c => !whitespace c))

def insertGroup (groups : List (String × List Row)) (key : String) (row : Row) : List (String × List Row) :=
 if groups.any (fun p => Text.equal p.1 key) then
  groups.map (fun (k,rs) => (k,if Text.equal k key then rs++[row] else rs))
 else groups++[(key,[row])]

def groups (rows : List Row) (key : Row → String) : List (String × List Row) :=
 rows.foldl (fun acc row => insertGroup acc (key row) row) []

def combinations : List Row → List (Row × Row)
 | [] => []
 | r::rs => rs.map (fun s => (r,s)) ++ combinations rs

def ratioText (n d : Nat) : String :=
 Text.intercalate "" ["PositiveRatio(numerator=PositiveCount(value=",toString n,
  "), denominator=PositiveCount(value=",toString d,"))"]

def pairRows (rows : List Row) : Except String (List J) := do
 let output ← (groups rows designator).mapM fun (key,group) => do
  let pairs ← (combinations group).mapM fun (left,right) => do
   if NuclearElectronic.equalNuclear left.isotopes right.isotopes then throw "ELEC-012 isotope support merged"
   let results ← (List.range 10).mapM fun index => do
    let column := index+1
    let (lk,lv) ← cellForm (← atNat left.stateCells column)
    let (rk,rv) ← cellForm (← atNat right.stateCells column)
    if !Text.equal lk "positive-exact" || !Text.equal rk "positive-exact" then return []
    match lv with
    | .ratio ln ld => match rv with
     | .ratio rn rd =>
      let n := ln.value * rd.value
      let d := ld.value * rn.value
      let g := Nat.gcd n d
      return [.object [("state_designator",.text key),("left_species",.text left.species),
       ("right_species",.text right.species),("column",.integer (Int.ofNat column)),
       ("ratio",.text (ratioText (n/g) (d/g))),("distinct",.boolean (n != d))]]
     | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => throw "positive-exact value has no ratio"
    | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => throw "positive-exact value has no ratio"
   return results.flatten
  return pairs.flatten
 return output.flatten

def initialCounts : List (String × Nat) := [("positive-exact",0),("source-zero-EmptyOne",0),
 ("held-negative-inscription",0),("held-text",0),("blank-EmptyOne",0)]

def rowForms (row : Row) : Except String (List String) := row.stateCells.mapM fun cell => do
 let (tag,_) ← cellForm cell
 return tag

def cellCounts (rows : List Row) : Except String (List (String × Nat)) := do
 let forms ← rows.mapM rowForms
 return forms.flatten.foldl (fun acc tag => acc.map fun (key,n) => (key,if Text.equal tag key then n+1 else n)) initialCounts

def rowComparisons (rows : List Row) (released : List (String × String)) : Except String (List J) :=
 rows.mapM fun row => do
  let forms ← rowForms row
  let label ← match released.find? (fun p => Text.equal p.1 row.targetId) with
   | none => throw (Text.intercalate "" ["'",row.targetId,"'"])
   | some p => pure p.2
  return .object [("target_id",.text row.targetId),("species",.text row.species),
   ("cell_forms",.array (forms.map Canonical.Value.text)),
   ("passed",.boolean (Text.equal label (Canonical.identity row.retained)))]

def groundAbsence (rows : List Row) : Except String Bool := do
 let ground := rows.filter (fun row => Text.equal (designator row) "X")
 let empty ← ground.mapM fun row => do
  let (_,value) ← cellForm (← atNat row.stateCells 1)
  return match value with
   | .emptyOne _ => true
   | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
 return ground.length==3 && empty.all id

def signedSourceHeld (rows : List Row) : Except String Bool := do
 let cells := rows.flatMap Row.stateCells
 let results ← cells.mapM fun cell => do
  match signedPrefix cell with
  | some (negative,n,_) =>
   if !negative || n==0 then return true
   let (kind,_) ← cellForm cell
   return Text.equal kind "held-negative-inscription"
  | none => return true
 return results.all id
end SFT.Chemistry.NuclearElectronicAnalysis
