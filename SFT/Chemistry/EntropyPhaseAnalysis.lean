import SFT.Chemistry.HeatWorkTransferAnalysis
namespace SFT.Chemistry.EntropyPhaseAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
open InternalEnergyCompositionExperiment
abbrev sourceDecimal := HeatWorkTransferAnalysis.sourceDecimal
abbrev decimalQuantum := HeatWorkTransferAnalysis.decimalQuantum
-- Original post-seal exact_entropy_phase_analysis; source readings remain external.
structure Analysis where
 entropyValues : List Rat
 entropySteps : List Rat
 phaseEntropyJump : Rat
 independentPhaseEntropy : Rat
 separation : Rat
 resolutionBound : Rat
 checks : List (String×Bool)
def thousand : Rat := ⟨1000,1,by decide,by decide⟩
def exactEntropyPhaseAnalysis (rows : List InternalEnergyCompositionSource.Target) : Except String Analysis := do
 let payloads := rows.map fun row => get row.row "target_payload"
 let entropies ← payloads.mapM fun p => field p "entropy-joule-per-mole-kelvin" >>= identityString >>= sourceDecimal
 let increments := (entropies.zip (entropies.drop 1)).map fun (first,second) => subtract second first
 let liquid ← match (payloads.drop 8).head? with | some p => pure p | none => throw "tuple index out of range"
 let vapor ← match (payloads.drop 9).head? with | some p => pure p | none => throw "tuple index out of range"
 let sLiquid ← field liquid "entropy-joule-per-mole-kelvin" >>= identityString
 let sVapor ← field vapor "entropy-joule-per-mole-kelvin" >>= identityString
 let hLiquid ← field liquid "enthalpy-kilojoule-per-mole" >>= identityString
 let hVapor ← field vapor "enthalpy-kilojoule-per-mole" >>= identityString
 let tLiquid ← field liquid "temperature-kelvin" >>= identityString
 let entropyJump := subtract (← sourceDecimal sVapor) (← sourceDecimal sLiquid)
 let enthalpyJump := subtract (← sourceDecimal hVapor) (← sourceDecimal hLiquid)
 let temperature ← sourceDecimal tLiquid
 let independent ← LeptonRatios.divide (multiply enthalpyJump thousand) temperature
 let difference := subtract entropyJump independent
 let separation := if @decide (0<difference.num) (Int.decLt _ _) then difference else subtract independent entropyJump
 let entropyBound := multiply (add (decimalQuantum sVapor) (decimalQuantum sLiquid)) half
 let enthalpyBound := multiply (add (decimalQuantum hVapor) (decimalQuantum hLiquid)) half
 let temperatureBound := multiply (decimalQuantum tLiquid) half
 let lowerTemperature := subtract temperature temperatureBound
 let firstTerm ← LeptonRatios.divide enthalpyBound lowerTemperature
 let secondTerm ← LeptonRatios.divide (multiply enthalpyJump temperatureBound) (multiply temperature lowerTemperature)
 let resolutionBound := add entropyBound (multiply thousand (add firstTerm secondTerm))
 let phases ← payloads.mapM fun p => field p "phase-identity" >>= identityString
 let first ← match entropies.head? with | some v => pure v | none => throw "tuple index out of range"
 let last ← match entropies.getLast? with | some v => pure v | none => throw "tuple index out of range"
 let path := increments.foldl add zero
 let direct := subtract last first
 let remaining := subtract resolutionBound separation
 pure ⟨entropies,increments,entropyJump,independent,separation,resolutionBound,[
  ("all_entropy_values_exact_positive",entropies.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("all_adjacent_entropy_steps_exact_positive",increments.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("complete_entropy_path_composes_exactly",@decide (path.num=direct.num) (Int.decEq _ _) && path.den==direct.den),
  ("phase_boundary_pair_retained",(phases.drop 8).take 2==["liquid","vapor"] &&
   sameValue (get liquid "temperature-kelvin") (.text "372.75593") && sameValue (get vapor "temperature-kelvin") (.text "372.75593")),
  ("phase_entropy_jump_exact_positive",@decide (0<entropyJump.num) (Int.decLt _ _)),
  ("independent_phase_entropy_relation_agrees_within_display_resolution",@decide (0≤remaining.num) (Int.decLe _ _)),
  ("all_fourteen_columns_retained",payloads.all fun p => valueColumns.all (hasKey p)),
  ("all_13_rows_retained",rows.length==13),
  ("nine_liquid_and_four_vapor_rows_retained",(phases.filter (Text.equal "liquid")).length==9 && (phases.filter (Text.equal "vapor")).length==4)]⟩
end SFT.Chemistry.EntropyPhaseAnalysis
