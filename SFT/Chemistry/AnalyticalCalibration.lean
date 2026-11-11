import SFT.Chemistry.TraceabilityChain
import SFT.Chemistry.AnalyticalSample
namespace SFT.Chemistry.AnalyticalCalibration
open SFT.Foundation.Count.TraceDerivation

-- Response is the declared observation organisation, shared by every row
-- and the sample. It is not a fitted transfer function.
structure ReferenceRow (Alternative Response : Type) where
 input : TraceabilityChain.Record Alternative
 anchor : TraceabilityChain.Anchor Alternative
 registry : List (TraceabilityChain.Certificate Alternative)
 trace : TraceabilityChain.Chain anchor registry input
 response : Response
 responseUncertainty : UncertaintyRecord.Record Alternative
 responseSource : SFT.Host.Canonical.Value

structure SampleResponse (Alternative Response : Type) where
 portion : AnalyticalSample.Portion
 response : Response
 uncertainty : UncertaintyRecord.Record Alternative
 source : SFT.Host.Canonical.Value

structure Map (Alternative Response : Type) where
 references : List (ReferenceRow Alternative Response)
 sample : SampleResponse Alternative Response
 organization : SFT.Physics.CapabilityValues.HeldLabel
 method : SFT.Host.Canonical.Value
 domain : SFT.Host.Canonical.Value

structure Comparison (Alternative Response : Type) where
 reference : ReferenceRow Alternative Response
 sample : SampleResponse Alternative Response
 organization : SFT.Physics.CapabilityValues.HeldLabel
 method : SFT.Host.Canonical.Value
 domain : SFT.Host.Canonical.Value

def compare {A R : Type} (map : Map A R) (row : ReferenceRow A R) : Comparison A R :=
 ⟨row,map.sample,map.organization,map.method,map.domain⟩

def comparisons {A R : Type} (map : Map A R) := map.references.map (compare map)

def base {A R : Type} (row : ReferenceRow A R) (sample : SampleResponse A R)
 (organization : SFT.Physics.CapabilityValues.HeldLabel) (method domain : SFT.Host.Canonical.Value) : Map A R :=
 ⟨[row],sample,organization,method,domain⟩

def append {A R : Type} (map : Map A R) (row : ReferenceRow A R) : Map A R :=
 {map with references:=map.references++[row]}

theorem completeComparison {A R : Type} (map : Map A R) (row : ReferenceRow A R)
 (held : row∈map.references) : compare map row∈comparisons map := memMap _ _ _ held

theorem noInventedComparison {A R : Type} (map : Map A R) (comparison : Comparison A R)
 (held : comparison∈comparisons map) : ∃ row∈map.references, compare map row=comparison :=
 memMapPreimage _ _ _ held

theorem comparisonInputBound {A R : Type} (map : Map A R) (row : ReferenceRow A R) :
 (compare map row).reference.input=row.input ∧ (compare map row).reference.response=row.response := ⟨rfl,rfl⟩

theorem sampleResponseBound {A R : Type} (map : Map A R) (row : ReferenceRow A R) :
 (compare map row).sample=map.sample := rfl

theorem allComparisonsShareOrganization {A R : Type} (map : Map A R) (comparison : Comparison A R)
 (held : comparison∈comparisons map) : comparison.organization=map.organization ∧
 comparison.method=map.method ∧ comparison.domain=map.domain := by
 obtain ⟨row,member,equal⟩ := noInventedComparison map comparison held
 cases equal
 exact ⟨rfl,rfl,rfl⟩

theorem traceabilityRetainsInput {A R : Type} (row : ReferenceRow A R) :
 row.input.propertyIdentity=row.anchor.record.propertyIdentity := TraceabilityChain.propertyPreserved row.trace

theorem allReferenceCertificatesHeld {A R : Type} (row : ReferenceRow A R)
 (certificate : TraceabilityChain.Certificate A) (held : certificate∈TraceabilityChain.certificates row.trace) :
 certificate=row.anchor.certificate ∨ certificate∈row.registry :=
 TraceabilityChain.everyCertificateRegistered row.trace certificate held

theorem completeReferenceChain {A R : Type} (row : ReferenceRow A R) :
 (TraceabilityChain.certificates row.trace).map TraceabilityChain.Certificate.subject=
 TraceabilityChain.records row.trace := TraceabilityChain.completeCertificateBinding row.trace

theorem referenceRealizationHeld {A R : Type} (row : ReferenceRow A R) :
 SFT.Physics.ReferenceRealization.trace row.anchor.realization≠[] :=
 TraceabilityChain.admittedReferenceTrace row.anchor

theorem comparisonUncertaintyRetained {A R : Type} (map : Map A R) (row : ReferenceRow A R) :
 (compare map row).reference.input.uncertainty=row.input.uncertainty ∧
 (compare map row).reference.responseUncertainty=row.responseUncertainty ∧
 (compare map row).sample.uncertainty=map.sample.uncertainty := ⟨rfl,rfl,rfl⟩

theorem admissibleReferenceAlternativesRetained {A R : Type} (map : Map A R) (row : ReferenceRow A R)
 (decision : SFT.Physics.MeasurementUncertainty.Decision A)
 (held : decision∈row.responseUncertainty.decisions) (compatible : decision.stillAdmissible=true) :
 decision∈UncertaintyRecord.alternatives (compare map row).reference.responseUncertainty :=
 UncertaintyRecord.allCompatibleRetained row.responseUncertainty decision held compatible

theorem admissibleSampleAlternativesRetained {A R : Type} (map : Map A R) (row : ReferenceRow A R)
 (decision : SFT.Physics.MeasurementUncertainty.Decision A)
 (held : decision∈map.sample.uncertainty.decisions) (compatible : decision.stillAdmissible=true) :
 decision∈UncertaintyRecord.alternatives (compare map row).sample.uncertainty :=
 UncertaintyRecord.allCompatibleRetained map.sample.uncertainty decision held compatible

theorem appendComparisonUnchanged {A R : Type} (map : Map A R) (new old : ReferenceRow A R) :
 compare (append map new) old=compare map old := rfl

theorem appendComparisonOrder {A R : Type} (map : Map A R) (row : ReferenceRow A R) :
 comparisons (append map row)=comparisons map++[compare map row] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (compare map) map.references [row]

theorem allPriorComparisonsRetained {A R : Type} (map : Map A R) (row : ReferenceRow A R)
 (old : Comparison A R) (held : old∈comparisons map) : old∈comparisons (append map row) := by
 rw [appendComparisonOrder]
 exact memAppendLeft _ _ _ held

theorem comparisonCount {A R : Type} (map : Map A R) :
 (comparisons map).length=map.references.length := SFT.Foundation.CommonRefinement.mapLength _ _

theorem baseOneComparison {A R : Type} (row : ReferenceRow A R) (sample : SampleResponse A R)
 (organization : SFT.Physics.CapabilityValues.HeldLabel) (method domain : SFT.Host.Canonical.Value) :
 (comparisons (base row sample organization method domain)).length=1 := rfl

theorem declaredBoundaryRetained {A R : Type} (map : Map A R) (row : ReferenceRow A R) :
 (append map row).sample=map.sample ∧ (append map row).organization=map.organization ∧
 (append map row).method=map.method ∧ (append map row).domain=map.domain := ⟨rfl,rfl,rfl,rfl⟩


def domainSupport {A R : Type} (map : Map A R) :=
 map.references.map (fun row => (row.input.value,row.response))

theorem everyReferenceInSupport {A R : Type} (map : Map A R) (row : ReferenceRow A R)
 (held : row∈map.references) : (row.input.value,row.response)∈domainSupport map := memMap _ _ _ held

theorem supportNoInventedPair {A R : Type} (map : Map A R)
 (pair : SFT.Host.Canonical.Value × R) (held : pair∈domainSupport map) :
 ∃ row∈map.references, (row.input.value,row.response)=pair := memMapPreimage _ _ _ held

theorem supportExtension {A R : Type} (map : Map A R) (row : ReferenceRow A R) :
 domainSupport (append map row)=domainSupport map++[(row.input.value,row.response)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend
  (fun r : ReferenceRow A R => (r.input.value,r.response)) map.references [row]


-- The registered comparison uses this finite observed response support;
-- no extension to unobserved responses is asserted by the construction.
def observationSupport {A R : Type} (map : Map A R) : List R :=
 map.references.map ReferenceRow.response++[map.sample.response]

theorem sampleInsideSupport {A R : Type} (map : Map A R) :
 map.sample.response∈observationSupport map := memAppendRight _ _ _ (.head [])

theorem referenceInsideSupport {A R : Type} (map : Map A R) (row : ReferenceRow A R)
 (held : row∈map.references) : row.response∈observationSupport map :=
 memAppendLeft _ _ _ (memMap _ _ _ held)

theorem finiteSupportCount {A R : Type} (map : Map A R) :
 (observationSupport map).length=map.references.length+1 := by
 unfold observationSupport
 rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength]
 rfl

theorem supportContainsOnlyRecordedResponses {A R : Type} (map : Map A R) (response : R)
 (held : response∈observationSupport map) :
 (∃ row∈map.references, row.response=response) ∨ response=map.sample.response := by
 cases memAppendCases response _ _ held with
 | inl reference => exact .inl (memMapPreimage _ _ _ reference)
 | inr sample =>
   cases sample with
   | head => exact .inr rfl
   | tail _ impossible => cases impossible

end SFT.Chemistry.AnalyticalCalibration
