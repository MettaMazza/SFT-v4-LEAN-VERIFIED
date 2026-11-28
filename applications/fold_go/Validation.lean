import SFT.Applications.FoldGo.Protocol
open SFT.Applications.FoldGo
def record0 : List (Nat × Option Nat) := [(1,some 180),(2,some 288),(1,some 269),(2,some 268),(1,some 307),(2,some 289),(1,some 249),(2,some 287),(1,some 267),(2,some 59),(1,some 40),(2,some 41),(1,some 60),(2,some 78),(1,some 42),(2,some 22),(1,some 58),(2,some 79),(1,some 80),(2,some 61),(1,some 62),(2,some 99),(1,some 81),(2,some 23),(1,some 43),(2,some 72),(1,some 98),(2,some 117),(1,some 97),(2,some 96),(1,some 118),(2,some 116),(1,some 100),(2,some 137),(1,some 119),(2,some 300),(1,some 98),(2,some 46),(1,some 136),(2,some 155),(1,some 115),(2,some 135),(1,some 301),(2,some 320),(1,some 281),(2,some 282),(1,some 138),(2,some 280),(1,some 156),(2,some 175),(1,some 157),(2,some 262),(1,some 302),(2,some 193),(1,some 174),(2,some 173),(1,some 77),(2,some 24),(1,some 60),(2,some 97),(1,some 45),(2,some 26),(1,some 319),(2,some 318),(1,some 25),(2,some 6),(1,some 136),(2,some 44),(1,some 64),(2,some 65),(1,some 338),(2,some 196),(1,some 290),(2,some 308),(1,some 63),(2,some 103),(1,some 27),(2,some 28),(1,some 8),(2,some 159),(1,some 25),(2,some 9),(1,some 7),(2,some 26),(1,some 137),(2,some 141),(1,some 5),(2,some 4),(1,some 6),(2,some 271),(1,some 160),(2,some 142),(1,some 47),(2,some 321),(1,some 84),(2,some 85),(1,some 66),(2,some 83),(1,some 21),(2,some 256),(1,some 3),(2,some 2),(1,some 22),(2,some 167),(1,some 1),(2,some 73),(1,some 57),(2,some 294),(1,some 39),(2,some 337),(1,some 102),(2,some 286),(1,some 82),(2,some 84),(1,some 120),(2,some 19),(1,some 104),(2,some 105),(1,some 86),(2,some 106),(1,some 122),(2,some 123),(1,some 140),(2,some 158),(1,some 124),(2,some 198),(1,some 143),(2,some 125)]
def record1 : List (Nat × Option Nat) := [(1,some 73),(2,some 74),(1,some 92),(2,some 91),(1,some 72),(2,some 53),(1,some 54),(2,some 34),(1,some 52),(2,some 51),(1,some 33),(2,some 14),(1,some 32),(2,some 93),(1,some 130),(2,some 149),(1,some 148),(2,some 147),(1,some 167),(2,some 186),(1,some 168),(2,some 150),(1,some 166),(2,some 165),(1,some 319),(2,some 31),(1,some 70),(2,some 90),(1,some 50),(2,some 49),(1,some 184),(2,some 69),(1,some 71),(2,some 203),(1,some 185),(2,some 320),(1,some 301),(2,some 300),(1,some 318),(2,some 302),(1,some 282),(2,some 183),(1,some 283),(2,some 338),(1,some 339),(2,some 303),(1,some 202),(2,some 221),(1,some 201),(2,some 200),(1,some 220),(2,some 111),(1,some 110),(2,some 128),(1,some 182),(2,some 358),(1,some 321),(2,some 340),(1,some 320),(2,some 164),(1,some 88),(2,some 68),(1,some 105),(2,some 322),(1,some 293),(2,some 264),(1,some 129),(2,some 274),(1,some 275),(2,some 294),(1,some 276),(2,some 277),(1,some 295),(2,some 313),(1,some 312),(2,some 106),(1,some 87),(2,some 292),(1,some 311),(2,some 256),(1,some 257),(2,some 310),(1,some 273),(2,some 237),(1,some 255),(2,some 291),(1,some 288),(2,some 287),(1,some 306),(2,some 325),(1,some 268),(2,some 286),(1,some 307),(2,some 308),(1,some 326),(2,some 269),(1,some 250),(2,some 270),(1,some 249),(2,some 317),(1,some 233),(2,some 214),(1,some 215),(2,some 254),(1,some 235),(2,some 253),(1,some 234),(2,some 196),(1,some 197),(2,some 331),(1,some 330),(2,some 236),(1,some 274),(2,some 239),(1,some 238),(2,some 232),(1,some 195),(2,some 217),(1,some 177),(2,some 213),(1,some 174),(2,some 155),(1,some 173),(2,some 172),(1,some 154),(2,some 192),(1,some 153),(2,some 135)]
def require (condition : Bool) (label : String) : IO Unit :=
 if condition then IO.println ("PASS " ++ label) else throw (IO.userError label)
def main : IO Unit := do
 require (packBase == 65536) "source packing base"
 let empty := emptyBoard 3
 require (countedCommand empty == (1,1)) "empty share"
 let (_,p1) := playMove empty none 1
 let (_,p2) := playMove p1 none 2
 require (p2.history.length == 2) "duplicate pass history retained"
 let (board,refused) := record0.foldl (fun (b,n) (color,move) => let (ok,next) := playMove b move color; (next,n+(if ok then 0 else 1))) ((emptyBoard 19,0) : GoBoard × Nat)
 let (black,white) := areaScore board
 require (black == 73 && white+7 == 54 && refused == 2) "historical record 1: native rules/score/capture history"
 let (board,refused) := record1.foldl (fun (b,n) (color,move) => let (ok,next) := playMove b move color; (next,n+(if ok then 0 else 1))) ((emptyBoard 19,0) : GoBoard × Nat)
 let (black,white) := areaScore board
 require (black == 66 && white+7 == 70 && refused == 0) "historical record 2: native rules/score/capture history"
 let mut protocol : ProtocolState := {}
 for pair in [("1 protocol_version","=1 2\n\n"),("2 name","=2 SFT_TypeZero_Go\n\n"),("3 known_command nonexistent","=3 true\n\n"),("4 boardsize 1","=4\n\n"),("5 play b A1","?5 illegal move\n\n"),("6 genmove w","=6 pass\n\n"),("7 quit","=7\n\n")] do
  let (next,reply) := command protocol pair.1
  require (SFT.Host.Text.equal reply pair.2) pair.1
  protocol := next
 for size in [1,2,3] do
  let b := emptyBoard size
  let move := selectMove b 1 2
  require (match move with | none => true | some p => isLegal b p 1) s!"native search legality size {size}"
 for line in ["17", "17 boardsize", "17 genmove", "17 play", "17 play b"] do
  require (SFT.Host.Text.equal (command {} line).2 "? error: list index out of range\n\n") s!"missing arguments: {line}"
 require (signedDecimal "-2" == some (-2)) "signed depth conversion"
 IO.println "NATIVE VALIDATION COMPLETE"
