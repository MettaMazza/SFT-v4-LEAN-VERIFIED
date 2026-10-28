import SFT.Computation.OracleTrace
namespace SFT.Computation.ComputationalLimit
open UniversalInterpretation StateTransition StateComposition ResourceRecord

-- These are the source's disclosed finite execution/resource/oracle records.
structure Record where
  request : Request
  observed : List String
  occupied : List String
  resource : ResourceRecord.Ledger
  external : OracleTrace.Ledger

def Verified (registry : List (String × OracleTrace.Interface)) (record : Record) : Prop :=
  create record.request.machine.states record.request.machine.actions
    record.request.machine.transitions = .ok record.request.machine ∧
  run record.request.machine record.request.initial record.request.actions = .ok record.observed ∧
  resourceLedger record.observed record.occupied = .ok record.resource ∧
  OracleTrace.Valid registry record.external

theorem fullDisclosure (registry : List (String × OracleTrace.Interface)) (record : Record)
    (verified : Verified registry record) :
    ∃ before terminal, record.observed = before ++ [terminal] ∧
      Path record.request.machine record.request.initial record.request.actions before terminal ∧
      record.resource.timeTrace.map Prod.snd = record.observed ∧
      record.resource.spaceSupport = record.occupied ∧
      record.resource.timeCount = record.request.actions.length + 1 ∧
      ∀ answer, answer ∈ OracleTrace.records record.external → OracleTrace.Registered registry answer := by
  obtain ⟨held,before,terminal,eq,path⟩ := nativePath _ _ _ _ verified.2.1
  have resources := recordReconstructs _ _ _ verified.2.2.1
  exact ⟨before,terminal,eq,path,resources.1,resources.2.1,
    executionObservationCount _ _ _ _ _ _ verified.2.1 verified.2.2.1,
    fun answer member => OracleTrace.retainedSource _ _ verified.2.2.2 answer member⟩

theorem falsifiedOutput (registry : List (String × OracleTrace.Interface)) (record : Record)
    (actual : List String)
    (replay : run record.request.machine record.request.initial record.request.actions = .ok actual)
    (different : actual ≠ record.observed) : ¬ Verified registry record := by
  intro verified
  have same := verified.2.1
  rw [replay] at same
  exact different (Except.ok.inj same)

theorem failedExecutionExcluded (registry : List (String × OracleTrace.Interface)) (record : Record)
    (reason : String)
    (failed : run record.request.machine record.request.initial record.request.actions = .error reason) :
    ¬ Verified registry record := by
  intro verified
  have successful := verified.2.1
  rw [failed] at successful
  cases successful

theorem missingOracleExcluded (registry : List (String × OracleTrace.Interface)) (record : Record)
    (answer : OracleTrace.AnswerRecord) (member : answer ∈ OracleTrace.records record.external)
    (absent : SFT.InformationScience.EncodingMaps.lookupFirst registry answer.identity = none) :
    ¬ Verified registry record := by
  intro verified
  exact OracleTrace.undeclaredSourceExcluded _ _ _ member absent verified.2.2.2

-- The claimed input domain is generated at arbitrary finite depth. A finite
-- sample is a separate list and does not stand in for this certificate.
def Complete (registry : List (String × OracleTrace.Interface)) (domain : Nat → List Record) : Prop :=
  ∀ depth record, record ∈ domain depth → Verified registry record

structure DepthCertificate (registry : List (String × OracleTrace.Interface))
    (domain : Nat → List Record) : Prop where
  base : ∀ record, record ∈ domain 0 → Verified registry record
  successor : ∀ depth, (∀ record, record ∈ domain depth → Verified registry record) →
    ∀ record, record ∈ domain (depth+1) → Verified registry record

theorem arbitraryDepth (registry : List (String × OracleTrace.Interface)) (domain : Nat → List Record)
    (certificate : DepthCertificate registry domain) : Complete registry domain := by
  intro depth
  induction depth with
  | zero => exact certificate.base
  | succ depth ih => exact certificate.successor depth ih

theorem noCertificateForFalsification (registry : List (String × OracleTrace.Interface))
    (domain : Nat → List Record) (depth : Nat) (record : Record) (held : record ∈ domain depth)
    (refuted : ¬ Verified registry record) : ¬ DepthCertificate registry domain := by
  intro certificate
  exact refuted (arbitraryDepth _ _ certificate depth record held)

theorem finiteEvidenceBoundary (registry : List (String × OracleTrace.Interface))
    (sample : List Record) (domain : Nat → List Record)
    (tested : ∀ record, record ∈ sample → Verified registry record)
    (depth : Nat) (record : Record) (held : record ∈ domain depth)
    (refuted : ¬ Verified registry record) :
    ¬ record ∈ sample ∧ ¬ Complete registry domain :=
  ⟨fun member => refuted (tested record member),fun full => refuted (full depth record held)⟩

theorem retainedDepthDomain (registry : List (String × OracleTrace.Interface))
    (domain extended : Nat → List Record) (retained : ∀ depth record,
      record ∈ domain depth → record ∈ extended depth)
    (verified : Complete registry extended) : Complete registry domain :=
  fun depth record member => verified depth record (retained depth record member)

theorem selfReferenceBoundary (registry : List (String × Request))
    (decoder : SFT.InformationScience.EncodingDecoder.Decoder)
    (predictor : SFT.InformationScience.EncodingClasses.Codeword → Except String String)
    (supported : DiagonalTrace.SelfSupport registry decoder predictor)
    (correct : DiagonalTrace.Correct registry decoder predictor) :
    ¬ DiagonalTrace.Total decoder predictor :=
  ProofBoundary.noCompleteInternalVerification _ _ _ supported correct
end SFT.Computation.ComputationalLimit
