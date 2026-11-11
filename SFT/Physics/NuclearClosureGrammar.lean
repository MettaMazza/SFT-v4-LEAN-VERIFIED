import SFT.Physics.NuclearClosure
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.NuclearClosureGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "selected-shell-degeneracy"
  | .admitted => "complete-three-direction-weak-compositions"

inductive Labels where
  | rejected | admitted

def labelsName : Labels → String
  | .rejected => "single-or-duplicated-label"
  | .admitted => "two-exclusion-distinct-labels"

inductive Base where
  | rejected | admitted

def baseName : Base → String
  | .rejected => "closure-list"
  | .admitted => "positive-rank-composition-form"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "fitted-spin-orbit-strength"
  | .admitted => "sealed-two-thirds-colour-coupling"

inductive Shift where
  | rejected | admitted

def shiftName : Shift → String
  | .rejected => "free-shell-shift"
  | .admitted => "top-angular-half-label-pair"

inductive Threshold where
  | rejected | admitted

def thresholdName : Threshold → String
  | .rejected => "selected-rank-threshold"
  | .admitted => "least-positive-whole-gap"

inductive Reorder where
  | rejected | admitted

def reorderName : Reorder → String
  | .rejected => "arbitrary-intruder-count"
  | .admitted => "complete-top-orbit-capacity"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "finite-eight-value-table"
  | .admitted => "piecewise-positive-successor-law"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "magic-numbers-visible"
  | .admitted => "sequence-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-nuclear-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  composition : Composition
  labels : Labels
  base : Base
  coupling : Coupling
  shift : Shift
  threshold : Threshold
  reorder : Reorder
  recurrence : Recurrence
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [compositionName c.composition, labelsName c.labels, baseName c.base, couplingName c.coupling, shiftName c.shift, thresholdName c.threshold, reorderName c.reorder, recurrenceName c.recurrence, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "labels=" (labelsName c.labels), SFT.Host.Text.append "base=" (baseName c.base), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "shift=" (shiftName c.shift), SFT.Host.Text.append "threshold=" (thresholdName c.threshold), SFT.Host.Text.append "reorder=" (reorderName c.reorder), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-three-direction-weak-compositions__two-exclusion-distinct-labels__positive-rank-composition-form__sealed-two-thirds-colour-coupling__top-angular-half-label-pair__least-positive-whole-gap__complete-top-orbit-capacity__piecewise-positive-successor-law__sequence-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (compositionName c.composition) "complete-three-direction-weak-compositions" &&
  SFT.Host.Text.equal (labelsName c.labels) "two-exclusion-distinct-labels" &&
  SFT.Host.Text.equal (baseName c.base) "positive-rank-composition-form" &&
  SFT.Host.Text.equal (couplingName c.coupling) "sealed-two-thirds-colour-coupling" &&
  SFT.Host.Text.equal (shiftName c.shift) "top-angular-half-label-pair" &&
  SFT.Host.Text.equal (thresholdName c.threshold) "least-positive-whole-gap" &&
  SFT.Host.Text.equal (reorderName c.reorder) "complete-top-orbit-capacity" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "piecewise-positive-successor-law" &&
  SFT.Host.Text.equal (targetName c.target) "sequence-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (compositionName c.composition) "selected-shell-degeneracy" then "A selected degeneracy imports a model." else
  if SFT.Host.Text.equal (labelsName c.labels) "single-or-duplicated-label" then "Omission or duplication violates Fold support and exclusion." else
  if SFT.Host.Text.equal (baseName c.base) "closure-list" then "A list has no generative proof." else
  if SFT.Host.Text.equal (couplingName c.coupling) "fitted-spin-orbit-strength" then "A fitted strength reads the closures." else
  if SFT.Host.Text.equal (shiftName c.shift) "free-shell-shift" then "A free shift is a parameter." else
  if SFT.Host.Text.equal (thresholdName c.threshold) "selected-rank-threshold" then "A selected threshold fits the sequence." else
  if SFT.Host.Text.equal (reorderName c.reorder) "arbitrary-intruder-count" then "An arbitrary intruder count is fitted." else
  if SFT.Host.Text.equal (recurrenceName c.recurrence) "finite-eight-value-table" then "A table does not close later ranks." else
  if SFT.Host.Text.equal (targetName c.target) "magic-numbers-visible" then "That is target leakage." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-nuclear-rule" then "An added selector is a parameter." else
  "The depth-independent nuclear closure law gives the exact prefix 2, 8, 20, 28, 50, 82, 126, 184; its next proton closure after 82 is 126 and the next closure after 126 is 184."

def generationRule : String := "Generate the complete product of spatial composition, label multiplicity, base closure, coupling source, shift, threshold, reordering, recurrence, target custody and extension forms."
def grammarBoundary : String := "All filled-shell closure schedules built from complete weak compositions over forced three-space, both exclusion labels and the first whole-gap action of the independently forced colour coupling."

def candidates : List Candidate :=
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Labels.rejected,Labels.admitted]).flatMap fun labels =>
  ([Base.rejected,Base.admitted]).flatMap fun base =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Shift.rejected,Shift.admitted]).flatMap fun shift =>
  ([Threshold.rejected,Threshold.admitted]).flatMap fun threshold =>
  ([Reorder.rejected,Reorder.admitted]).flatMap fun reorder =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨composition,labels,base,coupling,shift,threshold,reorder,recurrence,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk composition labels base coupling shift threshold reorder recurrence target extension =>
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlabels : labels ∈ [Labels.rejected,Labels.admitted] := by
      cases labels <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbase : base ∈ [Base.rejected,Base.admitted] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hshift : shift ∈ [Shift.rejected,Shift.admitted] := by
      cases shift <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthreshold : threshold ∈ [Threshold.rejected,Threshold.admitted] := by
      cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreorder : reorder ∈ [Reorder.rejected,Reorder.admitted] := by
      cases reorder <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ labels _ hlabels
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ shift _ hshift
    apply CommonRefinement.memFlatMap _ _ threshold _ hthreshold
    apply CommonRefinement.memFlatMap _ _ reorder _ hreorder
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk composition labels base coupling shift threshold reorder recurrence target extension =>
    cases composition <;> cases labels <;> cases base <;> cases coupling <;> cases shift <;> cases threshold <;> cases reorder <;> cases recurrence <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk composition labels base coupling shift threshold reorder recurrence target extension =>
    cases composition <;> cases labels <;> cases base <;> cases coupling <;> cases shift <;> cases threshold <;> cases reorder <;> cases recurrence <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.composition = .admitted ∧ c.labels = .admitted ∧ c.base = .admitted ∧ c.coupling = .admitted ∧ c.shift = .admitted ∧ c.threshold = .admitted ∧ c.reorder = .admitted ∧ c.recurrence = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk composition labels base coupling shift threshold reorder recurrence target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem labels_rejected_rejected (c : Candidate) (h : c.labels = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.labels eq
    rw [h] at field
    cases field

theorem base_rejected_rejected (c : Candidate) (h : c.base = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
    rw [h] at field
    cases field

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
    rw [h] at field
    cases field

theorem shift_rejected_rejected (c : Candidate) (h : c.shift = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.shift eq
    rw [h] at field
    cases field

theorem threshold_rejected_rejected (c : Candidate) (h : c.threshold = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.threshold eq
    rw [h] at field
    cases field

theorem reorder_rejected_rejected (c : Candidate) (h : c.reorder = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reorder eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.NuclearClosureGrammar
