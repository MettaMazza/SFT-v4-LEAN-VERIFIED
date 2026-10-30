import SFT.Mathematics.LimitContinuumWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.LimitContinuumGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Object where
  | rejected | admitted

def objectName : Object → String
  | .rejected => "completed-infinity"
  | .admitted => "finite-stage"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "largest-stage"
  | .admitted => "always-next"

inductive Refinement where
  | rejected | admitted

def refinementName : Refinement → String
  | .rejected => "vanishing-zero"
  | .admitted => "positive-rung"

inductive Convergence where
  | rejected | admitted

def convergenceName : Convergence → String
  | .rejected => "limit-as-value"
  | .admitted => "nested-rational-bounds"

inductive Continuum where
  | rejected | admitted

def continuumName : Continuum → String
  | .rejected => "ambient-real-line"
  | .admitted => "unbounded-process-boundary"

inductive Cardinality where
  | rejected | admitted

def cardinalityName : Cardinality → String
  | .rejected => "completed-comparison"
  | .admitted => "finite-bound-count"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-depth"
  | .admitted => "base-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-limit-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  object : Object
  successor : Successor
  refinement : Refinement
  convergence : Convergence
  continuum : Continuum
  cardinality : Cardinality
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [objectName c.object, successorName c.successor, refinementName c.refinement, convergenceName c.convergence, continuumName c.continuum, cardinalityName c.cardinality, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "object=" (objectName c.object), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "refinement=" (refinementName c.refinement), SFT.Host.Text.append "convergence=" (convergenceName c.convergence), SFT.Host.Text.append "continuum=" (continuumName c.continuum), SFT.Host.Text.append "cardinality=" (cardinalityName c.cardinality), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "finite-stage__always-next__positive-rung__nested-rational-bounds__unbounded-process-boundary__finite-bound-count__base-successor__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (objectName c.object) "finite-stage" &&
  SFT.Host.Text.equal (successorName c.successor) "always-next" &&
  SFT.Host.Text.equal (refinementName c.refinement) "positive-rung" &&
  SFT.Host.Text.equal (convergenceName c.convergence) "nested-rational-bounds" &&
  SFT.Host.Text.equal (continuumName c.continuum) "unbounded-process-boundary" &&
  SFT.Host.Text.equal (cardinalityName c.cardinality) "finite-bound-count" &&
  SFT.Host.Text.equal (generalityName c.generality) "base-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (objectName c.object) "finite-stage") then "A completed unbounded totality is not generated." else
  if !(SFT.Host.Text.equal (successorName c.successor) "always-next") then "No generated rule supplies a largest finite stage." else
  if !(SFT.Host.Text.equal (refinementName c.refinement) "positive-rung") then "Numerical zero is outside the domain." else
  if !(SFT.Host.Text.equal (convergenceName c.convergence) "nested-rational-bounds") then "An ungenerated limit cannot enter as a value." else
  if !(SFT.Host.Text.equal (continuumName c.continuum) "unbounded-process-boundary") then "An ambient continuum imports forbidden objects." else
  if !(SFT.Host.Text.equal (cardinalityName c.cardinality) "finite-bound-count") then "Cardinality of a nonobject has no SFT witness." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "base-successor") then "One fixed depth does not close the successor law." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "A limit oracle adds an axiom." else
  "Potential infinity is the never-terminal generated successor process; every reached object is finite and positive, convergence is an exact nested-bound certificate, and completed infinity or continuum is outside the admitted object language."

def generationRule : String := "Exhaust object, successor, refinement, convergence, continuum, cardinality, generality and extra-rule choices."
def grammarBoundary : String := "Generated positive finite depth traces and exact rational bounds at every supplied finite stage."

def candidates : List Candidate :=
  ([Object.rejected,Object.admitted]).flatMap fun object =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Refinement.rejected,Refinement.admitted]).flatMap fun refinement =>
  ([Convergence.rejected,Convergence.admitted]).flatMap fun convergence =>
  ([Continuum.rejected,Continuum.admitted]).flatMap fun continuum =>
  ([Cardinality.rejected,Cardinality.admitted]).flatMap fun cardinality =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨object,successor,refinement,convergence,continuum,cardinality,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk object successor refinement convergence continuum cardinality generality addition =>
    have hobject : object ∈ [Object.rejected,Object.admitted] := by
      cases object <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrefinement : refinement ∈ [Refinement.rejected,Refinement.admitted] := by
      cases refinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconvergence : convergence ∈ [Convergence.rejected,Convergence.admitted] := by
      cases convergence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontinuum : continuum ∈ [Continuum.rejected,Continuum.admitted] := by
      cases continuum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcardinality : cardinality ∈ [Cardinality.rejected,Cardinality.admitted] := by
      cases cardinality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ object _ hobject
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ refinement _ hrefinement
    apply CommonRefinement.memFlatMap _ _ convergence _ hconvergence
    apply CommonRefinement.memFlatMap _ _ continuum _ hcontinuum
    apply CommonRefinement.memFlatMap _ _ cardinality _ hcardinality
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition


end SFT.Mathematics.LimitContinuumGrammar
