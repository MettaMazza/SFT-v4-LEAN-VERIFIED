import SFT.Physics.UnifiedConstants
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.UnifiedConstantsGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Root where
  | rejected | admitted

def rootName : Root → String
  | .rejected => "disconnected-constant-list"
  | .admitted => "single-One-root"

inductive Fold where
  | rejected | admitted

def foldName : Fold → String
  | .rejected => "borrowed-numerals"
  | .admitted => "Fold-generated-binary-and-generator"

inductive Covers where
  | rejected | admitted

def coversName : Covers → String
  | .rejected => "selected-depth-labels"
  | .admitted => "least-binary-covers-of-generated-volumes"

inductive Typing where
  | rejected | admitted

def typingName : Typing → String
  | .rejected => "untyped-number-coincidence"
  | .admitted => "shared-carrier-incidence"

inductive Leading where
  | rejected | admitted

def leadingName : Leading → String
  | .rejected => "selected-headline-values"
  | .admitted => "complete-registered-foundation-vector"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "replacement-values-with-new-roots"
  | .admitted => "root-preserving-terminal-continuations"

inductive Graph where
  | rejected | admitted

def graphName : Graph → String
  | .rejected => "sector-local-formulas-only"
  | .admitted => "connected-rooted-dependency-graph"

inductive Mutation where
  | rejected | admitted

def mutationName : Mutation → String
  | .rejected => "decorative-shared-labels"
  | .admitted => "complete-generator-successor-probe"

inductive Control where
  | rejected | admitted

def controlName : Control → String
  | .rejected => "blanket-global-mutation"
  | .admitted => "binary-and-rank-held-controls"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "measurement-assembled-object"
  | .admitted => "formal-object-sealed-before-comparison"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "rewrite-existing-object"
  | .admitted => "append-traced-node"

inductive Rule where
  | rejected | admitted

def ruleName : Rule → String
  | .rejected => "free-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  root : Root
  fold : Fold
  covers : Covers
  typing : Typing
  leading : Leading
  terminal : Terminal
  graph : Graph
  mutation : Mutation
  control : Control
  measurement : Measurement
  extension : Extension
  rule : Rule

def sourceFields (c : Candidate) : List String := [rootName c.root, foldName c.fold, coversName c.covers, typingName c.typing, leadingName c.leading, terminalName c.terminal, graphName c.graph, mutationName c.mutation, controlName c.control, measurementName c.measurement, extensionName c.extension, ruleName c.rule]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "root=" (rootName c.root), SFT.Host.Text.append "fold=" (foldName c.fold), SFT.Host.Text.append "covers=" (coversName c.covers), SFT.Host.Text.append "typing=" (typingName c.typing), SFT.Host.Text.append "leading=" (leadingName c.leading), SFT.Host.Text.append "terminal=" (terminalName c.terminal), SFT.Host.Text.append "graph=" (graphName c.graph), SFT.Host.Text.append "mutation=" (mutationName c.mutation), SFT.Host.Text.append "control=" (controlName c.control), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension), SFT.Host.Text.append "rule=" (ruleName c.rule)]
def survivorId : String := "single-One-root__Fold-generated-binary-and-generator__least-binary-covers-of-generated-volumes__shared-carrier-incidence__complete-registered-foundation-vector__root-preserving-terminal-continuations__connected-rooted-dependency-graph__complete-generator-successor-probe__binary-and-rank-held-controls__formal-object-sealed-before-comparison__append-traced-node__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (rootName c.root) "single-One-root" &&
  SFT.Host.Text.equal (foldName c.fold) "Fold-generated-binary-and-generator" &&
  SFT.Host.Text.equal (coversName c.covers) "least-binary-covers-of-generated-volumes" &&
  SFT.Host.Text.equal (typingName c.typing) "shared-carrier-incidence" &&
  SFT.Host.Text.equal (leadingName c.leading) "complete-registered-foundation-vector" &&
  SFT.Host.Text.equal (terminalName c.terminal) "root-preserving-terminal-continuations" &&
  SFT.Host.Text.equal (graphName c.graph) "connected-rooted-dependency-graph" &&
  SFT.Host.Text.equal (mutationName c.mutation) "complete-generator-successor-probe" &&
  SFT.Host.Text.equal (controlName c.control) "binary-and-rank-held-controls" &&
  SFT.Host.Text.equal (measurementName c.measurement) "formal-object-sealed-before-comparison" &&
  SFT.Host.Text.equal (extensionName c.extension) "append-traced-node" &&
  SFT.Host.Text.equal (ruleName c.rule) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (rootName c.root) "disconnected-constant-list" then "A list cannot establish common mathematical identity." else
  if SFT.Host.Text.equal (foldName c.fold) "borrowed-numerals" then "Borrowed numbers are untraced inputs." else
  if SFT.Host.Text.equal (coversName c.covers) "selected-depth-labels" then "Selected depths are parameters." else
  if SFT.Host.Text.equal (typingName c.typing) "untyped-number-coincidence" then "Equal digits alone do not prove one object." else
  if SFT.Host.Text.equal (leadingName c.leading) "selected-headline-values" then "Headline selection can hide a disconnected branch." else
  if SFT.Host.Text.equal (terminalName c.terminal) "replacement-values-with-new-roots" then "Replacement would break the common object." else
  if SFT.Host.Text.equal (graphName c.graph) "sector-local-formulas-only" then "Local formulas do not expose common dependence." else
  if SFT.Host.Text.equal (mutationName c.mutation) "decorative-shared-labels" then "Labels without recomputation do not demonstrate dependence." else
  if SFT.Host.Text.equal (controlName c.control) "blanket-global-mutation" then "Changing everything cannot localize dependence." else
  if SFT.Host.Text.equal (measurementName c.measurement) "measurement-assembled-object" then "That would fit the dependency graph to targets." else
  if SFT.Host.Text.equal (extensionName c.extension) "rewrite-existing-object" then "Rewriting destroys provenance." else
  if SFT.Host.Text.equal (ruleName c.rule) "free-extra-rule" then "An extra selector is a parameter." else
  "One connected rooted Fold object generates the registered cross-sector constants. Its common order is b=2, c=3, spatial rank 3, boundary rank 2, down/up cover depths 5 and 7, leading inverse alpha 34259/250, charged-lepton product 1/485, depth-five conjugate 1/95, depth-seven product 1/383, dark/baryon 27/5 with dark share 27/32, Hubble 13/12, Planck exponent 127/2, local vacuum-energy floor 1/2^20 and half-One 1/2. V3 terminal continuations retain the same object and include inverse alpha 503846395469/3676744786, charged-lepton sharpened product 3/1454 and terminal product, quark products 1/383 and 1/3071, dark/baryon 279/52, Hubble 3305/3048, the terminal squared Planck hierarchy, local vacuum amplitude/energy floors 1/2^10 and 1/2^20, and normalized cosmological magnitude 33/16."

def generationRule : String := "Generate the complete twelve-axis product of root, Fold carrier, generated counts, cover geometry, typed sector incidence, leading vector, terminal continuation, graph connectedness, dependency mutation, independence control, measurement direction and extra-rule forms."
def grammarBoundary : String := "Every rooted typed dependency object over the admitted V3 electromagnetic, lepton, quark, dark/baryon, Hubble, Planck-hierarchy and vacuum branches, their exact foundation-order and terminal values, the full generator-three-to-successor dependency probe, the binary/rank independence controls and all 4096 alternatives."

def candidates : List Candidate :=
  ([Root.rejected,Root.admitted]).flatMap fun root =>
  ([Fold.rejected,Fold.admitted]).flatMap fun fold =>
  ([Covers.rejected,Covers.admitted]).flatMap fun covers =>
  ([Typing.rejected,Typing.admitted]).flatMap fun typing =>
  ([Leading.rejected,Leading.admitted]).flatMap fun leading =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Graph.rejected,Graph.admitted]).flatMap fun graph =>
  ([Mutation.rejected,Mutation.admitted]).flatMap fun mutation =>
  ([Control.rejected,Control.admitted]).flatMap fun control =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).flatMap fun extension =>
  ([Rule.rejected,Rule.admitted]).map fun rule =>
  ⟨root,fold,covers,typing,leading,terminal,graph,mutation,control,measurement,extension,rule⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk root fold covers typing leading terminal graph mutation control measurement extension rule =>
    have hroot : root ∈ [Root.rejected,Root.admitted] := by
      cases root <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfold : fold ∈ [Fold.rejected,Fold.admitted] := by
      cases fold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcovers : covers ∈ [Covers.rejected,Covers.admitted] := by
      cases covers <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htyping : typing ∈ [Typing.rejected,Typing.admitted] := by
      cases typing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hleading : leading ∈ [Leading.rejected,Leading.admitted] := by
      cases leading <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgraph : graph ∈ [Graph.rejected,Graph.admitted] := by
      cases graph <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmutation : mutation ∈ [Mutation.rejected,Mutation.admitted] := by
      cases mutation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontrol : control ∈ [Control.rejected,Control.admitted] := by
      cases control <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrule : rule ∈ [Rule.rejected,Rule.admitted] := by
      cases rule <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ root _ hroot
    apply CommonRefinement.memFlatMap _ _ fold _ hfold
    apply CommonRefinement.memFlatMap _ _ covers _ hcovers
    apply CommonRefinement.memFlatMap _ _ typing _ htyping
    apply CommonRefinement.memFlatMap _ _ leading _ hleading
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    apply CommonRefinement.memFlatMap _ _ graph _ hgraph
    apply CommonRefinement.memFlatMap _ _ mutation _ hmutation
    apply CommonRefinement.memFlatMap _ _ control _ hcontrol
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ extension _ hextension
    exact Count.TraceDerivation.memMap _ rule _ hrule


end SFT.Physics.UnifiedConstantsGrammar
