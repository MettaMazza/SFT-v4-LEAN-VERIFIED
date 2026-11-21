import SFT.Chemistry.HeatWorkTransferAnalysis
namespace SFT.Chemistry.EnthalpyStateAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
structure Analysis where
 enthalpyValues : List Rat
 internalValues : List Rat
 environmentComponents : List Rat
 enthalpySteps : List Rat
 checks : List (String×Bool)
def exactEnthalpyAnalysis (rows : List InternalEnergyCompositionSource.Target) : Except String Analysis := do
 let payloads := rows.map fun row => get row.row "target_payload"
 let enthalpies ← payloads.mapM fun p => field p "enthalpy-kilojoule-per-mole" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let internal ← payloads.mapM fun p => field p "internal-energy-kilojoule-per-mole" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let environment := (enthalpies.zip internal).map fun (h,u) => subtract h u
 let steps := (enthalpies.zip (enthalpies.drop 1)).map fun (first,second) => subtract second first
 let transfer ← HeatWorkTransferAnalysis.exactHeatWorkAnalysis rows
 let phases ← payloads.mapM fun p => field p "phase-identity" >>= identityString
 let first ← match enthalpies.head? with | some v => pure v | none => throw "tuple index out of range"
 let last ← match enthalpies.getLast? with | some v => pure v | none => throw "tuple index out of range"
 let path := steps.foldl add zero
 let direct := subtract last first
 let agreement := match transfer.checks.find? (fun item => Text.equal item.1 "all_independent_work_records_agree_within_display_resolution") with
  | some item => item.2
  | none => false
 pure ⟨enthalpies,internal,environment,steps,[
  ("all_enthalpy_values_exact_positive",enthalpies.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("all_environment_components_exact_positive",environment.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("all_adjacent_enthalpy_steps_exact_positive",steps.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("complete_enthalpy_path_composes_exactly",@decide (path.num=direct.num) (Int.decEq _ _) && path.den==direct.den),
  ("all_component_records_agree_with_pressure_volume_within_display_resolution",agreement),
  ("all_fourteen_columns_retained",payloads.all fun p => valueColumns.all (hasKey p)),
  ("all_13_rows_retained",rows.length==13),
  ("nine_liquid_and_four_vapor_rows_retained",(phases.filter (Text.equal "liquid")).length==9 && (phases.filter (Text.equal "vapor")).length==4),
  ("phase_boundary_pair_retained",(phases.drop 8).take 2==["liquid","vapor"] &&
   ((payloads.drop 8).take 2).all fun p => sameValue (get p "temperature-kelvin") (.text "372.75593"))]⟩
end SFT.Chemistry.EnthalpyStateAnalysis
