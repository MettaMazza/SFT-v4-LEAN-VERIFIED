import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ElectronCountSpinGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Nuclear_support where
  | rejected | admitted

def nuclear_supportName : Nuclear_support → String
  | .rejected => "formula-name-only"
  | .admitted => "atomic-number-occurrence-support"

inductive Charge where
  | rejected | admitted

def chargeName : Charge → String
  | .rejected => "signed-charge-scalar"
  | .admitted => "held-directed-electron-transfer"

inductive Electron_count where
  | rejected | admitted

def electron_countName : Electron_count → String
  | .rejected => "asserted-electron-number"
  | .admitted => "complete-electron-occurrence-census"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "signed-spin-magnitude"
  | .admitted => "two-held-spin-fibres"

inductive Occupation where
  | rejected | admitted

def occupationName : Occupation → String
  | .rejected => "same-fibre-cell-duplication"
  | .admitted => "complementary-cell-occupation"

inductive Decomposition where
  | rejected | admitted

def decompositionName : Decomposition → String
  | .rejected => "unstructured-spin-list"
  | .admitted => "complete-pairs-plus-held-surplus"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "state-width-detached-from-support"
  | .admitted => "support-compatible-spin-width"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-specific-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  nuclear_support : Nuclear_support
  charge : Charge
  electron_count : Electron_count
  spin : Spin
  occupation : Occupation
  decomposition : Decomposition
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [nuclear_supportName c.nuclear_support, chargeName c.charge, electron_countName c.electron_count, spinName c.spin, occupationName c.occupation, decompositionName c.decomposition, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "nuclear_support=" (nuclear_supportName c.nuclear_support), SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "electron_count=" (electron_countName c.electron_count), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "occupation=" (occupationName c.occupation), SFT.Host.Text.append "decomposition=" (decompositionName c.decomposition), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "atomic-number-occurrence-support__held-directed-electron-transfer__complete-electron-occurrence-census__two-held-spin-fibres__complementary-cell-occupation__complete-pairs-plus-held-surplus__support-compatible-spin-width__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (nuclear_supportName c.nuclear_support) "atomic-number-occurrence-support" &&
  SFT.Host.Text.equal (chargeName c.charge) "held-directed-electron-transfer" &&
  SFT.Host.Text.equal (electron_countName c.electron_count) "complete-electron-occurrence-census" &&
  SFT.Host.Text.equal (spinName c.spin) "two-held-spin-fibres" &&
  SFT.Host.Text.equal (occupationName c.occupation) "complementary-cell-occupation" &&
  SFT.Host.Text.equal (decompositionName c.decomposition) "complete-pairs-plus-held-surplus" &&
  SFT.Host.Text.equal (observationName c.observation) "support-compatible-spin-width" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (nuclear_supportName c.nuclear_support) "atomic-number-occurrence-support") then "A formula name does not enumerate the positive nuclear support that forces electron count." else
  if !(SFT.Host.Text.equal (chargeName c.charge) "held-directed-electron-transfer") then "A signed scalar imports negative quantity and conflates direction with magnitude." else
  if !(SFT.Host.Text.equal (electron_countName c.electron_count) "complete-electron-occurrence-census") then "An asserted number is neither generated nor reconstructible." else
  if !(SFT.Host.Text.equal (spinName c.spin) "two-held-spin-fibres") then "A signed magnitude imports a forbidden negative coordinate and loses fibre identity." else
  if !(SFT.Host.Text.equal (occupationName c.occupation) "complementary-cell-occupation") then "Doubled same-fibre occupation violates admitted indistinguishability and exclusion." else
  if !(SFT.Host.Text.equal (decompositionName c.decomposition) "complete-pairs-plus-held-surplus") then "An unstructured list cannot reconstruct pairs, surplus or width." else
  if !(SFT.Host.Text.equal (observationName c.observation) "support-compatible-spin-width") then "A detached multiplicity can contradict the complete electron support." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception or fitted table can select a measured state." else
  "atomic-number-occurrence-support__held-directed-electron-transfer__complete-electron-occurrence-census__two-held-spin-fibres__complementary-cell-occupation__complete-pairs-plus-held-surplus__support-compatible-spin-width__no-extra-rule"

def generationRule : String := "Generate the literal Cartesian product of nuclear support, charge representation, electron census, spin carrier, cell occupation, pair/surplus decomposition, observable width and extension choices. Decide every one of the 256 forms solely by preservation of admitted exact arithmetic, atomic-number, ion, spin, indistinguishability, exclusion, information and molecular-state laws."
def grammarBoundary : String := "Every positive finite molecular multiset of admitted atomic-number occurrences, structural empty-One or a positive held electron-transfer count that leaves positive support, and every positive spin width. Closure is depth-independent: adjoining one nucleus, electron occurrence, complementary pair or unmatched fibre repeats the same local census, two-fibre, exclusion and complete-support checks."

def candidates : List Candidate :=
  ([Nuclear_support.rejected,Nuclear_support.admitted]).flatMap fun nuclear_support =>
  ([Charge.rejected,Charge.admitted]).flatMap fun charge =>
  ([Electron_count.rejected,Electron_count.admitted]).flatMap fun electron_count =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Occupation.rejected,Occupation.admitted]).flatMap fun occupation =>
  ([Decomposition.rejected,Decomposition.admitted]).flatMap fun decomposition =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨nuclear_support,charge,electron_count,spin,occupation,decomposition,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk nuclear_support charge electron_count spin occupation decomposition observation extension =>
    have hnuclear_support : nuclear_support ∈ [Nuclear_support.rejected,Nuclear_support.admitted] := by
      cases nuclear_support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharge : charge ∈ [Charge.rejected,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectron_count : electron_count ∈ [Electron_count.rejected,Electron_count.admitted] := by
      cases electron_count <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccupation : occupation ∈ [Occupation.rejected,Occupation.admitted] := by
      cases occupation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecomposition : decomposition ∈ [Decomposition.rejected,Decomposition.admitted] := by
      cases decomposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ nuclear_support _ hnuclear_support
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ electron_count _ helectron_count
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ occupation _ hoccupation
    apply CommonRefinement.memFlatMap _ _ decomposition _ hdecomposition
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk nuclear_support charge electron_count spin occupation decomposition observation extension =>
    cases nuclear_support <;> cases charge <;> cases electron_count <;> cases spin <;> cases occupation <;> cases decomposition <;> cases observation <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk nuclear_support charge electron_count spin occupation decomposition observation extension =>
    cases nuclear_support <;> cases charge <;> cases electron_count <;> cases spin <;> cases occupation <;> cases decomposition <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.nuclear_support = .admitted ∧ c.charge = .admitted ∧ c.electron_count = .admitted ∧ c.spin = .admitted ∧ c.occupation = .admitted ∧ c.decomposition = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk nuclear_support charge electron_count spin occupation decomposition observation extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem nuclear_support_rejected_rejected (c : Candidate) (h : c.nuclear_support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.nuclear_support eq
    rw [h] at field
    cases field

theorem charge_rejected_rejected (c : Candidate) (h : c.charge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.charge eq
    rw [h] at field
    cases field

theorem electron_count_rejected_rejected (c : Candidate) (h : c.electron_count = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electron_count eq
    rw [h] at field
    cases field

theorem spin_rejected_rejected (c : Candidate) (h : c.spin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spin eq
    rw [h] at field
    cases field

theorem occupation_rejected_rejected (c : Candidate) (h : c.occupation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupation eq
    rw [h] at field
    cases field

theorem decomposition_rejected_rejected (c : Candidate) (h : c.decomposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decomposition eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Chemistry.ElectronCountSpinGrammar
