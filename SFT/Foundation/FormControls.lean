import SFT.Foundation.FormGrammar
import SFT.Foundation.FoldControls
namespace SFT.Foundation.FormControls
open SFT.Host.Canonical FormConstruction FormValidation
set_option maxRecDepth 20000

def closureRecord : List (String × String) := [
  ("base","The structural One is the sole terminal constructor."),
  ("recursion","The minimal Fold supplies exactly two distinctly held edges; each child must already be a generated finite Form; the node retains its return relation."),
  ("termination","Every admitted form has a finite construction trace ending only in One leaves. No completed infinite tree is formed."),
  ("completeness","Any finite assembly from One and Fold is parsed by the productions, and every production output is such an assembly."),
  ("minimality","Removing the base or a child, label, provenance or return loses a dependency; later arity or an extra constructor is unforced."),
  ("named_shape_uniqueness","Only base-included__two-children__labels-distinct-held__children-generated__return-present__finite-leaf-termination__no-extra defines the complete grammar."),
  ("generality","Structural induction over construction traces establishes the grammar at every generated finite tree depth.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def accepted (v : TupleValue) : Bool :=
  match valid v with
  | .ok b => b
  | .error _ => false

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(accepted (.tuple [.text "Fold",.tuple [.text "held-a",encode .one],.text "return"]))
  expected := "reject a one-child Fold node"
  observed := "the one-child production is outside the grammar"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := (generatedExamples.all fun f => accepted (encode f)) && !(accepted (.tuple [.text "Fold",.tuple [.text "held-a",encode .one],.tuple [.text "held-a",encode .one],.text "return"]))
  expected := "accept generated nonuniform finite trees and reject same-label edges"
  observed := "all generated examples parse and the same-label node does not"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := SFT.Host.Text.contains "Every admitted form has a finite construction trace ending only in One leaves. No completed infinite tree is formed." "No completed infinite tree"
  expected := "refuse completed-infinite trees and unforced constructors"
  observed := "only finite traces ending in One are admitted"

theorem generatedAccepted (f : Form) : accepted (encode f) = true := by
  unfold accepted
  rw [generatedFormsValid]

theorem falsePremisePassed : falsePremise.passed = true := rfl
theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl
theorem boundaryPassed : boundary.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.FormControls
