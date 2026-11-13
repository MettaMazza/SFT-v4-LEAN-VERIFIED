import SFT.Materials.Specimen
namespace SFT.Materials.MaterialAnisotropy
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[66]. Direction and Response preserve the supplied
-- directional carrier and response relation types; no tensor law is added.
structure Record (Composition Direction Response : Type) where
 specimen : Specimen.Record Composition
 directions : List Direction
 response : Direction → Response
 conditions : SFT.Host.Canonical.Value
 method : SFT.Host.Canonical.Value
 coordinateSymmetryBoundary : SFT.Host.Canonical.Value

variable {Composition Direction Response : Type}

def anisotropic (r : Record Composition Direction Response) : Prop :=
 ∃ a ∈ r.directions, ∃ b ∈ r.directions, r.response a ≠ r.response b

def isotropic (r : Record Composition Direction Response) : Prop :=
 ∀ a ∈ r.directions, ∀ b ∈ r.directions, r.response a = r.response b

def census (r : Record Composition Direction Response) := r.directions.map (fun d => (d,r.response d))

theorem unequalResponsesRequireDistinctDirections (r : Record Composition Direction Response)
 (a b : Direction) (different : r.response a ≠ r.response b) : a ≠ b :=
 fun same => different (congrArg r.response same)

theorem anisotropyWitness (r : Record Composition Direction Response) (held : anisotropic r) :
 ∃ a ∈ r.directions, ∃ b ∈ r.directions, a ≠ b ∧ r.response a ≠ r.response b := by
 obtain ⟨a,ha,b,hb,different⟩ := held
 exact ⟨a,ha,b,hb,unequalResponsesRequireDistinctDirections r a b different,different⟩

theorem isotropyExcludesAnisotropy (r : Record Composition Direction Response) (same : isotropic r) :
 ¬ anisotropic r := by
 intro ⟨a,ha,b,hb,different⟩
 exact different (same a ha b hb)

theorem everyDirectionRetained (r : Record Composition Direction Response) (d : Direction)
 (held : d ∈ r.directions) : (d,r.response d) ∈ census r := memMap _ _ _ held

theorem noInventedResponse (r : Record Composition Direction Response) (row : Direction × Response)
 (held : row ∈ census r) : ∃ d ∈ r.directions, (d,r.response d) = row := memMapPreimage _ _ _ held

def appendDirection (r : Record Composition Direction Response) (d : Direction) : Record Composition Direction Response :=
 {r with directions := r.directions++[d]}

theorem successorCensus (r : Record Composition Direction Response) (d : Direction) :
 census (appendDirection r d) = census r++[(d,r.response d)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (fun x => (x,r.response x)) r.directions [d]

theorem priorAnisotropyRetained (r : Record Composition Direction Response) (d : Direction)
 (held : anisotropic r) : anisotropic (appendDirection r d) := by
 obtain ⟨a,ha,b,hb,different⟩ := held
 exact ⟨a,memAppendLeft _ _ _ ha,b,memAppendLeft _ _ _ hb,different⟩

theorem fixedIdentities (r : Record Composition Direction Response) (d : Direction) :
 (appendDirection r d).specimen = r.specimen ∧
 (appendDirection r d).conditions = r.conditions ∧
 (appendDirection r d).method = r.method ∧
 (appendDirection r d).coordinateSymmetryBoundary = r.coordinateSymmetryBoundary := ⟨rfl,rfl,rfl,rfl⟩

theorem coordinateRenamingRetainsResponse {Other : Type}
 (r : Record Composition Direction Response) (encode : Direction → Other) (decode : Other → Direction)
 (inverse : ∀ d, decode (encode d) = d) (a b : Direction) :
 r.response (decode (encode a)) = r.response (decode (encode b)) ↔ r.response a = r.response b := by
 rw [inverse a,inverse b]

def record (r : Record Composition Direction Response) := (r,census r)

theorem wholeInputRetained (r : Record Composition Direction Response) : (record r).1 = r := rfl

def records (rs : List (Record Composition Direction Response)) := rs.map record

theorem base (r : Record Composition Direction Response) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Composition Direction Response)) (r : Record Composition Direction Response) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.MaterialAnisotropy
