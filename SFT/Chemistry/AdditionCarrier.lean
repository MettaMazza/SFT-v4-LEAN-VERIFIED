import SFT.Chemistry.NucleophilicCarrier
namespace SFT.Chemistry.AdditionCarrier
open SFT.Host SFT.Physics.CapabilityValues
open DihedralTorsion (equalLabel distinctAtoms)
open NucleophilicCarrier (contains sameEdge)
structure Bond where
 left : HeldLabel
 right : HeldLabel
 heldSupport : HeldLabel
structure FreeSupport where
 owner : HeldLabel
 heldSupport : HeldLabel
structure State where
 identity : HeldLabel
 atoms : List HeldLabel
 bonds : List Bond
 freeSupports : List FreeSupport

def atom (label : String) := heldLabel "addition-atom-occurrence" label
def support (label : String) := heldLabel "addition-held-support" label
def bond (left right heldSupport : HeldLabel) : Except String Bond := do
 if !Text.equal left.family "addition-atom-occurrence" || !Text.equal right.family "addition-atom-occurrence" || equalLabel left right then
  throw "an addition bond requires two distinct retained atoms"
 if !Text.equal heldSupport.family "addition-held-support" then throw "an addition bond requires one exact held support"
 return ⟨left,right,heldSupport⟩
def freeSupport (owner heldSupport : HeldLabel) : Except String FreeSupport := do
 if !Text.equal owner.family "addition-atom-occurrence" then throw "a free addition support requires a retained atom owner"
 if !Text.equal heldSupport.family "addition-held-support" then throw "a free addition support requires one exact held support"
 return ⟨owner,heldSupport⟩
def endpoints (b : Bond) := (b.left,b.right)
def supports (s : State) : List HeldLabel := s.bonds.map Bond.heldSupport ++ s.freeSupports.map FreeSupport.heldSupport
def sameBond (a b : Bond) : Bool := equalLabel a.left b.left && equalLabel a.right b.right && equalLabel a.heldSupport b.heldSupport
def distinctBondKeys : List Bond → Bool
 | [] => true
 | b::bs => !(bs.any (fun c => sameEdge (endpoints b) (endpoints c) && equalLabel b.heldSupport c.heldSupport)) && distinctBondKeys bs
def state (identity : HeldLabel) (atoms : List HeldLabel) (bonds : List Bond) (freeSupports : List FreeSupport) : Except String State := do
 if !Text.equal identity.family "addition-state" then throw "an addition state requires one exact state identity"
 if atoms.length<2 || !distinctAtoms atoms then throw "an addition state requires distinct retained atoms"
 if atoms.any (fun a => !Text.equal a.family "addition-atom-occurrence") then throw "an addition state contains an invalid atom occurrence"
 if bonds.any (fun b => !contains atoms b.left || !contains atoms b.right) then throw "an addition bond leaves the declared atom carrier"
 if freeSupports.any (fun f => !contains atoms f.owner) then throw "a free support leaves the declared atom carrier"
 let out : State := ⟨identity,atoms,bonds,freeSupports⟩
 if !distinctAtoms (supports out) then throw "each held support must occur exactly once in a state"
 if !distinctBondKeys bonds then throw "one exact bond support cannot be duplicated"
 return out
end SFT.Chemistry.AdditionCarrier
