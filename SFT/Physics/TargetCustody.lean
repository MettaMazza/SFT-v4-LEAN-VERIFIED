import SFT.Physics.LeptonCustody
import SFT.Engine.EvidenceGates
namespace SFT.Physics.TargetCustody
open SFT.Host SFT.Host.Canonical
abbrev PredictionSeal := SFT.Physics.LeptonCustody.PredictionSeal
def insertTarget (entry : String × Value) : List (String × Value) → List (String × Value)
 | [] => [entry]
 | head::tail => if Text.le entry.1 head.1 then entry::head::tail else head::insertTarget entry tail

def sortTargets : List (String × Value) → List (String × Value)
 | [] => []
 | head::tail => insertTarget head (sortTargets tail)

def targetIdentity (values : List (String × Value)) (nonce : String) : String :=
 identity (.array ((sortTargets values).map fun (name,value) => .array [.text name,.text nonce,value]))

structure Commitment where
 experiment : String
 custodian : String
 targetIds : List String
 targetHash : String
 expectedEnvelopeHash : String
 commitmentHash : String

def commitmentValue (c : Commitment) : Value := .object [
 ("experiment_id",.text c.experiment),("custodian_id",.text c.custodian),
 ("target_ids",.array (c.targetIds.map Value.text)),("target_identity_hash",.text c.targetHash),
 ("expected_envelope_hash",.text c.expectedEnvelopeHash),("commitment_hash",.text c.commitmentHash)]

structure Vault where
 commitment : Commitment
 values : List (String × Value)
 nonce : String
 released : Bool

-- On this typed layer, values are canonicalised source mapping entries.
def createVault (experiment custodian : String) (values : List (String × Value))
    (nonce expectedEnvelope : String) : Except String Vault :=
  if !SFT.Physics.LeptonPrediction.nonblank experiment || !SFT.Physics.LeptonPrediction.nonblank custodian ||
      !SFT.Physics.LeptonPrediction.nonblank nonce then
    .error "CustodyHalt: target vault requires experiment, custodian and nonce identities"
  else if values.isEmpty || values.any (fun row => !SFT.Physics.LeptonPrediction.nonblank row.1) then
    .error "CustodyHalt: target vault requires complete named target support"
  else if !SFT.Engine.isSha256Identity expectedEnvelope then
    .error "CustodyHalt: target vault requires the preregistered prediction-envelope identity"
  else
    let ids := (sortTargets values).map Prod.fst
    let targetHash := targetIdentity values nonce
    let payload : Value := .object [("experiment_id",.text experiment),("custodian_id",.text custodian),
      ("target_ids",.array (ids.map Value.text)),("target_identity_hash",.text targetHash),
      ("expected_envelope_hash",.text expectedEnvelope)]
    .ok ⟨⟨experiment,custodian,ids,targetHash,expectedEnvelope,identity payload⟩,values,nonce,false⟩

theorem constructorRetainsCommitment (experiment custodian : String) (values : List (String × Value))
    (nonce expectedEnvelope : String) (vault : Vault)
    (accepted : createVault experiment custodian values nonce expectedEnvelope = .ok vault) :
    vault.released = false ∧ vault.values = values ∧ vault.nonce = nonce ∧
      vault.commitment.experiment = experiment ∧ vault.commitment.custodian = custodian ∧
      vault.commitment.targetIds = (sortTargets values).map Prod.fst ∧
      vault.commitment.targetHash = targetIdentity values nonce ∧
      vault.commitment.expectedEnvelopeHash = expectedEnvelope := by
  unfold createVault at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · split at accepted
      · cases accepted
      · cases Except.ok.inj accepted
        exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩

structure Release where
 experiment : String
 custodian : String
 predictionSealHash : String
 targetHash : String
 values : List (String × Value)
 nonce : String
 releaseHash : String

def releasePayload (r : Release) : Value := .object [
 ("experiment_id",.text r.experiment),("custodian_id",.text r.custodian),
 ("prediction_seal_hash",.text r.predictionSealHash),("target_identity_hash",.text r.targetHash),
 ("targets",.object (r.values.map fun (name,value) => (name,value))),("custody_nonce",.text r.nonce)]

def releaseValue (r : Release) : Value := .object [
 ("experiment_id",.text r.experiment),("custodian_id",.text r.custodian),
 ("prediction_seal_hash",.text r.predictionSealHash),("target_identity_hash",.text r.targetHash),
 ("targets",.object (r.values.map fun (name,value) => (name,value))),
 ("custody_nonce",.text r.nonce),("release_hash",.text r.releaseHash)]

def release (vault : Vault) (prediction : PredictionSeal) : Except String (Vault × Release) :=
 if vault.released then .error "CustodyHalt: target vault has already released its registered package"
 else if !Text.equal prediction.experiment vault.commitment.experiment then
   .error "CustodyHalt: prediction seal belongs to a different experiment"
 else if !Text.equal prediction.envelopeHash vault.commitment.expectedEnvelopeHash then
   .error "CustodyHalt: prediction seal is not bound to the preregistered envelope"
 else
   let raw : Release := ⟨vault.commitment.experiment,vault.commitment.custodian,prediction.sealHash,
     vault.commitment.targetHash,vault.values,vault.nonce,""⟩
   .ok ({vault with released := true},{raw with releaseHash := identity (releasePayload raw)})

def sameNames (left right : List String) : Bool :=
 (left.map Text.chars) == (right.map Text.chars)

def violations (commitment : Commitment) (released : Release) (prediction : PredictionSeal) : List String :=
 (if !Text.equal released.experiment commitment.experiment || !Text.equal prediction.experiment commitment.experiment
  then ["experiment identities differ"] else []) ++
 (if !Text.equal released.custodian commitment.custodian then ["custodian identity differs"] else []) ++
 (if !Text.equal released.predictionSealHash prediction.sealHash then ["release is bound to a different prediction seal"] else []) ++
 (if !Text.equal prediction.envelopeHash commitment.expectedEnvelopeHash then ["prediction seal is bound to a different envelope"] else []) ++
 (if !sameNames ((sortTargets released.values).map Prod.fst) commitment.targetIds then ["released target support differs from the commitment"] else []) ++
 (if !Text.equal (targetIdentity released.values released.nonce) commitment.targetHash || !Text.equal released.targetHash commitment.targetHash
  then ["released target content differs from the pre-seal commitment"] else []) ++
 (if !Text.equal released.releaseHash (identity (releasePayload released)) then ["target release identity differs from its contents"] else [])

def verify (commitment : Commitment) (released : Release) (prediction : PredictionSeal) : Except String Unit :=
 let errors := violations commitment released prediction
 if errors.isEmpty then .ok () else .error (Text.append "CustodyHalt: " (Text.intercalate "; " errors))

def identityFromRelease (released : Release) : Except String String :=
 if SFT.Engine.isSha256Identity released.targetHash then .ok released.targetHash
 else .error "CustodyHalt: release target identity is invalid"


theorem cannotReleaseTwice (vault : Vault) (prediction : PredictionSeal) (used : vault.released = true) :
 release vault prediction = .error "CustodyHalt: target vault has already released its registered package" := by
 unfold release
 rw [used]
 rfl

theorem releasePreservesPackage (vault next : Vault) (prediction : PredictionSeal) (released : Release)
    (accepted : release vault prediction = .ok (next,released)) :
    next.released = true ∧ next.commitment = vault.commitment ∧ next.values = vault.values ∧
    released.values = vault.values ∧ released.nonce = vault.nonce ∧
    released.predictionSealHash = prediction.sealHash ∧ released.targetHash = vault.commitment.targetHash := by
  unfold release at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · split at accepted
      · cases accepted
      · cases Except.ok.inj accepted
        exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩

theorem successfulReleaseCannotRepeat (vault next : Vault) (first second : PredictionSeal) (released : Release)
    (accepted : release vault first = .ok (next,released)) :
    release next second = .error "CustodyHalt: target vault has already released its registered package" :=
  cannotReleaseTwice next second (releasePreservesPackage vault next first released accepted).1
theorem releaseRequiresMatchingSeal (vault next : Vault) (prediction : PredictionSeal) (released : Release)
    (accepted : release vault prediction = .ok (next,released)) :
    vault.released = false ∧ Text.equal prediction.experiment vault.commitment.experiment = true ∧
      Text.equal prediction.envelopeHash vault.commitment.expectedEnvelopeHash = true := by
  unfold release at accepted
  cases used : vault.released with
  | true => rw [used] at accepted; cases accepted
  | false =>
    rw [used] at accepted
    cases experiment : Text.equal prediction.experiment vault.commitment.experiment with
    | false => rw [experiment] at accepted; cases accepted
    | true =>
      rw [experiment] at accepted
      cases envelope : Text.equal prediction.envelopeHash vault.commitment.expectedEnvelopeHash with
      | false => rw [envelope] at accepted; cases accepted
      | true => exact ⟨rfl,rfl,rfl⟩
theorem verifyEmpty (commitment : Commitment) (released : Release) (prediction : PredictionSeal) :
    verify commitment released prediction = .ok () ↔ violations commitment released prediction = [] := by
  constructor
  · intro accepted
    unfold verify at accepted
    dsimp only at accepted
    cases empty : (violations commitment released prediction).isEmpty with
    | false => rw [empty] at accepted; cases accepted
    | true => exact SFT.Engine.listEmptyOfIsEmpty _ empty
  · intro empty
    unfold verify
    rw [empty]
    rfl

theorem violationRowEmpty (failed : Bool) (message : String) :
    (if failed then [message] else []) = [] ↔ failed = false := by
  cases failed with
  | false => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | true => constructor <;> intro impossible <;> cases impossible

theorem exchangeChecksExactly (commitment : Commitment) (released : Release) (prediction : PredictionSeal) :
    verify commitment released prediction = .ok () ↔
    (!Text.equal released.experiment commitment.experiment || !Text.equal prediction.experiment commitment.experiment) = false ∧
    (!Text.equal released.custodian commitment.custodian) = false ∧
    (!Text.equal released.predictionSealHash prediction.sealHash) = false ∧
    (!Text.equal prediction.envelopeHash commitment.expectedEnvelopeHash) = false ∧
    (!sameNames ((sortTargets released.values).map Prod.fst) commitment.targetIds) = false ∧
    (!Text.equal (targetIdentity released.values released.nonce) commitment.targetHash || !Text.equal released.targetHash commitment.targetHash) = false ∧
    (!Text.equal released.releaseHash (identity (releasePayload released))) = false := by
  constructor
  · intro accepted
    have empty := (verifyEmpty commitment released prediction).mp accepted
    unfold violations at empty
    have row7 := SFT.Engine.appendEmptyRight _ _ empty
    have rest6 := SFT.Engine.appendEmptyLeft _ _ empty
    have row6 := SFT.Engine.appendEmptyRight _ _ rest6
    have rest5 := SFT.Engine.appendEmptyLeft _ _ rest6
    have row5 := SFT.Engine.appendEmptyRight _ _ rest5
    have rest4 := SFT.Engine.appendEmptyLeft _ _ rest5
    have row4 := SFT.Engine.appendEmptyRight _ _ rest4
    have rest3 := SFT.Engine.appendEmptyLeft _ _ rest4
    have row3 := SFT.Engine.appendEmptyRight _ _ rest3
    have rest2 := SFT.Engine.appendEmptyLeft _ _ rest3
    have row2 := SFT.Engine.appendEmptyRight _ _ rest2
    have rest1 := SFT.Engine.appendEmptyLeft _ _ rest2
    exact ⟨(violationRowEmpty _ _).mp rest1,(violationRowEmpty _ _).mp row2,(violationRowEmpty _ _).mp row3,(violationRowEmpty _ _).mp row4,(violationRowEmpty _ _).mp row5,(violationRowEmpty _ _).mp row6,(violationRowEmpty _ _).mp row7⟩
  · intro ⟨h0,h1,h2,h3,h4,h5,h6⟩
    apply (verifyEmpty commitment released prediction).mpr
    unfold violations
    rw [h0,h1,h2,h3,h4,h5,h6]
    rfl
end SFT.Physics.TargetCustody
