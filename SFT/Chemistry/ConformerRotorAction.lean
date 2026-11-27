import SFT.Chemistry.ConformerIdentity
import SFT.Chemistry.ConformerAssignments
namespace SFT.Chemistry.ConformerRotorAction
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments ConformerIdentity
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

theorem identicalSitesMatch (sites : List PositiveCount) : sameSites sites sites=true := by
 have pairs : (sites.zip sites).all (fun (a,b) => a.value==b.value)=true := by
  induction sites with
  | nil => rfl
  | cons first rest ih =>
   change ((first.value==first.value) && (rest.zip rest).all (fun (a,b) => a.value==b.value))=true
   rw [naturalEqualityReflexive,ih]
   rfl
 unfold sameSites
 rw [naturalEqualityReflexive,pairs]
 rfl

theorem directTargetRetained (sites : List PositiveCount) (rotors : List Rotor)
 (rotor : Rotor) (index : Nat) (present : (rotor,index)∈rotors.zipIdx)
 (matched : sameSites sites rotor.orderedSites=true) :
 (index,false)∈targetMatches sites rotors := by
 have selected (rows : List (Rotor×Nat)) (member : (rotor,index)∈rows) :
  (index,false)∈rows.filterMap (fun ((target,i) : Rotor×Nat) => if sameSites sites target.orderedSites then some (i,false) else none) := by
  induction rows with
  | nil => cases member
  | cons row rest ih =>
   cases member with
   | head =>
    rw [List.filterMap_cons]
    dsimp only
    rw [matched]
    exact List.Mem.head _
   | tail _ member =>
    have retained := ih member
    rw [List.filterMap_cons]
    rcases row with ⟨target,i⟩
    dsimp only
    cases yes : sameSites sites target.orderedSites with
    | false => exact retained
    | true => exact List.Mem.tail _ retained
 exact memAppendLeft _ _ _ (selected _ present)

-- For the identity action, the source rotor is always one of the direct
-- matches. If the original guard accepts exactly one match, it must be this
-- own-index, non-reversed match; ambiguity follows the original error path.
theorem uniqueIdentityMatch (rotors : List Rotor) (rotor : Rotor) (index : Nat)
 (present : (rotor,index)∈rotors.zipIdx) (pair : Nat×Bool)
 (single : targetMatches rotor.orderedSites rotors=[pair]) : pair=(index,false) := by
 have member := directTargetRetained rotor.orderedSites rotors rotor index present
  (identicalSitesMatch rotor.orderedSites)
 rw [single] at member
 cases member with
 | head => rfl
 | tail _ impossible => cases impossible

theorem identityMappedMatch (size : Nat) (rotors : List Rotor) (rotor : Rotor) (index : Nat)
 (inside : ∀ site, site∈rotor.orderedSites → site.value≤size)
 (present : (rotor,index)∈rotors.zipIdx) (mapped : List PositiveCount)
 (evaluated : rotor.orderedSites.mapM (ConformerCarrier.apply ⟨positions size⟩)=.ok mapped)
 (pair : Nat×Bool) (single : targetMatches mapped rotors=[pair]) : pair=(index,false) := by
 rw [identitySiteWord size rotor.orderedSites inside] at evaluated
 have equal : rotor.orderedSites=mapped := Except.ok.inj evaluated
 rw [←equal] at single
 exact uniqueIdentityMatch rotors rotor index present pair single

-- Bind the own-index result to the actual source loop body, retaining its
-- original duplicate-index, alphabet and target-existence rejection paths.
theorem identitySuccessfulStep (size : Nat) (rotors : List Rotor) (alphabets : List Alphabet)
 (rotor : Rotor) (state : HeldLabel) (sourceAlphabet : Alphabet) (index : Nat)
 (transformed out : List (Nat×HeldLabel))
 (inside : ∀ site, site∈rotor.orderedSites → site.value≤size)
 (present : (rotor,index)∈rotors.zipIdx)
 (accepted : transformRotor ⟨positions size⟩ rotors alphabets transformed
  ((rotor,state),sourceAlphabet)=.ok out) : out=transformed++[(index,state)] := by
 unfold transformRotor at accepted
 dsimp only at accepted
 rw [identitySiteWord size rotor.orderedSites inside] at accepted
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
 cases matchRows : targetMatches rotor.orderedSites rotors with
 | nil => rw [matchRows] at accepted; cases accepted
 | cons pair rest =>
  cases rest with
  | cons second suffix => rw [matchRows] at accepted; cases accepted
  | nil =>
   have own := uniqueIdentityMatch rotors rotor index present pair matchRows
   rw [matchRows] at accepted
   dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
   rw [own] at accepted
   try dsimp only at accepted
   split at accepted
   · cases accepted
   · try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
     cases target : MolecularGraphEnumeration.atIndex alphabets index with
     | none => rw [target] at accepted; cases accepted
     | some targetAlphabet =>
      rw [target] at accepted
      try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
      split at accepted
      · cases accepted
      · cases accepted
        rfl
end SFT.Chemistry.ConformerRotorAction
