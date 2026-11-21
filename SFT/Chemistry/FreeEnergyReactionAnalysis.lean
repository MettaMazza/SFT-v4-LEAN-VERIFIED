import SFT.Chemistry.HeatWorkTransferAnalysis
namespace SFT.Chemistry.FreeEnergyReactionAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
open InternalEnergyCompositionExperiment
-- Pinned free_energy_equivalent_direction_validation_v1.py: exact_reaction_direction_analysis.
def speciesColumns : List String := ["temperature-kelvin","heat-capacity-joule-per-mole-kelvin","entropy-joule-per-mole-kelvin","gibbs-function-joule-per-mole-kelvin","enthalpy-increment-kilojoule-per-mole","formation-enthalpy-kilojoule-per-mole","formation-gibbs-kilojoule-per-mole","log10-formation-equilibrium-constant"]
structure RowAnalysis where
 temperature : Rat
 gibbs : Rat
 separation : Rat
 logK : Rat
 direction : String
def analyzeRow (payload : Value) : Except String RowAnalysis := do
 let a ← field payload "NO2_complete_row"
 let b ← field payload "N2O4_complete_row"
 let temperature ← field a "temperature-kelvin" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let ag ← field a "formation-gibbs-kilojoule-per-mole" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let bg ← field b "formation-gibbs-kilojoule-per-mole" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let ak ← field a "log10-formation-equilibrium-constant" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let bk ← field b "log10-formation-equilibrium-constant" >>= identityString >>= HeatWorkTransferAnalysis.sourceDecimal
 let dg := subtract (add ag ag) bg
 let lk := subtract (add ak ak) bk
 let negative := @decide (dg.num<0) (Int.decLt _ _)
 let separation := if negative then subtract zero dg else dg
 let direction := if @decide (dg.num=0) (Int.decEq _ _) then "equilibrium" else if negative then "forward" else "reverse"
 let checks ← [("reaction-gibbs-kilojoule-per-mole-external-signed-inscription",InternalEnergyCompositionSource.fractionText dg),
  ("reaction-gibbs-exact-positive-separation-kilojoule-per-mole",InternalEnergyCompositionSource.fractionText separation),
  ("reaction-log10-equilibrium-constant-external-signed-inscription",InternalEnergyCompositionSource.fractionText lk),
  ("held-reaction-direction",direction)].mapM fun (key,expected) => do
   let actual ← field payload key >>= identityString
   pure (Text.equal actual expected)
 if !checks.all id then throw "THERMO-007 target calculation changed"
 pure ⟨temperature,dg,separation,lk,direction⟩
structure Analysis where
 temperatures : List Rat
 gibbs : List Rat
 separations : List Rat
 logK : List Rat
 directions : List String
 checks : List (String×Bool)
def exactReactionDirectionAnalysis (rows : List InternalEnergyCompositionSource.Target) : Except String Analysis := do
 let payloads := rows.map fun row => get row.row "target_payload"
 let analyzed ← payloads.mapM analyzeRow
 let temperatures := analyzed.map RowAnalysis.temperature
 let directions := analyzed.map RowAnalysis.direction
 let crossings := (directions.zip (directions.drop 1)).zipIdx.filterMap fun ((left,right),index) =>
  if Text.equal left right then none else some index
 let columns ← payloads.mapM fun payload => do
  let a ← field payload "NO2_complete_row"
  let b ← field payload "N2O4_complete_row"
  pure ([a,b].all fun obj => match obj with
   | .object fields => fields.length==speciesColumns.length && speciesColumns.all (hasKey obj)
   | .null => false
   | .boolean _ => false
   | .integer _ => false
   | .text _ => false
   | .array _ => false)
 pure ⟨temperatures,analyzed.map RowAnalysis.gibbs,analyzed.map RowAnalysis.separation,analyzed.map RowAnalysis.logK,directions,[
  ("all_temperatures_strictly_increasing",(temperatures.zip (temperatures.drop 1)).all fun (a,b) => @decide (0<(subtract b a).num) (Int.decLt _ _)),
  ("all_Gibbs_logK_signs_opposed",analyzed.all fun row =>
   (@decide (row.gibbs.num<0) (Int.decLt _ _) && @decide (0<row.logK.num) (Int.decLt _ _)) ||
   (@decide (0<row.gibbs.num) (Int.decLt _ _) && @decide (row.logK.num<0) (Int.decLt _ _))),
  ("five_reverse_and_fifty_nine_forward_rows_retained",(directions.filter (Text.equal "reverse")).length==5 && (directions.filter (Text.equal "forward")).length==59),
  ("single_direction_crossing_retained",crossings==[4]),
  ("exact_crossing_bracket_300_to_350_kelvin",((temperatures.drop 4).take 2).map InternalEnergyCompositionSource.fractionText==["300","350"]),
  ("all_64_rows_retained",rows.length==64),
  ("all_eight_columns_per_species_retained",columns.all id)]⟩
end SFT.Chemistry.FreeEnergyReactionAnalysis
