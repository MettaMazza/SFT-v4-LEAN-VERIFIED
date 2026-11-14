import SFT.Physics.MixingCorrespondence
namespace SFT.Physics.MirrorMassClosure
open LeptonIntervals VacuumLedgerProofs
structure Result where
 positions : List Rat
 shortfalls : List Rat
 positionSum : Rat
 shortfallSum : Rat
 mirrorClosed : Bool

def sumFromFirst : List Rat → Except String Rat
 | [] => .error "IndexError: tuple index out of range"
 | x::xs => .ok (xs.foldl add x)
def mirrorMassClosure : Except String Result := do
 let positions ← MixingCorrespondence.leptonMassBasis
 let shortfalls := positions.map (fun value => subtract (wholeRatio 1) value)
 if !(shortfalls == positions.reverse) then throw "lepton position/shortfall mirror failed"
 let positionSum ← sumFromFirst positions
 let shortfallSum ← sumFromFirst shortfalls
 pure ⟨positions,shortfalls,positionSum,shortfallSum,true⟩
def originalRecord : Result :=
 ⟨MixingCorrespondence.originalLeptonBasis,MixingCorrespondence.originalLeptonBasis.reverse,
 normalize 3 2 (by decide),normalize 3 2 (by decide),true⟩
theorem completeSourceRecord : mirrorMassClosure=.ok originalRecord := rfl
theorem exactReverse :
 MixingCorrespondence.originalLeptonBasis.map (fun value => subtract (wholeRatio 1) value)=
 MixingCorrespondence.originalLeptonBasis.reverse := rfl
theorem bothCompleteSums :
 sumFromFirst originalRecord.positions=.ok (normalize 3 2 (by decide)) ∧
 sumFromFirst originalRecord.shortfalls=.ok (normalize 3 2 (by decide)) := ⟨rfl,rfl⟩
/-- Every reverse-invariant observable agrees on the two original complete carriers. -/
theorem everySymmetricInvariant {α : Type} (observable : List Rat → α)
 (symmetric : ∀ xs, observable xs.reverse=observable xs) :
 observable originalRecord.shortfalls=observable originalRecord.positions :=
 symmetric MixingCorrespondence.originalLeptonBasis
end SFT.Physics.MirrorMassClosure
