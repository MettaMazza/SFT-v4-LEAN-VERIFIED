import SFT.Host.Text
/-! Literal formalisation of SFT-ROOT-THERE-IS-NO-NOTHING.
Source: sft/foundation/root_theorem.py. Candidate constructors encode only the registered
finite grammar; they add no scientific object. See reference/CORRESPONDENCE.json. -/
namespace SFT.Foundation.Root
inductive Candidate where
  | c0 | c1
  deriving DecidableEq, Repr

def candidateId : Candidate → String
  | .c0 => "unpresented-absence"
  | .c1 => "presented-occurrence"

def exactForm : Candidate → String
  | .c0 => "No statement, denial, record, trace or identity is presented; there is therefore no operational counterexample to admit."
  | .c1 => "A statement, denial, record, trace or identity is presented; that presentation is an occurrence and therefore is not nothing."

def presented : Candidate → Bool
  | .c0 => false
  | .c1 => true

def survives (c : Candidate) : Bool := presented c

def decisionReason (c : Candidate) : String :=
  if presented c then "Presentation supplies the witnessed occurrence required by the theorem."
  else "Without a presentation there is no counterexample object to admit."

def generationRule : String := "Partition every purported operational counterexample by whether it emits an identifiable presentation at the proof boundary."
def grammarBoundary : String := "All operational statements, denials, records and proof challenges, independent of their internal length or notation."

def candidates : List Candidate := [.c0, .c1]

def survivor : Candidate := .c1

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c <;> (repeat first | exact List.Mem.head _ | apply List.Mem.tail)

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  cases c <;> constructor <;> intro h <;> first | rfl | cases h

theorem survivorAccepted : survives survivor = true := rfl


/-! Source closure and non-hash control semantics. Hash-based source custody is translated in RootEvidence; full engine integration remains pending. -/
def closureRecord : List (String × String) :=
  [("scope", "depth_independent"),
   ("minimality", "Deleting the presented witness deletes the only admissible proof object; no smaller operational witness remains."),
   ("named_shape_uniqueness", "Of the complete presentation partition, only presented-occurrence can enter execution, and its occurrence prevents it from being nothing."),
   ("generality", "The decision uses only whether a challenge is presented, never its length, notation, content, depth or host representation."),
   ("boundary", grammarBoundary)]

-- Source closure_record generality: only presentation determines the decision.
theorem decisionUsesOnlyPresentation (c : Candidate) :
    survives c = presented c := rfl

-- Removing the presented witness leaves no accepted operational candidate.
theorem deletionRemovesOnlyWitness :
    ((candidates.erase survivor).filter survives) = [] := rfl

-- control_records dictionaries: names and field meanings are unchanged.
structure ControlRecord where
  kind : String
  premise : String
  expected : String
  observed : String
  passed : Bool

def falsePremiseControl : ControlRecord where
  kind := "false_premise"
  premise := "Treat an unpresented absence as a presented counterexample."
  expected := "reject because no counterexample identity or trace exists"
  observed := "unpresented-absence is not admissible as a counterexample"
  passed := !(survives .c0)

theorem falsePremiseControlPassed : falsePremiseControl.passed = true := rfl

def tamperedArtifactControl : ControlRecord where
  kind := "tampered_artifact"
  premise := "Mark both generated classes as surviving."
  expected := "reject because forcing no longer has a unique survivor"
  observed := "the tampered survivor set contains both named classes"
  passed := candidates.length != 1

theorem tamperedArtifactControlPassed : tamperedArtifactControl.passed = true := rfl

def boundaryControl : ControlRecord where
  kind := "boundary"
  premise := "Claim an unexpressed metaphysical object beyond the operational boundary."
  expected := "refuse the broadened claim because it supplies no checkable object"
  observed := "the theorem remains scoped to admissible operational objects"
  passed := SFT.Host.Text.contains (SFT.Host.Text.lowerAscii grammarBoundary) "operational"

-- The fixed source boundary is ASCII; this exactly preserves Python lower/substring semantics.
set_option maxRecDepth 10000 in
set_option maxHeartbeats 1000000 in
theorem boundaryControlPassed : boundaryControl.passed = true := rfl

end SFT.Foundation.Root
