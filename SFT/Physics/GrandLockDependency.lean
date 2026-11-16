import SFT.Physics.PostNewtonianRecords
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.GrandLockDependency
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def inputHash := "sha256:325248e4081b287fbacd125efe18a9d5fbba05f1fbd459eaa2a61a225120b3ca"
def foundationalRoot := "SFT-FOUNDATION-ONE-001"
def frozenInput (bytes : ByteArray) (record : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) inputHash then throw "the frozen pre-lock Physics input changed"
 if !sameValue (getDefault record "schema") (.text "sft-v3-physics-grand-lock-input/1") then throw "wrong Grand Lock input schema"
 pure record
-- Direct list recursors preserve the source's ordered pure traversal and first error.
-- They avoid building course-of-values tables containing entire JSON records.
def recordMapImpl {α β : Type} (f : α → Except String β) (xs : List α) : Except String (List β) := xs.mapM f
@[implemented_by recordMapImpl]
def recordMap {α β : Type} (f : α → Except String β) : List α → Except String (List β) :=
 List.rec (.ok []) (fun a _ rest => do
  let b ← f a
  let bs ← rest
  pure (b::bs))
def recordFoldImpl {α β : Type} (f : β → α → Except String β) (initial : β) (xs : List α) : Except String β := xs.foldlM f initial
@[implemented_by recordFoldImpl]
def recordFold {α β : Type} (f : β → α → Except String β) (initial : β) (xs : List α) : Except String β :=
 (List.rec (motive := fun _ => β → Except String β) (fun acc => .ok acc) (fun a _ rest acc => do
  let next ← f acc a
  rest next) xs) initial
def recordFoldPureImpl {α β : Type} (f : β → α → β) (initial : β) (xs : List α) : β := xs.foldl f initial
@[implemented_by recordFoldPureImpl]
def recordFoldPure {α β : Type} (f : β → α → β) (initial : β) (xs : List α) : β :=
 (List.rec (motive := fun _ => β → β) (fun acc=>acc) (fun a _ rest acc=>rest (f acc a)) xs) initial
def recordAllImpl {α : Type} (f : α → Bool) (xs : List α) : Bool := xs.all f
@[implemented_by recordAllImpl]
def recordAll {α : Type} (f : α → Bool) : List α → Bool :=
 List.rec true (fun a _ rest => f a && rest)
def recordFilterImpl {α : Type} (f : α → Bool) (xs : List α) : List α := xs.filter f
@[implemented_by recordFilterImpl]
def recordFilter {α : Type} (f : α → Bool) : List α → List α :=
 List.rec [] (fun a _ rest => if f a then a::rest else rest)
def memberImpl (name : String) (xs : List String) : Bool := xs.any (fun a => @decide (name=a) (instDecidableEqString name a))
@[implemented_by memberImpl]
def member (name : String) : List String → Bool :=
 List.rec false (fun a _ rest => @decide (name=a) (instDecidableEqString name a) || rest)
-- Native finite dictionary for the source's dict/set/memo operations.
-- UTF-8 byte paths retain exact strings; insertion replaces only the same key.
inductive Dictionary (α : Type) where
 | node : Option α → List (Nat × Dictionary α) → Dictionary α
def emptyDictionary {α : Type} : Dictionary α := .node none []
def child {α : Type} (children : List (Nat × Dictionary α)) (key : Nat) : Dictionary α :=
 match children.find? (fun (k,_)=>k==key) with
 | none=>emptyDictionary
 | some (_,d)=>d
def keyBytes (s : String) : List Nat := s.toUTF8.data.toList.map UInt8.toNat
def dictionaryGet {α : Type} : List Nat → Dictionary α → Option α
 | [],.node value _=>value
 | k::ks,.node _ children=>dictionaryGet ks (child children k)
def dictionaryPut {α : Type} : List Nat → α → Dictionary α → Dictionary α
 | [],value,.node _ children=>.node (some value) children
 | k::ks,value,.node old children=>
  let next := dictionaryPut ks value (child children k)
  let children := if children.any (fun (key,_)=>key==k) then children.map (fun (key,d)=>(key,if key==k then next else d)) else (k,next)::children
  .node old children
def get {α : Type} (dictionary : Dictionary α) (name : String) : Option α := dictionaryGet (keyBytes name) dictionary
def put {α : Type} (dictionary : Dictionary α) (name : String) (value : α) : Dictionary α := dictionaryPut (keyBytes name) value dictionary
def contains {α : Type} (dictionary : Dictionary α) (name : String) : Bool := (get dictionary name).isSome
def nameSet (names : List String) : Dictionary Unit := recordFoldPure (fun d n=>put d n ()) emptyDictionary names
def uniqueImpl : List String → List String
 | []=>[]
 | x::xs=>if member x xs then uniqueImpl xs else x::uniqueImpl xs
@[implemented_by uniqueImpl]
def unique : List String → List String :=
 List.rec [] (fun x xs rest => if member x xs then rest else x::rest)
abbrev Rows := List (String × List String)
def rowDictionary (rows : Rows) : Dictionary (List String) := recordFoldPure (fun d (name,parents)=>put d name parents) emptyDictionary rows
def rowLookup (rows : Rows) (name : String) : Option (List String) := get (rowDictionary rows) name
abbrev Complete := Dictionary Unit × Nat
-- The finite dictionary bounds recursion depth; active repeats are tested first.
def visit (rows : Dictionary (List String)) : Nat → Dictionary Unit → Complete → String → Except String Complete
 | fuel,active,complete,name=>do
  if contains active name then throw "cycle in frozen dependency dictionary"
  if contains complete.1 name then return complete
  let dependencies ← match get rows name with
   | none=>throw "orphan dependency in frozen dictionary"
   | some ds=>pure ds
  match fuel with
  | 0=>throw "cycle in frozen dependency dictionary"
  | n+1=>
   let completed ← recordFold (fun done dep=>visit rows n (put active name ()) done dep) complete dependencies
   pure (put completed.1 name (),completed.2+1)
def reachesOne (rows : Dictionary (List String)) : Nat → Dictionary Bool → String → Except String (Bool × Dictionary Bool)
 | fuel,memo,name=>do
  if Text.equal name foundationalRoot then return (true,memo)
  match get memo name with
  | some value=>return (value,memo)
  | none=>pure ()
  let dependencies ← match get rows name with
   | none=>throw "orphan dependency in frozen dictionary"
   | some ds=>pure ds
  match fuel with
  | 0=>throw "cycle in frozen dependency dictionary"
  | n+1=>
   let result ← recordFold (fun (found,cache) dep=>do
    if found then pure (found,cache) else reachesOne rows n cache dep) (false,memo) dependencies
   pure (result.1,put result.2 name result.1)
def stringList (v : Value) : Except String (List String) := do recordMap text (← array v)
def traversalCount (rows : Rows) (physics : List String) : Except String Nat := do
 let dictionaryRows := rowDictionary rows
 let complete ← recordFold (fun done name=>visit dictionaryRows (rows.length+1) emptyDictionary done name) (emptyDictionary,0) physics
 pure complete.2
def allRooted (rows : Rows) (physics : List String) : Except String Bool := do
 let dictionaryRows := rowDictionary rows
 let roots ← recordFold (fun (found,memo) name=>do
  if !found then pure (false,memo) else reachesOne dictionaryRows (rows.length+1) memo name) (true,emptyDictionary) physics
 pure roots.1
def dependencyCertificate (record : Value) : Except String Value := do
 let dictionary ← array (← field record "dependency_dictionary")
 let rows ← recordMap (fun row=>do pure ((← text (← field row "claim_id")),(← stringList (← field row "dependencies")))) dictionary
 let physics ← stringList (← field record "physics_claim_ids")
 let distinct := unique physics
 let declared ← field record "physics_claim_count"
 -- Python's original chained comparison: len(ids) != len(set(ids)) == declared.
 if physics.length != distinct.length && sameValue (.integer (.ofNat distinct.length)) declared then
  throw "Physics ownership census is not unique and complete"
 let completeCount ← traversalCount rows physics
 let rooted ← allRooted rows physics
 let claims ← array (← field record "physics_claims")
 let owners ← recordMap (fun row=>do text (← field row "claim_id")) claims
 let ownerSet := nameSet owners
 let physicsSet := nameSet physics
 let evidence ← recordMap (fun row=>do
  let values ← recordMap (field row) ["receipt_hash","receipt_file_sha256","certificate_sha256","registration_sha256"]
  pure (recordAll SymmetricRecords.truthy values)) claims
 pure (.object [
 ("physics_claim_count",.integer (.ofNat physics.length)),
 ("transitive_claim_count",.integer (.ofNat completeCount)),
 ("no_omission",.boolean (physics.all (contains ownerSet) && owners.all (contains physicsSet))),
 ("acyclic",.boolean (sameValue (.integer (.ofNat completeCount)) (← field record "transitive_claim_count"))),
 ("all_reach_one",.boolean rooted),("all_evidence_hash_bound",.boolean (evidence.all id)),
 ("empirical_claim_count",← field record "empirical_claim_count"),
 ("unfavorable_or_scope_boundary_count",← field record "unfavorable_or_scope_boundary_count")])
#print axioms frozenInput
#print axioms visit
#print axioms reachesOne
#print axioms dependencyCertificate
end SFT.Physics.GrandLockDependency
