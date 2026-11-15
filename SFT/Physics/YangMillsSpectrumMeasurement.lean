import SFT.Physics.DeuteronMeasurement
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.YangMillsSpectrumMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- The admitted source record carries exact rational inscriptions as strings.
-- Retain the shared existing exact reader for strings and JSON integers/Booleans.
def exactInput : Value → Except String Rat
 | .text s => DeuteronMeasurement.fraction s
 | .integer n => .ok (normalize n 1 (by decide))
 | .boolean true => .ok (normalize 1 1 (by decide))
 | .boolean false => .ok (normalize 0 1 (by decide))
 | .null | .array _ | .object _ => .error "TypeError"
structure SpectrumRow where
 quantumNumbers : Value
 mass : Rat
 uncertainty : Rat
 lower : Rat
 upper : Rat
 role : Value
def spectrumRow (row : Value) : Except String SpectrumRow := do
 let quantum ← field row "quantum_numbers"
 let mass ← exactInput (← field row "mass_mev")
 let uncertainty ← exactInput (← field row "standard_uncertainty_mev")
 let role ← field row "role"
 pure ⟨quantum,mass,uncertainty,subtract mass uncertainty,add mass uncertainty,role⟩
def rowValue (r : SpectrumRow) : Value := .object [
 ("quantum_numbers",r.quantumNumbers),("mass",ratValue r.mass),("uncertainty",ratValue r.uncertainty),
 ("lower",ratValue r.lower),("upper",ratValue r.upper),("role",r.role)]
def nthRow : List SpectrumRow → Nat → Except String SpectrumRow
 | [],_ => .error "IndexError"
 | r::_,0 => .ok r
 | _::rs,n+1 => nthRow rs n
def orderedFrom (previous : SpectrumRow) : List SpectrumRow → Bool
 | [] => true
 | r::rs => previous.upper.blt r.lower && orderedFrom r rs
def ordered : List SpectrumRow → Bool
 | [] => true
 | r::rs => orderedFrom r rs
def exactSpectrumAnalysis (target : Value) : Except String Value := do
 let rows ← (← array (← field target "precise_lattice_rows")).mapM spectrumRow
 let ground ← if sameValue (← field target "ground_state_quantum_numbers") (.text "0++") then
  pure (sameValue (← nthRow rows 0).quantumNumbers (.text "0++")) else pure false
 let excitation ← if sameValue (← field target "first_excited_state_quantum_numbers") (.text "2++") then
  pure (sameValue (← nthRow rows 1).quantumNumbers (.text "2++")) else pure false
 let quenched ← field target "quenched_approximation_neglects_quark_loops"
 let mixing ← field target "glue_and_quark_antiquark_states_can_mix"
 let fullQcd ← field target "full_qcd_requires_dynamical_light_quarks_mixing_control_and_high_statistics"
 let nonidentification ← field target "pdg_reports_no_scalar_below_2_gev_as_predominantly_glueball"
 let experiment ← field target "unambiguous_experimental_glueball_identification"
 let fitted ← field target "dimensionful_mass_selected_formal_fold_gap"
 pure (.object [("rows",.array (rows.map rowValue)),("row_count",.integer (.ofNat rows.length)),
 ("quantum_number_order",.array (rows.map SpectrumRow.quantumNumbers)),
 ("all_central_masses_positive",.boolean (rows.all (fun r => zero.blt r.mass))),
 ("all_lower_edges_positive",.boolean (rows.all (fun r => zero.blt r.lower))),
 ("intervals_strictly_ordered_and_disjoint",.boolean (ordered rows)),
 ("ground_state_scalar",.boolean ground),("first_excitation_tensor",.boolean excitation),
 ("scope_rows_retained",.boolean (SymmetricRecords.truthy quenched && SymmetricRecords.truthy mixing &&
 SymmetricRecords.truthy fullQcd && SymmetricRecords.truthy nonidentification &&
 sameValue experiment (.boolean false) && sameValue fitted (.boolean false)))])
end SFT.Physics.YangMillsSpectrumMeasurement
