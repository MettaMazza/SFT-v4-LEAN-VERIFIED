import SFT.Physics.ThermoFluctuation
import SFT.InformationScience.ConservationCardinality
namespace SFT.Physics.ThermoIrreversibility
variable {History Macro Label : Type}

-- Retained predecessor labels are supplied by the actual microscopic record.
-- The extension keeps the macro projection and that record together.
def extend (observe : History → Macro) (label : History → Label) (history : History) :=
 (observe history,label history)

theorem macroProjectionPreserved (observe : History → Macro) (label : History → Label) (history : History) :
 (extend observe label history).1 = observe history := rfl

theorem retainedLabelPreserved (observe : History → Macro) (label : History → Label) (history : History) :
 (extend observe label history).2 = label history := rfl

theorem mergedHistoriesCannotBothBeDecoded (observe : History → Macro) (a b : History)
 (different : a ≠ b) (merged : observe a = observe b) (decode : Macro → History)
 (recoverA : decode (observe a) = a) (recoverB : decode (observe b) = b) : False :=
 different (recoverA.symm.trans ((congrArg decode merged).trans recoverB))

theorem extensionDistinguishesExactly (observe : History → Macro) (label : History → Label) (a b : History) :
 extend observe label a = extend observe label b ↔ observe a = observe b ∧ label a = label b := by
 constructor
 · intro h; exact ⟨congrArg Prod.fst h,congrArg Prod.snd h⟩
 · intro ⟨h,k⟩; unfold extend; rw [h,k]

theorem labelsMustSeparateMergedHistories (observe : History → Macro) (label : History → Label)
 (a b : History) (merged : observe a = observe b) (different : a ≠ b)
 (decode : Macro × Label → History)
 (recoverA : decode (extend observe label a) = a) (recoverB : decode (extend observe label b) = b) : label a ≠ label b := by
 intro same
 have equal := (extensionDistinguishesExactly observe label a b).mpr ⟨merged,same⟩
 exact different (recoverA.symm.trans ((congrArg decode equal).trans recoverB))

-- Keeping the complete predecessor record gives an explicit inverse.
def completeExtension (observe : History → Macro) (history : History) := extend observe (fun h => h) history

def recover (record : Macro × History) := record.2

theorem completeRecordReconstructs (observe : History → Macro) (history : History) :
 recover (completeExtension observe history) = history := rfl

theorem completeRecordInjective (observe : History → Macro) (a b : History)
 (same : completeExtension observe a = completeExtension observe b) : a = b := congrArg Prod.snd same

theorem retainedDecoderRecovers (observe : History → Macro) (label : History → Label)
 (decodeLabel : Label → History) (history : History) (complete : decodeLabel (label history) = history) :
 decodeLabel (extend observe label history).2 = history := complete

abbrev finiteReversalCriterion := SFT.InformationScience.ConservationCardinality.reversibleIffInjective
abbrev singletonFibreCriterion := SFT.InformationScience.ConservationCardinality.reversibleIffSingletonFibres
abbrev exactHeldFibreRecovery := SFT.InformationScience.ConservationReverse.heldRecovery
abbrev fullReverseRecords := SFT.InformationScience.ConservationReverse.reverseAdmitted
abbrev microscopicTraceDeterministic := ThermoFluctuation.deterministicSteps
abbrev completeObservedTrace := ThermoFluctuation.everyTraceRowRetained
end SFT.Physics.ThermoIrreversibility
