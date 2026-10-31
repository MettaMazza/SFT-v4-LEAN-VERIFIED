import SFT.Physics.GravityGeodesic
import SFT.Mathematics.GeometryShortest
namespace SFT.Physics.GravityGeodesicSelection
open SFT.Mathematics.GeometryTopology SFT.Mathematics.DiscreteObjects

-- Reuse the existing V3 geometry kernel's generated adjacent-support search.
-- It ranges over all admitted traces, including arbitrarily long competitors.
def select (nodes : List String) (edges : Boundary) (first last : String) :=
 pathDistance nodes edges first last

theorem everyReachableSupportHasSelectedPath (nodes : List String) (edges : Boundary)
 (first last : String) (admitted : (has nodes first && has nodes last)=true)
 (different : first ≠ last) (witness : List String) (trace : UndirectedTrace edges first last witness) :
 ∃ selected, select nodes edges first last=.ok (some selected) ∧ selected.length ≤ witness.length :=
 pathDistanceComplete nodes edges first last admitted different witness trace

theorem selectedPathIsGenerated (nodes : List String) (edges : Boundary)
 (first last : String) (different : first ≠ last) (selected : List String)
 (found : select nodes edges first last=.ok (some selected)) :
 UndirectedTrace edges first last selected :=
 pathDistanceTrace nodes edges first last selected different found

theorem selectedPathIsShortest (nodes : List String) (edges : Boundary)
 (first last : String) (admitted : (has nodes first && has nodes last)=true)
 (different : first ≠ last) (selected : List String)
 (found : select nodes edges first last=.ok (some selected))
 (alternative : List String) (trace : UndirectedTrace edges first last alternative) :
 selected.length ≤ alternative.length :=
 pathDistanceShortest nodes edges first last admitted different selected found alternative trace

theorem absentExactlyWhenNoGeneratedPath (nodes : List String) (edges : Boundary)
 (first last : String) (admitted : (has nodes first && has nodes last)=true)
 (different : first ≠ last) :
 select nodes edges first last=.ok none ↔ ¬ ∃ path, UndirectedTrace edges first last path :=
 pathDistanceNoneIff nodes edges first last admitted different
end SFT.Physics.GravityGeodesicSelection
