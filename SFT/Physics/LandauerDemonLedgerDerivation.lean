import SFT.Physics.LandauerDemonLedger
import SFT.Foundation.FoldFibres
import SFT.Foundation.CommonRefinement
import SFT.Physics.ThermoIrreversibility
namespace SFT.Physics.LandauerDemonLedgerDerivation
open SFT.Foundation.ExactPartCarrier
open LandauerDemonLedger
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original complete Fold fibre, specialized from its established dependency.
theorem originalCompleteResetFibre (p : Part) :
 SFT.Foundation.ExactOperations.foldPart p = SFT.Foundation.HalfOneDerivation.halfOne ↔
 p = (SFT.Foundation.FoldDynamics.preimages SFT.Foundation.HalfOneDerivation.halfOne).1 ∨
 p = (SFT.Foundation.FoldDynamics.preimages SFT.Foundation.HalfOneDerivation.halfOne).2 :=
 SFT.Foundation.FoldFibres.exactTwoPreimages p _
theorem originalFibreValues :
 asFraction (SFT.Foundation.FoldDynamics.preimages SFT.Foundation.HalfOneDerivation.halfOne).1 = quarterOne ∧
 asFraction (SFT.Foundation.FoldDynamics.preimages SFT.Foundation.HalfOneDerivation.halfOne).2 = threeQuarterOne := ⟨rfl,rfl⟩
theorem originalActualFold (p : Part) :
 foldPart (.fraction (asFraction p)) = .ok (asFraction (SFT.Foundation.ExactOperations.foldPart p)) := by
 unfold foldPart
 rw [SymmetryAction.originalAdmittedFold]
 rfl
theorem originalNativeFibreComplete (p : Part)
 (h : foldPart (.fraction (asFraction p)) = .ok halfOne) :
 asFraction p = quarterOne ∨ asFraction p = threeQuarterOne := by
 rw [originalActualFold] at h
 have same : asFraction (SFT.Foundation.ExactOperations.foldPart p) = halfOne := Except.ok.inj h
 have admitted := congrArg admitFraction same
 rw [admittedPartRoundTrip] at admitted
 have image : SFT.Foundation.ExactOperations.foldPart p = SFT.Foundation.HalfOneDerivation.halfOne := Option.some.inj admitted
 cases (originalCompleteResetFibre p).mp image with
 | inl lower => exact Or.inl ((congrArg asFraction lower).trans originalFibreValues.1)
 | inr upper => exact Or.inr ((congrArg asFraction upper).trans originalFibreValues.2)
theorem originalUnrecordedResetNotReversible (decode : Except String Rat → Rat)
 (lower : decode (foldPart (.fraction quarterOne)) = quarterOne)
 (upper : decode (foldPart (.fraction threeQuarterOne)) = threeQuarterOne) : False := by
 apply ThermoIrreversibility.mergedHistoriesCannotBothBeDecoded
  (fun q => foldPart (.fraction q)) quarterOne threeQuarterOne _
  (originalBothImages.1.trans originalBothImages.2.symm) decode lower upper
 intro h
 have bad : false = true := congrArg (fun q => SFT.Mathematics.LimitComputations.equalRat q threeQuarterOne) h
 exact Bool.noConfusion bad
-- The original retained lower/upper labels select precisely the original predecessors.
def predecessorForLabel (label : String) : Option Rat :=
 if SFT.Host.Text.equal label "lower-preimage" then some quarterOne
 else if SFT.Host.Text.equal label "upper-preimage" then some threeQuarterOne else none
theorem originalLowerRecord : predecessorForLabel "lower-preimage" = some quarterOne := rfl
theorem originalUpperRecord : predecessorForLabel "upper-preimage" = some threeQuarterOne := rfl
theorem originalRecordCriterion (label : String) :
 resetIsReversibleWithRecord label = (predecessorForLabel label).isSome := by
 change (SFT.Host.Text.equal label "lower-preimage" || (SFT.Host.Text.equal label "upper-preimage" || false)) =
  (if SFT.Host.Text.equal label "lower-preimage" then some quarterOne
   else if SFT.Host.Text.equal label "upper-preimage" then some threeQuarterOne else none).isSome
 cases h : SFT.Host.Text.equal label "lower-preimage" <;>
 cases k : SFT.Host.Text.equal label "upper-preimage" <;> rfl
-- Each source cycle contributes its actual gained and exported records.
def gainedRecords : List CycleLedger → List String
 | [] => [] | c::cs => c.sortingGain ++ gainedRecords cs
def exportedRecords : List CycleLedger → List String
 | [] => [] | c::cs => c.environmentRecord ++ exportedRecords cs
def closedDistinctions : List CycleLedger → Nat
 | [] => 0 | c::cs => c.erasedDistinctions + closedDistinctions cs
theorem originalFiniteClosedLedger (cs : List CycleLedger)
 (closed : ∀ c, c ∈ cs → c.sortingGain.length = c.erasedDistinctions ∧ c.environmentRecord.length = c.erasedDistinctions) :
 (gainedRecords cs).length = closedDistinctions cs ∧ (exportedRecords cs).length = closedDistinctions cs := by
 induction cs with
 | nil => exact ⟨rfl,rfl⟩
 | cons c cs ih =>
  have head := closed c (List.mem_cons_self)
  have tail := ih (fun d hd => closed d (List.mem_cons_of_mem c hd))
  constructor
  · change (c.sortingGain ++ gainedRecords cs).length = c.erasedDistinctions + closedDistinctions cs
    rw [SFT.Foundation.CommonRefinement.appendLength,head.1,tail.1]
  · change (c.environmentRecord ++ exportedRecords cs).length = c.erasedDistinctions + closedDistinctions cs
    rw [SFT.Foundation.CommonRefinement.appendLength,head.2,tail.2]
theorem originalReturnedCycleBalance (c : CycleLedger) (returned : demonCycleLedger = .ok c) :
 c.sortingGain.length = c.erasedDistinctions ∧ c.environmentRecord.length = c.erasedDistinctions := by
 have same := Except.ok.inj (originalCompleteLedger.symm.trans returned)
 cases same
 exact ⟨rfl,rfl⟩
theorem originalEveryReturnedCycleCloses (cs : List CycleLedger)
 (returned : ∀ c, c ∈ cs → demonCycleLedger = .ok c) :
 (gainedRecords cs).length = closedDistinctions cs ∧ (exportedRecords cs).length = closedDistinctions cs :=
 originalFiniteClosedLedger cs (fun c hc => originalReturnedCycleBalance c (returned c hc))
end SFT.Physics.LandauerDemonLedgerDerivation
