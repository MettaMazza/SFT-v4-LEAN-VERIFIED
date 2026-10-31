import SFT.Physics.SpacetimeLengthRelation
namespace SFT.Physics.GravityEquivalence

-- EQUIVALENCE compares local complete event traces. A constituent label
-- cannot change the free causal path class under universal response.
structure UniversalFreeResponse (Constituent Trace : Type) where
 common : Trace
 gravitational : Constituent → Trace
 referenceChange : Constituent → Trace
 gravityUniversal : ∀ c, gravitational c = common
 referenceUniversal : ∀ c, referenceChange c = common

variable {Constituent Trace Result : Type}

theorem completeTraceEquivalence (response : UniversalFreeResponse Constituent Trace) (c : Constituent) :
 response.gravitational c=response.referenceChange c :=
 (response.gravityUniversal c).trans (response.referenceUniversal c).symm

theorem everyLocalReadoutAgrees (response : UniversalFreeResponse Constituent Trace)
 (readout : Trace → Result) (c : Constituent) :
 readout (response.gravitational c)=readout (response.referenceChange c) :=
 congrArg readout (completeTraceEquivalence response c)

theorem constituentLabelCannotDistinguish (response : UniversalFreeResponse Constituent Trace)
 (readout : Trace → Result) (a b : Constituent) :
 readout (response.gravitational a)=readout (response.referenceChange b) :=
 congrArg readout ((response.gravityUniversal a).trans (response.referenceUniversal b).symm)

def fromCommonPath (path : Trace) : UniversalFreeResponse Constituent Trace :=
 ⟨path,fun _ => path,fun _ => path,fun _ => rfl,fun _ => rfl⟩

theorem freeResponseConstructed (path : Trace) (c : Constituent) :
 (fromCommonPath path : UniversalFreeResponse Constituent Trace).gravitational c=path := rfl

theorem changedReadoutExcludesUniversalEquivalence
 (g r : Constituent → Trace) (readout : Trace → Result) (c : Constituent)
 (different : readout (g c) ≠ readout (r c)) :
 ¬ ∃ response : UniversalFreeResponse Constituent Trace,
    response.gravitational c=g c ∧ response.referenceChange c=r c := by
 intro ⟨response,hg,hr⟩
 have h := everyLocalReadoutAgrees response readout c
 rw [hg,hr] at h
 exact different h

-- Append the same generated successor to every complete trace. Universal
-- response and local equivalence persist for every finite number of steps.
def successor (step : Trace → Trace) (r : UniversalFreeResponse Constituent Trace) :
 UniversalFreeResponse Constituent Trace :=
 ⟨step r.common,fun c => step (r.gravitational c),fun c => step (r.referenceChange c),
 fun c => congrArg step (r.gravityUniversal c),fun c => congrArg step (r.referenceUniversal c)⟩

def extend (step : Trace → Trace) : Nat → UniversalFreeResponse Constituent Trace → UniversalFreeResponse Constituent Trace
 | 0,r => r
 | n+1,r => successor step (extend step n r)

theorem everyFiniteExtension (step : Trace → Trace) (n : Nat)
 (r : UniversalFreeResponse Constituent Trace) (c : Constituent) :
 (extend step n r).gravitational c=(extend step n r).referenceChange c :=
 completeTraceEquivalence _ c
end SFT.Physics.GravityEquivalence
