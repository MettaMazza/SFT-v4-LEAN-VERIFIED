import SFT.Chemistry.ElectrophilicCarrier
namespace SFT.Chemistry.ElectrophilicPath
open SFT.Host SFT.Physics.CapabilityValues ElectrophilicCarrier
open NucleophilicCarrier (Pair State sameState sameSequence contains bond state sameBond)
open NucleophilicPath (itemAt)
structure ExactExchange where
 carrier : Carrier
 states : List State
 transitions : List Transition
 terminal : State
 pathClass : HeldLabel
 transitionCount : PositiveCount
def forcedPath (c : Carrier) (states : List State) (transitions : List Transition) : Except String ExactExchange := do
 if !(states.length==2 || states.length==3) || transitions.length != states.length-1 then
  throw "acceptor exchange admits exactly one-transition or two-transition paths"
 let first ← itemAt states 0
 if !sameState first c.source then throw "path must begin at the complete registered source"
 if !sameSequence (fun a b => a==b) (transitions.map fun t => t.occurrence.value) ((List.range transitions.length).map (fun n => n+1)) then
  throw "transition occurrences must remain complete and gap-free"
 let roles ← states.mapM (stateRole c)
 (states.zip (transitions.zip (states.drop 1))).forM fun (left,edge,right) => do
  if !sameState edge.entry left || !sameState edge.exit right then
   throw "every transition must meet its retained adjacent states"
 let (actions,label) ←
  if sameSequence Text.equal roles ["source","restored-terminal"] then
   pure (["exchange-and-restore-in-one-transition"],"one-transition-exchange-and-restoration")
  else if sameSequence Text.equal roles ["source","addition-intermediate","restored-terminal"] then
   pure (["transfer-aromatic-pair-to-entering-support","relinquish-leaving-pair-to-restore-recurrence"],"addition-then-recurrence-restoration")
  else throw "path order is outside the complete generated acceptor-exchange family"
 if !sameSequence Text.equal (transitions.map fun t => t.action.label) actions then
  throw "transition actions do not reconstruct the generated states"
 let terminal ← itemAt states (states.length-1)
 let pathClass ← heldLabel "acceptor-substitution-path-class" label
 let transitionCount ← count transitions.length
 return ⟨c,states,transitions,terminal,pathClass,transitionCount⟩

def extend (result : ExactExchange) (newAtom : HeldLabel) (newPair : Pair) : Except String Bool := do
 let c := result.carrier
 if contains c.source.atoms newAtom || !Text.equal newAtom.family "substitution-atom-occurrence" then
  throw "aromatic successor requires one fresh retained occurrence"
 let atoms := c.source.atoms++[newAtom]
 let states ← result.states.mapM fun s => do
  let added ← bond c.left newAtom newPair
  state s.identity atoms (s.bonds++[added]) s.freePairs
 let source ← itemAt states 0
 let extendedCarrier ← carrier c.identity c.left c.centre c.right c.entering c.leaving c.donorPair c.recurrencePair c.leavingPair .emptyOne source
 let edges ← result.transitions.zipIdx.mapM fun (e,i) => do
  transition e.occurrence (← itemAt states i) (← itemAt states (i+1)) e.action
 let extended ← forcedPath extendedCarrier states edges
 return DihedralTorsion.equalLabel extended.pathClass result.pathClass &&
  extended.transitionCount.value==result.transitionCount.value &&
  (extended.states.zip result.states).all (fun (s,prior) => sameSequence sameBond (s.bonds.take (s.bonds.length-1)) prior.bonds)
end SFT.Chemistry.ElectrophilicPath
