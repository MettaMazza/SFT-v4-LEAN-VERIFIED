import SFT.Chemistry.InorganicNetwork
namespace SFT.Chemistry.InorganicNetworkBoundary
open SFT.Host SFT.Physics.CapabilityValues InorganicNetwork
open InorganicColour (distinctLabels)
inductive StepValue where
 | lewis : Lewis → StepValue
 | redox : Redox → StepValue
 | other : Value → StepValue

def acidRow : StepValue → Except String Lewis
 | .lewis s => .ok s
 | .redox _ | .other _ => .error "acid/base transition support is invalid"
def redoxRow : StepValue → Except String Redox
 | .redox s => .ok s
 | .lewis _ | .other _ => .error "redox transition support is invalid"
def mapSupport {α β : Type} (f : α → Except String β) : Support α → Except String (Support β)
 | .emptyOne s => .ok (.emptyOne s)
 | .rows xs => do return .rows (← xs.mapM f)

def networkInput (identity : HeldLabel) (species : List HeldLabel) (acid redox : Support StepValue) (path : List HeldLabel) : Except String Network :=
 if !Text.equal identity.family "inorganic-reaction-network" then .error "reaction network identity is invalid"
 else if species.isEmpty || !distinctLabels species then .error "reaction network requires positive complete species support"
 else if !(species.all (fun x => Text.equal x.family "chemical-species")) then .error "network species identity is invalid"
 else if (values acid).isEmpty && (values redox).isEmpty then .error "a reaction network requires positive transition support"
 else do
  let a ← mapSupport acidRow acid
  let r ← mapSupport redoxRow redox
  network identity species a r path
end SFT.Chemistry.InorganicNetworkBoundary
