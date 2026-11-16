import SFT.Physics.QuantumSupportPreparation
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.QuantumSupportGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "universally-selected-depth-three"
  | .admitted => "preparation-derived-complete-binary-depth"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "imported-complex-Walsh-amplitudes"
  | .admitted => "held-returned-parity-count-table"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "named-or-selected-uncertainty-bound"
  | .admitted => "orthogonality-Parseval-support-count"

inductive Spread where
  | rejected | admitted

def spreadName : Spread → String
  | .rejected => "support-width-called-statistical-variance"
  | .admitted => "exact-unit-free-support-spread"

inductive Joint where
  | rejected | admitted

def jointName : Joint → String
  | .rejected => "product-size-relabeled-entanglement"
  | .admitted => "complete-factorability-subset-census"

inductive Projection where
  | rejected | admitted

def projectionName : Projection → String
  | .rejected => "remote-label-change-relabeled-signal"
  | .admitted => "complete-marginal-count-invariance"

inductive Bell where
  | rejected | admitted

def bellName : Bell → String
  | .rejected => "ontic-randomness-or-superluminal-message"
  | .admitted => "incomplete-local-factorization-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "measurement-selected-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  depth : Depth
  observation : Observation
  uncertainty : Uncertainty
  spread : Spread
  joint : Joint
  projection : Projection
  bell : Bell
  extension : Extension

def sourceFields (c : Candidate) : List String := [depthName c.depth, observationName c.observation, uncertaintyName c.uncertainty, spreadName c.spread, jointName c.joint, projectionName c.projection, bellName c.bell, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "spread=" (spreadName c.spread), SFT.Host.Text.append "joint=" (jointName c.joint), SFT.Host.Text.append "projection=" (projectionName c.projection), SFT.Host.Text.append "bell=" (bellName c.bell), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "preparation-derived-complete-binary-depth__held-returned-parity-count-table__orthogonality-Parseval-support-count__exact-unit-free-support-spread__complete-factorability-subset-census__complete-marginal-count-invariance__incomplete-local-factorization-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (depthName c.depth) "preparation-derived-complete-binary-depth" &&
  SFT.Host.Text.equal (observationName c.observation) "held-returned-parity-count-table" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "orthogonality-Parseval-support-count" &&
  SFT.Host.Text.equal (spreadName c.spread) "exact-unit-free-support-spread" &&
  SFT.Host.Text.equal (jointName c.joint) "complete-factorability-subset-census" &&
  SFT.Host.Text.equal (projectionName c.projection) "complete-marginal-count-invariance" &&
  SFT.Host.Text.equal (bellName c.bell) "incomplete-local-factorization-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (depthName c.depth) "preparation-derived-complete-binary-depth") then "A universal depth is an unforced parameter." else
  if !(SFT.Host.Text.equal (observationName c.observation) "held-returned-parity-count-table") then "Complex amplitudes are outside the proof grammar." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "orthogonality-Parseval-support-count") then "Naming a prior theorem does not force it." else
  if !(SFT.Host.Text.equal (spreadName c.spread) "exact-unit-free-support-spread") then "Support extent is not automatically a statistical central moment." else
  if !(SFT.Host.Text.equal (jointName c.joint) "complete-factorability-subset-census") then "A full Cartesian product factorizes exactly." else
  if !(SFT.Host.Text.equal (projectionName c.projection) "complete-marginal-count-invariance") then "A bijective relabelling changes no local count." else
  if !(SFT.Host.Text.equal (bellName c.bell) "incomplete-local-factorization-record") then "Neither is forced by the finite correlation census." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A fitted correction would select the law." else
  "For every complete dyadic preparation N=2^k and every nonempty position support, exact Fold-parity observation forces s_t*s_f>=N, unit-free support-spread product (s_t*s_f)/N>=One and squared normalized support-spread product at least 1/N^2; depth two attains 1/16 and an eight-branch preparation uniquely has depth three with branch unit 1/8. The complete 2-by-3 census has 63 nonempty supports: 21 factorable and 42 nonfactorable. The complete 3-by-5 census has 32767: 217 factorable and 32550 nonfactorable. Both full products are factorable, correcting their prior relabelling as entanglement; entanglement is the nonfactorable class. Complete projection preserves local counts under remote relabelling. All sixteen local deterministic Bell-response pairs obey the three-of-four bound, while setting-inclusive joint support can exceed it with invariant exact local marginals and no signalling."

def generationRule : String := "Generate the complete product of preparation depth, Fold-parity observation, support bound, spacing-weighted spread, joint factorability, projection, Bell-factorization and extra-rule forms."
def grammarBoundary : String := "Every nonempty subset of complete binary support through exhaustive depth four with depth-independent orthogonality induction; every nonempty 2-by-3 and 3-by-5 joint subset; all sixteen deterministic local two-setting response pairs; and the complete setting-inclusive two-outcome support."

def candidates : List Candidate :=
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Spread.rejected,Spread.admitted]).flatMap fun spread =>
  ([Joint.rejected,Joint.admitted]).flatMap fun joint =>
  ([Projection.rejected,Projection.admitted]).flatMap fun projection =>
  ([Bell.rejected,Bell.admitted]).flatMap fun bell =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨depth,observation,uncertainty,spread,joint,projection,bell,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk depth observation uncertainty spread joint projection bell extension =>
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspread : spread ∈ [Spread.rejected,Spread.admitted] := by
      cases spread <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoint : joint ∈ [Joint.rejected,Joint.admitted] := by
      cases joint <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprojection : projection ∈ [Projection.rejected,Projection.admitted] := by
      cases projection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbell : bell ∈ [Bell.rejected,Bell.admitted] := by
      cases bell <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ spread _ hspread
    apply CommonRefinement.memFlatMap _ _ joint _ hjoint
    apply CommonRefinement.memFlatMap _ _ projection _ hprojection
    apply CommonRefinement.memFlatMap _ _ bell _ hbell
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.QuantumSupportGrammar
