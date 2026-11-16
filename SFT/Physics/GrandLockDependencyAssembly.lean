import SFT.Physics.GrandLockDependency
namespace SFT.Physics.GrandLockDependency
open SFT.Host.Canonical SFT.Physics RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Exact source sequencing; every hypothesis is discharged by the original record checks.
theorem assembleOriginalRecord
 (record : Value) (dictionary claims : List Value) (rows : Rows) (physics owners : List String)
 (physicsValue declared empirical adverse : Value) (evidence : List Bool) (count : Nat) (rooted omission : Bool)
 (dictionaryField : field record "dependency_dictionary" = .ok (.array dictionary))
 (parsedRows : recordMap (fun row=>do pure ((← text (← field row "claim_id")),(← stringList (← field row "dependencies")))) dictionary = .ok rows)
 (physicsField : field record "physics_claim_ids" = .ok physicsValue)
 (physicsParsed : stringList physicsValue = .ok physics)
 (declaredField : field record "physics_claim_count" = .ok declared)
 (distinct : (physics.length != (unique physics).length) = false)
 (traversed : traversalCount rows physics = .ok count)
 (reached : allRooted rows physics = .ok rooted)
 (claimsField : field record "physics_claims" = .ok (.array claims))
 (parsedOwners : recordMap (fun row=>do text (← field row "claim_id")) claims = .ok owners)
 (parsedEvidence : recordMap (fun row=>do let values ← recordMap (field row) ["receipt_hash","receipt_file_sha256","certificate_sha256","registration_sha256"]; pure (recordAll SymmetricRecords.truthy values)) claims = .ok evidence)
 (ownership : (physics.all (contains (nameSet owners)) && owners.all (contains (nameSet physics))) = omission)
 (transitiveField : field record "transitive_claim_count" = .ok (.integer (.ofNat count)))
 (empiricalField : field record "empirical_claim_count" = .ok empirical)
 (adverseField : field record "unfavorable_or_scope_boundary_count" = .ok adverse)
 (evidenceTrue : evidence.all id = true)
 (countIdentity : sameValue (.integer (.ofNat count)) (.integer (.ofNat count)) = true) :
 dependencyCertificate record = .ok (.object [
 ("physics_claim_count",.integer (.ofNat physics.length)),
 ("transitive_claim_count",.integer (.ofNat count)),
 ("no_omission",.boolean omission),("acyclic",.boolean true),("all_reach_one",.boolean rooted),
 ("all_evidence_hash_bound",.boolean true),("empirical_claim_count",empirical),("unfavorable_or_scope_boundary_count",adverse)]) := by
 unfold dependencyCertificate
 rewrite [dictionaryField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at parsedRows
 rewrite [parsedRows]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at physicsField
 rewrite [physicsField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [physicsParsed]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [declaredField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [distinct, Bool.false_and]
 rewrite [ite_eq_right Bool.false_ne_true]
 rewrite [traversed]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [reached]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [claimsField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at parsedOwners
 rewrite [parsedOwners]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at parsedEvidence
 rewrite [parsedEvidence]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [transitiveField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [empiricalField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [adverseField]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 rewrite [ownership, evidenceTrue, countIdentity]
 rfl
#print axioms assembleOriginalRecord
end SFT.Physics.GrandLockDependency
