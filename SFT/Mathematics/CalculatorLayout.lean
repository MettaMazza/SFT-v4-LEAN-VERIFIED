import SFT.Mathematics.CalculatorGUI
namespace SFT.Mathematics.CalculatorLayout
open SFT.Host SFT.Mathematics
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Builder where
 sequence : Nat := 0
 calls : List Canonical.Value := []
def ref (name : String) : Canonical.Value := .object [("ref",.text name)]
def callback (name : String) : Canonical.Value := .object [("callback",.text name)]
def emit (target method : String) (args : List Canonical.Value := []) (kwargs : List (String × Canonical.Value) := []) : StateM Builder Unit := do
 modify (fun s => {s with calls := s.calls ++ [.object [("target",.text target),("method",.text method),("args",.array args),("kwargs",.object kwargs)]]})
def create (kind : String) (args : List Canonical.Value := []) (kwargs : List (String × Canonical.Value) := []) : StateM Builder String := do
 let s ← get
 let name := Text.append "w" (CalculatorRoots.digits s.sequence)
 set {s with sequence := s.sequence+1}
 emit name (Text.append "new:" kind) args kwargs
 pure name
def constructor (available : List String) : StateM Builder Unit := do
 let root := "root"
 let expression ← create "tk.StringVar" [] []
 let result ← create "tk.StringVar" [] [("value",.text "0")]
 let mode ← create "tk.StringVar" [] [("value",.text "RAD")]
 let memory ← create "tk.StringVar" [] [("value",.text "")]
 emit root "title" [.text "Smithian Fold Scientific Calculator"] []
 emit root "geometry" [.text "1040x720"] []
 emit root "minsize" [.integer 860,.integer 620] []
 emit root "configure" [] [("background",.text "#f3f3f3")]
 emit "root.tk" "call" [.text "tk",.text "scaling",.object [("float",.text "1.15")]] []
 let style ← create "ttk.Style" [ref root] []
 emit style "theme_names" [] []
 if available.any (Text.equal "vista") then emit style "theme_use" [.text "vista"] []
 else if available.any (Text.equal "aqua") then emit style "theme_use" [.text "aqua"] []
 else if available.any (Text.equal "clam") then emit style "theme_use" [.text "clam"] []
 else pure ()
 emit style "configure" [.text "Display.TEntry"] [("font",.array [.text "Segoe UI",.integer 17]),("padding",.integer 10)]
 emit style "configure" [.text "Result.TLabel"] [("font",.array [.text "Segoe UI Semibold",.integer 25]),("anchor",.text "e")]
 emit style "configure" [.text "Calc.TButton"] [("font",.array [.text "Segoe UI",.integer 11]),("padding",.array [.integer 7,.integer 12])]
 emit style "configure" [.text "Equals.TButton"] [("font",.array [.text "Segoe UI Semibold",.integer 12]),("padding",.array [.integer 7,.integer 12])]
 emit style "configure" [.text "Title.TLabel"] [("font",.array [.text "Segoe UI Semibold",.integer 15])]
 let outer ← create "ttk.Frame" [ref root] [("padding",.integer 14)]
 emit outer "pack" [] [("fill",.text "both"),("expand",.boolean true)]
 emit outer "columnconfigure" [.integer 0] [("weight",.integer 3)]
 emit outer "columnconfigure" [.integer 1] [("weight",.integer 2)]
 emit outer "rowconfigure" [.integer 0] [("weight",.integer 1)]
 let calculator ← create "ttk.Frame" [ref outer] [("padding",.array [.integer 0,.integer 0,.integer 12,.integer 0])]
 emit calculator "grid" [] [("row",.integer 0),("column",.integer 0),("sticky",.text "nsew")]
 (List.range ((CalculatorDisplay.buttonRows.map List.length).foldl max 0)).forM fun column => do
  emit calculator "columnconfigure" [.integer (Int.ofNat column)] [("weight",.integer 1)]
 let header ← create "ttk.Frame" [ref calculator] []
 emit header "grid" [] [("row",.integer 0),("column",.integer 0),("columnspan",.integer 7),("sticky",.text "ew"),("pady",.array [.integer 0,.integer 8])]
 let titleLabel ← create "ttk.Label" [ref header] [("text",.text "Scientific"),("style",.text "Title.TLabel")]
 emit titleLabel "pack" [] [("side",.text "left")]
 let memoryLabel ← create "ttk.Label" [ref header] [("textvariable",ref memory)]
 emit memoryLabel "pack" [] [("side",.text "left"),("padx",.integer 12)]
 let modeBox ← create "ttk.Combobox" [ref header] [("textvariable",ref mode),("values",.array [.text "RAD",.text "DEG",.text "GRAD"]),("state",.text "readonly"),("width",.integer 6)]
 emit modeBox "pack" [] [("side",.text "right")]
 emit modeBox "bind" [.text "<<ComboboxSelected>>",callback "_change_mode"] []
 let entry ← create "ttk.Entry" [ref calculator] [("textvariable",ref expression),("justify",.text "right"),("style",.text "Display.TEntry")]
 emit entry "grid" [] [("row",.integer 1),("column",.integer 0),("columnspan",.integer 7),("sticky",.text "ew"),("pady",.array [.integer 0,.integer 4])]
 emit entry "bind" [.text "<Return>",callback "evaluate"] []
 emit entry "bind" [.text "<KP_Enter>",callback "evaluate"] []
 emit entry "bind" [.text "<Escape>",callback "clear"] []
 let resultFrame ← create "ttk.Frame" [ref calculator] []
 emit resultFrame "grid" [] [("row",.integer 2),("column",.integer 0),("columnspan",.integer 7),("sticky",.text "ew"),("pady",.array [.integer 0,.integer 10])]
 emit resultFrame "columnconfigure" [.integer 0] [("weight",.integer 1)]
 let resultLabel ← create "ttk.Label" [ref resultFrame] [("textvariable",ref result),("style",.text "Result.TLabel")]
 emit resultLabel "grid" [] [("row",.integer 0),("column",.integer 0),("sticky",.text "ew")]
 let copyButton ← create "ttk.Button" [ref resultFrame] [("text",.text "Copy"),("command",callback "copy_result")]
 emit copyButton "grid" [] [("row",.integer 0),("column",.integer 1),("padx",.array [.integer 8,.integer 0])]
 CalculatorDisplay.buttonRows.zipIdx.forM fun (row,rowIndex) => do
  emit calculator "rowconfigure" [.integer (Int.ofNat (rowIndex+3))] [("weight",.integer 1)]
  row.zipIdx.forM fun (label,column) => do
   let styleName := if Text.equal label "=" then "Equals.TButton" else "Calc.TButton"
   let button ← create "ttk.Button" [ref calculator] [("text",.text label),("command",.object [("callback",.text "press"),("label",.text label)]),("style",.text styleName)]
   emit button "grid" [] [("row",.integer (Int.ofNat (rowIndex+3))),("column",.integer (Int.ofNat column)),("sticky",.text "nsew"),("padx",.integer 2),("pady",.integer 2)]
 let sidebar ← create "ttk.Notebook" [ref outer] []
 emit sidebar "grid" [] [("row",.integer 0),("column",.integer 1),("sticky",.text "nsew")]
 let historyTab ← create "ttk.Frame" [ref sidebar] [("padding",.integer 10)]
 let traceTab ← create "ttk.Frame" [ref sidebar] [("padding",.integer 10)]
 let learnTab ← create "ttk.Frame" [ref sidebar] [("padding",.integer 10)]
 emit sidebar "add" [ref historyTab] [("text",.text "History")]
 emit sidebar "add" [ref traceTab] [("text",.text "Exact details")]
 emit sidebar "add" [ref learnTab] [("text",.text "Learn")]
 emit historyTab "rowconfigure" [.integer 0] [("weight",.integer 1)]
 emit historyTab "columnconfigure" [.integer 0] [("weight",.integer 1)]
 let historyList ← create "tk.Listbox" [ref historyTab] [("font",.array [.text "Segoe UI",.integer 11]),("activestyle",.text "none")]
 emit historyList "grid" [] [("row",.integer 0),("column",.integer 0),("sticky",.text "nsew")]
 emit historyList "bind" [.text "<Double-Button-1>",callback "restore_history"] []
 let historyClear ← create "ttk.Button" [ref historyTab] [("text",.text "Clear history"),("command",callback "clear_history")]
 emit historyClear "grid" [] [("row",.integer 1),("column",.integer 0),("sticky",.text "ew"),("pady",.array [.integer 8,.integer 0])]
 emit traceTab "rowconfigure" [.integer 0] [("weight",.integer 1)]
 emit traceTab "columnconfigure" [.integer 0] [("weight",.integer 1)]
 let traceText ← create "tk.Text" [ref traceTab] [("wrap",.text "word"),("font",.array [.text "Consolas",.integer 10]),("relief",.text "flat"),("background",.text "#ffffff")]
 emit traceText "grid" [] [("row",.integer 0),("column",.integer 0),("sticky",.text "nsew")]
 emit traceText "configure" [] [("state",.text "disabled")]
 emit learnTab "rowconfigure" [.integer 0] [("weight",.integer 1)]
 emit learnTab "columnconfigure" [.integer 0] [("weight",.integer 1)]
 let guide ← create "tk.Text" [ref learnTab] [("wrap",.text "word"),("font",.array [.text "Segoe UI",.integer 10]),("relief",.text "flat"),("background",.text "#ffffff")]
 emit guide "grid" [] [("row",.integer 0),("column",.integer 0),("sticky",.text "nsew")]
 emit guide "insert" [.text "1.0",Canonical.Value.text CalculatorDisplay.guideText] []
 emit guide "configure" [] [("state",.text "disabled")]
 emit entry "focus_set" [] []
def constructorCalls (available : List String) : List Canonical.Value := ((constructor available).run {}).2.calls
def initialState (places : Int := 18) : CalculatorGUI.State := {session := {places := places}}
inductive LaunchResult where
 | halt (message : String)
 | run (places : Int)
def launch (tkAvailable : Bool) (places : Int := 18) : LaunchResult :=
 if tkAvailable then .run places else .halt "this Python installation does not include the standard Tk graphical library; the terminal calculator remains available"
def launchCalls (tkAvailable : Bool) (available : List String) : Except String (List Canonical.Value) :=
 match launch tkAvailable with
 | .halt message => .error message
 | .run _ => .ok ([.object [("target",.text "root"),("method",.text "new:tk.Tk"),("args",.array []),("kwargs",.object [])]] ++ constructorCalls available ++ [.object [("target",.text "root"),("method",.text "mainloop"),("args",.array []),("kwargs",.object [])]])
end SFT.Mathematics.CalculatorLayout
