import SFT.Chemistry.NucleophilicCarrier
namespace SFT.Chemistry.NucleophilicPath
open NucleophilicCarrier SFT.Host SFT.Physics.CapabilityValues
structure ExactSubstitution where
 carrier : Carrier
 states : List State
 transitions : List Transition
 terminal : State
 pathClass : HeldLabel
 transitionCount : PositiveCount

def itemAt {α : Type} : List α → Nat → Except String α
 | [],_ => .error "tuple index out of range"
 | x::_,0 => .ok x
 | _::xs,n+1 => itemAt xs n

def sameEdges (as bs : List (HeldLabel × HeldLabel)) : Bool :=
 as.all (fun a => bs.any (sameEdge a)) && bs.all (fun b => as.any (sameEdge b))

def forcedPath (c : Carrier) (states : List State) (transitions : List Transition) : Except String ExactSubstitution := do
 if !(states.length==2 || states.length==3) || transitions.length != states.length-1 then
  throw "substitution admits exactly one-transition or two-transition paths"
 let first ← itemAt states 0
 if !sameState first c.source then throw "path must begin itemAt the complete registered source"
 if !sameSequence (fun a b => a==b) (transitions.map fun t => t.occurrence.value) ((List.range transitions.length).map (fun n => n+1)) then
  throw "transition occurrences must remain complete and gap-free"
 let roles ← states.mapM (stateRole c)
 (states.zip (transitions.zip (states.drop 1))).forM fun (left,edge,right) => do
  if !sameState edge.entry left || !sameState edge.exit right then
   throw "every transition must meet its retained adjacent states"
 let (actions,label) ←
  if sameSequence Text.equal roles ["source","terminal"] then
   pure (["exchange-support-in-one-transition"],"one-transition-exchange")
  else if sameSequence Text.equal roles ["source","cleaved-intermediate","terminal"] then
   pure (["cleave-displaced-support","form-entering-support"],"cleavage-then-formation")
  else throw "path order is outside the complete generated substitution family"
 if !sameSequence Text.equal (transitions.map fun t => t.action.label) actions then
  throw "transition labels do not reconstruct the generated state changes"
 let terminal ← itemAt states (states.length-1)
 let leaving := (c.centre,c.leaving)
 let entering := (c.centre,c.entering)
 let expected := ((c.source.bonds.map edge).filter (fun e => !sameEdge e leaving))++[entering]
 if !sameEdges (terminal.bonds.map edge) expected then throw "terminal state must replace only the single exchange bond"
 let pathClass ← heldLabel "substitution-path-class" label
 let transitionCount ← count transitions.length
 return ⟨c,states,transitions,terminal,pathClass,transitionCount⟩

def extend (c : Carrier) (result : ExactSubstitution) (newAtom : HeldLabel) (newPair : Pair) : Except String Bool := do
 if contains c.source.atoms newAtom || !Text.equal newAtom.family "substitution-atom-occurrence" then
  throw "successor requires one fresh retained substrate occurrence"
 let atoms := c.source.atoms++[newAtom]
 let states ← result.states.mapM fun s => do
  let added ← bond c.retained newAtom newPair
  state s.identity atoms (s.bonds++[added]) s.freePairs
 let source ← itemAt states 0
 let extendedCarrier ← carrier c.identity c.centre c.retained c.entering c.leaving c.enteringPair c.leavingPair source
 let edges ← result.transitions.zipIdx.mapM fun (e,i) => do
  transition e.occurrence (← itemAt states i) (← itemAt states (i+1)) e.action
 let extended ← forcedPath extendedCarrier states edges
 return DihedralTorsion.equalLabel extended.pathClass result.pathClass &&
  extended.transitionCount.value==result.transitionCount.value &&
  (extended.states.zip result.states).all (fun (s,prior) => sameSequence sameBond (s.bonds.take (s.bonds.length-1)) prior.bonds)
end SFT.Chemistry.NucleophilicPath
