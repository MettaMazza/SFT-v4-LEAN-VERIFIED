import SFT.Foundation.One
/-! Literal formalisation of SFT-FOUNDATION-COUNT-001.
Source: sft/foundation/count.py. Candidate constructors encode only the registered
finite grammar; they add no scientific object. See reference/CORRESPONDENCE.json. -/
namespace SFT.Foundation.Count
inductive Candidate where
  | c0 | c1 | c2 | c3 | c4 | c5 | c6 | c7 | c8 | c9
  deriving DecidableEq, Repr

def candidateId : Candidate → String
  | .c0 => "none-coverage__not-applicable__no-extra"
  | .c1 => "none-coverage__not-applicable__has-extra"
  | .c2 => "proper-coverage__once__no-extra"
  | .c3 => "proper-coverage__once__has-extra"
  | .c4 => "proper-coverage__duplicated__no-extra"
  | .c5 => "proper-coverage__duplicated__has-extra"
  | .c6 => "complete-coverage__once__no-extra"
  | .c7 => "complete-coverage__once__has-extra"
  | .c8 => "complete-coverage__duplicated__no-extra"
  | .c9 => "complete-coverage__duplicated__has-extra"

def exactForm : Candidate → String
  | .c0 => "Trace representation has none coverage, not-applicable retained multiplicity, and no-extra."
  | .c1 => "Trace representation has none coverage, not-applicable retained multiplicity, and has-extra."
  | .c2 => "Trace representation has proper coverage, once retained multiplicity, and no-extra."
  | .c3 => "Trace representation has proper coverage, once retained multiplicity, and has-extra."
  | .c4 => "Trace representation has proper coverage, duplicated retained multiplicity, and no-extra."
  | .c5 => "Trace representation has proper coverage, duplicated retained multiplicity, and has-extra."
  | .c6 => "Trace representation has complete coverage, once retained multiplicity, and no-extra."
  | .c7 => "Trace representation has complete coverage, once retained multiplicity, and has-extra."
  | .c8 => "Trace representation has complete coverage, duplicated retained multiplicity, and no-extra."
  | .c9 => "Trace representation has complete coverage, duplicated retained multiplicity, and has-extra."

def coverage : Candidate → String
  | .c0 => "none"
  | .c1 => "none"
  | .c2 => "proper"
  | .c3 => "proper"
  | .c4 => "proper"
  | .c5 => "proper"
  | .c6 => "complete"
  | .c7 => "complete"
  | .c8 => "complete"
  | .c9 => "complete"

def extra : Candidate → String
  | .c0 => "no-extra"
  | .c1 => "has-extra"
  | .c2 => "no-extra"
  | .c3 => "has-extra"
  | .c4 => "no-extra"
  | .c5 => "has-extra"
  | .c6 => "no-extra"
  | .c7 => "has-extra"
  | .c8 => "no-extra"
  | .c9 => "has-extra"

def multiplicity : Candidate → String
  | .c0 => "not-applicable"
  | .c1 => "not-applicable"
  | .c2 => "once"
  | .c3 => "once"
  | .c4 => "duplicated"
  | .c5 => "duplicated"
  | .c6 => "once"
  | .c7 => "once"
  | .c8 => "duplicated"
  | .c9 => "duplicated"

def survives (c : Candidate) : Bool :=
  coverage c == "complete" && multiplicity c == "once" && extra c == "no-extra"

def decisionReason (c : Candidate) : String :=
  if coverage c == "none" then "It retains no occurrence from the registered nonempty trace." else
  if coverage c == "proper" then "It omits at least one generated occurrence and is not the complete trace." else
  if multiplicity c == "duplicated" then "It repeats a retained occurrence and therefore changes the generated trace." else
  if extra c == "has-extra" then "It adds an occurrence not supplied by the registered generation trace." else
  "It retains every generated occurrence once and adds no occurrence."

def generationRule : String := "For no retained occurrence, generate the two ungenerated-extra classes. For proper or complete retained coverage, generate the product of exact-once or duplicated multiplicity with absence or presence of ungenerated extra occurrences."
def grammarBoundary : String := "All representations of any registered nonempty finite generation trace, classified by coverage of its generated occurrences, multiplicity of retained occurrences, and addition of occurrences outside that trace."

def candidates : List Candidate := [.c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9]

def survivor : Candidate := .c6

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c <;> (repeat first | exact List.Mem.head _ | apply List.Mem.tail)

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  cases c <;> constructor <;> intro h <;> first | rfl | cases h

theorem survivorAccepted : survives survivor = true := rfl

end SFT.Foundation.Count
