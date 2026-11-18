import SFT.Chemistry.AnalyticalSensitivity
namespace SFT.Chemistry.AnalyticalDetection
open SFT.Host SFT.Physics.CapabilityValues SFT.Physics.LeptonIntervals
open AnalyticalSensitivity (positive less whole)
abbrev Level := Rat × List Rat
inductive Classification where
 | emptyOne | held (family label : String)
inductive Spread where
 | emptyOne | apart (magnitude : Rat)
structure Row where
 amount : Rat
 detection : Classification
 quantification : Classification
 spread : Spread
def smaller (a b : Rat) : Rat := if less a b then a else b
def larger (a b : Rat) : Rat := if less b a then a else b
def same (a b : Rat) : Bool := (@decide (a.num = b.num) (Int.decEq _ _)) && a.den == b.den
def spread (first : Rat) (rest : List Rat) : Spread :=
 let upper := rest.foldl larger first
 let lower := rest.foldl smaller first
 if same upper lower then .emptyOne else .apart (subtract upper lower)
def levelRow (upperBlank : Rat) (level : Level) : Except String Row :=
 match level.2 with
 | [] => .error "complete positive blank and level support required"
 | first::rest =>
  let detected := (first::rest).all (fun x => less upperBlank x)
  let distance := spread first rest
  let distinct := match distance with | .emptyOne => false | .apart _ => true
  let quantified := detected && (first::rest).length > 1 && distinct
  .ok ⟨level.1,if detected then .held "detection-class" "detected" else .emptyOne,
   if quantified then .held "quantification-class" "quantified" else .emptyOne,distance⟩
def boundaryRecord (analyte method condition : HeldLabel) (blanks : List Rat)
 (levels : List Level) : Except String (List Row) := do
 if !Text.equal analyte.family "analyte" || !Text.equal method.family "analytical-method" ||
    !Text.equal condition.family "analytical-condition" || blanks.isEmpty || levels.isEmpty ||
    !(blanks.all positive) || !(levels.all (fun level => positive level.1 && !level.2.isEmpty && level.2.all positive)) then
  throw "complete positive blank and level support required"
 match blanks with
 | [] => throw "complete positive blank and level support required"
 | first::rest => levels.mapM (levelRow (rest.foldl larger first))
-- The source preserves the supplied level order; there is no sorting or fitted threshold.
theorem levelRowRetainsAmount (upper : Rat) (level : Level) (row : Row)
 (accepted : levelRow upper level = .ok row) : row.amount = level.1 := by
 cases level with
 | mk amount responses =>
  cases responses with
  | nil => cases accepted
  | cons first rest => cases accepted; rfl
def originalBlanks := [whole 1,whole 2]
def originalLevels : List Level := [(whole 1,[whole 2,whole 3]),(whole 2,[whole 4,whole 5])]
def originalRecord := boundaryRecord AnalyticalSensitivity.analyte AnalyticalSensitivity.method AnalyticalSensitivity.condition originalBlanks originalLevels
def identityWitness := Text.equal AnalyticalSensitivity.analyte.label "a"
def blankWitness := originalBlanks.length == 2
def levelsWitness := (originalRecord.toOption.map (fun rows => rows.length==2)).getD false
def emptyClass : Classification → Bool | .emptyOne => true | .held _ _ => false
def detectionWitness := (originalRecord.toOption.map fun rows =>
 match rows with | [] => false | first::_ => emptyClass first.detection).getD false
def errorsWitness := same (whole 2) (larger (whole 1) (whole 2))
def quantificationWitness := (originalRecord.toOption.map fun rows =>
 match rows with
 | [] => false
 | _::rest =>
  match rest with
  | [] => false
  | second::_ =>
   match second.quantification with
   | .emptyOne => false
   | .held _ label => Text.equal label "quantified").getD false
def absenceWitness := detectionWitness
def extensionWitness := ((boundaryRecord AnalyticalSensitivity.analyte AnalyticalSensitivity.method AnalyticalSensitivity.condition originalBlanks (originalLevels++[(whole 3,[whole 6,whole 7])])).toOption.map fun rows => rows.length==3).getD false
theorem identityPassed : identityWitness = true := rfl
theorem blankPassed : blankWitness = true := rfl
theorem levelsPassed : levelsWitness = true := rfl
theorem detectionPassed : detectionWitness = true := rfl
theorem errorsPassed : errorsWitness = true := rfl
theorem quantificationPassed : quantificationWitness = true := rfl
theorem absencePassed : absenceWitness = true := rfl
theorem extensionPassed : extensionWitness = true := rfl
end SFT.Chemistry.AnalyticalDetection
