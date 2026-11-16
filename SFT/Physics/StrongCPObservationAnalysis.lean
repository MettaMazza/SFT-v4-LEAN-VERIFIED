import SFT.Physics.YangMillsSpectrumMeasurement
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.StrongCPObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original exact positive-power lifetime rows; the authoritative record binds all six exponents.
structure ProtonRow where
 mantissa : Rat
 power : Nat
 interpretation : Value
 candidateCountPresent : Bool
 confidence : Rat
structure Target where
 centralStatus : Value
 denominator : Int
 upperMantissa : Rat
 statisticalMantissa : Rat
 systematicMantissa : Rat
 neutronConfidence : Rat
 protonRows : List ProtonRow
 finiteLimits : Value
 nullNotProofZero : Value
 sourceCount : Nat
def lifetimeValue (row : ProtonRow) : Rat := multiply row.mantissa (wholeRatio (10^row.power))
def acceptedStatuses : List String := ["no-proton-decay-signal","consistent-with-atmospheric-neutrino-background","no-significant-excess-no-indication-of-proton-decay","compatible-with-expected-atmospheric-neutrino-background"]
def exactAnalysis (record : Target) : Except String Value := do
 let denominator := normalize record.denominator 1 (by decide)
 let upper ← LeptonRatios.divide record.upperMantissa denominator
 let statistical ← LeptonRatios.divide record.statisticalMantissa denominator
 let systematic ← LeptonRatios.divide record.systematicMantissa denominator
 let limits := record.protonRows.map lifetimeValue
 let confidence := normalize 9 10 (by decide)
 let rat := RunningConvergenceCertificate.rat
 .ok (.object [
 ("nedm_reported_central_status",record.centralStatus),
 ("nedm_upper_limit",rat upper),
 ("nedm_statistical_uncertainty",rat statistical),
 ("nedm_systematic_uncertainty",rat systematic),
 ("nedm_direct_record_consistent",.boolean (sameValue record.centralStatus (.text "null-central-estimate") && zero.blt upper && zero.blt statistical && zero.blt systematic)),
 ("proton_lifetime_lower_limits_years",.array (limits.map rat)),
 ("proton_mode_count",.integer record.protonRows.length),
 ("all_proton_limits_positive",.boolean (limits.all (fun q=>(wholeRatio 1).blt q))),
 ("no_significant_decay_signal",.boolean (record.protonRows.all (fun row=>acceptedStatuses.any (fun status=>sameValue row.interpretation (.text status))))),
 ("background_candidates_retained",.boolean ((record.protonRows.filter ProtonRow.candidateCountPresent).length==4)),
 ("all_confidence_rows_retained",.boolean (record.protonRows.all (fun row=>row.confidence==confidence) && record.neutronConfidence==confidence)),
 ("finite_limits_not_infinity",record.finiteLimits),
 ("null_not_proof_zero",record.nullNotProofZero),
 ("all_sources_retained",.boolean (record.sourceCount==4))])
#print axioms lifetimeValue
#print axioms exactAnalysis
end SFT.Physics.StrongCPObservationAnalysis
