import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HadronReggeEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-hadron-predecessors"
  | .admitted => "compose-immutable-hadron-predecessors"

inductive Flavour where
  | rejected | admitted

def flavourName : Flavour → String
  | .rejected => "import-named-flavour-table"
  | .admitted => "complete-generator-three-flavour-support"

inductive Meson where
  | rejected | admitted

def mesonName : Meson → String
  | .rejected => "assert-nonet"
  | .admitted => "enumerate-three-by-three-ordered-pairs"

inductive MesonPartition where
  | rejected | admitted

def mesonPartitionName : MesonPartition → String
  | .rejected => "import-octet-singlet-representation"
  | .admitted => "one-invariant-and-positive-predecessor"

inductive Baryon where
  | rejected | admitted

def baryonName : Baryon → String
  | .rejected => "assert-octet-and-decuplet"
  | .admitted => "enumerate-three-place-flavour-words"

inductive Exchange where
  | rejected | admitted

def exchangeName : Exchange → String
  | .rejected => "import-SU-three-decomposition"
  | .admitted => "enumerate-exchange-symmetry-classes"

inductive Tube where
  | rejected | admitted

def tubeName : Tube → String
  | .rejected => "chosen-spin-dependent-increment"
  | .admitted => "one-retained-step-per-spin-successor"

inductive Regge where
  | rejected | admitted

def ReggeName : Regge → String
  | .rejected => "fitted-mass-polynomial"
  | .admitted => "depth-independent-affine-successor"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-residual-or-tension-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  flavour : Flavour
  meson : Meson
  mesonPartition : MesonPartition
  baryon : Baryon
  exchange : Exchange
  tube : Tube
  Regge : Regge
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, flavourName c.flavour, mesonName c.meson, mesonPartitionName c.mesonPartition, baryonName c.baryon, exchangeName c.exchange, tubeName c.tube, ReggeName c.Regge, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "flavour=" (flavourName c.flavour), SFT.Host.Text.append "meson=" (mesonName c.meson), SFT.Host.Text.append "meson-partition=" (mesonPartitionName c.mesonPartition), SFT.Host.Text.append "baryon=" (baryonName c.baryon), SFT.Host.Text.append "exchange=" (exchangeName c.exchange), SFT.Host.Text.append "tube=" (tubeName c.tube), SFT.Host.Text.append "Regge=" (ReggeName c.Regge), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-hadron-predecessors__complete-generator-three-flavour-support__enumerate-three-by-three-ordered-pairs__one-invariant-and-positive-predecessor__enumerate-three-place-flavour-words__enumerate-exchange-symmetry-classes__one-retained-step-per-spin-successor__depth-independent-affine-successor__target-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-hadron-predecessors" &&
  SFT.Host.Text.equal (flavourName c.flavour) "complete-generator-three-flavour-support" &&
  SFT.Host.Text.equal (mesonName c.meson) "enumerate-three-by-three-ordered-pairs" &&
  SFT.Host.Text.equal (mesonPartitionName c.mesonPartition) "one-invariant-and-positive-predecessor" &&
  SFT.Host.Text.equal (baryonName c.baryon) "enumerate-three-place-flavour-words" &&
  SFT.Host.Text.equal (exchangeName c.exchange) "enumerate-exchange-symmetry-classes" &&
  SFT.Host.Text.equal (tubeName c.tube) "one-retained-step-per-spin-successor" &&
  SFT.Host.Text.equal (ReggeName c.Regge) "depth-independent-affine-successor" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "rewrite-hadron-predecessors" then "A successor cannot alter admitted receipts." else
  if SFT.Host.Text.equal (flavourName c.flavour) "import-named-flavour-table" then "Names do not generate a support." else
  if SFT.Host.Text.equal (mesonName c.meson) "assert-nonet" then "A conventional name does not prove its size." else
  if SFT.Host.Text.equal (mesonPartitionName c.mesonPartition) "import-octet-singlet-representation" then "An imported representation would select the answer." else
  if SFT.Host.Text.equal (baryonName c.baryon) "assert-octet-and-decuplet" then "Named multiplets are not a derivation." else
  if SFT.Host.Text.equal (exchangeName c.exchange) "import-SU-three-decomposition" then "A conventional group decomposition cannot be a premise." else
  if SFT.Host.Text.equal (tubeName c.tube) "chosen-spin-dependent-increment" then "A different free increment at each rank destroys structural closure." else
  if SFT.Host.Text.equal (ReggeName c.Regge) "fitted-mass-polynomial" then "A fitted polynomial is not forced." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target access cannot seal a prediction." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-residual-or-tension-fit" then "An ungenerated correction would be a parameter." else
  "Light mesons have exact flavour support 9=8+1; light three-place baryons have exact support 27=10+8+8+1; normalized fixed-tube squared support is Q(J)=J and every positive successor difference is exactly One."

def generationRule : String := "Generate the complete ten-axis predecessor, flavour, meson, partition, baryon, exchange, tube, affine-support, custody and extension product."
def grammarBoundary : String := "Every ordered word over the complete generated three-member light-flavour support at widths two and three, every permutation-exchange class, and every positive rank produced by repeated application of one held fixed-tube successor act."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Flavour.rejected,Flavour.admitted]).flatMap fun flavour =>
  ([Meson.rejected,Meson.admitted]).flatMap fun meson =>
  ([MesonPartition.rejected,MesonPartition.admitted]).flatMap fun mesonPartition =>
  ([Baryon.rejected,Baryon.admitted]).flatMap fun baryon =>
  ([Exchange.rejected,Exchange.admitted]).flatMap fun exchange =>
  ([Tube.rejected,Tube.admitted]).flatMap fun tube =>
  ([Regge.rejected,Regge.admitted]).flatMap fun Regge =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,flavour,meson,mesonPartition,baryon,exchange,tube,Regge,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor flavour meson mesonPartition baryon exchange tube Regge target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hflavour : flavour ∈ [Flavour.rejected,Flavour.admitted] := by
      cases flavour <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeson : meson ∈ [Meson.rejected,Meson.admitted] := by
      cases meson <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmesonPartition : mesonPartition ∈ [MesonPartition.rejected,MesonPartition.admitted] := by
      cases mesonPartition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaryon : baryon ∈ [Baryon.rejected,Baryon.admitted] := by
      cases baryon <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexchange : exchange ∈ [Exchange.rejected,Exchange.admitted] := by
      cases exchange <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htube : tube ∈ [Tube.rejected,Tube.admitted] := by
      cases tube <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hRegge : Regge ∈ [.rejected,.admitted] := by
      cases Regge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ flavour _ hflavour
    apply CommonRefinement.memFlatMap _ _ meson _ hmeson
    apply CommonRefinement.memFlatMap _ _ mesonPartition _ hmesonPartition
    apply CommonRefinement.memFlatMap _ _ baryon _ hbaryon
    apply CommonRefinement.memFlatMap _ _ exchange _ hexchange
    apply CommonRefinement.memFlatMap _ _ tube _ htube
    apply CommonRefinement.memFlatMap _ _ Regge _ hRegge
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor flavour meson mesonPartition baryon exchange tube Regge target extension =>
    cases predecessor <;> cases flavour <;> cases meson <;> cases mesonPartition <;> cases baryon <;> cases exchange <;> cases tube <;> cases Regge <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor flavour meson mesonPartition baryon exchange tube Regge target extension =>
    cases predecessor <;> cases flavour <;> cases meson <;> cases mesonPartition <;> cases baryon <;> cases exchange <;> cases tube <;> cases Regge <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.flavour = .admitted ∧ c.meson = .admitted ∧ c.mesonPartition = .admitted ∧ c.baryon = .admitted ∧ c.exchange = .admitted ∧ c.tube = .admitted ∧ c.Regge = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor flavour meson mesonPartition baryon exchange tube Regge target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem flavour_rejected_rejected (c : Candidate) (h : c.flavour = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.flavour eq
    rw [h] at field
    cases field

theorem meson_rejected_rejected (c : Candidate) (h : c.meson = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.meson eq
    rw [h] at field
    cases field

theorem mesonPartition_rejected_rejected (c : Candidate) (h : c.mesonPartition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mesonPartition eq
    rw [h] at field
    cases field

theorem baryon_rejected_rejected (c : Candidate) (h : c.baryon = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baryon eq
    rw [h] at field
    cases field

theorem exchange_rejected_rejected (c : Candidate) (h : c.exchange = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exchange eq
    rw [h] at field
    cases field

theorem tube_rejected_rejected (c : Candidate) (h : c.tube = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tube eq
    rw [h] at field
    cases field

theorem Regge_rejected_rejected (c : Candidate) (h : c.Regge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.Regge eq
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

end SFT.Physics.HadronReggeEntryGrammar
