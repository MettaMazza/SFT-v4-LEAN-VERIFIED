import SFT.Physics.SymmetricSourceConservationCertificate
import SFT.Host.Canonical
open SFT.Physics.SymmetricSourceConservation SFT.Physics.SymmetricSourceConservationCertificate SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def cs (xs : List Coordinate) : Value := .array (xs.map (fun c => .text (coordinateName c)))
def sv (p : Slot) : Value := .array [.text (coordinateName p.1),.text (coordinateName p.2)]
def tv (p : Term) : Value := .array [cs p.1,sv p.2]
def commValue (c : Commutation) : Value := .object [("word_count",nv c.wordCount),("rows",.array (c.rows.map (fun row => .array [cs row.word,cs row.canonical,.boolean row.allOrdersCommute]))),("every_derivative_order_commutes",.boolean c.everyDerivativeOrderCommutes),("successor_proof",.text c.successorProof)]
def rowValue (row : DivergenceRow) : Value := .object [("direction",.text (coordinateName row.direction)),("carried_terms",nv row.carriedTerms),("opposed_terms",nv row.opposedTerms),("distinct_terms",nv row.distinctTerms),("balanced",.boolean row.balanced),("unmatched_terms",.array (row.unmatchedTerms.map tv))]
def certValue (c : Certificate) : Value := .object [("coordinates",cs c.coordinates),("symmetric_slots",.array (c.symmetricSlots.map sv)),("slot_count",nv c.slotCount),("source_ledger",.object (c.sourceLedger.map (fun p => (p.1,.array (p.2.map sv))))),("source_partition_counts",.array (c.sourcePartitionCounts.map nv)),("componentwise_bijection",.array (c.componentwiseBijection.map (fun p => .array [sv p.1,sv p.2]))),("divergence_rows",.array (c.divergenceRows.map rowValue)),("conserved_directions",cs c.conservedDirections),("all_four_balanced",.boolean c.allFourBalanced),("commutation",commValue c.commutation),("leaking_control_balanced",.boolean c.leakingControlBalanced),("leaking_control_has_one_missing_flow",.boolean c.leakingControlHasOneMissingFlow),("signed_numerical_scalar_used",.boolean c.signedNumericalScalarUsed),("depth_independent_identity",.text c.depthIndependentIdentity)]
#eval IO.println (render (certValue conservationCertificate))
