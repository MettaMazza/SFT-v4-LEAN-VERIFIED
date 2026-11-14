import SFT.Computation.NativeVerification
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.NativePnpGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "arbitrary-external-languages"
  | .admitted => "complete-native-fold-word-family"

inductive Evaluator where
  | rejected | admitted

def evaluatorName : Evaluator → String
  | .rejected => "answer-only-evaluation"
  | .admitted => "unique-exact-closing-trace"

inductive Certificate where
  | rejected | admitted

def certificateName : Certificate → String
  | .rejected => "unconstrained-advice"
  | .admitted => "compiled-lawful-evaluation-trace"

inductive Verifier where
  | rejected | admitted

def verifierName : Verifier → String
  | .rejected => "test-sampled-verifier"
  | .admitted => "edgewise-sound-complete-verifier"

inductive P_to_np where
  | rejected | admitted

def p_to_npName : P_to_np → String
  | .rejected => "assumed-first-containment"
  | .admitted => "evaluator-emits-accepted-certificate"

inductive Np_to_p where
  | rejected | admitted

def np_to_pName : Np_to_p → String
  | .rejected => "nondeterministic-branch-import"
  | .admitted => "soundness-forces-unique-evaluation"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "depth-seven-only"
  | .admitted => "prepend-label-trace-successor"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "export-to-arbitrary-p-np"
  | .admitted => "native-equality-only"

structure Candidate where
  domain : Domain
  evaluator : Evaluator
  certificate : Certificate
  verifier : Verifier
  p_to_np : P_to_np
  np_to_p : Np_to_p
  successor : Successor
  boundary : Boundary

def sourceFields (c : Candidate) : List String := [domainName c.domain, evaluatorName c.evaluator, certificateName c.certificate, verifierName c.verifier, p_to_npName c.p_to_np, np_to_pName c.np_to_p, successorName c.successor, boundaryName c.boundary]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "evaluator=" (evaluatorName c.evaluator), SFT.Host.Text.append "certificate=" (certificateName c.certificate), SFT.Host.Text.append "verifier=" (verifierName c.verifier), SFT.Host.Text.append "p_to_np=" (p_to_npName c.p_to_np), SFT.Host.Text.append "np_to_p=" (np_to_pName c.np_to_p), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "boundary=" (boundaryName c.boundary)]
def survivorId : String := "complete-native-fold-word-family__unique-exact-closing-trace__compiled-lawful-evaluation-trace__edgewise-sound-complete-verifier__evaluator-emits-accepted-certificate__soundness-forces-unique-evaluation__prepend-label-trace-successor__native-equality-only"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "complete-native-fold-word-family" &&
  SFT.Host.Text.equal (evaluatorName c.evaluator) "unique-exact-closing-trace" &&
  SFT.Host.Text.equal (certificateName c.certificate) "compiled-lawful-evaluation-trace" &&
  SFT.Host.Text.equal (verifierName c.verifier) "edgewise-sound-complete-verifier" &&
  SFT.Host.Text.equal (p_to_npName c.p_to_np) "evaluator-emits-accepted-certificate" &&
  SFT.Host.Text.equal (np_to_pName c.np_to_p) "soundness-forces-unique-evaluation" &&
  SFT.Host.Text.equal (successorName c.successor) "prepend-label-trace-successor" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "native-equality-only"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "complete-native-fold-word-family") then "External languages import encodings and machines." else
  if !(SFT.Host.Text.equal (evaluatorName c.evaluator) "unique-exact-closing-trace") then "A verdict without its trace hides resource and soundness." else
  if !(SFT.Host.Text.equal (certificateName c.certificate) "compiled-lawful-evaluation-trace") then "Unconstrained advice imports answer power." else
  if !(SFT.Host.Text.equal (verifierName c.verifier) "edgewise-sound-complete-verifier") then "Examples cannot prove soundness over generated support." else
  if !(SFT.Host.Text.equal (p_to_npName c.p_to_np) "evaluator-emits-accepted-certificate") then "A familiar containment name is not evidence." else
  if !(SFT.Host.Text.equal (np_to_pName c.np_to_p) "soundness-forces-unique-evaluation") then "A foreign branch model changes the grammar." else
  if !(SFT.Host.Text.equal (successorName c.successor) "prepend-label-trace-successor") then "Finite testing alone is not depth-independent." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "native-equality-only") then "External languages, encodings and polynomial conventions are absent." else
  "The sole all-preserving kernel forces P_F=NP_F with exact resource k for every supplied positive finite native description depth, without asserting conventional P=NP."

def generationRule : String := "Generate the literal product of domain, evaluator, certificate, verifier, two containments, successor and external-boundary coordinates."
def grammarBoundary : String := "Every generated positive finite native Fold word, its unique suffix-closing evaluation and certificates composed only from the registered trace proof system."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Evaluator.rejected,Evaluator.admitted]).flatMap fun evaluator =>
  ([Certificate.rejected,Certificate.admitted]).flatMap fun certificate =>
  ([Verifier.rejected,Verifier.admitted]).flatMap fun verifier =>
  ([P_to_np.rejected,P_to_np.admitted]).flatMap fun p_to_np =>
  ([Np_to_p.rejected,Np_to_p.admitted]).flatMap fun np_to_p =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Boundary.rejected,Boundary.admitted]).map fun boundary =>
  ⟨domain,evaluator,certificate,verifier,p_to_np,np_to_p,successor,boundary⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain evaluator certificate verifier p_to_np np_to_p successor boundary =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevaluator : evaluator ∈ [Evaluator.rejected,Evaluator.admitted] := by
      cases evaluator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcertificate : certificate ∈ [Certificate.rejected,Certificate.admitted] := by
      cases certificate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hverifier : verifier ∈ [Verifier.rejected,Verifier.admitted] := by
      cases verifier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hp_to_np : p_to_np ∈ [P_to_np.rejected,P_to_np.admitted] := by
      cases p_to_np <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnp_to_p : np_to_p ∈ [Np_to_p.rejected,Np_to_p.admitted] := by
      cases np_to_p <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ evaluator _ hevaluator
    apply CommonRefinement.memFlatMap _ _ certificate _ hcertificate
    apply CommonRefinement.memFlatMap _ _ verifier _ hverifier
    apply CommonRefinement.memFlatMap _ _ p_to_np _ hp_to_np
    apply CommonRefinement.memFlatMap _ _ np_to_p _ hnp_to_p
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    exact Count.TraceDerivation.memMap _ boundary _ hboundary

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain evaluator certificate verifier p_to_np np_to_p successor boundary =>
    cases domain <;> cases evaluator <;> cases certificate <;> cases verifier <;> cases p_to_np <;> cases np_to_p <;> cases successor <;> cases boundary
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain evaluator certificate verifier p_to_np np_to_p successor boundary =>
    cases domain <;> cases evaluator <;> cases certificate <;> cases verifier <;> cases p_to_np <;> cases np_to_p <;> cases successor <;> cases boundary
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.evaluator = .admitted ∧ c.certificate = .admitted ∧ c.verifier = .admitted ∧ c.p_to_np = .admitted ∧ c.np_to_p = .admitted ∧ c.successor = .admitted ∧ c.boundary = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain evaluator certificate verifier p_to_np np_to_p successor boundary =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem evaluator_rejected_rejected (c : Candidate) (h : c.evaluator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.evaluator eq
    rw [h] at field
    cases field

theorem certificate_rejected_rejected (c : Candidate) (h : c.certificate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.certificate eq
    rw [h] at field
    cases field

theorem verifier_rejected_rejected (c : Candidate) (h : c.verifier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.verifier eq
    rw [h] at field
    cases field

theorem p_to_np_rejected_rejected (c : Candidate) (h : c.p_to_np = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.p_to_np eq
    rw [h] at field
    cases field

theorem np_to_p_rejected_rejected (c : Candidate) (h : c.np_to_p = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.np_to_p eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

end SFT.Computation.NativePnpGrammar
