import SFT.Physics.HorizonInformation
namespace SFT.Physics.SpacetimeAdmissibility
open SFT.Mathematics.GeometryTopology

def wormholeAdmissible : FoldFirstReturn.Input → Bool → Bool → Bool
 | .nonFraction,_,_ => false
 | .fraction source,generatedLink,completeTrace =>
  LeptonIntervals.zero.blt source && generatedLink && completeTrace

def warpAdmissible : FoldFirstReturn.Input → FoldFirstReturn.Input → Bool → Bool
 | .nonFraction,_,_ | _,.nonFraction,_ => false
 | .fraction source,.fraction destination,returnedLedger =>
  LeptonIntervals.zero.blt source && LeptonIntervals.zero.blt destination && decide (source=destination) && returnedLedger

def closedTimelikeAdmissible (initial returned : List String) (completeTrace : Bool) : Bool :=
 !initial.isEmpty && decide (initial=returned) && completeTrace

theorem wormholeExact (source : Rat) (link trace : Bool) :
 wormholeAdmissible (.fraction source) link trace=true ↔
 LeptonIntervals.zero.blt source=true ∧ link=true ∧ trace=true := by
 constructor
 · intro h
   have a := (andTrue _ _).mp h
   have b := (andTrue _ _).mp a.1
   exact ⟨b.1,b.2,a.2⟩
 · intro h
   exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,h.2.2⟩

theorem warpExact (source destination : Rat) (ledger : Bool) :
 warpAdmissible (.fraction source) (.fraction destination) ledger=true ↔
 LeptonIntervals.zero.blt source=true ∧ LeptonIntervals.zero.blt destination=true ∧ source=destination ∧ ledger=true := by
 constructor
 · intro h
   have a := (andTrue _ _).mp h
   have b := (andTrue _ _).mp a.1
   have c := (andTrue _ _).mp b.1
   exact ⟨c.1,c.2,of_decide_eq_true b.2,a.2⟩
 · intro h
   exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,decide_eq_true h.2.2.1⟩,h.2.2.2⟩

theorem closedTimelikeExact (initial returned : List String) (trace : Bool) :
 closedTimelikeAdmissible initial returned trace=true ↔
 (!initial.isEmpty)=true ∧ initial=returned ∧ trace=true := by
 constructor
 · intro h
   have a := (andTrue _ _).mp h
   have b := (andTrue _ _).mp a.1
   exact ⟨b.1,of_decide_eq_true b.2,a.2⟩
 · intro h
   exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,decide_eq_true h.2.1⟩,h.2.2⟩

theorem originalWormholeWitnesses :
 wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) true true=true ∧
 wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) false true=false := ⟨rfl,rfl⟩

theorem originalWarpWitnesses :
 warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) true=true ∧
 warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) false=false ∧
 warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩) true=false := ⟨rfl,rfl,rfl⟩

theorem originalTimelikeWitnesses :
 closedTimelikeAdmissible ["state","proof"] ["state","proof"] true=true ∧
 closedTimelikeAdmissible ["state","proof"] ["changed-state","proof"] true=false ∧
 closedTimelikeAdmissible ["state","proof"] ["state","proof"] false=false := ⟨rfl,rfl,rfl⟩
end SFT.Physics.SpacetimeAdmissibility
