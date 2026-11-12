import SFT.Materials.RotationClosure
import SFT.Chemistry.SourceExtraction
namespace SFT.Materials.CrystalSystems
open SFT.Host

def lengthClasses : List String := ["all-equal","two-equal","all-distinct"]
def angleClasses : List String := ["all-right","two-right","all-equal-nonright","all-distinct"]

structure CrystalSystem where
 name : String
 lengthClass : String
 angleClass : String
 deriving Repr

def compatible : List CrystalSystem :=
 [⟨"cubic","all-equal","all-right"⟩,
  ⟨"tetragonal","two-equal","all-right"⟩,
  ⟨"orthorhombic","all-distinct","all-right"⟩,
  ⟨"hexagonal","two-equal","two-right"⟩,
  ⟨"trigonal","all-equal","all-equal-nonright"⟩,
  ⟨"monoclinic","all-distinct","two-right"⟩,
  ⟨"triclinic","all-distinct","all-distinct"⟩]

def lookup (lengthClass angleClass : String) : List CrystalSystem → Option String
 | [] => none
 | row::rest =>
   if Text.equal row.lengthClass lengthClass && Text.equal row.angleClass angleClass
   then some row.name else lookup lengthClass angleClass rest

def systemName (lengthClass angleClass : String) : Option String :=
 lookup lengthClass angleClass compatible

def metricGrammar : List (String × String) :=
 lengthClasses.flatMap (fun l => angleClasses.map (fun a => (l,a)))

def retained : List CrystalSystem := metricGrammar.flatMap fun (l,a) =>
 match systemName l a with
 | none => []
 | some name => [⟨name,l,a⟩]

def crystalSystemCensus : Except String (List CrystalSystem) :=
 if retained.length == 7 && SFT.Chemistry.SourceExtraction.unique (retained.map CrystalSystem.name)
 then .ok retained else .error "rank-three metric quotient did not close to seven classes"

theorem completeMetricCount : metricGrammar.length = 12 := rfl

theorem exactRetained : retained =
 [⟨"cubic","all-equal","all-right"⟩,
  ⟨"trigonal","all-equal","all-equal-nonright"⟩,
  ⟨"tetragonal","two-equal","all-right"⟩,
  ⟨"hexagonal","two-equal","two-right"⟩,
  ⟨"orthorhombic","all-distinct","all-right"⟩,
  ⟨"monoclinic","all-distinct","two-right"⟩,
  ⟨"triclinic","all-distinct","all-distinct"⟩] := rfl

theorem sevenSystems : retained.length = 7 := rfl

theorem distinctNames : SFT.Chemistry.SourceExtraction.unique (retained.map CrystalSystem.name) = true := rfl

theorem originalGuardPassed : crystalSystemCensus = .ok retained := rfl
end SFT.Materials.CrystalSystems
