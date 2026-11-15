import SFT.Physics.LyapunovExperiment
namespace SFT.Physics.LyapunovMeasurement
open SFT.Host SFT.Host.Canonical LyapunovKSCorrespondence RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def targetCount (target : Value) (key : String) : Except String Int := do
 let raw ← text (← field target key)
 match LeptonDecimal.exponent (Text.chars raw) with | some n => .ok n | none => .error "ValueError"
structure Analysis where
 generatedCarrier : Int
 registeredPieceCount : Int
 absoluteSlope : Int
 preimageCount : Int
 outputAlphabetSize : Int
 depths : List Nat
 completeSupport : List Nat
 successorRatios : List Nat
 separationMultipliers : List Int
 allExactCarriersEqual : Bool
 uniformIndependentSymbols : Bool
 conventionalLabels : List String
 entropyScope : String
 entropyRelation : String
 analyticValueImported : Bool
def exactMeasurementAnalysis (target : Value) : Except String Analysis := do
 let m ← targetCount target "map_piece_count"
 let depths := [1,2,3,4,5]
 let support ← depths.mapM (fun d => exactSupportCount (.integer m) (.integer (.ofNat d)))
 let ratios ← (List.range (support.length-1)).mapM (fun i =>
  match (support.drop (i+1)).head?,(support.drop i).head? with
  | some next,some previous => .ok (next/previous)
  | none,none => .error "IndexError"
  | none,some _ => .error "IndexError"
  | some _,none => .error "IndexError")
 let separation ← [1,2,3,5,8].mapM (fun parts => do
  let value ← separationCarrier (.integer m) (.integer (.ofNat parts))
  pure (value/Int.ofNat parts))
 let slope ← targetCount target "absolute_branch_slope"
 let preimages ← targetCount target "preimage_count"
 let alphabet ← targetCount target "output_alphabet_size"
 let distribution ← text (← field target "stationary_distribution")
 let symbols ← text (← field target "output_symbols")
 pure ⟨m,m,slope,preimages,alphabet,depths,support,ratios,separation,
  ([slope,preimages,alphabet] ++ ratios.map Int.ofNat ++ separation).all (fun v => decide (v=m)),
  Text.equal distribution "uniform" && Text.equal symbols "independent-and-equiprobable",
  [← text (← field target "conventional_lyapunov_label"),← text (← field target "conventional_information_rate_label")],
  ← text (← field target "entropy_formula_scope"),← text (← field target "entropy_formula_relation"),false⟩
def analysisValue (a : Analysis) : Value :=
 let ns := fun xs : List Nat => Value.array (xs.map (fun n => .integer (.ofNat n)))
 .object [("generated_carrier",.integer a.generatedCarrier),("registered_piece_count",.integer a.registeredPieceCount),("registered_absolute_slope",.integer a.absoluteSlope),("registered_preimage_count",.integer a.preimageCount),("registered_output_alphabet_size",.integer a.outputAlphabetSize),("depths",ns a.depths),("complete_support",ns a.completeSupport),("support_successor_ratios",ns a.successorRatios),("separation_multipliers",.array (a.separationMultipliers.map Value.integer)),("all_exact_carriers_equal",.boolean a.allExactCarriersEqual),("uniform_independent_symbol_record_retained",.boolean a.uniformIndependentSymbols),("conventional_labels_retained",.array (a.conventionalLabels.map Value.text)),("entropy_formula_scope_retained",.text a.entropyScope),("entropy_formula_relation_retained",.text a.entropyRelation),("analytic_value_computed_or_imported",.boolean a.analyticValueImported)]
end SFT.Physics.LyapunovMeasurement
