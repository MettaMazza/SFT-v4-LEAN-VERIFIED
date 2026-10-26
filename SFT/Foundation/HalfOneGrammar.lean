import SFT.Foundation.HalfOneDerivation
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.HalfOneGrammar
set_option maxRecDepth 20000

inductive Selection where
  | whole | singleton

def selectionName : Selection → String
  | .whole => "selection-whole"
  | .singleton => "selection-singleton-equivalence-class"

inductive Junction where
  | incomplete | one

def junctionName : Junction → String
  | .incomplete => "self-junction-incomplete"
  | .one => "self-junction-One"

inductive Complement where
  | distinct | equivalent

def complementName : Complement → String
  | .distinct => "complement-distinct"
  | .equivalent => "self-complement-equivalent"

inductive FoldImage where
  | notOne | one

def foldImageName : FoldImage → String
  | .notOne => "fold-image-not-One"
  | .one => "fold-image-One"

inductive FixedOne where
  | notFixed | fixed

def fixedOneName : FixedOne → String
  | .notFixed => "One-not-fixed"
  | .fixed => "One-fixed"

inductive Antipode where
  | conflated | distinguished

def antipodeName : Antipode → String
  | .conflated => "phase-antipode-conflated"
  | .distinguished => "phase-antipode-distinguished"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  selection : Selection
  junction : Junction
  complement : Complement
  foldImage : FoldImage
  fixedOne : FixedOne
  antipode : Antipode
  extra : Extra

def sourceFields (c : Candidate) : List String := [selectionName c.selection, junctionName c.junction, complementName c.complement, foldImageName c.foldImage, fixedOneName c.fixedOne, antipodeName c.antipode, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Ground proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survivorId : String := "selection-singleton-equivalence-class__self-junction-One__self-complement-equivalent__fold-image-One__One-fixed__phase-antipode-distinguished__no-extra"

def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId

def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (selectionName c.selection) "selection-singleton-equivalence-class" &&
  SFT.Host.Text.equal (junctionName c.junction) "self-junction-One" &&
  SFT.Host.Text.equal (complementName c.complement) "self-complement-equivalent" &&
  SFT.Host.Text.equal (foldImageName c.foldImage) "fold-image-One" &&
  SFT.Host.Text.equal (fixedOneName c.fixedOne) "One-fixed" &&
  SFT.Host.Text.equal (antipodeName c.antipode) "phase-antipode-distinguished" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.contains (candidateId c) "selection-whole" then "The complete two-fibre selection is the One, not the proper ground." else
  if SFT.Host.Text.contains (candidateId c) "self-junction-incomplete" then "The selected class does not generate the complete first Fold." else
  if SFT.Host.Text.contains (candidateId c) "complement-distinct" then "It fails the equal-fibre complement symmetry." else
  if SFT.Host.Text.contains (candidateId c) "fold-image-not-One" then "It does not Fold to the complete source whole." else
  if SFT.Host.Text.contains (candidateId c) "One-not-fixed" then "It does not retain the One as the completed Fold image." else
  if SFT.Host.Text.contains (candidateId c) "phase-antipode-conflated" then "It incorrectly identifies complement with a half-One phase translation." else
  if SFT.Host.Text.contains (candidateId c) "has-extra" then "It adds a selector or scale not supplied by the first Fold." else
  "One of the two equal first-Fold fibres is one exact equivalence class: one-of-two, self-complementary, folding to the fixed One."

def generationRule : String := "Generate the complete product of first-Fold selection class, self-junction, complement, Fold image, One fixedness, antipode terminology and added-data class."
def grammarBoundary : String := "All exact candidate grounds obtainable as nonempty selection-equivalence classes of the minimal Fold's two equal held fibres."

def candidates : List Candidate :=
  ([Selection.whole,.singleton]).flatMap fun selection =>
  ([Junction.incomplete,.one]).flatMap fun junction =>
  ([Complement.distinct,.equivalent]).flatMap fun complement =>
  ([FoldImage.notOne,.one]).flatMap fun foldImage =>
  ([FixedOne.notFixed,.fixed]).flatMap fun fixedOne =>
  ([Antipode.conflated,.distinguished]).flatMap fun antipode =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨selection,junction,complement,foldImage,fixedOne,antipode,extra⟩

def survivor : Candidate := ⟨.singleton,.one,.equivalent,.one,.fixed,.distinguished,.noExtra⟩

theorem generatedCardinality : candidates.length = 128 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk selection junction complement foldImage fixedOne antipode extra =>
    have hselection : selection ∈ [Selection.whole,.singleton] := by
      cases selection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjunction : junction ∈ [Junction.incomplete,.one] := by
      cases junction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomplement : complement ∈ [Complement.distinct,.equivalent] := by
      cases complement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfoldImage : foldImage ∈ [FoldImage.notOne,.one] := by
      cases foldImage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfixedOne : fixedOne ∈ [FixedOne.notFixed,.fixed] := by
      cases fixedOne <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hantipode : antipode ∈ [Antipode.conflated,.distinguished] := by
      cases antipode <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ selection _ hselection
    apply CommonRefinement.memFlatMap _ _ junction _ hjunction
    apply CommonRefinement.memFlatMap _ _ complement _ hcomplement
    apply CommonRefinement.memFlatMap _ _ foldImage _ hfoldImage
    apply CommonRefinement.memFlatMap _ _ fixedOne _ hfixedOne
    apply CommonRefinement.memFlatMap _ _ antipode _ hantipode
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 10000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk selection junction complement foldImage fixedOne antipode extra =>
    cases selection <;> cases junction <;> cases complement <;> cases foldImage <;> cases fixedOne <;> cases antipode <;> cases extra
    all_goals rfl

set_option maxHeartbeats 4000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk selection junction complement foldImage fixedOne antipode extra =>
    cases selection <;> cases junction <;> cases complement <;> cases foldImage <;> cases fixedOne <;> cases antipode <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.selection = .singleton ∧ c.junction = .one ∧ c.complement = .equivalent ∧ c.foldImage = .one ∧ c.fixedOne = .fixed ∧ c.antipode = .distinguished ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk selection junction complement foldImage fixedOne antipode extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem selectionRejected (c : Candidate) (h : c.selection = .whole) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selection eq
    rw [h] at field
    cases field

theorem junctionRejected (c : Candidate) (h : c.junction = .incomplete) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.junction eq
    rw [h] at field
    cases field

theorem complementRejected (c : Candidate) (h : c.complement = .distinct) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.complement eq
    rw [h] at field
    cases field

theorem foldImageRejected (c : Candidate) (h : c.foldImage = .notOne) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.foldImage eq
    rw [h] at field
    cases field

theorem fixedOneRejected (c : Candidate) (h : c.fixedOne = .notFixed) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fixedOne eq
    rw [h] at field
    cases field

theorem antipodeRejected (c : Candidate) (h : c.antipode = .conflated) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.antipode eq
    rw [h] at field
    cases field

theorem extraRejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.HalfOneGrammar
