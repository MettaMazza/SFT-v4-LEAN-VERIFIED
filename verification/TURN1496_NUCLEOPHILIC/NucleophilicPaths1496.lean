import SFT.Chemistry.NucleophilicWitnesses
open SFT.Chemistry SFT.Chemistry.NucleophilicCarrier SFT.Chemistry.NucleophilicPath
open SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def held (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def joining (p : Pair) : J := .object [("first",held p.first),("second",held p.second)]
def bondValue (b : Bond) : J := .object [("left",held b.left),("right",held b.right),("pair",joining b.pair)]
def freeValue (f : FreePair) : J := .object [("owner",held f.owner),("pair",joining f.pair)]
def stateValue (s : State) : J := .object [("state_identity",held s.identity),("atoms",.array (s.atoms.map held)),("retained_bonds",.array (s.bonds.map bondValue)),("free_pairs",.array (s.freePairs.map freeValue))]
def carrierValue (c : Carrier) : J := .object [("reaction_identity",held c.identity),("centre",held c.centre),("retained_neighbour",held c.retained),("entering_carrier",held c.entering),("leaving_carrier",held c.leaving),("entering_pair",joining c.enteringPair),("leaving_pair",joining c.leavingPair),("source",stateValue c.source)]
def countValue (n : PositiveCount) : J := .object [("value",.integer (.ofNat n.value))]
def edgeValue (e : Transition) : J := .object [("occurrence",countValue e.occurrence),("entry",stateValue e.entry),("exit",stateValue e.exit),("action",held e.action)]
def resultValue (r : ExactSubstitution) : J := .object [("carrier",carrierValue r.carrier),("ordered_states",.array (r.states.map stateValue)),("ordered_transitions",.array (r.transitions.map edgeValue)),("terminal",stateValue r.terminal),("path_class",held r.pathClass),("transition_count",countValue r.transitionCount)]
def main : IO Unit := do
 let (c,one,two) ← IO.ofExcept NucleophilicWitnesses.sourcePaths
 IO.println (SFT.Host.Canonical.render (.array [carrierValue c,resultValue one,resultValue two]))
