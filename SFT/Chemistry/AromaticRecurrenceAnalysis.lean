import SFT.Chemistry.AromaticRecurrenceWitnesses
import SFT.Chemistry.AromaticMagnitude
import SFT.Chemistry.InorganicNetworkPrediction
namespace SFT.Chemistry.AromaticRecurrenceAnalysis
open SFT.Host AromaticRecurrence AromaticRecurrenceWitnesses
open JointCorrelationTargets (field text)
abbrev J := Canonical.Value

def array : J → Except String (List J)
 | .array xs => .ok xs
 | .null | .boolean _ | .integer _ | .text _ | .object _ => .error "expected array"
def byRole (rows : List J) (role : String) : Except String J := do
 let pairs ← rows.mapM fun row => do
  let r ← field row "source_record_role" >>= text
  return (r,row)
 match pairs.filter (fun p => Text.equal p.1 role) with
 | [(_,row)] => field row "source_outcome"
 | [] | _::_::_ => throw (Text.append "ORG-003 role cardinality changed: " role)
def property (surface : J) (label : String) : Except String (String × String × String) := do
 let tables ← field surface "complete_experimental_data_tables" >>= array
 let rows ← tables.mapM fun table => do
  let rows ← array table
  rows.mapM array
 let selected :=  rows.flatten.filter (fun row => match row with
  | .text first::_ => Text.equal first label
  | [] | .null::_ | .boolean _::_ | .integer _::_ | .array _::_ | .object _::_ => false)
 match selected with
 | [row] => match row with
  | _::v::u::reference::_ => return (← text v,← text u,← text reference)
  | [] | [_] | [_,_] | [_,_,_] => throw (Text.append "ORG-003 property cardinality changed: " label)
 | [] | _::_::_ => throw (Text.append "ORG-003 property cardinality changed: " label)

def externalProperty (rows : List J) (species : String) : Except String (String × String × String) := do
 property (← byRole rows (Text.join ["complete-cccbdb-",species,"-experimental-data-surface"])) "Hfg(298.15K)"
def duplicateBoundaryRejected (r : Recurrence) : Bool :=
 match r.boundary with
 | [] => false
 | first::_ => match recurrence r.carrier r.cycle [first,first] r.layers with
  | .error _ => true | .ok _ => false
-- Python dictionary expansion preserves prior key order while replacing its value.
def overlay (base extra : List (String × J)) : List (String × J) :=
 extra.foldl (fun out pair =>
  if out.any (fun p => Text.equal p.1 pair.1) then
   out.map (fun p => if Text.equal p.1 pair.1 then pair else p)
  else out++[pair]) base

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 9 then throw "ORG-003 requires all nine external surfaces"
 let b ← base
 let s ← successor
 let t ← secondSuccessor
 let stability ← aromaticStability b
 let trace ← firstReturnTrace b
 let firstReturn := match trace,trace.reverse with
  | x::_,y::_ => MulticentreSupport.sameLabel x y
  | [],[] | [],_::_ | _::_,[] => false
 let bv ← externalProperty rows "benzene"
 let ev ← externalProperty rows "cyclohexene"
 let av ← externalProperty rows "cyclohexane"
 let (bd,bn) ← AromaticMagnitude.directedHundredths bv.1
 let (ed,en) ← AromaticMagnitude.directedHundredths ev.1
 let (ad,an) ← AromaticMagnitude.directedHundredths av.1
 if !Text.equal bd "above-reference" || !Text.equal ed "below-reference" || !Text.equal ad "below-reference" then
  throw "ORG-003 directed external relation changed"
 let single : Int := Int.ofNat an - Int.ofNat en
 let cyclic : Int := Int.ofNat an + Int.ofNat bn
 let g ← SFT.Physics.FoldFirstReturn.generatorPeriod
 let localized := Int.ofNat g * single
 let excess := localized - cyclic
 let ub ← AromaticMagnitude.directedHundredths bv.2.1
 let ue ← AromaticMagnitude.directedHundredths ev.2.1
 let ua ← AromaticMagnitude.directedHundredths av.2.1
 let envelope := Int.ofNat (g*(ue.2+ua.2)+ub.2+ua.2)
 let post ← field primary "exact_postseal_analysis"
 let extra ← (match post with | .object fs => .ok fs | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "expected object" : Except String (List (String × J)))
 let ids ← rows.mapM (fun row => field row "source_id" >>= text)
 let unique := ids.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let custody ← rows.mapM (fun row => field row "custody_class" >>= text)
 let values : List (String × J) := [
 ("primitive_support_count",.integer (.ofNat (supportSize b))),
 ("successor_support_count",.integer (.ofNat (supportSize s))),
 ("second_successor_support_count",.integer (.ofNat (supportSize t))),
 ("complete_first_return",.boolean firstReturn),
 ("complete_pair_cell_perturbation_closure",.boolean (perturbationClosure b)),
 ("positive_recurrence_opening_gap",.boolean (closedPrecedes stability)),
 ("incomplete_pair_cell_layer_rejected",.boolean incompleteWitness),
 ("duplicated_boundary_fibre_rejected",.boolean (duplicateBoundaryRejected b)),
 ("open_two_centre_cycle_rejected",.boolean openPathWitness),
 ("complete_target_count",.integer (.ofNat rows.length)),
 ("complete_source_count",.integer (.ofNat unique.length)),
 ("development_observed_target_count",.integer (.ofNat (custody.filter (Text.equal "family-development-observed-before-ORG-003-seal")).length)),
 ("outcome_unopened_blind_target_count",.integer (.ofNat (custody.filter (fun c => Text.equal (String.ofList ((Text.chars c).take (Text.chars "identity-only-outcome-unopened").length)) "identity-only-outcome-unopened")).length)),
 ("blind_hfg_298_external_strings",.object [("benzene",.text bv.1),("cyclohexene",.text ev.1),("cyclohexane",.text av.1)]),
 ("blind_hfg_298_uncertainty_external_strings",.object [("benzene",.text bv.2.1),("cyclohexene",.text ev.2.1),("cyclohexane",.text av.2.1)]),
 ("blind_single_isolated_hydrogenation_magnitude_kj_per_mol",.text (← AromaticMagnitude.hundredths single)),
 ("blind_cyclic_threefold_hydrogenation_magnitude_kj_per_mol",.text (← AromaticMagnitude.hundredths cyclic)),
 ("blind_localized_threefold_reference_magnitude_kj_per_mol",.text (← AromaticMagnitude.hundredths localized)),
 ("blind_recurrence_stability_excess_magnitude_kj_per_mol",.text (← AromaticMagnitude.hundredths excess)),
 ("blind_conservative_uncertainty_envelope_kj_per_mol",.text (← AromaticMagnitude.hundredths envelope)),
 ("blind_stability_excess_lower_envelope_kj_per_mol",.text (← AromaticMagnitude.hundredths (excess-envelope)))]
 return .object (overlay values extra)
end SFT.Chemistry.AromaticRecurrenceAnalysis
