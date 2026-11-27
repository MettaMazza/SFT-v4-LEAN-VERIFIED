import SFT.Chemistry.DefectDerivation
namespace SFT.Chemistry.InorganicNetwork
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel distinctLabels)
structure Lewis where
 step : HeldLabel
 provider : HeldLabel
 acceptor : HeldLabel
 pair : List HeldLabel
 adduct : HeldLabel
structure Redox where
 step : HeldLabel
 donor : HeldLabel
 acceptor : HeldLabel
 electrons : List HeldLabel
inductive Support (α : Type) where
 | emptyOne : String → Support α
 | rows : List α → Support α
structure Network where
 network : HeldLabel
 species : List HeldLabel
 acid : Support Lewis
 redox : Support Redox
 path : List HeldLabel

def species (label : String) := heldLabel "chemical-species" label
def values {α : Type} : Support α → List α
 | .emptyOne _ => [] | .rows xs => xs
def pack {α : Type} (xs : List α) : Support α :=
 if xs.isEmpty then .emptyOne "empty-One" else .rows xs

def lewis (step provider acceptor : HeldLabel) (pair : List HeldLabel) (adduct : HeldLabel) : Except String Lewis :=
 if !Text.equal step.family "inorganic-network-step" then .error "Lewis step identity is invalid"
 else if !([provider,acceptor,adduct].all (fun x => Text.equal x.family "chemical-species")) then .error "Lewis endpoints and adduct must retain chemical identities"
 else if !distinctLabels [provider,acceptor,adduct] then .error "Lewis provider, acceptor and adduct occurrences must be distinct"
 else if pair.length != 2 || !distinctLabels pair || !(pair.all (fun x => Text.equal x.family "electron-carrier")) then .error "Lewis joining requires the exact two retained pair occurrences"
 else .ok ⟨step,provider,acceptor,pair,adduct⟩
def lewisParticipants (s : Lewis) := [s.provider,s.acceptor,s.adduct]
def redox (step donor acceptor : HeldLabel) (electrons : List HeldLabel) : Except String Redox :=
 if !Text.equal step.family "inorganic-network-step" then .error "redox step identity is invalid"
 else if !([donor,acceptor].all (fun x => Text.equal x.family "chemical-species")) then .error "redox endpoints must retain chemical identities"
 else if sameLabel donor acceptor then .error "redox transfer requires distinct donor and acceptor occurrences"
 else if electrons.isEmpty || !distinctLabels electrons || !(electrons.all (fun x => Text.equal x.family "electron-carrier")) then .error "redox transfer requires positive complete electron support"
 else .ok ⟨step,donor,acceptor,electrons⟩
def transferCount (s : Redox) := count s.electrons.length
def redoxParticipants (s : Redox) := [s.donor,s.acceptor]
def sameSet (xs ys : List HeldLabel) : Bool :=
 xs.all (fun x => ys.any (sameLabel x)) && ys.all (fun y => xs.any (sameLabel y))
def network (identity : HeldLabel) (species : List HeldLabel) (acid : Support Lewis) (redox : Support Redox) (path : List HeldLabel) : Except String Network :=
 if !Text.equal identity.family "inorganic-reaction-network" then .error "reaction network identity is invalid"
 else if species.isEmpty || !distinctLabels species then .error "reaction network requires positive complete species support"
 else if !(species.all (fun x => Text.equal x.family "chemical-species")) then .error "network species identity is invalid"
 else
  let acids := values acid
  let redoxes := values redox
  if acids.isEmpty && redoxes.isEmpty then .error "a reaction network requires positive transition support"
  else
   let steps := acids.map Lewis.step ++ redoxes.map Redox.step
   if !distinctLabels steps then .error "network step identities are duplicated"
   else if path.length != steps.length || !sameSet path steps then .error "ordered path must retain every network step exactly once"
   else
    let participants := (acids.map lewisParticipants ++ redoxes.map redoxParticipants).flatten
    if !(participants.all (fun item => species.any (sameLabel item))) then .error "network species support omits a transition participant"
    else .ok ⟨identity,species,acid,redox,path⟩
def stepCount (s : Network) := count s.path.length

def lewisStep (label provider acceptor adduct : String) : Except String Lewis := do
 let step ← heldLabel "inorganic-network-step" label
 let p ← species provider
 let a ← species acceptor
 let one ← heldLabel "electron-carrier" (Text.append label "-fibre-one")
 let two ← heldLabel "electron-carrier" (Text.append label "-fibre-two")
 let product ← species adduct
 lewis step p a [one,two] product

def redoxStep (label donor acceptor : String) (n : PositiveCount) : Except String Redox := do
 let step ← heldLabel "inorganic-network-step" label
 let d ← species donor
 let a ← species acceptor
 let electrons ← (List.range n.value).mapM (fun i => heldLabel "electron-carrier" (Text.join [label,"-electron-",toString (i+1)]))
 redox step d a electrons

def reverseRedox (s : Redox) (label : String) : Except String Redox := do
 let step ← heldLabel "inorganic-network-step" label
 redox step s.acceptor s.donor s.electrons

def reactionNetwork (label : String) (speciesLabels : List String) (acid : List Lewis) (redox : List Redox) (pathLabels : List String) : Except String Network := do
 let identity ← heldLabel "inorganic-reaction-network" label
 let sp ← speciesLabels.mapM species
 let path ← pathLabels.mapM (heldLabel "inorganic-network-step")
 network identity sp (pack acid) (pack redox) path

def orderedUnique (xs : List HeldLabel) : List HeldLabel :=
 xs.foldl (fun acc x => if acc.any (sameLabel x) then acc else acc++[x]) []
def appendRedox (s : Network) (step : Redox) : Except String Network :=
 network s.network (orderedUnique (s.species++redoxParticipants step)) (pack (values s.acid))
  (.rows (values s.redox++[step])) (s.path++[step.step])
end SFT.Chemistry.InorganicNetwork
