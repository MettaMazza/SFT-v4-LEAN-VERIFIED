import SFT.Chemistry.ResonanceEquivalentWitnesses
import SFT.Chemistry.ConjugatedSupportAnalysis
namespace SFT.Chemistry.ResonanceEquivalentAnalysis
open SFT.Host SFT.Chemistry.ResonanceEquivalent
abbrev J := Canonical.Value
abbrev SourceRow := ConjugatedSupportAnalysis.SourceRow

def base : Except String ExactEquivalentRepresentationPair := do
 let first ← encoding "first" "carrier" ["atom-a","atom-b","atom-c"] [(1,2),(2,3)] ["fold-fibre-one","fold-fibre-two"]
 let second ← encoding "second" "carrier" ["atom-a","atom-b","atom-c"] [(1,2),(2,3)] ["fold-fibre-two","fold-fibre-one"]
 equivalentPair "carrier" first second

def trial (first : ExactMolecularEncoding) (name carrier : String) (edges : List (Int × Int)) (labels : List String) : Except String ExactEquivalentRepresentationPair := do
 let other ← encoding name carrier ["atom-a","atom-b","atom-c"] edges labels
 equivalentPair "carrier" first other

-- Python dictionary expansion retains earlier positions and replaces colliding values.
def putField (fields : List (String × J)) (item : String × J) : List (String × J) :=
 if fields.any (fun old => Text.equal old.1 item.1) then
  fields.map (fun old => if Text.equal old.1 item.1 then item else old)
 else fields ++ [item]

def exactAnalysis (rows : List SourceRow) (primary : J) : Except String J := do
 if rows.length != 4 then throw "ORG-002 requires all four external surfaces"
 let pair ← base
 let successor ← appendSharedSuccessor pair "atom-d"
 let carrierRejected := rejected (trial pair.first "other" "other-carrier" [(1,2),(2,3)] ["fold-fibre-two","fold-fibre-one"])
 let adjacencyRejected := rejected (trial pair.first "changed" "carrier" [(1,3),(2,3)] ["fold-fibre-two","fold-fibre-one"])
 let partialRejected := rejected (trial pair.first "partial" "carrier" [(1,2),(2,3)] ["fold-fibre-one","fold-fibre-one"])
 let identicalRejected := rejected (equivalentPair "carrier" pair.first pair.first)
 let postseal ← ConjugatedSupportAnalysis.field primary "exact_postseal_analysis"
 let fields ← match postseal with
  | .object fields => .ok fields
  | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "postseal analysis requires a mapping"
 let n ← representationCount pair
 let firstLabels := successor.first.fibres.map (fun row => row.label)
 let reversedSecond := successor.second.fibres.map (fun row => if Text.equal row.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
 let original : List (String × J) := [
 ("base_atom_count",.integer (.ofNat pair.first.atoms.length)),
 ("base_adjacency_count",.integer (.ofNat pair.first.adjacency.length)),
 ("base_representation_count",.integer (.ofNat n.value)),
 ("successor_atom_count",.integer (.ofNat successor.first.atoms.length)),
 ("successor_adjacency_count",.integer (.ofNat successor.first.adjacency.length)),
 ("prior_atom_prefix_preserved",.boolean (sameLabels (successor.first.atoms.take (successor.first.atoms.length-1)) pair.first.atoms)),
 ("prior_adjacency_prefix_preserved",.boolean (sameEdges (successor.first.adjacency.take (successor.first.adjacency.length-1)) pair.first.adjacency)),
 ("complete_complement_preserved",.boolean (firstLabels.length == reversedSecond.length && (firstLabels.zip reversedSecond).all (fun (a,b) => Text.equal a b))),
 ("carrier_mismatch_rejected",.boolean carrierRejected),
 ("adjacency_mismatch_rejected",.boolean adjacencyRejected),
 ("partial_complement_rejected",.boolean partialRejected),
 ("identical_encoding_rejected",.boolean identicalRejected),
 ("complete_target_count",.integer (.ofNat rows.length)),
 ("complete_source_count",.integer (.ofNat (ConjugatedSupportAnalysis.distinctSources rows).length)),
 ("development_observed_target_count",.integer (.ofNat (rows.filter (fun row => Text.equal row.custodyClass "family-development-observed")).length)),
 ("predecessor_opened_target_count",.integer (.ofNat (rows.filter (fun row => Text.equal row.custodyClass "family-identity-opened-by-admitted-ORG-001")).length))]
 pure (.object (fields.foldl putField original))
#print axioms base
#print axioms trial
#print axioms putField
#print axioms exactAnalysis
end SFT.Chemistry.ResonanceEquivalentAnalysis
