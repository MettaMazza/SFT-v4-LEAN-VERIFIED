import SFT.Chemistry.OrganometallicElectronAccountDerivation
namespace SFT.Chemistry.OxidativeReductive
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel)
def sameLabels : List HeldLabel → List HeldLabel → Bool
 | [],[] => true
 | a::as,b::bs => sameLabel a b && sameLabels as bs
 | [],_::_ | _::_,[] => false
def sameIncidences : List (HeldLabel × HeldLabel) → List (HeldLabel × HeldLabel) → Bool
 | [],[] => true
 | a::as,b::bs => sameLabel a.1 b.1 && sameLabel a.2 b.2 && sameIncidences as bs
 | [],_::_ | _::_,[] => false
def uniqueLabels (xs : List HeldLabel) : List HeldLabel :=
 xs.foldl (fun out x => if out.any (sameLabel x) then out else out++[x]) []
structure OxidativeTrace where
 metals : List HeldLabel
 carriers : List HeldLabel
 sourceBond : List HeldLabel
 products : List (HeldLabel × HeldLabel)
 distribution : List PositiveCount
 direction : HeldLabel
def oxidativeTrace (metals carriers sourceBond : List HeldLabel) (products : List (HeldLabel × HeldLabel))
 (distribution : List PositiveCount) (direction : HeldLabel) : Except String OxidativeTrace :=
 if !(metals.length==1 || metals.length==2) || metals.any (fun m => !Text.equal m.family "metal-occurrence") then
  .error "oxidative addition requires one or two retained metal occurrences"
 else if carriers.any (fun x => !Text.equal x.family "transferred-carrier") || (uniqueLabels carriers).length != 2 then
  .error "two distinct transferred carriers must be retained"
 else if !sameLabels sourceBond carriers then
  .error "source covalent bond must retain both transferred carriers"
 else if !sameLabels (products.map Prod.snd) carriers then
  .error "product incidences must conserve both transferred carriers"
 else if products.any (fun p => !(metals.any (sameLabel p.1))) then
  .error "product incidence loses its retained metal"
 else if !(distribution.map PositiveCount.value == (if metals.length==1 then [2] else [1,1])) then
  .error "transfer distribution must be exact two on one metal or one on each of two"
 else if !sameLabel direction ⟨"electron-transfer-orientation","metal-support-to-two-new-incidences",rfl,rfl⟩ then
  .error "electron transfer orientation must remain held"
 else .ok ⟨metals,carriers,sourceBond,products,distribution,direction⟩
structure ReductiveTrace where
 oxidative : OxidativeTrace
 restoredBond : List HeldLabel
 removedProducts : List (HeldLabel × HeldLabel)
 direction : HeldLabel
def reductiveTrace (trace : OxidativeTrace) (restored : List HeldLabel) (removed : List (HeldLabel × HeldLabel))
 (direction : HeldLabel) : Except String ReductiveTrace :=
 if !sameLabels restored trace.sourceBond || !sameIncidences removed trace.products then
  .error "reductive elimination must exactly reverse the registered oxidative trace"
 else if !sameLabel direction ⟨"electron-transfer-orientation","two-incidences-to-metal-support",rfl,rfl⟩ then
  .error "reverse transfer orientation must remain held"
 else .ok ⟨trace,restored,removed,direction⟩
def oxidativeHeld (metals : List HeldLabel) (x y : HeldLabel) : Except String OxidativeTrace :=
 match metals with
 | [m] => oxidativeTrace metals [x,y] [x,y] [(m,x),(m,y)] [⟨2,by decide⟩]
   ⟨"electron-transfer-orientation","metal-support-to-two-new-incidences",rfl,rfl⟩
 | [m,n] => oxidativeTrace metals [x,y] [x,y] [(m,x),(n,y)] [⟨1,by decide⟩,⟨1,by decide⟩]
   ⟨"electron-transfer-orientation","metal-support-to-two-new-incidences",rfl,rfl⟩
 | [] | _::_::_::_ => .error "only the structurally generated one- and two-metal partitions are admissible"
def oxidative (metals : List String) (x y : String) : Except String OxidativeTrace := do
 let ms ← metals.mapM (heldLabel "metal-occurrence")
 let a ← heldLabel "transferred-carrier" x
 let b ← heldLabel "transferred-carrier" y
 oxidativeHeld ms a b
def reductive (trace : OxidativeTrace) : Except String ReductiveTrace :=
 reductiveTrace trace trace.sourceBond trace.products
  ⟨"electron-transfer-orientation","two-incidences-to-metal-support",rfl,rfl⟩
def one := oxidative ["M"] "X" "Y"
def two := oxidative ["M1","M2"] "X" "Y"
def singleWitness : Bool := match one with
 | .error _ => false | .ok t => t.distribution.map PositiveCount.value == [2]
def splitWitness : Bool := match two with
 | .error _ => false | .ok t => t.distribution.map PositiveCount.value == [1,1]
def reverseWitness : Bool := match one with
 | .error _ => false
 | .ok t => match reductive t with
  | .error _ => false | .ok r => sameLabels r.restoredBond t.sourceBond
def partitionWitness : Bool := match oxidative ["M1","M2","M3"] "X" "Y" with
 | .error _ => true | .ok _ => false
theorem singlePassed : singleWitness=true := by decide
theorem splitPassed : splitWitness=true := by decide
theorem reversePassed : reverseWitness=true := by decide
theorem partitionPassed : partitionWitness=true := by decide
end SFT.Chemistry.OxidativeReductive
