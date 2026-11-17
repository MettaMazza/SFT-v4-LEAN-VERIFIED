import SFT.Chemistry.PairExchangePrediction
import SFT.Chemistry.StateSymmetryComparison
namespace SFT.Chemistry.PairExchangeComparison
open SFT.Host SFT.Physics.CapabilityValues
open StateSymmetryComparison (sameKey isLabel isCount lookup Predictions)
abbrev J := Canonical.Value

def predictionMap : Value → Except String Predictions
 | .table entries => do
  let rows ← entries.foldlM (fun rows (key,value) => do
   let key ← match key with
    | .label h => .ok (h.family,h.label)
    | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
     .error "ELEC-006 prediction key is not a held label"
   if rows.any (fun row => sameKey row.1 key) then
    pure (rows.map (fun row => if sameKey row.1 key then (key,value) else row))
   else pure (rows++[(key,value)])) ([] : Predictions)
  if rows.length != entries.length then throw "ELEC-006 prediction contains duplicate keys"
  return rows
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ =>
  .error "ELEC-006 prediction is not a complete Fold table"
def textField (fields : List (String × J)) (key : String) : Except String String := do
 let v ← match fields.find? (fun p => Text.equal p.1 key) with
  | none => .error (Text.intercalate "" ["'",key,"'"])
  | some p => .ok p.2
 match v with
 | .text s => .ok s
 | .null | .boolean _ | .integer _ | .array _ | .object _ => .error "source text field required"
structure StateComparison where
 source : PairExchangeTargets.State
 state : PairExchange.PairState
 passed : Bool

def compareState (predicted : Predictions) (row : PairExchangeTargets.State) : Except String StateComparison := do
 let multiplicity ← count row.term.multiplicity
 let key := if multiplicity.value==1 then "positive-One-width" else "positive-three-width"
 let state ← PairExchange.fromMultiplicity "H2" row.targetId multiplicity
 let occupancyPassed ← match row.configuration with
  | none => .ok true
  | some c => do PairExchange.occupancyCompatible state (← count c.occupancy)
 let sameCell ← textField row.fields "same_cell_record"
 let recorded := match row.configuration with | none => false | some c => c.occupancy==2
 let sameCellPassed := if recorded then Text.equal sameCell "same-cell-pair-recorded" &&
   StateSymmetry.labelEqual state.sameCellStatus PairExchange.sameCellAdmitted
  else Text.equal sameCell "no-explicit-same-cell-pair"
 let spin ← lookup predicted "spin-exchange-by-multiplicity" key
 let spatial ← lookup predicted "spatial-exchange-by-multiplicity" key
 let cell ← lookup predicted "same-cell-by-multiplicity" key
 let total ← lookup predicted "pair-exchange-law" "total-electron-pair"
 let sourceSpin ← textField row.fields "spin_exchange_class"
 let sourceSpatial ← textField row.fields "spatial_exchange_class"
 let passed := isLabel spin state.spinExchange.family state.spinExchange.label && isLabel spin "exchange-class" sourceSpin &&
  isLabel spatial state.spatialExchange.family state.spatialExchange.label && isLabel spatial "exchange-class" sourceSpatial &&
  isLabel cell state.sameCellStatus.family state.sameCellStatus.label &&
  isLabel total state.totalExchange.family state.totalExchange.label && isLabel total "exchange-class" "alternating-exchange" &&
  occupancyPassed && sameCellPassed
 return ⟨row,state,passed⟩

def stateComparisonValue (row : StateComparison) : Except String J := do
 let s := row.source
 return .object [("target_id",.text s.targetId),("NIST_state_record",.text s.stateRecord),
  ("NIST_term_assignment",.text (Text.append s.term.inscription s.term.suffix)),
  ("positive_spin_multiplicity",.integer (.ofNat s.term.multiplicity)),
  ("spin_exchange_class",.text (← textField s.fields "spin_exchange_class")),
  ("spatial_exchange_class",.text (← textField s.fields "spatial_exchange_class")),
  ("total_exchange_class",.text (← textField s.fields "total_exchange_class")),
  ("same_cell_record",.text (← textField s.fields "same_cell_record")),
  ("configuration",PairExchangeSource.configurationValue s.configuration),
  ("energy_inscription",.text s.energyInscription),
  ("source_ground_glyph_is_absence_baseline",.boolean (Text.equal s.energyInscription "0")),("passed",.boolean row.passed)]
def positiveRatio (n d : Nat) : Except String (PositiveCount × PositiveCount) := do
 -- Original PositiveRatio.from_pair preserves the two supplied counted values.
 return (← count n,← count d)
structure PairComparison where
 source : PairExchangeTargets.ExchangePair
 numerator : PositiveCount
 denominator : PositiveCount
 passed : Bool

def comparePair (predicted : Predictions) (states : List StateComparison) (row : PairExchangeTargets.ExchangePair) : Except String PairComparison := do
 let singlet ← match states.find? (fun s => Text.equal s.source.targetId row.singlet.targetId) with
  | none => .error (Text.intercalate "" ["'",row.singlet.targetId,"'"])
  | some s => .ok s.state
 let triplet ← match states.find? (fun s => Text.equal s.source.targetId row.triplet.targetId) with
  | none => .error (Text.intercalate "" ["'",row.triplet.targetId,"'"])
  | some s => .ok s.state
 let pair ← PairExchange.buildSameSupport "H2" row.support singlet.stateIdentity.label triplet.stateIdentity.label
 let (n,d) ← positiveRatio row.numerator row.denominator
 let partners ← lookup predicted "pair-exchange-law" "same-support-partners"
 let order ← lookup predicted "pair-exchange-law" "energy-order"
 let passed := StateSymmetry.labelEqual pair.singlet.spinExchange PairExchange.alternating &&
  StateSymmetry.labelEqual pair.triplet.spinExchange PairExchange.preserving &&
  StateSymmetry.labelEqual pair.singlet.spatialExchange PairExchange.preserving &&
  StateSymmetry.labelEqual pair.triplet.spatialExchange PairExchange.alternating &&
  !(StateSymmetry.labelEqual pair.singlet.stateIdentity pair.triplet.stateIdentity) && n.value ≥ 1 &&
  isLabel partners "exchange-law-result" "distinct-complementary-state-identities" &&
  isLabel order "exchange-law-result" "retained-observation-not-universal-sign"
 return ⟨row,n,d,passed⟩
def pairComparisonValue (row : PairComparison) : J :=
 let p := row.source
 .object [("target_id",.text p.targetId),("configuration",PairExchangeSource.configurationValue (some p.configuration)),
  ("singlet_state",.text p.singlet.stateRecord),("triplet_state",.text p.triplet.stateRecord),
  ("singlet_energy_inscription",.text p.singlet.energyInscription),("triplet_energy_inscription",.text p.triplet.energyInscription),
  ("positive_energy_separation_numerator",.integer (.ofNat row.numerator.value)),
  ("positive_energy_separation_denominator",.integer (.ofNat row.denominator.value)),
  ("held_energy_order",.text p.order),("passed",.boolean row.passed)]
def counts (states : List StateComparison) (pairs : List PairComparison) : Except String (List (String × Nat)) := do
 let explicit ← states.mapM fun s => do
  return Text.equal (← textField s.source.fields "same_cell_record") "same-cell-pair-recorded" && s.source.term.multiplicity==1
 return [("state_rows",states.length),
  ("singlet_states",(states.filter (fun s => s.source.term.multiplicity==1)).length),
  ("triplet_states",(states.filter (fun s => s.source.term.multiplicity==3)).length),
  ("explicit_same_cell_singlets",(explicit.filter id).length),
  ("same_configuration_exchange_pairs",pairs.length),
  ("triplet_below_singlet",(pairs.filter (fun p => Text.equal p.source.order "triplet-below-singlet")).length),
  ("singlet_below_triplet",(pairs.filter (fun p => Text.equal p.source.order "singlet-below-triplet")).length),
  ("source_ground_absence_glyphs",(states.filter (fun s => Text.equal s.source.energyInscription "0")).length)]

#print axioms predictionMap
#print axioms textField
#print axioms compareState
#print axioms stateComparisonValue
#print axioms positiveRatio
#print axioms comparePair
#print axioms pairComparisonValue
#print axioms counts
end SFT.Chemistry.PairExchangeComparison
