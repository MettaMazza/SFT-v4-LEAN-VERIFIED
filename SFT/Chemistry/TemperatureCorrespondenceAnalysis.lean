import SFT.Chemistry.TemperatureCorrespondence
import SFT.Host.Canonical
namespace SFT.Chemistry.TemperatureCorrespondenceAnalysis
open SFT.Host SFT.Host.Canonical
-- Exact integer fields of the three released source payloads, after the
-- original int conversions. No measured field enters the chemical law.
structure IntervalRecord where
 lower : Int
 upper : Int
 center : Int
 uncertainty : Int
structure ReleasedRecords where
 commonNumerator : Int
 commonDenominator : Int
 acoustic : IntervalRecord
 electronic : IntervalRecord
 composition : String
 phase : String
 equilibriumReference : String
 kineticTemperatureRelation : Bool
 noiseTemperatureRelation : Bool
 noiseRelationAccuracy : Int
def exactTemperatureAnalysis (r : ReleasedRecords) : Value :=
 .object [
 ("exact_common_carrier_scaled_numerator",.integer r.commonNumerator),
 ("common_scale_denominator",.integer r.commonDenominator),
 ("acoustic_interval",.array [.integer r.acoustic.lower,.integer r.acoustic.upper]),
 ("electronic_interval",.array [.integer r.electronic.lower,.integer r.electronic.upper]),
 ("all_external_magnitudes_exact_positive",.boolean
  ([r.commonNumerator,r.commonDenominator,r.acoustic.lower,r.acoustic.upper,
    r.electronic.lower,r.electronic.upper,r.acoustic.center,r.acoustic.uncertainty,
    r.electronic.center,r.electronic.uncertainty].all fun n => @decide (0<n) (Int.decLt 0 n))),
 ("acoustic_contains_exact_common_carrier",.boolean
  ((@decide (r.acoustic.lower ≤ r.commonNumerator) (Int.decLe _ _)) &&
   (@decide (r.commonNumerator ≤ r.acoustic.upper) (Int.decLe _ _)))),
 ("electronic_contains_exact_common_carrier",.boolean
  ((@decide (r.electronic.lower ≤ r.commonNumerator) (Int.decLe _ _)) &&
   (@decide (r.commonNumerator ≤ r.electronic.upper) (Int.decLe _ _)))),
 ("acoustic_center_and_uncertainty_reconstruct_interval",.boolean
  ((@decide (r.acoustic.center-r.acoustic.uncertainty=r.acoustic.lower) (Int.decEq _ _)) &&
   (@decide (r.acoustic.center+r.acoustic.uncertainty=r.acoustic.upper) (Int.decEq _ _)))),
 ("electronic_center_and_uncertainty_reconstruct_interval",.boolean
  ((@decide (r.electronic.center-r.electronic.uncertainty=r.electronic.lower) (Int.decEq _ _)) &&
   (@decide (r.electronic.center+r.electronic.uncertainty=r.electronic.upper) (Int.decEq _ _)))),
 ("argon_gas_TPW_context_retained",.boolean
  (Text.equal r.composition "argon" && Text.equal r.phase "gas" &&
   Text.equal r.equilibriumReference "triple-point-of-water")),
 ("kinetic_temperature_relation_retained",.boolean r.kineticTemperatureRelation),
 ("Johnson_temperature_response_retained",.boolean r.noiseTemperatureRelation),
 ("Johnson_one_ppm_relation_record_retained",.boolean
  (@decide (r.noiseRelationAccuracy=1) (Int.decEq _ _)))]
end SFT.Chemistry.TemperatureCorrespondenceAnalysis
