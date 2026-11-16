import SFT.Physics.ThermometryAnalysis
import SFT.Physics.SectorAnchorRecords
namespace SFT.Physics.ThermometryMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement
-- Source Boolean identity is strict: integer1 is not the singleton True.
def literalBoolean (v : Value) (wanted : Bool) : Bool := match v with
 | .boolean b => if b then wanted else !wanted
 | .null | .integer _ | .text _ | .array _ | .object _ => false

def exactThermalAnalysis (target : Value) : Except String Value := do
 let exact ← SectorAnchorRecords.originalInt (← field target "exact_si_kb_scaled")
 let acousticCenter ← SectorAnchorRecords.originalInt (← field target "acoustic_kb_scaled_center")
 let acousticUncertainty ← SectorAnchorRecords.originalInt (← field target "acoustic_kb_scaled_standard_uncertainty")
 let electronicCenter ← SectorAnchorRecords.originalInt (← field target "electronic_kb_scaled_center")
 let electronicUncertainty ← SectorAnchorRecords.originalInt (← field target "electronic_kb_scaled_standard_uncertainty")
 let scale ← SectorAnchorRecords.originalInt (← field target "scale_denominator")
 let routes ← SectorAnchorRecords.originalInt (← field target "measurement_route_count")
 let accuracy ← SectorAnchorRecords.originalInt (← field target "electronic_johnson_relation_accuracy_parts_per_million")
 let distinctRoutes := literalBoolean (← field target "measurement_routes_physically_distinct") true
 let kinetic := literalBoolean (← field target "acoustic_temperature_measures_average_kinetic_energy") true
 let johnson := literalBoolean (← field target "electronic_johnson_noise_power_depends_on_resistance_and_temperature") true
 let dyadicNotClaimed := literalBoolean (← field target "universal_dyadic_population_ladder_reported_as_measured") false
 let responseNotClaimed := literalBoolean (← field target "three_quarter_response_reported_as_universal_measured_value") false
 let allRows := literalBoolean (← field target "all_registered_rows_retained") true
 pure (ThermometryAnalysis.exactAnalysis ⟨exact,acousticCenter,acousticUncertainty,electronicCenter,electronicUncertainty,scale,routes,accuracy,distinctRoutes,kinetic,johnson,dyadicNotClaimed,responseNotClaimed,allRows⟩)
end SFT.Physics.ThermometryMeasurement
