import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TerminalMuonAnomalyEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Base where
  | rejected | admitted

def baseName : Base → String
  | .rejected => "independent-fitted-muon-base"
  | .admitted => "complete-terminal-electron-loop"

inductive Generation where
  | rejected | admitted

def generationName : Generation → String
  | .rejected => "selected-generation-label"
  | .admitted => "second-charged-lepton-depth"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "selected-alpha-order"
  | .admitted => "two-charged-end-alpha-square"

inductive DepthTwo where
  | rejected | admitted

def depthTwoName : DepthTwo → String
  | .rejected => "free-leading-muon-weight"
  | .admitted => "both-labels-over-depth-two-complement"

inductive DepthThree where
  | rejected | admitted

def depthThreeName : DepthThree → String
  | .rejected => "free-successor-weight"
  | .admitted => "one-alpha-over-binary-depth-three-complement"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "selected-terminal-denominator"
  | .admitted => "four-rung-times-depth-three-plus-down-depth"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "signed-or-cancelled-series"
  | .admitted => "complete-positive-sum-appended-once"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurement-readable-execution"
  | .admitted => "target-inaccessible-until-prediction-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unregistered-fit"
  | .admitted => "registered-observational-prediction-protocol"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-muon-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  base : Base
  generation : Generation
  order : Order
  depthTwo : DepthTwo
  depthThree : DepthThree
  terminal : Terminal
  composition : Composition
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [baseName c.base, generationName c.generation, orderName c.order, depthTwoName c.depthTwo, depthThreeName c.depthThree, terminalName c.terminal, compositionName c.composition, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "base=" (baseName c.base), SFT.Host.Text.append "generation=" (generationName c.generation), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "depth-two=" (depthTwoName c.depthTwo), SFT.Host.Text.append "depth-three=" (depthThreeName c.depthThree), SFT.Host.Text.append "terminal=" (terminalName c.terminal), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-terminal-electron-loop__second-charged-lepton-depth__two-charged-end-alpha-square__both-labels-over-depth-two-complement__one-alpha-over-binary-depth-three-complement__four-rung-times-depth-three-plus-down-depth__complete-positive-sum-appended-once__target-inaccessible-until-prediction-seal__registered-observational-prediction-protocol__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (baseName c.base) "complete-terminal-electron-loop" &&
  SFT.Host.Text.equal (generationName c.generation) "second-charged-lepton-depth" &&
  SFT.Host.Text.equal (orderName c.order) "two-charged-end-alpha-square" &&
  SFT.Host.Text.equal (depthTwoName c.depthTwo) "both-labels-over-depth-two-complement" &&
  SFT.Host.Text.equal (depthThreeName c.depthThree) "one-alpha-over-binary-depth-three-complement" &&
  SFT.Host.Text.equal (terminalName c.terminal) "four-rung-times-depth-three-plus-down-depth" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-positive-sum-appended-once" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-prediction-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "registered-observational-prediction-protocol" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (baseName c.base) "independent-fitted-muon-base" then "A separate base loses electron/muon correspondence." else
  if SFT.Host.Text.equal (generationName c.generation) "selected-generation-label" then "A label alone cannot force a carrier." else
  if SFT.Host.Text.equal (orderName c.order) "selected-alpha-order" then "A selected order can tune the anomaly." else
  if SFT.Host.Text.equal (depthTwoName c.depthTwo) "free-leading-muon-weight" then "A free weight is fitted." else
  if SFT.Host.Text.equal (depthThreeName c.depthThree) "free-successor-weight" then "A free return is fitted." else
  if SFT.Host.Text.equal (terminalName c.terminal) "selected-terminal-denominator" then "A selected denominator is fitted." else
  if SFT.Host.Text.equal (compositionName c.composition) "signed-or-cancelled-series" then "Cancellation imports signed proof values." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-execution" then "That cannot issue a target-inaccessible prediction." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "unregistered-fit" then "An unregistered fit lacks custody and prediction receipts." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-muon-term" then "Depth two, its successor and terminal cell exhaust the registered muon grammar." else
  "The exact muon anomaly is the terminal electron anomaly plus alpha^2 [2/17 + alpha/106 + alpha^2/853], with 17=2*3^2-1, 53=2*3^3-1 and 853=16*53+5."

def generationRule : String := "Generate the complete ten-axis product of universal base, muon generation, coupling order, depth-two complement, depth-three return, terminal support, composition, target custody, provenance and extension forms."
def grammarBoundary : String := "All first terminal positive mass-scale corrections to the complete electron loop for the second charged-lepton generation, using depth-two/three complements, Fold labels, four-rung support and down-depth exactly once."

def candidates : List Candidate :=
  ([Base.rejected,Base.admitted]).flatMap fun base =>
  ([Generation.rejected,Generation.admitted]).flatMap fun generation =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([DepthTwo.rejected,DepthTwo.admitted]).flatMap fun depthTwo =>
  ([DepthThree.rejected,DepthThree.admitted]).flatMap fun depthThree =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨base,generation,order,depthTwo,depthThree,terminal,composition,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk base generation order depthTwo depthThree terminal composition target provenance extension =>
    have hbase : base ∈ [Base.rejected,Base.admitted] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgeneration : generation ∈ [Generation.rejected,Generation.admitted] := by
      cases generation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepthTwo : depthTwo ∈ [DepthTwo.rejected,DepthTwo.admitted] := by
      cases depthTwo <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepthThree : depthThree ∈ [DepthThree.rejected,DepthThree.admitted] := by
      cases depthThree <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ generation _ hgeneration
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ depthTwo _ hdepthTwo
    apply CommonRefinement.memFlatMap _ _ depthThree _ hdepthThree
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk base generation order depthTwo depthThree terminal composition target provenance extension =>
    cases base <;> cases generation <;> cases order <;> cases depthTwo <;> cases depthThree <;> cases terminal <;> cases composition <;> cases target <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk base generation order depthTwo depthThree terminal composition target provenance extension =>
    cases base <;> cases generation <;> cases order <;> cases depthTwo <;> cases depthThree <;> cases terminal <;> cases composition <;> cases target <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.base = .admitted ∧ c.generation = .admitted ∧ c.order = .admitted ∧ c.depthTwo = .admitted ∧ c.depthThree = .admitted ∧ c.terminal = .admitted ∧ c.composition = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk base generation order depthTwo depthThree terminal composition target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem base_rejected_rejected (c : Candidate) (h : c.base = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
    rw [h] at field
    cases field

theorem generation_rejected_rejected (c : Candidate) (h : c.generation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generation eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem depthTwo_rejected_rejected (c : Candidate) (h : c.depthTwo = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depthTwo eq
    rw [h] at field
    cases field

theorem depthThree_rejected_rejected (c : Candidate) (h : c.depthThree = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depthThree eq
    rw [h] at field
    cases field

theorem terminal_rejected_rejected (c : Candidate) (h : c.terminal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.terminal eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.TerminalMuonAnomalyEntryGrammar
