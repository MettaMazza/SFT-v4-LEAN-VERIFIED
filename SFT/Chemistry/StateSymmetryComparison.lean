import SFT.Chemistry.StateSymmetryPrediction
namespace SFT.Chemistry.StateSymmetryComparison
open SFT.Host SFT.Physics.CapabilityValues
open StateSymmetryPrediction (Resolved)
abbrev J := Canonical.Value
abbrev Predictions := List ((String × String) × Value)
def sameKey (a b : String × String) : Bool := Text.equal a.1 b.1 && Text.equal a.2 b.2
def predictionKey : Value → Except String (String × String)
 | .label h => .ok (h.family,h.label)
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
  .error "ELEC-005 prediction key is not a held label"
def predictionMap : Value → Except String Predictions
 | .table entries => do
  let rows ← entries.foldlM (fun rows (key,value) => do
   let key ← predictionKey key
   if rows.any (fun row => sameKey row.1 key) then
    pure (rows.map (fun row => if sameKey row.1 key then (key,value) else row))
   else pure (rows++[(key,value)])) ([] : Predictions)
  if rows.length != entries.length then throw "ELEC-005 prediction contains duplicate keys"
  return rows
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ =>
  .error "ELEC-005 prediction is not a complete Fold table"
def lookup (rows : Predictions) (family label : String) : Except String Value :=
 match rows.find? (fun row => sameKey row.1 (family,label)) with
 | some row => .ok row.2
 | none => .error (Text.intercalate "" ["missing prediction key: ",family,"/",label])
def isLabel (v : Value) (family label : String) : Bool :=
 match v with
 | .label h => Text.equal h.family family && Text.equal h.label label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def isCount (v : Value) (n : Nat) : Bool :=
 match v with
 | .count c => c.value==n
 | .emptyOne _ | .label _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def isEmpty (v : Value) : Bool :=
 match v with
 | .emptyOne s => Text.equal s "empty-One"
 | .count _ | .label _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
structure Comparison where
 target : Resolved
 passed : Bool

def compare (predicted : Predictions) (row : Resolved) : Except String Comparison := do
 let symbol := row.term.symbol
 let predictedRank ← lookup predicted "axis-rank-law" symbol
 let expectedRank ← StateSymmetry.axisFromSymbol symbol
 let rank ← StateSymmetrySource.rankInscription symbol
 let rankPassed := match expectedRank with
  | .emptyOne _ => isEmpty predictedRank
  | .count _ => isLabel predictedRank "axis-rank" rank
 let predictedOrientation ← lookup predicted "axis-orientation-law" symbol
 let signature ← StateSymmetry.fromSource row.identity.speciesRowId (← count row.term.multiplicity) symbol
  (StateSymmetrySource.inversionLabel row.term.suffix) (StateSymmetrySource.reflectionLabel row.term.suffix)
  (StateSymmetrySource.axisComponent row.term.suffix) (StateSymmetrySource.componentKind row.term.suffix)
 let equivalenceClass ← StateSymmetry.buildClass signature
 let combined := StateSymmetry.degeneracy signature
 let sourceOrientation := if Text.equal symbol "Σ" then 1 else 2
 let stateEquivalence ← lookup predicted "symmetry-law" "state-equivalence"
 let degeneracy ← lookup predicted "symmetry-law" "degeneracy"
 let optionalCoordinate ← lookup predicted "symmetry-law" "optional-coordinate"
 let componentClass ← lookup predicted "symmetry-law" "component-class"
 return ⟨row,rankPassed && isCount predictedOrientation signature.orientationCount.value &&
  isCount predictedOrientation sourceOrientation && combined.value==row.term.multiplicity*sourceOrientation &&
  equivalenceClass.occurrences.length==combined.value &&
  isLabel stateEquivalence "symmetry-law-result" "complete-signature-identity" &&
  isLabel degeneracy "symmetry-law-result" "positive-spin-width-times-positive-axis-orientation-count" &&
  isLabel optionalCoordinate "symmetry-law-result" "held-label-or-structural-empty-One" &&
  isLabel componentClass "symmetry-law-result" "complete-positive-enumeration"⟩

def comparisonValue (c : Comparison) : Except String J := do
 let row := c.target
 let term := row.term
 let rank ← StateSymmetrySource.rankInscription term.symbol
 let orientation := if Text.equal term.symbol "Σ" then 1 else 2
 return .object [
  ("target_id",.text row.identity.targetId),("species_row_id",.text row.identity.speciesRowId),
  ("NIST_state_record",.text row.stateRecord),("NIST_term_assignment",.text (Text.append term.inscription term.suffix)),
  ("positive_spin_multiplicity",.integer (.ofNat term.multiplicity)),("axis_support_symbol",.text term.symbol),
  ("fold_axis_rank",.text rank),("positive_axis_orientation_count",.integer (.ofNat orientation)),
  ("positive_combined_degeneracy_count",.integer (.ofNat (term.multiplicity*orientation))),
  ("inversion",.text (StateSymmetrySource.inversionLabel term.suffix)),
  ("reflection",.text (StateSymmetrySource.reflectionLabel term.suffix)),
  ("axis_component",.text (StateSymmetrySource.axisComponent term.suffix)),
  ("component_kind",.text (StateSymmetrySource.componentKind term.suffix)),
  ("source_zero_component_glyph_means_absence",.boolean (Text.contains term.suffix "_0")),("passed",.boolean c.passed)]
def uniqueStrings (xs : List String) : List String :=
 xs.foldl (fun out s => if out.any (Text.equal s) then out else out++[s]) []
def ordinalEqual : Int → Int → Bool
 | .ofNat a,.ofNat b => Nat.beq a b
 | .negSucc a,.negSucc b => Nat.beq a b
 | .ofNat _,.negSucc _ | .negSucc _,.ofNat _ => false
def uniqueStates (xs : List (String × Int)) : List (String × Int) :=
 xs.foldl (fun out s => if out.any (fun t => Text.equal s.1 t.1 && ordinalEqual s.2 t.2) then out else out++[s]) []
def counts (comparisons : List Comparison) : List (String × Nat) :=
 let rows := comparisons.map Comparison.target
 [("term_assignments",comparisons.length),
  ("inversion_labels",(rows.filter (fun r => !Text.equal (StateSymmetrySource.inversionLabel r.term.suffix) "absence")).length),
  ("reflection_labels",(rows.filter (fun r => !Text.equal (StateSymmetrySource.reflectionLabel r.term.suffix) "absence")).length),
  ("positive_axis_components",(rows.filter (fun r => !Text.equal (StateSymmetrySource.axisComponent r.term.suffix) "absence")).length),
  ("absent_axis_components",(rows.filter (fun r => Text.equal (StateSymmetrySource.axisComponent r.term.suffix) "absence")).length),
  ("source_zero_component_glyphs",(rows.filter (fun r => Text.contains r.term.suffix "_0")).length),
  ("species",(uniqueStrings (rows.map (fun r => r.identity.speciesRowId))).length),
  ("registered_state_rows",(uniqueStates (rows.map (fun r => (r.identity.speciesRowId,r.identity.stateRowOrdinal)))).length)]

#print axioms sameKey
#print axioms predictionKey
#print axioms predictionMap
#print axioms lookup
#print axioms isLabel
#print axioms isCount
#print axioms isEmpty
#print axioms compare
#print axioms comparisonValue
#print axioms uniqueStrings
#print axioms ordinalEqual
#print axioms uniqueStates
#print axioms counts
end SFT.Chemistry.StateSymmetryComparison
