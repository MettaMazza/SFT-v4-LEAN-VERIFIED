import SFT.Physics.MirrorMassClosure
namespace SFT.Physics.MixingRowCoupling
open LeptonIntervals VacuumLedgerProofs
structure Result where
 quarkRowSum : Rat
 quarkLock : Rat
 leptonRowSum : Rat
 leptonLock : Rat
def interEntryCouplings : Except String Result := do
 let matrices ← MixingCorrespondence.mixingCorrespondence
 let quarkRow ← LeptonRatios.atIndex matrices.quarkMatrix 0
 let leptonRow ← LeptonRatios.atIndex matrices.leptonMatrix 0
 let quarkTotal ← MirrorMassClosure.sumFromFirst quarkRow
 let leptonTotal ← MirrorMassClosure.sumFromFirst leptonRow
 let quarkResidue := subtract quarkTotal (wholeRatio 1)
 let leptonResidue := subtract leptonTotal (wholeRatio 1)
 if !(quarkResidue == matrices.quarkLock) || !(leptonResidue == matrices.leptonLock) then
   throw "mixing rows did not return their generating locks"
 pure ⟨quarkTotal,quarkResidue,leptonTotal,leptonResidue⟩
def originalRecord : Result := ⟨normalize 5 3 (by decide),normalize 2 3 (by decide),normalize 3 2 (by decide),normalize 1 2 (by decide)⟩
theorem completeSourceRecord : interEntryCouplings=.ok originalRecord := rfl
theorem bothOriginalLocks : originalRecord.quarkLock=normalize 2 3 (by decide) ∧
 originalRecord.leptonLock=normalize 1 2 (by decide) := ⟨rfl,rfl⟩
end SFT.Physics.MixingRowCoupling
