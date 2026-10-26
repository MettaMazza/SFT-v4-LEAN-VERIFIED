import SFT.Host.Canonical
/-! Literal typed translation of engine/model.py Candidate/CandidateDecision and
engine.py::_decision_violations. Typed fields have the source dataclass domains.
Malformed Python values outside those annotations are not silently reinterpreted. -/
namespace SFT.Engine

structure Candidate where
  candidateId : String
  exactForm : String
  traceHash : String

structure CandidateDecision where
  candidateId : String
  survives : Bool
  reason : String
  proofHash : String

def candidateValue (c : Candidate) : SFT.Host.Canonical.Value := .object [
  ("candidate_id", .text c.candidateId), ("exact_form", .text c.exactForm),
  ("trace_hash", .text c.traceHash)]

def decisionValue (d : CandidateDecision) : SFT.Host.Canonical.Value := .object [
  ("candidate_id", .text d.candidateId), ("survives", .boolean d.survives),
  ("reason", .text d.reason), ("proof_hash", .text d.proofHash)]

-- Python str.strip emptiness uses these Unicode whitespace code points.
def pythonWhitespace (c : Char) : Bool :=
  let n := c.toNat
  (9 ≤ n && n ≤ 13) || (28 ≤ n && n ≤ 32) ||
  n == 133 || n == 160 || n == 5760 || (8192 ≤ n && n ≤ 8202) ||
  n == 8232 || n == 8233 || n == 8239 || n == 8287 || n == 12288

def blank (s : String) : Bool := (SFT.Host.Text.chars s).all pythonWhitespace

def isHexDigit (c : Char) : Bool :=
  (48 ≤ c.toNat && c.toNat ≤ 57) || (97 ≤ c.toNat && c.toNat ≤ 102)

def isSha256Identity (s : String) : Bool :=
  let bytes := s.toUTF8.data.toList
  let chars := SFT.Host.Text.chars s
  SFT.Host.Text.isPrefix "sha256:".toUTF8.data.toList bytes &&
  chars.length == 71 && (chars.drop 7).all isHexDigit

def sameIdentifiers : List String → List String → Bool
 | [], [] => true
 | [], _::_ => false
 | _::_, [] => false
 | a::as, b::bs => SFT.Host.Text.equal a b && sameIdentifiers as bs

def survivors (decisions : List CandidateDecision) : List CandidateDecision :=
  decisions.filter CandidateDecision.survives

-- Ordered accumulation is the source imperative append sequence.
def collectViolations : List (Bool × String) → List String
 | [] => []
 | (bad,msg)::xs => if bad then msg :: collectViolations xs else collectViolations xs

def decisionViolations (candidates : List Candidate) (decisions : List CandidateDecision) : List String :=
  collectViolations [
    (!(sameIdentifiers (decisions.map CandidateDecision.candidateId) (candidates.map Candidate.candidateId)),
      "decisions do not correspond one-for-one with the generated census"),
    (!((survivors decisions).length == 1), "forcing did not leave exactly one survivor"),
    (decisions.any (fun d => blank d.reason), "every candidate decision requires an explicit reason"),
    (decisions.any (fun d => !(isSha256Identity d.proofHash)), "every candidate decision requires a proof hash")]

theorem collectEmptyHeadFalse (b : Bool) (msg : String) (xs : List (Bool × String))
    (h : collectViolations ((b,msg)::xs) = []) : b = false := by
  cases b with
  | false => rfl
  | true => cases h

theorem collectEmptyTail (b : Bool) (msg : String) (xs : List (Bool × String))
    (h : collectViolations ((b,msg)::xs) = []) : collectViolations xs = [] := by
  cases b with
  | false => exact h
  | true => cases h

theorem eqOneOfBeq (n : Nat) (h : (n == 1) = true) : n = 1 := by
  cases n with
  | zero => cases h
  | succ n =>
    cases n with
    | zero => rfl
    | succ n => cases h

theorem passingDecisionGateHasOneSurvivor (cs : List Candidate) (ds : List CandidateDecision)
    (h : decisionViolations cs ds = []) : (survivors ds).length = 1 := by
  have tail := collectEmptyTail _ _ _ h
  have notBad := collectEmptyHeadFalse _ _ _ tail
  have good : ((survivors ds).length == 1) = true := by
    cases hb : ((survivors ds).length == 1) with
    | false => rw [hb] at notBad; cases notBad
    | true => rfl
  exact eqOneOfBeq _ good

end SFT.Engine
