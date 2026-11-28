import SFT.Applications.FoldGo.Driver
namespace SFT.Applications.FoldGo
open SFT.Host.Text

def whitespace (c : Char) : Bool := decide (c.toNat = 32 ∨ (9 ≤ c.toNat ∧ c.toNat ≤ 13))
def words (s : String) : List String :=
 let (out,current) := (chars s).foldl (fun (out,current) c =>
  bif whitespace c then if current.isEmpty then (out,[]) else (String.ofList current.reverse::out,[])
  else (out,c::current)) (([],[]) : List String×List Char)
 (if current.isEmpty then out else String.ofList current.reverse::out).reverse

def upper (s : String) : String := String.ofList ((chars s).map fun c =>
 if 97 ≤ c.toNat ∧ c.toNat ≤ 122 then Char.ofNat (c.toNat-32) else c)

def decimal (s : String) : Option Nat :=
 let cs := chars s
 if cs.isEmpty then none
 else if cs.all (fun c => decide (48 ≤ c.toNat ∧ c.toNat ≤ 57)) then
  some (cs.foldl (fun n c => n*10+c.toNat-48) 0)
 else none

def signedDecimal (s : String) : Option Int :=
 match chars s with
 | [] => none
 | first::rest =>
  if first.toNat = 43 then (decimal (String.ofList rest)).map Int.ofNat
  else if first.toNat = 45 then (decimal (String.ofList rest)).map (fun n => -Int.ofNat n)
  else (decimal s).map Int.ofNat

def indexToGtp (idx : Option Nat) (size : Nat) : String :=
 match idx with
 | none => "pass"
 | some i =>
  let col := (chars "ABCDEFGHJKLMNOPQRSTY").toArray.getD (i%size) '?'
  append (String.ofList [col]) (SFT.Applications.FoldChess.integerText (Int.ofNat size-Int.ofNat (i/size)))

def gtpToIndex (input : String) (size : Nat) : Except String (Option Nat) :=
 let s := upper (intercalate " " (words input))
 if equal s "PASS" || equal s "RESIGN" then .ok none
 else match chars s with
 | [] => .error "string index out of range"
 | col::row =>
  let cols := chars "ABCDEFGHJKLMNOPQRSTY"
  match (List.range cols.length).find? (fun i => decide ((cols.toArray.getD i '?').toNat = col.toNat)), decimal (String.ofList row) with
  | some c, some r => .ok (some ((size-r)*size+c))
  | none, _ => .error "substring not found"
  | _, none => .error "invalid coordinate row"

def commandColor (s : String) : Nat :=
 let s := upper s
 if equal s "W" || equal s "WHITE" then 2 else 1

structure ProtocolState where
 board : GoBoard := emptyBoard 9
 search : SearchContext := {}
 quit : Bool := false

def response (id body : String) (success : Bool := true) : String :=
 append (append (bif success then "=" else "?") id) (append body "\n\n")

def command (state : ProtocolState) (line : String) : ProtocolState × String :=
 let parts := words line
 match parts with
 | [] => (state,"")
 | first::rest =>
  if ((chars first).headD ' ').toNat = 35 then (state,"")
  else
   let (id,cmd,args) := if (decimal first).isSome then (first,rest.headD "",rest.drop 1) else ("",first,rest)
   if equal cmd "" || ((equal cmd "boardsize" || equal cmd "genmove") && args.isEmpty) || (equal cmd "play" && decide (args.length < 2)) then (state,"? error: list index out of range\n\n")
   else if equal cmd "protocol_version" then (state,response id " 2")
   else if equal cmd "name" then (state,response id " SFT_TypeZero_Go")
   else if equal cmd "version" then (state,response id " 2.0")
   else if equal cmd "known_command" then (state,response id " true")
   else if equal cmd "list_commands" then (state,response id " protocol_version\nname\nversion\nknown_command\nlist_commands\nquit\nboardsize\nclear_board\nplay\ngenmove")
   else if equal cmd "quit" then ({state with quit := true},response id "")
   else if equal cmd "boardsize" then
    match decimal (args.headD "") with
    | none => (state,"? error: invalid boardsize\n\n")
    | some size => ({state with board := emptyBoard size},response id "")
   else if equal cmd "clear_board" then ({state with board := emptyBoard state.board.size},response id "")
   else if equal cmd "play" then
    match gtpToIndex (args.toArray.getD 1 "") state.board.size with
    | .error e => (state,append "? error: " (append e "\n\n"))
    | .ok move =>
     let (ok,board) := playMove state.board move (commandColor (args.headD ""))
     ({state with board},bif ok then response id "" else response id " illegal move" false)
   else if equal cmd "genmove" then
    let color := commandColor (args.headD "")
    let (move,search) := selectMoveWithContext state.board color 8 state.search
    let board := (playMove state.board move color).2
    ({state with board,search},response id (append " " (indexToGtp move board.size)))
   else (state,response id " unknown command" false)
end SFT.Applications.FoldGo
