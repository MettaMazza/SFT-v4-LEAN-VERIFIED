import SFT.Chemistry.InternalEnergyCompositionSource
namespace SFT.Chemistry.HeatWorkTransferAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
open InternalEnergyCompositionExperiment
-- Original post-seal analysis: heat_work_transfer_partition_validation_v1.py.
-- These signed rational values are external source inscriptions, not law inputs.
def sourceDecimal (inscription : String) : Except String Rat :=
 let chars := LeptonDecimal.strip (Text.chars inscription)
 let negative := match chars with
  | head::_ => head == '-'
  | [] => false
 let body := match chars with
  | head::rest => if head == '-' || head == '+' then rest else chars
  | [] => []
 (LeptonDecimal.coefficient body).map fun parsed =>
  let numerator : Int := match negative,parsed.1 with
   | true,0 => .ofNat 0
   | true,n+1 => .negSucc n
   | false,n => .ofNat n
  normalize numerator (10^parsed.2) (Nat.pow_pos (by decide))
def decimalQuantum (inscription : String) : Rat :=
 let parts := LeptonDecimal.split '.' (Text.chars inscription)
 let places := if parts.length>1 then (parts.getLast?.getD []).length else 0
 normalize 1 (10^places) (Nat.pow_pos (by decide))
def tenth : Rat := ⟨1,10,by decide,by decide⟩
def quarter : Rat := ⟨1,4,by decide,by decide⟩
structure RowAnalysis where
 heatCapacity : Rat
 pressureVolumeWork : Rat
 stateRecordWork : Rat
 separation : Rat
 resolutionBound : Rat
def analyzeRow (payload : Value) : Except String RowAnalysis := do
 let cpText ← field payload "isobaric-heat-capacity-joule-per-mole-kelvin" >>= identityString
 let pText ← field payload "pressure-bar" >>= identityString
 let vText ← field payload "volume-litre-per-mole" >>= identityString
 let hText ← field payload "enthalpy-kilojoule-per-mole" >>= identityString
 let uText ← field payload "internal-energy-kilojoule-per-mole" >>= identityString
 let cp ← sourceDecimal cpText
 let pressure ← sourceDecimal pText
 let volume ← sourceDecimal vText
 let enthalpy ← sourceDecimal hText
 let internal ← sourceDecimal uText
 let directWork := multiply (multiply pressure volume) tenth
 let recordedWork := subtract enthalpy internal
 let difference := subtract directWork recordedWork
 let separation := if @decide (0<difference.num) (Int.decLt _ _) then difference else subtract recordedWork directWork
 let pvBound := multiply (add (add
  (multiply (multiply pressure (decimalQuantum vText)) half)
  (multiply (multiply volume (decimalQuantum pText)) half))
  (multiply (multiply (decimalQuantum pText) (decimalQuantum vText)) quarter)) tenth
 let stateBound := multiply (add (decimalQuantum hText) (decimalQuantum uText)) half
 pure ⟨cp,directWork,recordedWork,separation,add pvBound stateBound⟩
structure Analysis where
 calorimetricHeatCapacityValues : List Rat
 pressureVolumeWorkValues : List Rat
 stateRecordWorkValues : List Rat
 workRecordExactSeparations : List Rat
 workRecordExactResolutionBounds : List Rat
 checks : List (String×Bool)
def exactHeatWorkAnalysis (rows : List InternalEnergyCompositionSource.Target) : Except String Analysis := do
 let payloads := rows.map fun row => get row.row "target_payload"
 let analyzed ← payloads.mapM analyzeRow
 let phases ← payloads.mapM fun p => field p "phase-identity" >>= identityString
 let cp := analyzed.map RowAnalysis.heatCapacity
 let work := analyzed.map RowAnalysis.pressureVolumeWork
 let recorded := analyzed.map RowAnalysis.stateRecordWork
 let separations := analyzed.map RowAnalysis.separation
 let bounds := analyzed.map RowAnalysis.resolutionBound
 pure ⟨cp,work,recorded,separations,bounds,[
  ("all_calorimetric_values_exact_positive",cp.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("all_pressure_volume_work_values_exact_positive",work.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("all_state_record_work_values_exact_positive",recorded.all fun v => @decide (0<v.num) (Int.decLt _ _)),
  ("all_independent_work_records_agree_within_display_resolution",analyzed.all fun r =>
    let difference := subtract r.resolutionBound r.separation
    @decide (0≤difference.num) (Int.decLe _ _)),
  ("all_fourteen_columns_retained",payloads.all fun p => valueColumns.all (hasKey p)),
  ("all_13_rows_retained",rows.length==13),
  ("nine_liquid_and_four_vapor_rows_retained",(phases.filter (Text.equal "liquid")).length==9 && (phases.filter (Text.equal "vapor")).length==4),
  ("phase_boundary_pair_retained",(phases.drop 8).take 2==["liquid","vapor"] &&
    ((payloads.drop 8).take 2).all fun p => sameValue (get p "temperature-kelvin") (.text "372.75593"))]⟩
end SFT.Chemistry.HeatWorkTransferAnalysis
