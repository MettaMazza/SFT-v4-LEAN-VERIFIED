from pathlib import Path
ns={};exec(Path('work/matsize_source838.py').read_text().split('registration=')[0],ns);q=ns['q'];spec=ns['spec'];namespace=ns['namespace'];p=Path('work/constants-recovery/SFT/Materials/SizeMaterialExperiment.lean');s=p.read_text().replace('import SFT.Materials.SizeMaterialEvidence','import SFT.Materials.SizeMaterialEvidence\nimport SFT.Chemistry.SourceExtraction');a=s.index('def validateSpec');b=s.index('theorem registeredSpecValid',a)
block='def registeredSubbranches : List String := ['+','.join(q(x) for x in namespace['SUBBRANCH_DEPENDENCIES'])+']\n'
block+='def subbranch : String := '+q(spec.subbranch)+'\n'
block+='def dimensions : List (String × List (String × Bool)) := ['+','.join('('+q(d.key)+',['+','.join('('+q(c.name)+','+str(c.admitted).lower()+')' for c in d.choices)+'])' for d in spec.dimensions)+']\n'
block+='''def preservingNames : List (String × List (String × Bool)) → Except String (List String)
 | [] => .ok []
 | (key,choices)::rest => do
   if !(choices.length == 2) then .error "each Materials dimension must exhaust two registered forms"
   else
    let held := choices.filter (fun c => c.2)
    if !(held.length == 1) then .error (Text.intercalate "" ["dimension ",key," requires one preserving form"])
    else do
     let tail ← preservingNames rest
     .ok ((held.headD ("",false)).1::tail)

def binding : Option (List MaterialSource.Requirement) := some SizeMaterialSource.requirements

def bindingSources (rows : List MaterialSource.Requirement) : List String :=
 rows.foldl (fun held row => if held.any (fun id => Text.equal id row.sourceId) then held else held++[row.sourceId]) []

def sameLabels : List String → List String → Bool
 | [], [] => true
 | [], _::_ => false
 | _::_, [] => false
 | a::xs, b::ys => Text.equal a b && sameLabels xs ys

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-MAT-").isPrefixOf (Text.chars claimId) then .error "Materials blueprint claim identity is invalid"
 else if !(Text.chars "SFT-EXP-MAT-").isPrefixOf (Text.chars experimentId) then .error "Materials blueprint experiment identity is invalid"
 else if !(registeredSubbranches.any (fun name => Text.equal name subbranch)) then .error "Materials blueprint subbranch is unregistered"
 else if SizeMaterialEvidence.dependencies.isEmpty || !(dimensions.length == 8) then .error "Materials blueprint requires dependencies and eight dimensions"
 else if !(SFT.Chemistry.SourceExtraction.unique (dimensions.map (fun d => d.1))) then .error "Materials blueprint dimensions repeat"
 else do
  let names ← preservingNames dimensions
  if !(Text.equal frozenRelation (Text.intercalate "__" names)) then .error "Materials exact result is not the unique preservation survivor"
  else if !SFT.Chemistry.SourceText.nonblank expectedLabel || !SFT.Chemistry.SourceText.nonblank falsification then .error "Materials blueprint lacks prediction or falsification boundary"
  else if !(SizeMaterialEvidence.witness0 && SizeMaterialEvidence.witness1 && SizeMaterialEvidence.witness2) then .error "Materials operational witness failed"
  else match binding with
  | none => .error "Materials claim lacks a post-seal binding"
  | some rows =>
   if sourceIds.isEmpty || !(sameLabels sourceIds (bindingSources rows)) then .error "Materials source support differs from the registered binding"
   else if !(Text.equal targetId (Text.append (Text.lowerAscii claimId) "-authority-correspondence")) then .error "Materials target identity is invalid"
   else .ok ()

'''
s=s[:a]+block+s[b:];p.write_text(s)
