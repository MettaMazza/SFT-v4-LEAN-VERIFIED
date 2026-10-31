import SFT.Physics.CustodyTypes
import SFT.Physics.LeptonExperiment
import SFT.Engine.DecisionGate
namespace SFT.Physics.LeptonCustody
open SFT.Host SFT.Host.Canonical LeptonPrediction LeptonExperiment
set_option maxRecDepth 20000



def sealValue (s : PredictionSeal) : Value := .object [
 ("experiment_id",.text s.experiment),("prediction_hash",.text s.predictionHash),
 ("trace_hash",.text s.traceHash),("envelope_hash",.text s.envelopeHash),("seal_hash",.text s.sealHash)]

def sealPrediction (prior : Option PredictionSeal) (derivationSeal : String)
 (output : Held) (trace : List TraceRow) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "TargetAccessViolation: prediction is already sealed and cannot be replaced"
 | none =>
   let prediction := identity (heldValue output)
   let traceHash := identity (.array (trace.map traceValue))
   let env := identity (envelope derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text prediction),("trace_hash",.text traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,prediction,traceHash,env,identity payload⟩

def nativeSeal (derivationSeal : String) : Except String PredictionSeal := do
 let execution ← execute derivationSeal
 match execution.output with
 | none => .error "FoldLanguageHalt: registered program did not emit"
 | some output => sealPrediction none derivationSeal output execution.trace

def insertTarget (entry : String × Held) : List (String × Held) → List (String × Held)
 | [] => [entry]
 | head::tail => if Text.le entry.1 head.1 then entry::head::tail else head::insertTarget entry tail

def sortTargets : List (String × Held) → List (String × Held)
 | [] => []
 | head::tail => insertTarget head (sortTargets tail)

def targetIdentity (values : List (String × Held)) (nonce : String) : String :=
 identity (.array ((sortTargets values).map fun (name,value) => .array [.text name,.text nonce,heldValue value]))

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
 values : List (String × Held)
 nonce : String
 released : Bool

def registeredVault (derivationSeal : String) : Vault :=
 let nonce := identity (.array [.text registrationHash,.text snapshotHash])
 let ids := (sortTargets targets).map Prod.fst
 let targetHash := targetIdentity targets nonce
 let custodian := Text.append experimentId "-external-target-custodian"
 let expected := identity (envelope derivationSeal)
 let payload : Value := .object [("experiment_id",.text experimentId),("custodian_id",.text custodian),
   ("target_ids",.array (ids.map Value.text)),("target_identity_hash",.text targetHash),
   ("expected_envelope_hash",.text expected)]
 ⟨⟨experimentId,custodian,ids,targetHash,expected,identity payload⟩,targets,nonce,false⟩

def checkVault (vault : Vault) : Except String Unit :=
 if !nonblank vault.commitment.experiment || !nonblank vault.commitment.custodian || !nonblank vault.nonce then
   .error "CustodyHalt: target vault requires experiment, custodian and nonce identities"
 else if vault.values.isEmpty || vault.values.any (fun row => !nonblank row.1) then
   .error "CustodyHalt: target vault requires complete named target support"
 else if !SFT.Engine.isSha256Identity vault.commitment.expectedEnvelopeHash then
   .error "CustodyHalt: target vault requires the preregistered prediction-envelope identity"
 else .ok ()

structure Release where
 experiment : String
 custodian : String
 predictionSealHash : String
 targetHash : String
 values : List (String × Held)
 nonce : String
 releaseHash : String

def releasePayload (r : Release) : Value := .object [
 ("experiment_id",.text r.experiment),("custodian_id",.text r.custodian),
 ("prediction_seal_hash",.text r.predictionSealHash),("target_identity_hash",.text r.targetHash),
 ("targets",.object (r.values.map fun (name,value) => (name,heldValue value))),("custody_nonce",.text r.nonce)]

def releaseValue (r : Release) : Value := .object [
 ("experiment_id",.text r.experiment),("custodian_id",.text r.custodian),
 ("prediction_seal_hash",.text r.predictionSealHash),("target_identity_hash",.text r.targetHash),
 ("targets",.object (r.values.map fun (name,value) => (name,heldValue value))),
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

def measurementContext (prediction : Option PredictionSeal) (values : List (String × Held)) : Except String (PredictionSeal × List (String × Held)) :=
 match prediction with
 | none => .error "TargetAccessViolation: target material cannot be opened before prediction seal"
 | some p => if sameNames ((sortTargets values).map Prod.fst) ((sortTargets targets).map Prod.fst)
   then .ok (p,values)
   else .error "TargetAccessViolation: post-seal target identities do not match the registration"

theorem noPreSealAccess (values : List (String × Held)) :
 measurementContext none values = .error "TargetAccessViolation: target material cannot be opened before prediction seal" := rfl

theorem cannotReseal (prior : PredictionSeal) (derivationSeal : String) (output : Held) (trace : List TraceRow) :
 sealPrediction (some prior) derivationSeal output trace =
 .error "TargetAccessViolation: prediction is already sealed and cannot be replaced" := rfl

theorem cannotReleaseTwice (vault : Vault) (prediction : PredictionSeal) (used : vault.released = true) :
 release vault prediction = .error "CustodyHalt: target vault has already released its registered package" := by
 unfold release
 rw [used]
 rfl

end SFT.Physics.LeptonCustody
