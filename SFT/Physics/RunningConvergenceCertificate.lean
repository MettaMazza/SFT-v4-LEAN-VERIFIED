import SFT.Physics.RunningConvergence
import SFT.Host.Canonical
namespace SFT.Physics.RunningConvergenceCertificate
open SFT.Physics.RunningConvergence SFT.Host.Canonical
def rat (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def nats (xs : List Nat) : Value := .array (xs.map (fun n => .integer (.ofNat n)))
def rats (xs : List Rat) : Value := .array (xs.map rat)
def witness (w : ConvergenceWitness) : Value := .object [
 ("lower_sector",.integer w.lowerSector),("upper_sector",.integer w.upperSector),
 ("tolerance",rat w.tolerance),("level",.integer (.ofNat w.level)),
 ("support",.integer (.ofNat w.support)),("gap",rat w.gap),
 ("gap_below_tolerance",.boolean w.gapBelowTolerance),
 ("binary_support_reaches_required_bound",.boolean w.binarySupportReachesRequiredBound)]
def carrier (c : CarrierTranslation) : Value := .object [
 ("generated_coordinate",.text c.generatedCoordinate),
 ("larger_support_corresponds_to",.text c.largerSupportCorrespondsTo),
 ("formal_holding_direction",.text c.formalHoldingDirection)]
def translation (c : CarrierTranslationRecord) : Value := .object [
 ("self_sourced_colour",carrier c.selfSourcedColour),
 ("screened_electromagnetic",carrier c.screenedElectromagnetic),
 ("single_common_fold_axis",.boolean c.singleCommonFoldAxis),
 ("universal_imported_energy_sign_required",.boolean c.universalImportedEnergySignRequired),
 ("measurement_selects_orientation",.boolean c.measurementSelectsOrientation)]
def certificate (c : FormalCertificate) : Value := .object [
 ("sectors",nats c.sectors),("levels",nats c.levels),("supports",nats c.supports),
 ("common_scale_vectors",.array (c.commonScaleVectors.map (fun xs => .array (xs.map (fun (p,q) => .array [.integer (.ofNat p),rat q]))))),
 ("shortfall_vectors",.array (c.shortfallVectors.map rats)),
 ("successor_take_vectors",.array (c.successorTakeVectors.map rats)),
 ("pair_gap_vectors",.array (c.pairGapVectors.map rats)),
 ("pair_gap_successor_takes",.array (c.pairGapSuccessorTakes.map rats)),
 ("convergence_witnesses",.array (c.convergenceWitnesses.map witness)),
 ("carrier_translation",translation c.carrierTranslation)]

def value : Value := match formalCertificate with | .ok c => certificate c | .error _ => .null
end SFT.Physics.RunningConvergenceCertificate
