import SFT.Chemistry.UncertaintyRecord
import SFT.Physics.ReferenceRealization
namespace SFT.Chemistry.TraceabilityChain
open SFT.Physics.DimensionReferenceTransport

-- V3 measurement_identity_batch_2.py SPECS[4]. All data are retained
-- source records. No property value is computed from certificate typography.
structure Record (Alternative : Type) where
 materialIdentity : String
 sampleIdentity : String
 propertyIdentity : String
 value : SFT.Host.Canonical.Value
 uncertainty : UncertaintyRecord.Record Alternative
 reference : Reference

structure Certificate (Alternative : Type) where
 identity : String
 subject : Record Alternative
 predecessor : Option (Record Alternative)
 sourceRecord : SFT.Host.Canonical.Value

variable {A : Type}
structure Anchor (Alternative : Type) where
 record : Record Alternative
 certificate : Certificate Alternative
 subjectBound : certificate.subject = record
 initial : certificate.predecessor = none
 reference : Reference
 realization : SFT.Physics.ReferenceRealization.Process record.reference reference

structure Link (registry : List (Certificate A)) (prior next : Record A) where
 certificate : Certificate A
 registered : certificate ∈ registry
 subjectBound : certificate.subject = next
 predecessorBound : certificate.predecessor = some prior
 sameProperty : next.propertyIdentity = prior.propertyIdentity

inductive Chain (anchor : Anchor A) (registry : List (Certificate A)) : Record A → Type where
 | base : Chain anchor registry anchor.record
 | next {prior next : Record A} (history : Chain anchor registry prior)
   (link : Link registry prior next) : Chain anchor registry next

def certificates {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A} :
 Chain anchor registry last → List (Certificate A)
 | .base => [anchor.certificate]
 | .next history link => certificates history ++ [link.certificate]

def records {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A} :
 Chain anchor registry last → List (Record A)
 | .base => [anchor.record]
 | .next history _ => records history ++ [last]

def length {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A} :
 Chain anchor registry last → Nat
 | .base => 1
 | .next history _ => length history + 1

theorem completeCertificateBinding {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A}
 (history : Chain anchor registry last) : (certificates history).map Certificate.subject = records history := by
 induction history with
 | base => exact congrArg (fun x => [x]) anchor.subjectBound
 | next history link ih =>
   change (certificates history ++ [link.certificate]).map _ = records history ++ [_]
   rw [SFT.Physics.ReferenceRealization.mapAppendOne,ih,link.subjectBound]

theorem chainPositive {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A}
 (history : Chain anchor registry last) : 0 < length history := by
 cases history with
 | base => exact Nat.zero_lt_succ _
 | next history link => exact Nat.zero_lt_succ _

theorem completeLength {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A}
 (history : Chain anchor registry last) : (records history).length = length history := by
 induction history with
 | base => rfl
 | next history link ih =>
   change (records history ++ [_]).length = length history + 1
   rw [SFT.Physics.ReferenceRealization.lengthAppendOne,ih]

theorem propertyPreserved {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A}
 (history : Chain anchor registry last) : last.propertyIdentity = anchor.record.propertyIdentity := by
 induction history with
 | base => rfl
 | next history link ih => exact link.sameProperty.trans ih

theorem predecessorExact {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next) : link.certificate.predecessor = some prior := link.predecessorBound

theorem uncertaintyBound {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next) : link.certificate.subject.uncertainty = next.uncertainty :=
 congrArg Record.uncertainty link.subjectBound

theorem materialBound {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next) : link.certificate.subject.materialIdentity = next.materialIdentity ∧
 link.certificate.subject.sampleIdentity = next.sampleIdentity :=
 ⟨congrArg Record.materialIdentity link.subjectBound,congrArg Record.sampleIdentity link.subjectBound⟩

theorem valueBound {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next) : link.certificate.subject.value = next.value :=
 congrArg Record.value link.subjectBound

theorem unregisteredLinkRejected {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next) (absent : ¬link.certificate ∈ registry) : False := absent link.registered

theorem substitutionRejected {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next)
 (changed : link.certificate.subject.materialIdentity ≠ next.materialIdentity) : False :=
 changed (materialBound link).1

theorem brokenPredecessorRejected {registry : List (Certificate A)} {prior next : Record A}
 (link : Link registry prior next) (changed : link.certificate.predecessor ≠ some prior) : False :=
 changed link.predecessorBound

theorem allPriorRecordsRetained {anchor : Anchor A} {registry : List (Certificate A)} {prior next : Record A}
 (history : Chain anchor registry prior) (link : Link registry prior next) (row : Record A)
 (held : row ∈ records history) : row ∈ records (.next history link) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft row (records history) [next] held

theorem allPriorCertificatesRetained {anchor : Anchor A} {registry : List (Certificate A)} {prior next : Record A}
 (history : Chain anchor registry prior) (link : Link registry prior next) (row : Certificate A)
 (held : row ∈ certificates history) : row ∈ certificates (.next history link) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft row (certificates history) [link.certificate] held

theorem referenceRecordRetained {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A}
 (history : Chain anchor registry last) : anchor.record ∈ records history := by
 induction history with
 | base => exact List.Mem.head _
 | next history link ih => exact allPriorRecordsRetained history link anchor.record ih

theorem everyCertificateRegistered {anchor : Anchor A} {registry : List (Certificate A)} {last : Record A}
 (history : Chain anchor registry last) (row : Certificate A) (held : row ∈ certificates history) :
 row = anchor.certificate ∨ row ∈ registry := by
 induction history with
 | base =>
   cases held with
   | head => exact .inl rfl
   | tail _ impossible => cases impossible
 | next history link ih =>
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases row (certificates history) [link.certificate] held with
   | inl old => exact ih old
   | inr new =>
     cases new with
     | head => exact .inr link.registered
     | tail _ impossible => cases impossible

theorem admittedReferenceTrace (anchor : Anchor A) :
 SFT.Physics.ReferenceRealization.trace anchor.realization ≠ [] :=
 SFT.Physics.ReferenceRealization.noNameOnlyRealization anchor.realization

theorem referenceRealizationRecords (anchor : Anchor A) :
 (SFT.Physics.ReferenceRealization.trace anchor.realization).map (fun r => (r.sourceIdentity,r.record)) =
 SFT.Physics.ReferenceRealization.records anchor.realization :=
 SFT.Physics.ReferenceRealization.allRecordsRetained anchor.realization
end SFT.Chemistry.TraceabilityChain
