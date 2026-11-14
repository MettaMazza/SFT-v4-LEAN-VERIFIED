import SFT.Physics.GravitonPolarization
namespace SFT.Physics.GravityWaveTrace

def increasing : List Int → Bool
 | [] => true
 | [_] => true
 | a::b::tail => decide (a<b) && increasing (b::tail)

def adjacentDifferences : List Int → List Int
 | [] => []
 | [_] => []
 | a::b::tail => (b-a)::adjacentDifferences (b::tail)

def positiveDifferences (values : List Int) : Except String (List Int) :=
 if values.length<2 || !increasing values then
  .error "difference trace requires increasing positive counts"
 else .ok (adjacentDifferences values)

structure Result where
 speed : Rat
 phaseTrace : List Rat
 monopoleRecord : String
 dipoleRecord : String
 firstUnfrozenSecondDifferences : List Int

def gravitationalWaveTrace : Except String Result := do
 let linearFirst ← positiveDifferences [1,2,3,4]
 let cubicFirst ← positiveDifferences [1,8,27,64]
 let cubicSecond ← positiveDifferences cubicFirst
 let uniform := match linearFirst with
  | [] => false
  | h::tail => tail.all (fun x => @decide (x=h) (Int.decEq x h))
 if !uniform || !decide (cubicSecond=[12,18]) then
  throw "quadrupole boundary witness failed"
 let phase : Rat := ⟨1,3,by decide,by decide⟩
 pure ⟨⟨1,1,by decide,by decide⟩,List.replicate 8 phase,"source-held","momentum-held",cubicSecond⟩

theorem originalLinearDifferences : positiveDifferences [1,2,3,4]=.ok [1,1,1] := rfl

theorem originalCubicDifferences : positiveDifferences [1,8,27,64]=.ok [7,19,37] := rfl

theorem originalSecondDifferences : positiveDifferences [7,19,37]=.ok [12,18] := rfl

theorem completeSourceRecord : gravitationalWaveTrace=.ok ⟨⟨1,1,by decide,by decide⟩,
 List.replicate 8 ⟨1,3,by decide,by decide⟩,"source-held","momentum-held",[12,18]⟩ := rfl

theorem everyRetainedTick : (List.replicate 8 (⟨1,3,by decide,by decide⟩ : Rat)).all
 (fun q => !q.blt ⟨1,3,by decide,by decide⟩ && !(⟨1,3,by decide,by decide⟩ : Rat).blt q)=true := rfl
end SFT.Physics.GravityWaveTrace
