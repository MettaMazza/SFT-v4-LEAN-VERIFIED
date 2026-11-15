import SFT.Physics.AccumulatedSeparation
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AccumulatedSeparationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "imported-or-selected-coupling-table"
  | .admitted => "admitted-common-support-gap-law"

inductive Term where
  | rejected | admitted

def termName : Term → String
  | .rejected => "unsigned-or-fitted-difference"
  | .admitted => "exact-adjacent-sector-gap"

inductive First where
  | rejected | admitted

def firstName : First → String
  | .rejected => "assert-half-contraction-from-first-gap"
  | .admitted => "retain-one-twelfth-and-one-twentieth"

inductive Contraction where
  | rejected | admitted

def contractionName : Contraction → String
  | .rejected => "visual-or-imported-convergence"
  | .admitted => "exact-strict-half-contraction-after-level-two"

inductive Envelope where
  | rejected0 | admitted | rejected2 | rejected3

def envelopeName : Envelope → String
  | .rejected0 => "one-sixth"
  | .admitted => "eleven-sixtieths"
  | .rejected2 => "one-fifth"
  | .rejected3 => "target-selected-bound"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "completed-infinite-sum"
  | .admitted => "every-positive-finite-partial-support"

inductive Tolerance where
  | rejected | admitted

def toleranceName : Tolerance → String
  | .rejected => "limit-symbol-without-witness"
  | .admitted => "generated-finite-tail-witness"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-tail-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  term : Term
  first : First
  contraction : Contraction
  envelope : Envelope
  boundary : Boundary
  tolerance : Tolerance
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, termName c.term, firstName c.first, contractionName c.contraction, envelopeName c.envelope, boundaryName c.boundary, toleranceName c.tolerance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "term=" (termName c.term), SFT.Host.Text.append "first=" (firstName c.first), SFT.Host.Text.append "contraction=" (contractionName c.contraction), SFT.Host.Text.append "envelope=" (envelopeName c.envelope), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "tolerance=" (toleranceName c.tolerance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "admitted-common-support-gap-law__exact-adjacent-sector-gap__retain-one-twelfth-and-one-twentieth__exact-strict-half-contraction-after-level-two__eleven-sixtieths__every-positive-finite-partial-support__generated-finite-tail-witness__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "admitted-common-support-gap-law" &&
  SFT.Host.Text.equal (termName c.term) "exact-adjacent-sector-gap" &&
  SFT.Host.Text.equal (firstName c.first) "retain-one-twelfth-and-one-twentieth" &&
  SFT.Host.Text.equal (contractionName c.contraction) "exact-strict-half-contraction-after-level-two" &&
  SFT.Host.Text.equal (envelopeName c.envelope) "eleven-sixtieths" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "every-positive-finite-partial-support" &&
  SFT.Host.Text.equal (toleranceName c.tolerance) "generated-finite-tail-witness" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "imported-or-selected-coupling-table" then "A conventional or selected table is not an admitted predecessor." else
  if SFT.Host.Text.equal (termName c.term) "unsigned-or-fitted-difference" then "A fitted difference can encode a target." else
  if SFT.Host.Text.equal (firstName c.first) "assert-half-contraction-from-first-gap" then "The transition 1/12 to 1/20 shrinks but is not below half." else
  if SFT.Host.Text.equal (contractionName c.contraction) "visual-or-imported-convergence" then "Visual approach and an imported series theorem are not Fold proof objects." else
  if SFT.Host.Text.equal (envelopeName c.envelope) "one-sixth" then "Later exact partial sums exceed this candidate." else
  if SFT.Host.Text.equal (envelopeName c.envelope) "one-fifth" then "This is a weaker nonminimal envelope." else
  if SFT.Host.Text.equal (envelopeName c.envelope) "target-selected-bound" then "A target-selected bound violates the direction of proof." else
  if SFT.Host.Text.equal (boundaryName c.boundary) "completed-infinite-sum" then "Completed infinity is outside the SFT domain." else
  if SFT.Host.Text.equal (toleranceName c.tolerance) "limit-symbol-without-witness" then "A limit label alone supplies no finite certificate." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-tail-correction" then "A free correction is a parameter." else
  "Every positive finite partial sum of the binary/generator-three Fold coupling gaps lies in the exact bracket [1/12, 11/60); after the second level every successor gap is below half its predecessor, and every positive rational tolerance has a generated finite tail witness."

def generationRule : String := "Generate the complete product of predecessor, gap term, first-step, contraction, envelope, finite-boundary, tolerance and extension forms."
def grammarBoundary : String := "Every positive finite common-support level generated from the One by binary succession; the exact binary/generator-three pair gap; every positive finite partial accumulation and every positive rational tolerance represented by a positive denominator."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Term.rejected,Term.admitted]).flatMap fun term =>
  ([First.rejected,First.admitted]).flatMap fun first =>
  ([Contraction.rejected,Contraction.admitted]).flatMap fun contraction =>
  ([Envelope.rejected0,Envelope.admitted,Envelope.rejected2,Envelope.rejected3]).flatMap fun envelope =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Tolerance.rejected,Tolerance.admitted]).flatMap fun tolerance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,term,first,contraction,envelope,boundary,tolerance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor term first contraction envelope boundary tolerance extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterm : term ∈ [Term.rejected,Term.admitted] := by
      cases term <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfirst : first ∈ [First.rejected,First.admitted] := by
      cases first <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontraction : contraction ∈ [Contraction.rejected,Contraction.admitted] := by
      cases contraction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henvelope : envelope ∈ [Envelope.rejected0,Envelope.admitted,Envelope.rejected2,Envelope.rejected3] := by
      cases envelope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htolerance : tolerance ∈ [Tolerance.rejected,Tolerance.admitted] := by
      cases tolerance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ term _ hterm
    apply CommonRefinement.memFlatMap _ _ first _ hfirst
    apply CommonRefinement.memFlatMap _ _ contraction _ hcontraction
    apply CommonRefinement.memFlatMap _ _ envelope _ henvelope
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ tolerance _ htolerance
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.AccumulatedSeparationGrammar
