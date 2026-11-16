import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OrbitalSupportGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-orbital-name"
  | .admitted => "molecule-bound-support-cell"

inductive Joining where
  | rejected | admitted

def joiningName : Joining → String
  | .rejected => "unjoined-atomic-support-list"
  | .admitted => "two-held-joining-phases"

inductive Axis where
  | rejected | admitted

def axisName : Axis → String
  | .rejected => "continuum-angular-coordinate"
  | .admitted => "empty-One-or-positive-axis-recurrence"

inductive Symmetry where
  | rejected | admitted

def symmetryName : Symmetry → String
  | .rejected => "unsigned-erased-symmetry"
  | .admitted => "held-exchange-and-reflection-labels"

inductive Occupancy where
  | rejected | admitted

def occupancyName : Occupancy → String
  | .rejected => "signed-or-unbounded-occupation"
  | .admitted => "empty-One-single-or-complementary-pair"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "same-fibre-double-occupation"
  | .admitted => "complementary-spin-double-occupation"

inductive Completeness where
  | rejected | admitted

def completenessName : Completeness → String
  | .rejected => "selected-support-fragment"
  | .admitted => "complete-electron-support-partition"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-or-symbol-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  joining : Joining
  axis : Axis
  symmetry : Symmetry
  occupancy : Occupancy
  spin : Spin
  completeness : Completeness
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, joiningName c.joining, axisName c.axis, symmetryName c.symmetry, occupancyName c.occupancy, spinName c.spin, completenessName c.completeness, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "joining=" (joiningName c.joining), SFT.Host.Text.append "axis=" (axisName c.axis), SFT.Host.Text.append "symmetry=" (symmetryName c.symmetry), SFT.Host.Text.append "occupancy=" (occupancyName c.occupancy), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "completeness=" (completenessName c.completeness), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "molecule-bound-support-cell__two-held-joining-phases__empty-One-or-positive-axis-recurrence__held-exchange-and-reflection-labels__empty-One-single-or-complementary-pair__complementary-spin-double-occupation__complete-electron-support-partition__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "molecule-bound-support-cell" &&
  SFT.Host.Text.equal (joiningName c.joining) "two-held-joining-phases" &&
  SFT.Host.Text.equal (axisName c.axis) "empty-One-or-positive-axis-recurrence" &&
  SFT.Host.Text.equal (symmetryName c.symmetry) "held-exchange-and-reflection-labels" &&
  SFT.Host.Text.equal (occupancyName c.occupancy) "empty-One-single-or-complementary-pair" &&
  SFT.Host.Text.equal (spinName c.spin) "complementary-spin-double-occupation" &&
  SFT.Host.Text.equal (completenessName c.completeness) "complete-electron-support-partition" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "molecule-bound-support-cell") then "A free orbital name is detached from the molecule and its derivation." else
  if !(SFT.Host.Text.equal (joiningName c.joining) "two-held-joining-phases") then "An unjoined list cannot express the two generated molecular phase relations." else
  if !(SFT.Host.Text.equal (axisName c.axis) "empty-One-or-positive-axis-recurrence") then "A continuum angular coordinate imports an ungenerated state space." else
  if !(SFT.Host.Text.equal (symmetryName c.symmetry) "held-exchange-and-reflection-labels") then "Erasing exchange and reflection distinctions merges spectroscopically distinct support." else
  if !(SFT.Host.Text.equal (occupancyName c.occupancy) "empty-One-single-or-complementary-pair") then "Signed, numerical-zero or unbounded fermion occupation violates the exact domain and exclusion." else
  if !(SFT.Host.Text.equal (spinName c.spin) "complementary-spin-double-occupation") then "Same-fibre doubling has no distinct admissible preimage under exclusion." else
  if !(SFT.Host.Text.equal (completenessName c.completeness) "complete-electron-support-partition") then "A selected fragment cannot reconstruct the molecular electronic state or electron census." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A species lookup or conventional symbol exception lets the target select the law." else
  "molecule-bound-support-cell__two-held-joining-phases__empty-One-or-positive-axis-recurrence__held-exchange-and-reflection-labels__empty-One-single-or-complementary-pair__complementary-spin-double-occupation__complete-electron-support-partition__no-extra-rule"

def generationRule : String := "Generate the literal Cartesian product of carrier, joining, axis organization, held symmetry, occupancy, spin, completeness and extension forms. Decide all 256 forms only by admitted molecular composition, exact recurrence, two-fibre, spin, indistinguishability, exclusion, electron-count and information-retention laws."
def grammarBoundary : String := "Every positive finite molecular carrier; every positive radial recurrence; the structural axis-invariant boundary and every positive axis recurrence; both held joining phases; applicable held exchange/reflection labels; and every positive finite electron support. Closure is depth-independent because each newly generated cell and occurrence repeats the same coordinate-identity, occupancy, complementary-spin and complete-partition checks."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Joining.rejected,Joining.admitted]).flatMap fun joining =>
  ([Axis.rejected,Axis.admitted]).flatMap fun axis =>
  ([Symmetry.rejected,Symmetry.admitted]).flatMap fun symmetry =>
  ([Occupancy.rejected,Occupancy.admitted]).flatMap fun occupancy =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Completeness.rejected,Completeness.admitted]).flatMap fun completeness =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,joining,axis,symmetry,occupancy,spin,completeness,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier joining axis symmetry occupancy spin completeness extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoining : joining ∈ [Joining.rejected,Joining.admitted] := by
      cases joining <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haxis : axis ∈ [Axis.rejected,Axis.admitted] := by
      cases axis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsymmetry : symmetry ∈ [Symmetry.rejected,Symmetry.admitted] := by
      cases symmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccupancy : occupancy ∈ [Occupancy.rejected,Occupancy.admitted] := by
      cases occupancy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompleteness : completeness ∈ [Completeness.rejected,Completeness.admitted] := by
      cases completeness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ joining _ hjoining
    apply CommonRefinement.memFlatMap _ _ axis _ haxis
    apply CommonRefinement.memFlatMap _ _ symmetry _ hsymmetry
    apply CommonRefinement.memFlatMap _ _ occupancy _ hoccupancy
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ completeness _ hcompleteness
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier joining axis symmetry occupancy spin completeness extension =>
    cases carrier <;> cases joining <;> cases axis <;> cases symmetry <;> cases occupancy <;> cases spin <;> cases completeness <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier joining axis symmetry occupancy spin completeness extension =>
    cases carrier <;> cases joining <;> cases axis <;> cases symmetry <;> cases occupancy <;> cases spin <;> cases completeness <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.joining = .admitted ∧ c.axis = .admitted ∧ c.symmetry = .admitted ∧ c.occupancy = .admitted ∧ c.spin = .admitted ∧ c.completeness = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier joining axis symmetry occupancy spin completeness extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem joining_rejected_rejected (c : Candidate) (h : c.joining = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.joining eq
    rw [h] at field
    cases field

theorem axis_rejected_rejected (c : Candidate) (h : c.axis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.axis eq
    rw [h] at field
    cases field

theorem symmetry_rejected_rejected (c : Candidate) (h : c.symmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.symmetry eq
    rw [h] at field
    cases field

theorem occupancy_rejected_rejected (c : Candidate) (h : c.occupancy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupancy eq
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

theorem completeness_rejected_rejected (c : Candidate) (h : c.completeness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.completeness eq
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

end SFT.Chemistry.OrbitalSupportGrammar
