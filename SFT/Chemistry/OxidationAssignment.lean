import SFT.Chemistry.BondPolarity
import SFT.Chemistry.IonTransfer
namespace SFT.Chemistry.OxidationAssignment
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
structure Raw where
 atomIdentity : String
 carrierCount : PositiveCount
 orientation : HeldLabel
 assignmentTrace : List HeldLabel

def admit (r : Raw) : Except String Raw :=
 if !SourceText.nonblank r.atomIdentity ||
 !(SFT.Host.Text.equal r.orientation.family "oxidation-orientation") ||
 r.assignmentTrace.isEmpty ||
 !(r.assignmentTrace.all fun row => SFT.Host.Text.equal row.family "bond-electron-assignment") then
 .error "oxidation assignment requires positive support, orientation and a complete trace"
 else .ok r
structure Record where
 raw : Raw
 accepted : admit raw = .ok raw

def originalRaw : Raw := ⟨"atom-a",⟨1,by decide⟩,⟨"oxidation-orientation","assigned-away",rfl,rfl⟩,
 [⟨"bond-electron-assignment","bond-a-b-electron-one",rfl,rfl⟩]⟩
theorem originalAdmitted : admit originalRaw = .ok originalRaw := rfl
theorem magnitudePositive (r : Raw) : 0 < r.carrierCount.value := r.carrierCount.positive

-- The declared ionic approximation retains each covalent electron pair and
-- its endpoint order. That source order is retained for equal division.
structure Pair where
 bond : BondPolarity.Bond
 firstElectron : HeldLabel
 secondElectron : HeldLabel
 distinct : firstElectron ≠ secondElectron

structure Assigned where
 electron : HeldLabel
 bond : BondPolarity.Bond
 atom : String

def support (p : Pair) : List HeldLabel := [p.firstElectron,p.secondElectron]
def assign (p : Pair) : List Assigned :=
 if BondPolarity.unequal p.bond then
 [⟨p.firstElectron,p.bond,p.bond.record.raw.affinity.raw.preferredEndpoint⟩,
  ⟨p.secondElectron,p.bond,p.bond.record.raw.affinity.raw.preferredEndpoint⟩]
 else
 [⟨p.firstElectron,p.bond,p.bond.record.raw.affinity.raw.firstAtom⟩,
  ⟨p.secondElectron,p.bond,p.bond.record.raw.affinity.raw.secondAtom⟩]

theorem unequalBothPreferred (p : Pair) (h : BondPolarity.unequal p.bond) :
 (assign p).map Assigned.atom = [p.bond.record.raw.affinity.raw.preferredEndpoint,
 p.bond.record.raw.affinity.raw.preferredEndpoint] := by rw [assign,ite_eq_left h]; rfl

theorem tiedEqualDivision (p : Pair)
 (h : AffinityTraceBinding.sameTrace p.bond.comparison.first p.bond.comparison.second) :
 (assign p).map Assigned.atom = [p.bond.record.raw.affinity.raw.firstAtom,
 p.bond.record.raw.affinity.raw.secondAtom] := by
 rw [assign,ite_eq_right (fun different => different h)]; rfl

theorem pairSupportConserved (p : Pair) : (assign p).map Assigned.electron = support p := by
 unfold assign
 split <;> rfl

theorem exactlyTwoAssignments (p : Pair) : (assign p).length=2 := by
 unfold assign
 split <;> rfl

theorem bondRetained (p : Pair) : (assign p).map Assigned.bond = [p.bond,p.bond] := by
 unfold assign
 split <;> rfl

def completeSupport (pairs : List Pair) := pairs.flatMap support
def assignment (pairs : List Pair) := pairs.flatMap assign

theorem completeCarrierSequence (pairs : List Pair) :
 (assignment pairs).map Assigned.electron = completeSupport pairs := by
 induction pairs with
 | nil => rfl
 | cons p rest ih =>
  change ((assign p)++assignment rest).map Assigned.electron = support p++completeSupport rest
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,pairSupportConserved,ih]

theorem completeCountConserved (pairs : List Pair) :
 (assignment pairs).length = (completeSupport pairs).length := by
 have h := congrArg List.length (completeCarrierSequence pairs)
 rw [SFT.Foundation.CommonRefinement.mapLength] at h
 exact h

theorem eachSourceOccurrenceOnce (pairs : List Pair) (unique : (completeSupport pairs).Nodup) :
 ((assignment pairs).map Assigned.electron).Nodup := by
 rw [completeCarrierSequence]; exact unique

theorem base (p : Pair) : assignment [p] = assign p := by
 change assign p++[] = assign p
 unfold assign
 split <;> rfl

theorem successor (prior : List Pair) (next : Pair) :
 assignment (prior++[next]) = assignment prior++assign next := by
 induction prior with
 | nil => exact base next
 | cons p rest ih =>
  change assign p++assignment (rest++[next]) = (assign p++assignment rest)++assign next
  rw [ih]; exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem priorAssignmentsRetained (prior : List Pair) (next : Pair) (row : Assigned)
 (held : row ∈ assignment prior) : row ∈ assignment (prior++[next]) := by
 rw [successor]; exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

-- Per-atom charge accounting reuses the exact positive-magnitude/held-fibre
-- difference already derived for ions. Equal counts retain neutral support.
def perAtom (initial assigned : Nat) : IonTransfer.Net := IonTransfer.net ⟨initial,assigned⟩
theorem perAtomUsesExistingAccounting (initial assigned : Nat) :
 perAtom initial assigned = IonTransfer.net ⟨initial,assigned⟩ := rfl

theorem completeTraceReconstructsSupport (pairs : List Pair) (other : List HeldLabel)
 (same : (assignment pairs).map Assigned.electron=other) : completeSupport pairs=other :=
 (completeCarrierSequence pairs).symm.trans same
theorem assignedOnlyToBondEndpoints (p : Pair) (row : Assigned) (held : row ∈ assign p) :
 row.atom=p.bond.record.raw.affinity.raw.firstAtom ∨ row.atom=p.bond.record.raw.affinity.raw.secondAtom := by
 unfold assign at held
 split at held
 · cases held with
   | head => exact AffinityComparison.preferredIsEndpoint p.bond.record.raw.affinity
   | tail _ rest =>
     cases rest with
     | head => exact AffinityComparison.preferredIsEndpoint p.bond.record.raw.affinity
     | tail _ empty => cases empty
 · cases held with
   | head => exact .inl rfl
   | tail _ rest =>
     cases rest with
     | head => exact .inr rfl
     | tail _ empty => cases empty
end SFT.Chemistry.OxidationAssignment
