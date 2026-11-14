import SFT.Physics.RadioactiveMeasuredRows
import SFT.Physics.CosmicComponentTransportMeasurement
namespace SFT.Physics.RadioactiveMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement RadioactiveMeasuredRows
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def fractionValue (q : Rat) : Value := .text (CosmicComponentTransportMeasurement.fractionText q)
def insertCode (code : String) : List (String × Nat) → List (String × Nat)
 | [] => [(code,1)]
 | (key,n)::rest => if Text.equal code key then (key,n+1)::rest
   else if Text.le code key then (code,1)::(key,n)::rest else (key,n)::insertCode code rest
def textSetEqual (xs ys : List String) : Bool :=
 xs.all (fun x => ys.any (fun y => Text.equal x y)) && ys.all (fun y => xs.any (fun x => Text.equal x y))
def exactHalfLifeInterval (row : Row) : Except String (Rat × Rat) := do
 let value ← match row.halfLife with
  | none => .error "registered half-life is not a positive exact value"
  | some v => .ok v
 let uncertainty ← LeptonDecimal.exactDecimal row.halfLifeUncertainty
 let lower ← RunningConvergence.positiveTake value uncertainty
 pure (lower,add value uncertainty)
def exampleValue (row : Row) : Value := .object [("nuclide",.text row.nuclide),("half_life",.text row.halfLifeInscription),("unit",.text row.halfLifeUnit),("uncertainty",.text row.halfLifeUncertainty),("branching_record",.text row.branchingRecord),("mode_codes",.array (row.modeCodes.map Value.text))]
def analysisFromRows (rows : List Row) : Except String Value := do
 let decayRows := rows.filter (fun row => !row.modeCodes.isEmpty)
 let numericRows := rows.filter (fun row => row.halfLife.isSome)
 let counts := (decayRows.flatMap Row.modeCodes).foldl (fun counts code => insertCode code counts) []
 let traces ← counts.mapM (fun (code,_) => do let trace ← primitiveTraceForCode code; pure (code,trace))
 let u ← rowByCoordinate rows 238 92 "0"
 let c ← rowByCoordinate rows 14 6 "0"
 let tc ← rowByCoordinate rows 99 43 "1"
 let be7 ← rowByCoordinate rows 7 4 "0"
 let be8 ← rowByCoordinate rows 8 4 "0"
 let examples : List (String × Row) := [("uranium238_ground",u),("carbon14_ground",c),("technetium99_isomer",tc),("beryllium7_ground",be7),("beryllium8_ground",be8)]
 let intervals ← examples.mapM (fun (name,row) => do
  let (lo,hi) ← exactHalfLifeInterval row
  pure (name,Value.array [fractionValue lo,fractionValue hi]))
 let transported ← (examples.filter (fun p => p.2.halfLife.isSome)).mapM (fun (name,row) => do
  let value ← match row.halfLife with | none => .error "registered half-life is not a positive exact value" | some v => .ok v
  let times ← (List.range 3).mapM (fun k => do
   let tr ← RadioactiveDecay.transportHalfLife (.fraction value) (.integer (.ofNat (k+1)))
   let survival ← RadioactiveDecay.survivalPart (.integer (.ofNat (k+1)))
   pure (toString (k+1),Value.object [("elapsed_in_reported_unit",fractionValue tr.elapsedTime),("survival_part",fractionValue survival)]))
  pure (name,Value.object times))
 let survival ← RadioactiveDecay.survivalTrace (.integer 7)
 let positiveSurvival ← (List.range 127).mapM (fun k => do
  let value ← RadioactiveDecay.survivalPart (.integer (.ofNat (k+1)))
  pure (zero.blt value))
 let allMapped := textSetEqual (traces.map Prod.fst) (counts.map Prod.fst) && traces.all (fun p => !p.2.isEmpty)
 let allThree := textSetEqual (traces.flatMap Prod.snd) [RadioactiveDecay.release.name,RadioactiveDecay.conversion.name,RadioactiveDecay.deexcitation.name]
 pure (.object [("all_nuclear_state_rows",.integer (.ofNat rows.length)),("rows_with_decay_modes",.integer (.ofNat decayRows.length)),("decay_mode_entry_count",.integer (.ofNat (counts.foldl (fun n p => n+p.2) 0))),("distinct_decay_mode_code_count",.integer (.ofNat counts.length)),("numeric_positive_half_life_row_count",.integer (.ofNat numericRows.length)),("mode_code_counts",.object (counts.map (fun (key,n) => (key,.integer (.ofNat n))))),("mode_primitive_traces",.object (traces.map (fun (code,trace) => (code,.array (trace.map Value.text))))),("all_codes_mapped",.boolean allMapped),("all_three_primitives_observed",.boolean allThree),("composite_delayed_modes_observed",.boolean (traces.any (fun p => p.2.length>1))),("literal_only_three_named_codes_rejected",.boolean (counts.length>RadioactiveDecay.primitiveTransitionClasses.length)),("registered_examples",.object (examples.map (fun (name,row) => (name,exampleValue row)))),("registered_example_intervals",.object intervals),("exact_half_life_transports",.object transported),("survival_law",.array (survival.map fractionValue)),("no_finite_survival_part_is_empty",.boolean (positiveSurvival.all id))])
def measurementAnalysis (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 analysisFromRows (← nubaseRows bytes files payload)
def label : String := "sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"
def classificationFromAnalysis (analysis : Value) : Except String String := do
 if !sameValue (← field analysis "all_nuclear_state_rows") (.integer 5843) then throw "complete NUBASE2020 decay vector changed"
 if !sameValue (← field analysis "rows_with_decay_modes") (.integer 5500) then throw "complete NUBASE2020 decay vector changed"
 if !sameValue (← field analysis "decay_mode_entry_count") (.integer 8718) then throw "complete NUBASE2020 decay vector changed"
 if !sameValue (← field analysis "distinct_decay_mode_code_count") (.integer 50) then throw "complete NUBASE2020 decay vector changed"
 if !sameValue (← field analysis "numeric_positive_half_life_row_count") (.integer 4700) then throw "complete NUBASE2020 decay vector changed"
 let keys := ["all_codes_mapped", "all_three_primitives_observed", "composite_delayed_modes_observed", "literal_only_three_named_codes_rejected", "no_finite_survival_part_is_empty"]
 if !(keys.all (fun key => sameValue ((field analysis key).toOption.getD .null) (.boolean true))) then throw "NUBASE2020 topology or half-life comparison failed"
 let examples ← field analysis "registered_examples"
 let row ← field examples "uranium238_ground"
 let codes ← (← array (← field row "mode_codes")).mapM text
 if !sameValue (← field row "half_life") (.text "4.463") || !sameValue (← field row "unit") (.text "Gy") || !sameValue (← field row "uncertainty") (.text "0.003") || !textSetEqual codes ["2B-", "A", "SF"] then throw "registered NUBASE2020 example changed: uranium238_ground"
 let row ← field examples "carbon14_ground"
 let codes ← (← array (← field row "mode_codes")).mapM text
 if !sameValue (← field row "half_life") (.text "5.70") || !sameValue (← field row "unit") (.text "ky") || !sameValue (← field row "uncertainty") (.text "0.03") || !textSetEqual codes ["B-"] then throw "registered NUBASE2020 example changed: carbon14_ground"
 let row ← field examples "technetium99_isomer"
 let codes ← (← array (← field row "mode_codes")).mapM text
 if !sameValue (← field row "half_life") (.text "6.0066") || !sameValue (← field row "unit") (.text "h") || !sameValue (← field row "uncertainty") (.text "0.0002") || !textSetEqual codes ["B-", "IT"] then throw "registered NUBASE2020 example changed: technetium99_isomer"
 let row ← field examples "beryllium7_ground"
 let codes ← (← array (← field row "mode_codes")).mapM text
 if !sameValue (← field row "half_life") (.text "53.22") || !sameValue (← field row "unit") (.text "d") || !sameValue (← field row "uncertainty") (.text "0.06") || !textSetEqual codes ["EC"] then throw "registered NUBASE2020 example changed: beryllium7_ground"
 let row ← field examples "beryllium8_ground"
 let codes ← (← array (← field row "mode_codes")).mapM text
 if !sameValue (← field row "half_life") (.text "81.9") || !sameValue (← field row "unit") (.text "as") || !sameValue (← field row "uncertainty") (.text "3.7") || !textSetEqual codes ["A"] then throw "registered NUBASE2020 example changed: beryllium8_ground"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromAnalysis (← measurementAnalysis bytes files payload)
end SFT.Physics.RadioactiveMeasurement
