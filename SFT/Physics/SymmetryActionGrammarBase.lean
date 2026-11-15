import SFT.Physics.SymmetryAction
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.SymmetryActionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-or-continuous-state-sample"
  | .admitted => "complete-finite-generated-support"

inductive Symmetry where
  | rejected | admitted

def symmetryName : Symmetry → String
  | .rejected => "named-transformation-without-census"
  | .admitted => "complete-bijection-enumeration"

inductive Incidence where
  | rejected | admitted

def incidenceName : Incidence → String
  | .rejected => "state-labels-without-transition-law"
  | .admitted => "transition-incidence-preserved"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-rescaling-under-symmetry"
  | .admitted => "exact-positive-carrier-preserved"

inductive Conserved where
  | rejected | admitted

def conservedName : Conserved → String
  | .rejected => "answer-only-scalar"
  | .admitted => "odd-core-and-held-invariant-fibre"

inductive Converse where
  | rejected | admitted

def converseName : Converse → String
  | .rejected => "assert-every-conservation-has-unknown-symmetry"
  | .admitted => "enumerate-all-fibre-preserving-bijections"

inductive Action where
  | rejected | admitted

def actionName : Action → String
  | .rejected => "signed-or-imported-action-integral"
  | .admitted => "sum-of-positive-oriented-step-magnitudes"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "postulated-stationary-physical-path"
  | .admitted => "dyadic-Fold-descent-and-positive-detour-bound"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-Lagrangian-or-Euler-equation"
  | .admitted => "no-extra-rule"

structure Candidate where
  support : Support
  symmetry : Symmetry
  incidence : Incidence
  carrier : Carrier
  conserved : Conserved
  converse : Converse
  action : Action
  path : Path
  extension : Extension

def sourceFields (c : Candidate) : List String := [supportName c.support, symmetryName c.symmetry, incidenceName c.incidence, carrierName c.carrier, conservedName c.conserved, converseName c.converse, actionName c.action, pathName c.path, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "symmetry=" (symmetryName c.symmetry), SFT.Host.Text.append "incidence=" (incidenceName c.incidence), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "conserved=" (conservedName c.conserved), SFT.Host.Text.append "converse=" (converseName c.converse), SFT.Host.Text.append "action=" (actionName c.action), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-finite-generated-support__complete-bijection-enumeration__transition-incidence-preserved__exact-positive-carrier-preserved__odd-core-and-held-invariant-fibre__enumerate-all-fibre-preserving-bijections__sum-of-positive-oriented-step-magnitudes__dyadic-Fold-descent-and-positive-detour-bound__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-finite-generated-support" &&
  SFT.Host.Text.equal (symmetryName c.symmetry) "complete-bijection-enumeration" &&
  SFT.Host.Text.equal (incidenceName c.incidence) "transition-incidence-preserved" &&
  SFT.Host.Text.equal (carrierName c.carrier) "exact-positive-carrier-preserved" &&
  SFT.Host.Text.equal (conservedName c.conserved) "odd-core-and-held-invariant-fibre" &&
  SFT.Host.Text.equal (converseName c.converse) "enumerate-all-fibre-preserving-bijections" &&
  SFT.Host.Text.equal (actionName c.action) "sum-of-positive-oriented-step-magnitudes" &&
  SFT.Host.Text.equal (pathName c.path) "dyadic-Fold-descent-and-positive-detour-bound" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (supportName c.support) "selected-or-continuous-state-sample" then "A sample or continuum premise is not a complete generated domain." else
  if SFT.Host.Text.equal (symmetryName c.symmetry) "named-transformation-without-census" then "A named transformation does not prove bijection or completeness." else
  if SFT.Host.Text.equal (incidenceName c.incidence) "state-labels-without-transition-law" then "Ignoring incidence can turn a non-dynamics map into a symmetry." else
  if SFT.Host.Text.equal (carrierName c.carrier) "free-rescaling-under-symmetry" then "A free rescaling changes the physical law." else
  if SFT.Host.Text.equal (conservedName c.conserved) "answer-only-scalar" then "A scalar detached from support has no conservation trace." else
  if SFT.Host.Text.equal (converseName c.converse) "assert-every-conservation-has-unknown-symmetry" then "An ungenerated symmetry is not evidence." else
  if SFT.Host.Text.equal (actionName c.action) "signed-or-imported-action-integral" then "Signed continuum integration is outside the proof domain." else
  if SFT.Host.Text.equal (pathName c.path) "postulated-stationary-physical-path" then "Postulating stationarity imports the desired principle." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-Lagrangian-or-Euler-equation" then "An imported functional or equation is an extra premise." else
  "Fold preserves the reduced odd denominator core of every rational part; complete finite Fold symmetries preserve their held invariant fibres, every registered conserved partition generates its complete preserving symmetry class; every dyadic Fold part follows its unique binary-rank descent to stationary One; every monotone positive descent path telescopes to its endpoint carrier; and no finite detour has smaller action."

def generationRule : String := "Generate the complete product of support, symmetry, incidence, carrier, conserved-fibre, converse, action, path and extension forms."
def grammarBoundary : String := "Every exact positive rational Fold part; the complete dyadic fixed-point basin; every finite generated state support; every bijection of that support; every registered exact transition/carrier relation and held fibre partition; every finite path of distinct adjacent states with exact positive ranked coordinates."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Symmetry.rejected,Symmetry.admitted]).flatMap fun symmetry =>
  ([Incidence.rejected,Incidence.admitted]).flatMap fun incidence =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Conserved.rejected,Conserved.admitted]).flatMap fun conserved =>
  ([Converse.rejected,Converse.admitted]).flatMap fun converse =>
  ([Action.rejected,Action.admitted]).flatMap fun action =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨support,symmetry,incidence,carrier,conserved,converse,action,path,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support symmetry incidence carrier conserved converse action path extension =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsymmetry : symmetry ∈ [Symmetry.rejected,Symmetry.admitted] := by
      cases symmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hincidence : incidence ∈ [Incidence.rejected,Incidence.admitted] := by
      cases incidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconserved : conserved ∈ [Conserved.rejected,Conserved.admitted] := by
      cases conserved <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconverse : converse ∈ [Converse.rejected,Converse.admitted] := by
      cases converse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haction : action ∈ [Action.rejected,Action.admitted] := by
      cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ symmetry _ hsymmetry
    apply CommonRefinement.memFlatMap _ _ incidence _ hincidence
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ conserved _ hconserved
    apply CommonRefinement.memFlatMap _ _ converse _ hconverse
    apply CommonRefinement.memFlatMap _ _ action _ haction
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.SymmetryActionGrammar
