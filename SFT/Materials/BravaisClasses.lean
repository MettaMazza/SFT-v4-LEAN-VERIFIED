import SFT.Materials.CrystalSystems
namespace SFT.Materials.BravaisClasses
open SFT.Host CrystalSystems

def centeringClasses : List String := ["primitive","base","body","face","rhombohedral"]
def canonical : List (String × List String) :=
 [("triclinic",["primitive"]),("monoclinic",["primitive","base"]),
  ("orthorhombic",["primitive","base","body","face"]),
  ("tetragonal",["primitive","body"]),("trigonal",["rhombohedral"]),
  ("hexagonal",["primitive"]),("cubic",["primitive","body","face"])]

inductive CensusError where
 | keyError (key : String)
 | runtimeError (message : String)
 deriving Repr

structure BravaisClass where
 crystalSystem : String
 centering : String
 deriving Repr

def lookupCenterings (system : String) : List (String × List String) → Except CensusError (List String)
 | [] => .error (.keyError system)
 | (name,rows)::rest => if Text.equal name system then .ok rows else lookupCenterings system rest

def centeringPreservesSystem (system centering : String) : Except CensusError Bool := do
 let allowed ← lookupCenterings system canonical
 return allowed.any (fun c => Text.equal c centering)

def forms (systems : List CrystalSystem) : List (String × String) :=
 systems.flatMap (fun system => centeringClasses.map (fun centering => (system.name,centering)))

def collect : List (String × String) → Except CensusError (List BravaisClass)
 | [] => .ok []
 | (system,centering)::rest => do
   let keep ← centeringPreservesSystem system centering
   let tail ← collect rest
   return if keep then ⟨system,centering⟩::tail else tail

def equalRow (a b : BravaisClass) : Bool :=
 Text.equal a.crystalSystem b.crystalSystem && Text.equal a.centering b.centering

def uniqueRows : List BravaisClass → Bool
 | [] => true
 | row::rest => !(rest.any (equalRow row)) && uniqueRows rest

def bravaisCensus : Except CensusError (List BravaisClass) := do
 let systems ← match crystalSystemCensus with
   | .ok rows => .ok rows
   | .error message => .error (.runtimeError message)
 let survivors ← collect (forms systems)
 if survivors.length == 14 && uniqueRows survivors then .ok survivors
 else .error (.runtimeError "Bravais system/centering quotient did not close to fourteen classes")

def expected : List BravaisClass :=
 [⟨"cubic","primitive"⟩,⟨"cubic","body"⟩,⟨"cubic","face"⟩,
  ⟨"trigonal","rhombohedral"⟩,⟨"tetragonal","primitive"⟩,⟨"tetragonal","body"⟩,
  ⟨"hexagonal","primitive"⟩,⟨"orthorhombic","primitive"⟩,⟨"orthorhombic","base"⟩,
  ⟨"orthorhombic","body"⟩,⟨"orthorhombic","face"⟩,
  ⟨"monoclinic","primitive"⟩,⟨"monoclinic","base"⟩,⟨"triclinic","primitive"⟩]

theorem allThirtyFiveForms : (forms retained).length = 35 := rfl
theorem sourceOrderExact : collect (forms retained) = .ok expected := rfl
theorem fourteenDistinct : expected.length = 14 ∧ uniqueRows expected = true := ⟨rfl,rfl⟩
theorem originalGuardPassed : bravaisCensus = .ok expected := rfl
end SFT.Materials.BravaisClasses
