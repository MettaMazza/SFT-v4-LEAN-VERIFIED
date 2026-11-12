import SFT.Chemistry.TraceabilityChain
namespace SFT.Materials.Traceability
open SFT.Chemistry

-- MATERIALS_OBLIGATIONS[6]: the complete measurement and its actual chain.
structure Record (Alternative : Type) where
 result : TraceabilityChain.Record Alternative
 conditions : SFT.Host.Canonical.Value
 anchor : TraceabilityChain.Anchor Alternative
 calibration : List (TraceabilityChain.Certificate Alternative)
 chain : TraceabilityChain.Chain anchor calibration result

variable {A : Type}

def measurementFields (record : Record A) :=
 (record.result.value,record.result.uncertainty,record.result.uncertainty.boundary.methodIdentity,
 record.result.sampleIdentity,record.conditions,record.calibration)

theorem completeResultBinding (record : Record A) :
 (TraceabilityChain.certificates record.chain).map TraceabilityChain.Certificate.subject =
 TraceabilityChain.records record.chain := TraceabilityChain.completeCertificateBinding record.chain

theorem positiveReferenceChain (record : Record A) : 0<TraceabilityChain.length record.chain :=
 TraceabilityChain.chainPositive record.chain

theorem sameMeasuredProperty (record : Record A) :
 record.result.propertyIdentity=record.anchor.record.propertyIdentity := TraceabilityChain.propertyPreserved record.chain

theorem allCalibrationsRegistered (record : Record A) (certificate : TraceabilityChain.Certificate A)
 (held : certificate∈TraceabilityChain.certificates record.chain) :
 certificate=record.anchor.certificate ∨ certificate∈record.calibration :=
 TraceabilityChain.everyCertificateRegistered record.chain certificate held

theorem realizedReference (record : Record A) :
 SFT.Physics.ReferenceRealization.trace record.anchor.realization≠[] :=
 TraceabilityChain.admittedReferenceTrace record.anchor

def initial (anchor : TraceabilityChain.Anchor A) (calibration : List (TraceabilityChain.Certificate A))
 (conditions : SFT.Host.Canonical.Value) : Record A :=
 ⟨anchor.record,conditions,anchor,calibration,.base⟩

def extend (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next) : Record A :=
 ⟨next,record.conditions,record.anchor,record.calibration,.next record.chain link⟩

theorem successorConditionsHeld (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next) :
 (extend record next link).conditions=record.conditions := rfl

theorem successorRecordsHeld (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next) (prior : TraceabilityChain.Record A)
 (held : prior∈TraceabilityChain.records record.chain) :
 prior∈TraceabilityChain.records (extend record next link).chain :=
 TraceabilityChain.allPriorRecordsRetained record.chain link prior held

theorem successorCertificatesHeld (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next) (prior : TraceabilityChain.Certificate A)
 (held : prior∈TraceabilityChain.certificates record.chain) :
 prior∈TraceabilityChain.certificates (extend record next link).chain :=
 TraceabilityChain.allPriorCertificatesRetained record.chain link prior held

theorem uncertaintyExactlyBound (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next) :
 link.certificate.subject.uncertainty=next.uncertainty := TraceabilityChain.uncertaintyBound link

theorem specimenExactlyBound (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next) :
 link.certificate.subject.sampleIdentity=next.sampleIdentity := (TraceabilityChain.materialBound link).2

theorem brokenChainExcluded (record : Record A) (next : TraceabilityChain.Record A)
 (link : TraceabilityChain.Link record.calibration record.result next)
 (broken : link.certificate.predecessor≠some record.result) : False :=
 TraceabilityChain.brokenPredecessorRejected link broken
end SFT.Materials.Traceability
