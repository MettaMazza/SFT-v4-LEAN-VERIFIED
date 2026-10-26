import SFT.Foundation.Root
/-! Literal formalisation of SFT-FOUNDATION-ONE-001.
Source: sft/foundation/one.py. Candidate constructors encode only the registered
finite grammar; they add no scientific object. See reference/CORRESPONDENCE.json. -/
namespace SFT.Foundation.One
inductive Candidate where
  | c0 | c1 | c2 | c3 | c4 | c5
  deriving DecidableEq, Repr

def candidateId : Candidate → String
  | .c0 => "omitted-root"
  | .c1 => "replacement-extra"
  | .c2 => "fragmented-root"
  | .c3 => "fragment-plus-extra"
  | .c4 => "exact-self-whole"
  | .c5 => "whole-plus-extra"

def exactForm : Candidate → String
  | .c0 => "Representation has none coverage of the admitted root occurrence and relation no-extra."
  | .c1 => "Representation has none coverage of the admitted root occurrence and relation has-extra."
  | .c2 => "Representation has proper coverage of the admitted root occurrence and relation no-extra."
  | .c3 => "Representation has proper coverage of the admitted root occurrence and relation has-extra."
  | .c4 => "Representation has complete coverage of the admitted root occurrence and relation no-extra."
  | .c5 => "Representation has complete coverage of the admitted root occurrence and relation has-extra."

def coverage : Candidate → String
  | .c0 => "none"
  | .c1 => "none"
  | .c2 => "proper"
  | .c3 => "proper"
  | .c4 => "complete"
  | .c5 => "complete"

def extra : Candidate → String
  | .c0 => "no-extra"
  | .c1 => "has-extra"
  | .c2 => "no-extra"
  | .c3 => "has-extra"
  | .c4 => "no-extra"
  | .c5 => "has-extra"

def survives (c : Candidate) : Bool :=
  coverage c == "complete" && extra c == "no-extra"

def decisionReason (c : Candidate) : String :=
  if coverage c == "none" then "It does not retain the admitted root occurrence." else
  if coverage c == "proper" then "It presupposes a cut and fails to retain the complete admitted identity." else
  if extra c == "has-extra" then "It introduces material not supplied by the sole admitted dependency." else
  "It retains the complete admitted occurrence without omission or addition."

def generationRule : String := "Generate the product of every root-coverage relation (none, proper, complete) with whether unforced extra material is present."
def grammarBoundary : String := "All representations classified solely by coverage of the admitted root occurrence and addition of material not supplied by that occurrence."

def candidates : List Candidate := [.c0, .c1, .c2, .c3, .c4, .c5]

def survivor : Candidate := .c4

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c <;> (repeat first | exact List.Mem.head _ | apply List.Mem.tail)

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  cases c <;> constructor <;> intro h <;> first | rfl | cases h

theorem survivorAccepted : survives survivor = true := rfl

end SFT.Foundation.One
