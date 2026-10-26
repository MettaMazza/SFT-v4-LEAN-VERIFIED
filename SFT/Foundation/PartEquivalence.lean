import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.PartEquivalence
set_option maxRecDepth 20000

inductive Coverage where
  | incomplete | complete

def coverageName : Coverage → String
  | .incomplete => "incomplete"
  | .complete => "complete"

inductive Overlap where
  | overlapping | disjoint

def overlapName : Overlap → String
  | .overlapping => "overlapping"
  | .disjoint => "disjoint"

inductive Fibres where
  | unequal | equal

def fibresName : Fibres → String
  | .unequal => "unequal"
  | .equal => "equal"

inductive RefinesA where
  | unrefined | refined

def refinesAName : RefinesA → String
  | .unrefined => "a-unrefined"
  | .refined => "a-refined"

inductive RefinesB where
  | unrefined | refined

def refinesBName : RefinesB → String
  | .unrefined => "b-unrefined"
  | .refined => "b-refined"

inductive SelectionA where
  | incomplete | complete

def selectionAName : SelectionA → String
  | .incomplete => "a-selection-incomplete"
  | .complete => "a-selection-complete"

inductive SelectionB where
  | incomplete | complete

def selectionBName : SelectionB → String
  | .incomplete => "b-selection-incomplete"
  | .complete => "b-selection-complete"

inductive Pairing where
  | absent | oneToOneOnly | ontoOnly | bijective

def pairingName : Pairing → String
  | .absent => "pairing-absent"
  | .oneToOneOnly => "one-to-one-only"
  | .ontoOnly => "onto-only"
  | .bijective => "bijective"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  coverage : Coverage
  overlap : Overlap
  fibres : Fibres
  refinesA : RefinesA
  refinesB : RefinesB
  selectionA : SelectionA
  selectionB : SelectionB
  pairing : Pairing
  extra : Extra

def sourceFields (c : Candidate) : List String := [coverageName c.coverage, overlapName c.overlap, fibresName c.fibres, refinesAName c.refinesA, refinesBName c.refinesB, selectionAName c.selectionA, selectionBName c.selectionB, pairingName c.pairing, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Equivalence witness has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survivorId : String := "complete__disjoint__equal__a-refined__b-refined__a-selection-complete__b-selection-complete__bijective__no-extra"

def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (coverageName c.coverage) "incomplete" then "The refinement does not cover the complete source wholes." else
  if SFT.Host.Text.equal (overlapName c.overlap) "overlapping" then "Overlapping refinement cells repeat shared structure." else
  if SFT.Host.Text.equal (fibresName c.fibres) "unequal" then "Unequal refinement cells cannot compare selected part counts exactly." else
  if SFT.Host.Text.equal (refinesAName c.refinesA) "a-unrefined" then "The witness does not refine the first partition." else
  if SFT.Host.Text.equal (refinesBName c.refinesB) "b-unrefined" then "The witness does not refine the second partition." else
  if SFT.Host.Text.equal (selectionAName c.selectionA) "a-selection-incomplete" then "The first held selection is not completely lifted." else
  if SFT.Host.Text.equal (selectionBName c.selectionB) "b-selection-incomplete" then "The second held selection is not completely lifted." else
  if SFT.Host.Text.equal (pairingName c.pairing) "pairing-absent" then "No exact pairing compares the lifted selected traces." else
  if SFT.Host.Text.equal (pairingName c.pairing) "one-to-one-only" then "The pairing leaves selected cells in the second trace unmatched." else
  if SFT.Host.Text.equal (pairingName c.pairing) "onto-only" then "The pairing repeats at least one selected cell in the second trace." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "The witness adds a scale or rule not supplied by refinement and count." else
  "A complete equal disjoint common refinement lifts both selections and pairs their refined selected traces one-to-one and onto without extra data."

def generationRule : String := "Generate the complete product of common-refinement coverage, overlap, equal-fibre status, refinement of each source partition, complete lifting of each held selection, pairing class and unforced-extra-data presence."
def grammarBoundary : String := "All equivalence witnesses between two admitted exact positive part coordinates, using only a generated pair-cell common refinement and an exact pairing of their lifted selected-fibre traces."

def candidates : List Candidate :=
  ([Coverage.incomplete,.complete]).flatMap fun coverage =>
  ([Overlap.overlapping,.disjoint]).flatMap fun overlap =>
  ([Fibres.unequal,.equal]).flatMap fun fibres =>
  ([RefinesA.unrefined,.refined]).flatMap fun refinesA =>
  ([RefinesB.unrefined,.refined]).flatMap fun refinesB =>
  ([SelectionA.incomplete,.complete]).flatMap fun selectionA =>
  ([SelectionB.incomplete,.complete]).flatMap fun selectionB =>
  ([Pairing.absent,.oneToOneOnly,.ontoOnly,.bijective]).flatMap fun pairing =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨coverage,overlap,fibres,refinesA,refinesB,selectionA,selectionB,pairing,extra⟩

def survivor : Candidate := ⟨.complete,.disjoint,.equal,.refined,.refined,.complete,.complete,.bijective,.noExtra⟩

set_option maxRecDepth 20000 in
set_option maxHeartbeats 20000000 in
theorem generatedCardinality : candidates.length = 1024 := rfl

set_option maxRecDepth 20000 in
set_option maxHeartbeats 20000000 in
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk coverage overlap fibres refinesA refinesB selectionA selectionB pairing extra =>
    have hcoverage : coverage ∈ [Coverage.incomplete,.complete] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoverlap : overlap ∈ [Overlap.overlapping,.disjoint] := by
      cases overlap <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfibres : fibres ∈ [Fibres.unequal,.equal] := by
      cases fibres <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrefinesA : refinesA ∈ [RefinesA.unrefined,.refined] := by
      cases refinesA <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrefinesB : refinesB ∈ [RefinesB.unrefined,.refined] := by
      cases refinesB <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselectionA : selectionA ∈ [SelectionA.incomplete,.complete] := by
      cases selectionA <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselectionB : selectionB ∈ [SelectionB.incomplete,.complete] := by
      cases selectionB <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpairing : pairing ∈ [Pairing.absent,.oneToOneOnly,.ontoOnly,.bijective] := by
      cases pairing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ overlap _ hoverlap
    apply CommonRefinement.memFlatMap _ _ fibres _ hfibres
    apply CommonRefinement.memFlatMap _ _ refinesA _ hrefinesA
    apply CommonRefinement.memFlatMap _ _ refinesB _ hrefinesB
    apply CommonRefinement.memFlatMap _ _ selectionA _ hselectionA
    apply CommonRefinement.memFlatMap _ _ selectionB _ hselectionB
    apply CommonRefinement.memFlatMap _ _ pairing _ hpairing
    exact Count.TraceDerivation.memMap _ extra _ hextra

def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverageName c.coverage) "complete" &&
  SFT.Host.Text.equal (overlapName c.overlap) "disjoint" &&
  SFT.Host.Text.equal (fibresName c.fibres) "equal" &&
  SFT.Host.Text.equal (refinesAName c.refinesA) "a-refined" &&
  SFT.Host.Text.equal (refinesBName c.refinesB) "b-refined" &&
  SFT.Host.Text.equal (selectionAName c.selectionA) "a-selection-complete" &&
  SFT.Host.Text.equal (selectionBName c.selectionB) "b-selection-complete" &&
  SFT.Host.Text.equal (pairingName c.pairing) "bijective" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

set_option maxRecDepth 20000 in
set_option maxHeartbeats 20000000 in
theorem sourceDecisionIffCriteriaDecision (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk coverage overlap fibres refinesA refinesB selectionA selectionB pairing extra =>
    cases coverage <;> cases overlap <;> cases fibres <;> cases refinesA <;> cases refinesB <;> cases selectionA <;> cases selectionB <;> cases pairing <;> cases extra
    all_goals rfl

set_option maxHeartbeats 20000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk coverage overlap fibres refinesA refinesB selectionA selectionB pairing extra =>
    cases coverage <;> cases overlap <;> cases fibres <;> cases refinesA <;> cases refinesB <;> cases selectionA <;> cases selectionB <;> cases pairing <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionIffCriteriaDecision]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.coverage = .complete ∧ c.overlap = .disjoint ∧ c.fibres = .equal ∧ c.refinesA = .refined ∧ c.refinesB = .refined ∧ c.selectionA = .complete ∧ c.selectionB = .complete ∧ c.pairing = .bijective ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk coverage overlap fibres refinesA refinesB selectionA selectionB pairing extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem coverageIncompleteRejected (c : Candidate) (h : c.coverage = .incomplete) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem overlapOverlappingRejected (c : Candidate) (h : c.overlap = .overlapping) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.overlap eq
    rw [h] at field
    cases field

theorem fibresUnequalRejected (c : Candidate) (h : c.fibres = .unequal) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fibres eq
    rw [h] at field
    cases field

theorem refinesAUnrefinedRejected (c : Candidate) (h : c.refinesA = .unrefined) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.refinesA eq
    rw [h] at field
    cases field

theorem refinesBUnrefinedRejected (c : Candidate) (h : c.refinesB = .unrefined) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.refinesB eq
    rw [h] at field
    cases field

theorem selectionAIncompleteRejected (c : Candidate) (h : c.selectionA = .incomplete) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selectionA eq
    rw [h] at field
    cases field

theorem selectionBIncompleteRejected (c : Candidate) (h : c.selectionB = .incomplete) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selectionB eq
    rw [h] at field
    cases field

theorem pairingAbsentRejected (c : Candidate) (h : c.pairing = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairing eq
    rw [h] at field
    cases field

theorem pairingOneToOneOnlyRejected (c : Candidate) (h : c.pairing = .oneToOneOnly) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairing eq
    rw [h] at field
    cases field

theorem pairingOntoOnlyRejected (c : Candidate) (h : c.pairing = .ontoOnly) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairing eq
    rw [h] at field
    cases field

theorem extraHasExtraRejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.PartEquivalence
