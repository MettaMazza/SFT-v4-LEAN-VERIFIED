import SFT.Physics.CapabilityValues
import SFT.Mathematics.GraphReachability
namespace SFT.Chemistry.MulticentreSupport
open SFT.Host SFT.Physics.CapabilityValues
structure Edge where
 left : HeldLabel
 right : HeldLabel
structure Support where
 molecularCarrier : HeldLabel
 topology : HeldLabel
 centres : List HeldLabel
 edges : List Edge
 electronSupport : List HeldLabel

def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def ribbon : HeldLabel := ⟨"delocalized-topology","ribbon-path",by rfl,by rfl⟩
def surface : HeldLabel := ⟨"delocalized-topology","surface-cycle",by rfl,by rfl⟩
def volume : HeldLabel := ⟨"delocalized-topology","volume-polyhedron",by rfl,by rfl⟩
def edge (a b : HeldLabel) : Except String Edge := do
 if !(Text.equal a.family "molecular-centre" && Text.equal b.family "molecular-centre") then
  throw "multicentre support edges require retained molecular centres"
 if sameLabel a b then throw "a support edge cannot erase its endpoint distinction"
 return ⟨a,b⟩
def contains (xs : List HeldLabel) (x : HeldLabel) : Bool := xs.any (sameLabel x)
def distinct (xs : List HeldLabel) : Bool := (xs.foldl (fun acc x => if contains acc x then acc else acc++[x]) []).length==xs.length
def sameEdge (a b : Edge) : Bool := (sameLabel a.left b.left && sameLabel a.right b.right) || (sameLabel a.left b.right && sameLabel a.right b.left)
def distinctEdges (xs : List Edge) : Bool := (xs.foldl (fun acc x => if acc.any (sameEdge x) then acc else acc++[x]) []).length==xs.length
def sameWord : List HeldLabel → List HeldLabel → Bool
 | [],[] => true
 | a::as,b::bs => sameLabel a b && sameWord as bs
 | [],_::_ | _::_,[] => false
def degrees (cs : List HeldLabel) (es : List Edge) : List Nat := cs.map fun c => (es.filter (fun e => sameLabel c e.left || sameLabel c e.right)).length
def addReached (xs : List HeldLabel) (x : HeldLabel) : List HeldLabel := if contains xs x then xs else xs++[x]
def scanEdges (es : List Edge) (reached : List HeldLabel) : List HeldLabel := es.foldl (fun acc e =>
 if contains acc e.left || contains acc e.right then addReached (addReached acc e.left) e.right else acc) reached
def connectedScan : Nat → List Edge → List HeldLabel → List HeldLabel
 | 0,_,reached => reached
 | n+1,es,reached =>
  let next := scanEdges es reached
  if next.length>reached.length then connectedScan n es next else next
-- After the endpoint-membership guards, each changing scan adds a registered centre.
-- The constructor's finite centre count bounds all changes; no user-selected cutoff.
def connected (cs : List HeldLabel) (es : List Edge) : Bool := match cs with
 | [] => false
 | first::_ => (connectedScan cs.length es [first]).length==cs.length
def construct (m t : HeldLabel) (cs : List HeldLabel) (es : List Edge) (word : List HeldLabel) : Except String Support := do
 if !Text.equal m.family "molecular-carrier" then throw "delocalized support requires one retained molecular carrier"
 if !(sameLabel t ribbon || sameLabel t surface || sameLabel t volume) then throw "delocalized support requires one generated topology"
 if cs.length<3 || !distinct cs then throw "multicentre support requires at least three distinct retained centres"
 if !(cs.all fun c => Text.equal c.family "molecular-centre") then throw "every multicentre vertex must retain its molecular-centre identity"
 if !distinctEdges es then throw "multicentre support contains a duplicate undirected edge"
 if !(es.all fun e => contains cs e.left && contains cs e.right) then throw "multicentre support edge escapes its registered centres"
 if !sameWord word cs then throw "one delocalized electron support must retain every centre exactly once"
 if !connected cs es then throw "delocalized molecular support must be connected"
 let ds := degrees cs es
 if sameLabel t ribbon && !(es.length+1==cs.length && (ds.filter (· == 1)).length==2 && ds.all (fun d => d==1 || d==2)) then throw "ribbon support must be one connected generated path"
 if sameLabel t surface && !(es.length==cs.length && ds.all (· == 2)) then throw "surface support must be one connected generated cycle"
 if sameLabel t volume && !(cs.length>=4 && es.length>cs.length && ds.any (· >= 3)) then throw "volume support must contain a connected polyhedral branch"
 return ⟨m,t,cs,es,word⟩
def positiveCentreCount (s : Support) : Except String PositiveCount := count s.centres.length
def positiveEdgeCount (s : Support) : Except String PositiveCount := count s.edges.length
def irreducible (s : Support) : Bool := s.centres.length>=3 && s.electronSupport.all (contains s.centres)
def centres (labels : List String) : Except String (List HeldLabel) := labels.mapM (heldLabel "molecular-centre")
def indexNat : List HeldLabel → Nat → Except String HeldLabel
 | [],_ => .error "tuple index out of range"
 | c::_,0 => .ok c
 | _::cs,n+1 => indexNat cs n
def index (cs : List HeldLabel) : Int → Except String HeldLabel
 | .ofNat n => indexNat cs n
 | .negSucc n => if n+1<=cs.length then indexNat cs (cs.length-(n+1)) else .error "tuple index out of range"
def support (molecule : String) (topology : HeldLabel) (labels : List String) (pairs : List (Int × Int)) : Except String Support := do
 let cs ← centres labels
 let es ← pairs.mapM fun (a,b) => do edge (← index cs a) (← index cs b)
 construct (← heldLabel "molecular-carrier" molecule) topology cs es cs
def pathPairs (n : Nat) : List (Int × Int) := (List.range (n-1)).map (fun i => (.ofNat i,.ofNat (i+1)))
def ribbonSupport (m : String) (labels : List String) : Except String Support := do
 if labels.length<3 then throw "ribbon support requires at least three centre labels"
 support m ribbon labels (pathPairs labels.length)
def surfaceSupport (m : String) (labels : List String) : Except String Support := do
 if labels.length<3 then throw "surface support requires at least three centre labels"
 support m surface labels (pathPairs labels.length++[(.ofNat (labels.length-1),0)])
def tetrahedralSupport (m : String) (labels : List String) : Except String Support := support m volume labels [(0,1),(0,2),(0,3),(1,2),(1,3),(2,3)]
def bridge := ribbonSupport "diborane" ["B-left","H-bridge","B-right"]
def ring := surfaceSupport "benzene" ["C-1","C-2","C-3","C-4","C-5","C-6"]
def tetrahedron := tetrahedralSupport "tetrahedrane" ["C-one","C-two","C-three","C-four"]
def bridgeWitness : Bool := match bridge with | .ok s => s.centres.length==3 && irreducible s | .error _ => false
def cycleWitness : Bool := match ring with | .ok s => s.centres.length==6 && s.edges.length==6 | .error _ => false
def volumeWitness : Bool := match tetrahedron with | .ok s => s.centres.length==4 && s.edges.length==6 | .error _ => false
def localizedWitness : Bool := match ribbonSupport "invalid" ["left","right"] with | .error _ => true | .ok _ => false
def disconnectedWitness : Bool := match support "invalid" ribbon ["one","two","three"] [(0,1)] with | .error _ => true | .ok _ => false
set_option maxRecDepth 10000
set_option maxHeartbeats 20000000
theorem bridgeWitnessPassed : bridgeWitness = true := rfl
theorem cycleWitnessPassed : cycleWitness = true := rfl
theorem volumeWitnessPassed : volumeWitness = true := rfl
theorem localizedWitnessPassed : localizedWitness = true := rfl
theorem disconnectedWitnessPassed : disconnectedWitness = true := rfl
end SFT.Chemistry.MulticentreSupport
