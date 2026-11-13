import SFT.Materials.JunctionIndependentValidator
open SFT.Materials.JunctionIndependentValidator SFT.Engine SFT.Host.Canonical
def base : Sealed := {
 claim := claimId
 census := ⟨"", "", 256, "", generated.map (fun id => ⟨id,"",""⟩)⟩
 decisions := generated.map (fun id => ⟨id,SFT.Host.Text.equal id survivor,"",""⟩)
 closure := ⟨.depthIndependent,"",true,true,"",none⟩
 controls := [ControlKind.falsePremise,.tamperedSource,.tamperedArtifact,.boundary].map
   (fun kind => ⟨kind,true,"","",""⟩)
 sealHash := "original-validator-comparison"
}
def extra : CandidateDecision := ⟨"outside-original-domain",false,"",""⟩
def falseSurvivor : CandidateDecision := ⟨survivor,false,"",""⟩
def trueSurvivor : CandidateDecision := ⟨survivor,true,"",""⟩
def tests : List (String × Sealed) := [
 ("original",base),
 ("wrong-claim",{base with claim := "wrong"}),
 ("reversed-census",{base with census := {base.census with candidates := base.census.candidates.reverse}}),
 ("missing-candidate",{base with census := {base.census with candidates := base.census.candidates.drop 1}}),
 ("duplicate-candidate",{base with census := {base.census with candidates := base.census.candidates ++ base.census.candidates.take 1}}),
 ("wrong-cardinality",{base with census := {base.census with expectedCardinality := 255}}),
 ("negative-cardinality",{base with census := {base.census with expectedCardinality := -1}}),
 ("missing-decision",{base with decisions := base.decisions.drop 1}),
 ("foreign-decision",{base with decisions := base.decisions ++ [extra]}),
 ("reversed-decisions",{base with decisions := base.decisions.reverse}),
 ("earlier-false-overwritten",{base with decisions := falseSurvivor :: base.decisions}),
 ("later-false-retained",{base with decisions := base.decisions ++ [falseSurvivor]}),
 ("later-true-overwrites-false",{base with decisions := base.decisions ++ [falseSurvivor,trueSurvivor]}),
 ("finite-closure",{base with closure := {base.closure with scope := .finiteComplete}}),
 ("conditional-closure",{base with closure := {base.closure with scope := .conditionalGrammar}}),
 ("failed-minimality",{base with closure := {base.closure with minimalityPassed := false}}),
 ("failed-uniqueness",{base with closure := {base.closure with namedShapeUniquenessPassed := false}}),
 ("missing-control",{base with controls := base.controls.drop 1}),
 ("duplicate-control",{base with controls := base.controls ++ base.controls.take 1}),
 ("failed-control",{base with controls := base.controls ++ [⟨.boundary,false,"","",""⟩]}),
 ("reversed-controls",{base with controls := base.controls.reverse}),
 ("seal-identity",{base with sealHash := "different-seal"})]
def main : IO Unit := do
 let out ← IO.getStdout
 out.putStrLn (render (.array (generated.map Value.text)))
 for (name,sealed) in tests do
  out.putStrLn (render (.object [("case",.text name),("result",certificate sealed)]))
