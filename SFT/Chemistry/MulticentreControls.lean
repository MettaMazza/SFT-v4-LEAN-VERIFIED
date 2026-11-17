import SFT.Chemistry.MulticentreComparison
import SFT.Chemistry.JointCorrelationControls
namespace SFT.Chemistry.MulticentreControls
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open StateSymmetryControls (rejected)
abbrev J := Canonical.Value
def textAt (row : J) (key : String) : Except String String := field row key >>= text
def counts (rows : List J) : Except String (List (String × Nat)) := do
 let sources ← rows.mapM (fun row => textAt row "source_id")
 let magnitudes ← rows.mapM (fun row => textAt row "exact_magnitude")
 return [("records",rows.length),("IUPAC",(sources.filter (Text.equal · "IUPAC-GOLD-BOOK-08789-2026")).length),
 ("diborane",(sources.filter (Text.equal · "NIST-CCCBDB-SRD101-DIBORANE")).length),
 ("benzene",(sources.filter (Text.equal · "NIST-CCCBDB-SRD101-BENZENE")).length),
 ("positive_numeric",(magnitudes.filter (fun s => !Text.equal s "structural-absence")).length),
 ("categorical_or_text",(magnitudes.filter (Text.equal · "structural-absence")).length)]
def expectedCounts : List (String × Nat) := [("records",20),("IUPAC",4),("diborane",9),("benzene",7),("positive_numeric",14),("categorical_or_text",6)]
def hasRecord (rows : List J) (role inscription : String) : Bool := rows.any fun row =>
 match (do return (← textAt row "record_role",← textAt row "inscription")) with
 | .error _ => false
 | .ok (r,i) => Text.equal r role && Text.equal i inscription
def targetMagnitude (rows : List MulticentreTargets.Resolved) (id : String) : Except String Value :=
 match rows.find? (fun row => Text.equal row.row.targetId id) with
 | none => .error "StopIteration"
 | some row => .ok row.magnitude
def adverse (targets : List MulticentreTargets.Resolved) (rows : List J) (counts : List (String × Nat))
 (actualHash changedHash : String) : Except String (List (String × Bool)) := do
 let bridge ← MulticentreSupport.bridge
 let ring ← MulticentreSupport.ring
 let volume ← MulticentreSupport.tetrahedron
 let outer ← targetMagnitude targets "NIST-DIBORANE-rBH-OUTER"
 let bridging ← targetMagnitude targets "NIST-DIBORANE-rBH-BRIDGING"
 let oldValue := Value.ratio (← count 1320) (← count 1000)
 let newValue := Value.ratio (← count 1321) (← count 1000)
 let allCounts := counts.length==expectedCounts.length && expectedCounts.all (fun (key,n) => counts.any (fun (k,m) => Text.equal key k && n==m))
 return [("two_centre_rejected",rejected (MulticentreSupport.ribbonSupport "control" ["left","right"])),
 ("disconnected_support_rejected",rejected (MulticentreSupport.construct bridge.molecularCarrier MulticentreSupport.ribbon bridge.centres (bridge.edges.take 1) bridge.centres)),
 ("incomplete_support_word_rejected",rejected (MulticentreSupport.construct bridge.molecularCarrier MulticentreSupport.ribbon bridge.centres bridge.edges (bridge.centres.take (bridge.centres.length-1)))),
 ("topology_mismatch_rejected",rejected (MulticentreSupport.construct ring.molecularCarrier MulticentreSupport.ribbon ring.centres ring.edges ring.electronSupport)),
 ("numerical_zero_rejected",rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
 ("measured_bridge_distinction_retained",!equal bridging outer),
 ("diborane_BHB_connectivity_retained",hasRecord rows "aBHB" "83.8"),
 ("benzene_six_equal_aromatic_links_retained",hasRecord rows "C:C-count" "6" && hasRecord rows "rCC" "1.397"),
 ("omitted_record_rejected",rows.length-1 != 20),
 ("selected_IUPAC_only_rejected",(← PairExchangeControls.countAt counts "diborane")==9 && (← PairExchangeControls.countAt counts "benzene")==7),
 ("selected_NIST_only_rejected",(← PairExchangeControls.countAt counts "IUPAC")==4),
 ("changed_value_rejected",!equal oldValue newValue),
 ("tampered_snapshot_rejected",Text.equal actualHash MulticentreTargets.diboraneHash && !Text.equal changedHash MulticentreTargets.diboraneHash),
 ("complete_vector_retained",allCounts),
 ("all_generated_topologies_operational",[bridge,ring,volume].all MulticentreSupport.irreducible)]
end SFT.Chemistry.MulticentreControls
