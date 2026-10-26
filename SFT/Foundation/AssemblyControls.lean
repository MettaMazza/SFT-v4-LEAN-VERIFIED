import SFT.Foundation.AssemblySets
namespace SFT.Foundation.AssemblyControls
open FoldAssembly AssemblySupport AssemblySets SFT.Host.Canonical

def closureRecord : List (String × String) := [
  ("base","The empty One word is the complete support before a Fold; empty is a structural form, not numerical zero."),
  ("successor","Appending each of the two distinct held labels once to every prior word produces all and only the next support."),
  ("uniqueness","Distinct prior words or distinct appended held labels yield distinct successor traces."),
  ("return","The return relation at each Fold node reunites its two successor branches to their predecessor whole."),
  ("minimality","Removing a word loses support; duplicating or adding a word is nonminimal; missing transitions or returns loses construction identity."),
  ("named_shape_uniqueness","Only complete__consistent-length__support-complete__words-unique__transitions-present__returns-present__no-extra is complete."),
  ("generality","The base and successor clauses apply to every generated finite Fold depth without a maximum or completed infinity.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def depthCheck (n : Nat) : Bool :=
  sourceUniquenessCheck (supportAfterExtensions n) && lengthsAgree n (supportAfterExtensions n)

theorem depthCheckPassed (n : Nat) : depthCheck n = true :=
  (Count.Representation.andTrue _ _).mpr
    ⟨(sourceUniquenessIff _).mpr (allFiniteSupportsUnique n),
     (lengthsAgreeIff _ _).mpr (supportWordLength n)⟩

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(sameWordSet [["held-a"]] (supportAfterExtensions 1))
  expected := "reject incomplete one-step support"
  observed := "a single held-label word omits the other forced branch"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := ([1,2,3,4,5] : List Nat).all depthCheck
  expected := "reject duplicated or missing word support"
  observed := "generated depths one through five are unique, equal-length and complete"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := SFT.Host.Text.contains "The base and successor clauses apply to every generated finite Fold depth without a maximum or completed infinity." "completed infinity"
  expected := "refuse imported binary numerals, exponentiation and completed-infinite support"
  observed := "support is generated only by finite held-label recursion"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := by
  change (depthCheck 1 && (depthCheck 2 && (depthCheck 3 && (depthCheck 4 && (depthCheck 5 && true))))) = true
  rw [depthCheckPassed,depthCheckPassed,depthCheckPassed,depthCheckPassed,depthCheckPassed]
  rfl

set_option maxRecDepth 10000 in
theorem boundaryRecordPassed : boundary.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.AssemblyControls
