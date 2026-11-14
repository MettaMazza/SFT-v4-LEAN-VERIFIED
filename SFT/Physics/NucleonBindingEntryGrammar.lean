import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.NucleonBindingEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-predecessor-laws"
  | .admitted => "compose-immutable-predecessors"

inductive Colour where
  | rejected | admitted

def colourName : Colour → String
  | .rejected => "listed-three-colour-names"
  | .admitted => "complete-period-three-One-cycle"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "import-proton-neutron-labels"
  | .admitted => "enumerate-complete-three-flavour-charge-words"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "selected-binding-depth"
  | .admitted => "admitted-upper-quark-depth-seven"

inductive Ledger where
  | rejected | admitted

def ledgerName : Ledger → String
  | .rejected => "free-binding-percentage"
  | .admitted => "one-cell-and-complete-positive-predecessor"

inductive Binding where
  | rejected | admitted

def bindingName : Binding → String
  | .rejected => "qualitative-most-without-bound"
  | .admitted => "bare-below-one-percent-held-above-ninety-nine"

inductive Flavour where
  | rejected | admitted

def flavourName : Flavour → String
  | .rejected => "borrowed-quark-mass-order"
  | .admitted => "exact-light-root-enclosure-order"

inductive Electromagnetic where
  | rejected | admitted

def electromagneticName : Electromagnetic → String
  | .rejected => "ignore-or-fit-electromagnetic-effect"
  | .admitted => "compare-admitted-terminal-proton-dressing"

inductive Ordering where
  | rejected | admitted

def orderingName : Ordering → String
  | .rejected => "assert-measured-mass-order"
  | .admitted => "one-down-replacement-forces-neutron-heavier"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "conceal-observational-development"
  | .admitted => "registered-observational-prediction-protocol"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-mass-term-or-percentage"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  colour : Colour
  composition : Composition
  depth : Depth
  ledger : Ledger
  binding : Binding
  flavour : Flavour
  electromagnetic : Electromagnetic
  ordering : Ordering
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, colourName c.colour, compositionName c.composition, depthName c.depth, ledgerName c.ledger, bindingName c.binding, flavourName c.flavour, electromagneticName c.electromagnetic, orderingName c.ordering, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "colour=" (colourName c.colour), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "ledger=" (ledgerName c.ledger), SFT.Host.Text.append "binding=" (bindingName c.binding), SFT.Host.Text.append "flavour=" (flavourName c.flavour), SFT.Host.Text.append "electromagnetic=" (electromagneticName c.electromagnetic), SFT.Host.Text.append "ordering=" (orderingName c.ordering), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-predecessors__complete-period-three-One-cycle__enumerate-complete-three-flavour-charge-words__admitted-upper-quark-depth-seven__one-cell-and-complete-positive-predecessor__bare-below-one-percent-held-above-ninety-nine__exact-light-root-enclosure-order__compare-admitted-terminal-proton-dressing__one-down-replacement-forces-neutron-heavier__target-inaccessible-until-seal__registered-observational-prediction-protocol__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-predecessors" &&
  SFT.Host.Text.equal (colourName c.colour) "complete-period-three-One-cycle" &&
  SFT.Host.Text.equal (compositionName c.composition) "enumerate-complete-three-flavour-charge-words" &&
  SFT.Host.Text.equal (depthName c.depth) "admitted-upper-quark-depth-seven" &&
  SFT.Host.Text.equal (ledgerName c.ledger) "one-cell-and-complete-positive-predecessor" &&
  SFT.Host.Text.equal (bindingName c.binding) "bare-below-one-percent-held-above-ninety-nine" &&
  SFT.Host.Text.equal (flavourName c.flavour) "exact-light-root-enclosure-order" &&
  SFT.Host.Text.equal (electromagneticName c.electromagnetic) "compare-admitted-terminal-proton-dressing" &&
  SFT.Host.Text.equal (orderingName c.ordering) "one-down-replacement-forces-neutron-heavier" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "registered-observational-prediction-protocol" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "rewrite-predecessor-laws" then "A successor cannot alter admitted receipts." else
  if SFT.Host.Text.equal (colourName c.colour) "listed-three-colour-names" then "Names do not prove a closed orbit." else
  if SFT.Host.Text.equal (compositionName c.composition) "import-proton-neutron-labels" then "Imported particle labels would select the result." else
  if SFT.Host.Text.equal (depthName c.depth) "selected-binding-depth" then "A chosen depth can tune a mass share." else
  if SFT.Host.Text.equal (ledgerName c.ledger) "free-binding-percentage" then "A percentage read from observation is a parameter." else
  if SFT.Host.Text.equal (bindingName c.binding) "qualitative-most-without-bound" then "An unbounded slogan is not falsifiable." else
  if SFT.Host.Text.equal (flavourName c.flavour) "borrowed-quark-mass-order" then "Borrowing a measured ordering reverses the derivation." else
  if SFT.Host.Text.equal (electromagneticName c.electromagnetic) "ignore-or-fit-electromagnetic-effect" then "Ignoring or fitting the competing carrier cannot close the sign." else
  if SFT.Host.Text.equal (orderingName c.ordering) "assert-measured-mass-order" then "An asserted ordering has no Fold certificate." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target access cannot seal a prediction." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "conceal-observational-development" then "Concealment misstates the derivation history." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-mass-term-or-percentage" then "An ungenerated term is a parameter." else
  "The proton word is uud and the neutron word is udd; the exact structural mass ledger is bare 1/128 and held-cycle 127/128, hence bare below 1/100 and held above 99/100; the exact down-minus-up enclosure exceeds the proton electromagnetic dressing and forces neutron mass above proton mass."

def generationRule : String := "Generate the complete twelve-axis predecessor, colour, composition, depth, ledger, dominance, flavour, electromagnetic, ordering, custody, provenance and extension product."
def grammarBoundary : String := "All minimal positive u/d count splits over the complete generated colour-three cycle, complete depth-seven binary support, the admitted light-quark algebraic enclosures and the admitted terminal proton electromagnetic dressing."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Colour.rejected,Colour.admitted]).flatMap fun colour =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Ledger.rejected,Ledger.admitted]).flatMap fun ledger =>
  ([Binding.rejected,Binding.admitted]).flatMap fun binding =>
  ([Flavour.rejected,Flavour.admitted]).flatMap fun flavour =>
  ([Electromagnetic.rejected,Electromagnetic.admitted]).flatMap fun electromagnetic =>
  ([Ordering.rejected,Ordering.admitted]).flatMap fun ordering =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,colour,composition,depth,ledger,binding,flavour,electromagnetic,ordering,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor colour composition depth ledger binding flavour electromagnetic ordering target provenance extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcolour : colour ∈ [Colour.rejected,Colour.admitted] := by
      cases colour <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hledger : ledger ∈ [Ledger.rejected,Ledger.admitted] := by
      cases ledger <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbinding : binding ∈ [Binding.rejected,Binding.admitted] := by
      cases binding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hflavour : flavour ∈ [Flavour.rejected,Flavour.admitted] := by
      cases flavour <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectromagnetic : electromagnetic ∈ [Electromagnetic.rejected,Electromagnetic.admitted] := by
      cases electromagnetic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hordering : ordering ∈ [Ordering.rejected,Ordering.admitted] := by
      cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ colour _ hcolour
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ ledger _ hledger
    apply CommonRefinement.memFlatMap _ _ binding _ hbinding
    apply CommonRefinement.memFlatMap _ _ flavour _ hflavour
    apply CommonRefinement.memFlatMap _ _ electromagnetic _ helectromagnetic
    apply CommonRefinement.memFlatMap _ _ ordering _ hordering
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor colour composition depth ledger binding flavour electromagnetic ordering target provenance extension =>
    cases predecessor <;> cases colour <;> cases composition <;> cases depth <;> cases ledger <;> cases binding <;> cases flavour <;> cases electromagnetic <;> cases ordering <;> cases target <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor colour composition depth ledger binding flavour electromagnetic ordering target provenance extension =>
    cases predecessor <;> cases colour <;> cases composition <;> cases depth <;> cases ledger <;> cases binding <;> cases flavour <;> cases electromagnetic <;> cases ordering <;> cases target <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.colour = .admitted ∧ c.composition = .admitted ∧ c.depth = .admitted ∧ c.ledger = .admitted ∧ c.binding = .admitted ∧ c.flavour = .admitted ∧ c.electromagnetic = .admitted ∧ c.ordering = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor colour composition depth ledger binding flavour electromagnetic ordering target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem colour_rejected_rejected (c : Candidate) (h : c.colour = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.colour eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem depth_rejected_rejected (c : Candidate) (h : c.depth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depth eq
    rw [h] at field
    cases field

theorem ledger_rejected_rejected (c : Candidate) (h : c.ledger = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ledger eq
    rw [h] at field
    cases field

theorem binding_rejected_rejected (c : Candidate) (h : c.binding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.binding eq
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

theorem electromagnetic_rejected_rejected (c : Candidate) (h : c.electromagnetic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electromagnetic eq
    rw [h] at field
    cases field

theorem ordering_rejected_rejected (c : Candidate) (h : c.ordering = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ordering eq
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

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Physics.NucleonBindingEntryGrammar
