import SFT.Applications.Discovery.Carry
namespace SFT.Applications.Discovery.Source
open SFT.Host.Text
open SFT.Applications.Discovery.Carry

-- Source text is read; no Python module is imported or evaluated.
def lines (s : String) : List String :=
 let (out,current) := (chars s).foldl (fun (out,current) c =>
  if c.toNat = 10 then (String.ofList (c::current).reverse::out,[])
  else (out,c::current)) (([],[]) : List String×List Char)
 (if current.isEmpty then out else String.ofList current.reverse::out).reverse

def findAfter (needle : List Char) : List Char → Option (List Char)
 | [] => if needle.isEmpty then some [] else none
 | c::cs => bif hasPrefixChars needle (c::cs) then some ((c::cs).drop needle.length) else findAfter needle cs

def functionName (line : String) : Option String :=
 let cs := chars line
 if hasPrefixChars (chars "def ") cs then some (String.ofList ((cs.drop 4).takeWhile wordChar)) else none
structure Blocks where
 finished : List (String×String) := []
 name : Option String := none
 body : List String := []
 pending : List String := []
def finish (state : Blocks) : Blocks :=
 match state.name with
 | none => state
 | some name => {finished := state.finished++[(name,join state.body)]}
def functionBlocks (source : String) : List (String×String) :=
 let state := (lines source).foldl (fun state line =>
  match functionName line with
  | some name => {finish state with name := some name,body := [line]}
  | none =>
   if state.name.isNone then state else
   let cs := chars line
   if cs.all whitespace then {state with pending := state.pending++[line]}
   else if whitespace (cs.headD 'x') then {state with body := state.body++state.pending++[line],pending := []}
   else finish state) ({} : Blocks)
 (finish state).finished

def lookup (blocks : List (String×String)) (name : String) : Option String :=
 blocks.findSome? (fun (n,source) => bif SFT.Host.Text.equal n name then some source else none)
def testName (source : String) : Option String :=
 match findAfter (chars "test_") (chars source) with
 | none => none
 | some tail => let suffix := tail.takeWhile wordChar
                if suffix.isEmpty then none else some (append "test_" (String.ofList suffix))
def callAt (needle : String) (cs : List Char) : Option String :=
 if hasPrefixChars (chars needle) cs then
  let tail := cs.drop (chars needle).length
  let name := tail.takeWhile wordChar
  let rest := tail.drop name.length
  if !name.isEmpty && hasPrefixChars ['('] rest then some (String.ofList name) else none
 else none
def constructionCall : List Char → Option String
 | [] => none
 | c::cs =>
  match callAt "Co." (c::cs) with
  | some name => some name
  | none => match callAt "correspondence." (c::cs) with
    | some name => some name
    | none => constructionCall cs

def constructionSource (wrapper : String) (comparisons constructions : List (String×String)) : String :=
 match testName wrapper with
 | none => wrapper
 | some name => match lookup comparisons name with
  | none => wrapper
  | some test => match constructionCall (chars test) with
    | none => test
    | some name => (lookup constructions name).getD test

inductive Token where
 | literal (text : String)
 | identifier (text : String)
 | symbol (code : Nat)

def quoted (quote : Nat) : Nat → List Char → List Char → Except String (String × List Char)
 | 0, _, _ => .error "unterminated source string"
 | fuel+1, cs, out => match cs with
  | [] => .error "unterminated source string"
  | c::rest =>
   if c.toNat = quote then .ok (String.ofList out.reverse,rest)
   else if c.toNat = 92 then match rest with
    | [] => .error "unterminated source escape"
    | escaped::tail =>
     let decoded := if escaped.toNat = 110 then '\n' else if escaped.toNat = 116 then '\t' else if escaped.toNat = 114 then '\r' else escaped
     quoted quote fuel tail (decoded::out)
   else quoted quote fuel rest (c::out)

def lex : Nat → List Char → Except String (List Token)
 | 0, cs => if cs.isEmpty then .ok [] else .error "source token walk exhausted"
 | fuel+1, cs => match cs with
  | [] => .ok []
  | c::rest => do
   if whitespace c then lex fuel rest
   else if c.toNat = 35 then lex fuel (rest.dropWhile (fun c => decide (c.toNat ≠ 10)))
   else if c.toNat = 34 ∨ c.toNat = 39 then
    let (value,tail) ← quoted c.toNat (rest.length+1) rest []
    let more ← lex fuel tail
    pure (.literal value::more)
   else if wordChar c then
    let tail := rest.takeWhile wordChar
    let more ← lex fuel (rest.drop tail.length)
    pure (.identifier (String.ofList (c::tail))::more)
   else
    let more ← lex fuel rest
    pure (.symbol c.toNat::more)
structure Claim where
 tag : String
 status : String
 description : String
 comparison : String
 wrapper : String

def literalToken : List Token → Except String (String×List Token)
 | [] => .error "missing string token"
 | token::rest => match token with
  | .literal s => .ok (s,rest)
  | .identifier _ => .error "expected string token"
  | .symbol _ => .error "expected string token"
def identifierToken : List Token → Except String (String×List Token)
 | [] => .error "missing wrapper name"
 | token::rest => match token with
  | .identifier s => .ok (s,rest)
  | .literal _ => .error "expected wrapper name"
  | .symbol _ => .error "expected wrapper name"
def symbolToken (expected : Nat) : List Token → Except String (List Token)
 | [] => .error "missing separator"
 | token::rest => match token with
  | .symbol code => if code = expected then .ok rest else .error "unexpected separator"
  | .literal _ => .error "expected separator"
  | .identifier _ => .error "expected separator"
def claimRow (tokens : List Token) : Except String (Claim×List Token) := do
 let (tag,ts) ← literalToken tokens
 let ts ← symbolToken 44 ts
 let (status,ts) ← literalToken ts
 let ts ← symbolToken 44 ts
 let (description,ts) ← literalToken ts
 let ts ← symbolToken 44 ts
 let (comparison,ts) ← literalToken ts
 let ts ← symbolToken 44 ts
 let (wrapper,ts) ← identifierToken ts
 let ts ← symbolToken 41 ts
 pure ({tag,status,description,comparison,wrapper},ts)
def claimRows : Nat → List Token → Except String (List Claim)
 | 0, ts => if ts.isEmpty then .ok [] else .error "source row walk exhausted"
 | fuel+1, ts => match ts with
  | [] => .ok []
  | token::rest => match token with
   | .symbol code =>
    if code = 40 then do
     let (row,tail) ← claimRow rest
     let more ← claimRows fuel tail
     pure (row::more)
    else claimRows fuel rest
   | .literal _ => .error "unexpected registry string"
   | .identifier _ => .error "unexpected registry identifier"

def claims (source : String) : Except String (List Claim) := do
 let tail ← match findAfter (chars "CLAIMS=") (chars source) with
  | none => .error "CLAIMS assignment absent"
  | some cs => .ok cs
 let tokens ← lex (tail.length+1) tail
 claimRows (tokens.length+1) tokens

def readText (path : String) : IO String := do
 let bytes ← IO.FS.readBinFile (System.FilePath.mk path)
 return String.ofList (decode bytes.size bytes.data.toList)
structure Corpus where
 entries : List Claim
 wrappers : List (String×String)
 comparisons : List (String×String)
 constructions : List (String×String)
def load (root : String) : IO Corpus := do
 let registry ← readText (append root "/pure/claims_physics.py")
 let compare ← readText (append root "/pure/compare.py")
 let correspondence ← readText (append root "/pure/correspondence.py")
 let entries ← match claims registry with | .ok xs => pure xs | .error message => throw (IO.userError message)
 return {entries,wrappers := functionBlocks registry,comparisons := functionBlocks compare,constructions := functionBlocks correspondence}
def entrySource (corpus : Corpus) (entry : Claim) : String :=
 constructionSource ((lookup corpus.wrappers entry.wrapper).getD "") corpus.comparisons corpus.constructions
end SFT.Applications.Discovery.Source
