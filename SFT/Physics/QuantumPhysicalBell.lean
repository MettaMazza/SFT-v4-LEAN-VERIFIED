import SFT.Physics.QuantumPhysicalEntanglement
namespace SFT.Physics.QuantumPhysicalBell

-- A complete generated record includes both settings and the common preparation.
structure Event (Preparation LeftSetting RightSetting LeftOutput RightOutput : Type) where
  preparation : Preparation
  leftSetting : LeftSetting
  rightSetting : RightSetting
  leftOutput : LeftOutput
  rightOutput : RightOutput

def completeInput {P LS RS LO RO : Type} (e : Event P LS RS LO RO) :=
  (e.preparation,e.leftSetting,e.rightSetting)

def localFactorization {P LS RS LO RO Hidden : Type} (rows : List (Event P LS RS LO RO))
    (held : Event P LS RS LO RO → Hidden) (left : Hidden → LS → LO) (right : Hidden → RS → RO) : Prop :=
  ∀ e ∈ rows, left (held e) e.leftSetting = e.leftOutput ∧ right (held e) e.rightSetting = e.rightOutput

theorem omittedLeftDependenceExcludesFactorization {P LS RS LO RO Hidden : Type}
    (rows : List (Event P LS RS LO RO)) (held : Event P LS RS LO RO → Hidden)
    (a b : Event P LS RS LO RO) (ha : a ∈ rows) (hb : b ∈ rows)
    (sameHeld : held a = held b) (sameSetting : a.leftSetting = b.leftSetting)
    (different : a.leftOutput ≠ b.leftOutput) :
    ¬ ∃ left right, localFactorization rows held left right := by
  intro ⟨left,right,h⟩
  apply different
  exact ((h a ha).1.symm.trans ((congrArg (fun h => left h a.leftSetting) sameHeld).trans (congrArg (left (held b)) sameSetting))).trans (h b hb).1

theorem omittedRightDependenceExcludesFactorization {P LS RS LO RO Hidden : Type}
    (rows : List (Event P LS RS LO RO)) (held : Event P LS RS LO RO → Hidden)
    (a b : Event P LS RS LO RO) (ha : a ∈ rows) (hb : b ∈ rows)
    (sameHeld : held a = held b) (sameSetting : a.rightSetting = b.rightSetting)
    (different : a.rightOutput ≠ b.rightOutput) :
    ¬ ∃ left right, localFactorization rows held left right := by
  intro ⟨left,right,h⟩
  apply different
  exact ((h a ha).2.symm.trans ((congrArg (fun h => right h a.rightSetting) sameHeld).trans (congrArg (right (held b)) sameSetting))).trans (h b hb).2

def ledger {P LS RS LO RO : Type} (rows : List (Event P LS RS LO RO)) :=
  rows.map (fun e => (e,completeInput e,e.leftOutput,e.rightOutput))

theorem completeJointCensusRetained {P LS RS LO RO : Type} (rows : List (Event P LS RS LO RO)) :
    (ledger rows).map Prod.fst = rows := by
  induction rows with
  | nil => rfl
  | cons e rest ih => exact congrArg (List.cons e) ih

theorem everyGeneratedRecordPresent {P LS RS LO RO : Type} (rows : List (Event P LS RS LO RO))
    (e : Event P LS RS LO RO) (held : e ∈ rows) :
    (e,completeInput e,e.leftOutput,e.rightOutput) ∈ ledger rows :=
  SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem completeInputRetainsSettings {P LS RS LO RO : Type} (e : Event P LS RS LO RO) :
    (completeInput e).1 = e.preparation ∧ (completeInput e).2.1 = e.leftSetting ∧
      (completeInput e).2.2 = e.rightSetting := ⟨rfl,rfl,rfl⟩

theorem fullDeterministicRecordRetained {P LS RS LO RO : Type}
    (left : P → LS → RS → LO) (right : P → LS → RS → RO) (p : P) (ls : LS) (rs : RS) :
    completeInput (⟨p,ls,rs,left p ls rs,right p ls rs⟩ : Event P LS RS LO RO) = (p,ls,rs) := rfl

def physicalLedger {P LS RS LO RO : Type} (p : QuantumPhysicalState.Prepared)
    (describe : SFT.QuantumComputation.ReversibleModel.Word × String → Event P LS RS LO RO) :=
  (p,p.state.branches.map (fun branch => (branch,describe branch)))

theorem physicalSourceAndEveryBranchRetained {P LS RS LO RO : Type} (p : QuantumPhysicalState.Prepared)
    (describe : SFT.QuantumComputation.ReversibleModel.Word × String → Event P LS RS LO RO) :
    (physicalLedger p describe).1 = p ∧
      ((physicalLedger p describe).2.map Prod.fst) = p.state.branches := by
  refine ⟨rfl,?_⟩
  change (p.state.branches.map (fun b => (b,describe b))).map Prod.fst = p.state.branches
  induction p.state.branches with
  | nil => rfl
  | cons b bs ih => exact congrArg (List.cons b) ih

theorem physicalOmissionExcludesLocalFactorization {P LS RS LO RO Hidden : Type}
    (p : QuantumPhysicalState.Prepared)
    (describe : SFT.QuantumComputation.ReversibleModel.Word × String → Event P LS RS LO RO)
    (held : Event P LS RS LO RO → Hidden)
    (a b : SFT.QuantumComputation.ReversibleModel.Word × String)
    (ha : a ∈ p.state.branches) (hb : b ∈ p.state.branches)
    (sameHeld : held (describe a) = held (describe b))
    (sameSetting : (describe a).leftSetting = (describe b).leftSetting)
    (different : (describe a).leftOutput ≠ (describe b).leftOutput) :
    ¬ ∃ left right, localFactorization (p.state.branches.map describe) held left right :=
  omittedLeftDependenceExcludesFactorization _ held (describe a) (describe b)
    (SFT.Foundation.Count.TraceDerivation.memMap describe a _ ha)
    (SFT.Foundation.Count.TraceDerivation.memMap describe b _ hb) sameHeld sameSetting different
end SFT.Physics.QuantumPhysicalBell
