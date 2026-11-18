import SFT.Chemistry.AnalyticalDetection
import SFT.Chemistry.AnalyticalSelectivity
namespace SFT.Chemistry.AnalyticalInterferenceMatrix
open SFT.Host SFT.Physics.CapabilityValues SFT.Physics.LeptonIntervals
open AnalyticalSensitivity (positive less whole)
structure InputRow where
 interferent : HeldLabel
 pureResponse : Rat
 mixedResponse : Rat
inductive Difference where
 | emptyOne
 | raises (magnitude : Rat)
 | lowers (magnitude : Rat)
structure Row where
 interferent : HeldLabel
 difference : Difference
 responseRatio : Rat
 pureResponse : Rat
def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def distinct : List InputRow → Bool
 | [] => true
 | first::rest => !(rest.any (fun row => sameLabel first.interferent row.interferent)) && distinct rest
def difference (baseline mixed : Rat) : Difference :=
 let delta := subtract mixed baseline
 if (@decide (delta.num = 0) (Int.decEq _ _)) then .emptyOne
 else if positive delta then .raises delta
 else .lowers (normalize (.ofNat delta.num.natAbs) delta.den (Nat.pos_of_ne_zero delta.den_nz))
def rowFor (baseline : Rat) (input : InputRow) : Except String Row :=
 let denominator := input.mixedResponse.den * baseline.num.natAbs
 if h : 0 < denominator then
  .ok ⟨input.interferent,difference baseline input.mixedResponse,
   normalize (input.mixedResponse.num * Int.ofNat baseline.den) denominator h,input.pureResponse⟩
 else .error "complete positive interference matrix required"
def interferenceMatrix (analyte method condition : HeldLabel) (baseline : Rat)
 (rows : List InputRow) : Except String (List Row) := do
 if !Text.equal analyte.family "analyte" || !Text.equal method.family "analytical-method" ||
    !Text.equal condition.family "analytical-condition" || !positive baseline || rows.isEmpty ||
    !(rows.all fun row => Text.equal row.interferent.family "interferent" && positive row.pureResponse && positive row.mixedResponse) then
  throw "complete positive interference matrix required"
 if !distinct rows then throw "interferent identities must be distinct"
 rows.mapM (rowFor baseline)
theorem rowIdentityRetained (baseline : Rat) (input : InputRow) (row : Row)
 (accepted : rowFor baseline input = .ok row) : row.interferent = input.interferent ∧ row.pureResponse = input.pureResponse := by
 dsimp only [rowFor] at accepted
 split at accepted
 · cases accepted; exact ⟨rfl,rfl⟩
 · cases accepted
def interferent (name : String) (held : nonblank name = true) : HeldLabel := ⟨"interferent",name,rfl,held⟩
def originalRows : List InputRow := [⟨interferent "i1" rfl,whole 1,whole 5⟩,⟨interferent "i2" rfl,whole 2,whole 6⟩]
def originalRecord := interferenceMatrix AnalyticalSensitivity.analyte AnalyticalSensitivity.method AnalyticalSensitivity.condition (whole 5) originalRows
def identityWitness := Text.equal AnalyticalSensitivity.analyte.label "a"
def matrixWitness := (originalRecord.toOption.map fun rows => rows.length==2).getD false
def baselinesWitness := (originalRecord.toOption.map fun rows => (rows.map fun row => (row.pureResponse.num.natAbs,row.pureResponse.den)) == [(1,1),(2,1)]).getD false
def mixturesWitness := (originalRecord.toOption.map fun rows => (rows.map fun row => (row.responseRatio.num.natAbs,row.responseRatio.den)) == [(1,1),(6,5)]).getD false
def comparisonWitness := (originalRecord.toOption.map fun rows => match rows with
 | [] => false | first::_ => match first.difference with | .emptyOne => true | .raises _ => false | .lowers _ => false).getD false
def selectivityWitness := (originalRecord.toOption.map fun rows =>
 match rows with
 | [] => false
 | _::rest =>
  match rest with
  | [] => false
  | second::_ =>
   match second.difference with
   | .emptyOne => false
   | .raises _ => true
   | .lowers _ => false).getD false
def adverseWitness := (originalRecord.toOption.map fun rows =>
 match rows with
 | [] => false
 | _::rest =>
  match rest with
  | [] => false
  | second::_ =>
   match second.difference with
   | .emptyOne => false
   | .raises q => (@decide (q.num = 1) (Int.decEq _ _)) && q.den==1
   | .lowers q => (@decide (q.num = 1) (Int.decEq _ _)) && q.den==1).getD false
def extensionWitness := ((interferenceMatrix AnalyticalSensitivity.analyte AnalyticalSensitivity.method AnalyticalSensitivity.condition (whole 5)
 (originalRows++[⟨interferent "i3" rfl,whole 1,whole 4⟩])).toOption.map fun rows => rows.length==3).getD false
theorem identityPassed : identityWitness = true := rfl
theorem matrixPassed : matrixWitness = true := rfl
theorem baselinesPassed : baselinesWitness = true := rfl
theorem mixturesPassed : mixturesWitness = true := rfl
theorem comparisonPassed : comparisonWitness = true := rfl
theorem selectivityPassed : selectivityWitness = true := rfl
theorem adversePassed : adverseWitness = true := rfl
theorem extensionPassed : extensionWitness = true := rfl
end SFT.Chemistry.AnalyticalInterferenceMatrix
