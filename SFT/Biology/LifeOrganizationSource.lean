import SFT.Materials.MaterialSource
namespace SFT.Biology.LifeOrganizationSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := SFT.Materials.MaterialSource.Snapshot
abbrev readSnapshot := SFT.Materials.MaterialSource.readSnapshot
abbrev bytesHash := SFT.Materials.MaterialSource.bytesHash
structure Source where
 sourceId : String
 body : String
 uri : String
 path : String
 digest : String
 scope : String
structure Requirement where
 sourceId : String
 fragment : String
def sources : List Source := [⟨"SFT-BIO-SRC-NASEM-UNITY-BIOLOGY-2010","US National Academies / NCBI Bookshelf","https://www.ncbi.nlm.nih.gov/books/NBK32506/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-nasem-unity-biology-2010.html","sha256:62b53a959de8aa5b377997063a3a2719a87ff029a99f36225a383c7a4cfad9e6","DNA inheritance; cell; multicellularity; organism; community; ecosystem; biological energy"⟩,⟨"SFT-BIO-SRC-NCBI-CELL-ORIGIN-METABOLISM","NCBI Bookshelf, The Cell","https://www.ncbi.nlm.nih.gov/books/NBK9841/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-cell-origin-metabolism.html","sha256:ce64ef3e815f9a4f14dc6938e708f449bfd3a39de108c317aac8a941bff68b6b","cells; membranes; compartments; metabolism; replication"⟩,⟨"SFT-BIO-SRC-GO-ONTOLOGY-DOCUMENTATION","Gene Ontology Consortium","https://geneontology.org/docs/ontology-documentation/","experiments/external_sources/biology/snapshots/sft-bio-src-go-ontology-documentation.html","sha256:a55c5b5fc204dae486fa1bdfa85d50035f70bf2286fc089783d1a961fa8fcf26","molecular function; cellular component; biological process and relations"⟩,⟨"SFT-BIO-SRC-GO-ANNOTATION-EVIDENCE","Gene Ontology Consortium","https://geneontology.org/docs/go-annotations/","experiments/external_sources/biology/snapshots/sft-bio-src-go-annotation-evidence.html","sha256:b16235ab261f6b02afa71826546aad87823680ff267e0bd1c433d54c838b7ebd","evidence codes; context; negation; missingness; causal activity models"⟩,⟨"SFT-BIO-SRC-NCBI-GENETIC-CODE","NCBI Taxonomy","https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-genetic-code.html","sha256:c329091f012ae379949dc3a39f1961d2338a7b38ddad60245f9c12d8a31db514","complete genetic-code tables and ordered base positions"⟩,⟨"SFT-BIO-SRC-RCSB-1COP-CIF","Worldwide Protein Data Bank / RCSB PDB","https://files.rcsb.org/download/1COP.cif","experiments/external_sources/biology/snapshots/sft-bio-src-rcsb-1cop-cif.cif","sha256:6eddefaa66f6191a3080ca3b0dd333c9e7859448d6aaf17b79b60a3e32ad9a3c","primary Lambda Cro NMR ensemble and homodimer assembly"⟩,⟨"SFT-BIO-SRC-GBIF-DARWIN-CORE-ARCHIVE","Global Biodiversity Information Facility","https://ipt.gbif.org/manual/en/ipt/latest/dwca-guide","experiments/external_sources/biology/snapshots/sft-bio-src-gbif-darwin-core-archive.html","sha256:89adbe8ba230fd51495154e86843e624d2805d632bc17e55136e88f85c7cad1f","taxon, occurrence and sampling-event data structures"⟩,⟨"SFT-BIO-SRC-SEQUENCE-ONTOLOGY-OBO-RELEASE-V1","Sequence Ontology Consortium","https://raw.githubusercontent.com/The-Sequence-Ontology/SO-Ontologies/master/Ontology_Files/so.obo","experiments/external_sources/biology/snapshots/sft-bio-src-sequence-ontology-obo-release-v1.obo","sha256:dde032d4c7cfb89a7013f2f8ab7420a8ef7dc469fbc2b0ffb38bef2a064a1d1f","sequence features, gene, genome, transcript, polypeptide and mutation classes"⟩,⟨"SFT-BIO-SRC-GBIF-SURVEY-GUIDE-V1","Global Biodiversity Information Facility","https://docs.gbif.org/guide-publishing-survey-data/en/","experiments/external_sources/biology/snapshots/sft-bio-src-gbif-survey-guide-v1.html","sha256:58b745acf0df0e8235a5c50e9ff86a128593f26fb6982fd92834ca544bf31be8","ecological survey protocol, effort, occurrence, absence and monitoring"⟩,⟨"SFT-BIO-SRC-NCBI-EVOLUTION-GENETICS-V1","NCBI Bookshelf","https://www.ncbi.nlm.nih.gov/books/NBK595925/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-evolution-genetics-v1.html","sha256:49fd44aa874381d681845301eb337b361ed763fb4272118befc61af4a07eaceb","heritable variation, mutation, selection, population size and drift"⟩,⟨"SFT-BIO-SRC-NCBI-PROTEIN-FOLDING-V1","NCBI Bookshelf, The Cell","https://www.ncbi.nlm.nih.gov/books/NBK9843/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-protein-folding-v1.html","sha256:ba95b96559c7a21af68f3dc044011bb842b1d641ef86beeb2713a8b360e14313","sequence, folding, intermediates, chaperones, function and assembly"⟩,⟨"SFT-BIO-SRC-NCBI-GENOME-REGULATION-DEVELOPMENT-V1","NCBI Bookshelf, Genomes","https://www.ncbi.nlm.nih.gov/books/NBK21127/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-genome-regulation-development-v1.html","sha256:e1d430fae9b5cee3fdd0778c89ccb4a578be472db6a81f5ba802191d94e909ce","genome expression, signalling, differentiation and development"⟩,⟨"SFT-BIO-SRC-NCBI-AGING-SENESCENCE-V1","NCBI Bookshelf, Developmental Biology","https://www.ncbi.nlm.nih.gov/books/NBK10041/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-aging-senescence-v1.html","sha256:920f58581ed5a30448598733f38a1b2eb85682fb9901cf5c1a5606513f6adb4c","aging, lifespan, regeneration and cancer distinction"⟩,⟨"SFT-BIO-SRC-NCBI-HOMEOSTASIS-V1","NCBI Bookshelf","https://www.ncbi.nlm.nih.gov/books/NBK559138/?report=printable","experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-homeostasis-v1.html","sha256:687e91d0923fa79516112a8c3bd99df2a4b911d3fc79d0c488954caaee4c7c24","physiology and homeostatic control loops"⟩,⟨"SFT-BIO-SRC-PUBMED-HOMOCHIRALITY-35969306-V1","US National Library of Medicine / PubMed","https://pubmed.ncbi.nlm.nih.gov/35969306/?format=pubmed","experiments/external_sources/biology/snapshots/sft-bio-src-pubmed-homochirality-35969306-v1.html","sha256:8980303d43e13f638eccaf22e24edc141fc51b26037c5e9336facdea4f5c9bca","observed L-amino-acid and D-sugar predominance with mechanism unresolved"⟩,⟨"SFT-BIO-SRC-EUROPEPMC-SCALE-FREE-RARE-6399239-XML-V1","Europe PMC","https://www.ebi.ac.uk/europepmc/webservices/rest/PMC6399239/fullTextXML","experiments/external_sources/biology/snapshots/sft-bio-src-europepmc-scale-free-rare-6399239-xml-v1.xml","sha256:3896db77ef007b8da965fb21a7f87d63790222cb566889ec89d978392ded21a8","severe empirical scale-free test and alternative distributions"⟩,⟨"SFT-BIO-SRC-EUROPEPMC-ALLOMETRY-11782306-XML-V1","Europe PMC","https://www.ebi.ac.uk/europepmc/webservices/rest/PMC11782306/fullTextXML","experiments/external_sources/biology/snapshots/sft-bio-src-europepmc-allometry-11782306-xml-v1.xml","sha256:214f06e309b9505e2ec0852d9b30cb02b6c4863c7e17f16d16ceb17378462e99","three-quarter, two-thirds, unity and nonuniversal allometric evidence"⟩]
def requirements : List Requirement := [⟨"SFT-BIO-SRC-NASEM-UNITY-BIOLOGY-2010","cell is the smallest independent unit of life"⟩,⟨"SFT-BIO-SRC-NCBI-CELL-ORIGIN-METABOLISM","metabolic energy"⟩]
def expectedLabel : String := "biology:bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared"
def continuation (n : Nat) : Bool := 128 ≤ n && n ≤ 191
-- Python UTF-8 errors="replace": consume each maximal valid prefix of a
-- malformed sequence once, then retain the offending byte for the next step.
def decodeReplaceRev : Nat → List UInt8 → List Char → List Char
 | 0,_,acc => acc
 | fuel+1,bytes,acc => match bytes with
  | [] => acc
  | first::rest =>
   let a := first.toNat
   let b := (rest.headD 0).toNat
   let c := ((rest.drop 1).headD 0).toNat
   let d := ((rest.drop 2).headD 0).toNat
   if a<128 then decodeReplaceRev fuel rest (Char.ofNat a::acc)
   else if 194≤a && a≤223 then
    if continuation b then decodeReplaceRev fuel (rest.drop 1) (Char.ofNat ((a-192)*64+b-128)::acc)
    else decodeReplaceRev fuel rest ('�'::acc)
   else if 224≤a && a≤239 then
    if !(continuation b) || (a==224 && b<160) || (a==237 && b>159) then decodeReplaceRev fuel rest ('�'::acc)
    else if !(continuation c) then decodeReplaceRev fuel (rest.drop 1) ('�'::acc)
    else decodeReplaceRev fuel (rest.drop 2) (Char.ofNat ((a-224)*4096+(b-128)*64+c-128)::acc)
   else if 240≤a && a≤244 then
    if !(continuation b) || (a==240 && b<144) || (a==244 && b>143) then decodeReplaceRev fuel rest ('�'::acc)
    else if !(continuation c) then decodeReplaceRev fuel (rest.drop 1) ('�'::acc)
    else if !(continuation d) then decodeReplaceRev fuel (rest.drop 2) ('�'::acc)
    else decodeReplaceRev fuel (rest.drop 3) (Char.ofNat ((a-240)*262144+(b-128)*4096+(c-128)*64+d-128)::acc)
   else decodeReplaceRev fuel rest ('�'::acc)
def decodeReplace (bytes : ByteArray) : String :=
 String.ofList ((decodeReplaceRev bytes.size bytes.data.toList []).reverse)
def collapseWhitespace (cs : List Char) : List Char :=
 ((cs.foldl (fun (state : List Char × Bool) c =>
   if SFT.Chemistry.SourceText.whitespace c then
    if state.2 then state else (' '::state.1,true)
   else (c::state.1,false)) ([],false)).1.reverse)
def stripTagsRev : Nat → List Char → List Char → List Char
 | 0,cs,acc => cs.reverse ++ acc
 | fuel+1,cs,acc => match cs with
  | [] => acc
  | c::rest =>
   if c.toNat==60 then
    let body := rest.takeWhile (fun x => x.toNat != 62)
    let tail := rest.drop body.length
    if !body.isEmpty && !tail.isEmpty then stripTagsRev fuel (tail.drop 1) (' '::acc)
    else stripTagsRev fuel rest (c::acc)
   else stripTagsRev fuel rest (c::acc)
def unescapeRev : Nat → List Char → List Char → List Char
 | 0,cs,acc => cs.reverse ++ acc
 | fuel+1,cs,acc => match cs with
  | [] => acc
  | c::rest =>
   if c.toNat==38 then
    match SFT.Materials.SourceText.characterReference rest with
    | none => unescapeRev fuel rest (c::acc)
    | some (replacement,tail) => unescapeRev fuel tail ((Text.chars replacement).reverse ++ acc)
   else unescapeRev fuel rest (c::acc)
def corpus (bytes : ByteArray) : String :=
 let chars := Text.chars (decodeReplace bytes)
 let stripped := (stripTagsRev chars.length chars []).reverse
 let collapsed := collapseWhitespace stripped
 SFT.Chemistry.SourceText.casefold (String.ofList ((unescapeRev collapsed.length collapsed []).reverse))
def distinctIds (rows : List String) : Bool :=
 match rows with
 | [] => true
 | r::rs => !(rs.any (Text.equal r)) && distinctIds rs
def validateSources (files : List Snapshot) : Except String Unit := do
 if sources.length==17 && !(distinctIds (sources.map Source.sourceId)) then
  throw "Biology source identities repeat or are incomplete"
 let _ ← sources.mapM fun source => do
  let bytes ← readSnapshot files source.path
  if !Text.equal (bytesHash bytes) source.digest then
   throw (Text.append "Biology snapshot changed: " source.sourceId)
 return ()
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let receipts ← requirements.mapM fun requirement => do
  let source ← match sources.find? (fun s => Text.equal s.sourceId requirement.sourceId) with
   | none => .error (Text.intercalate "" ["'",requirement.sourceId,"'"])
   | some s => .ok s
  let bytes ← readSnapshot files source.path
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  if !(Text.contains (corpus bytes) folded) then
   throw (Text.intercalate "" ["required Biology feature absent: ",requirement.sourceId," :: ",requirement.fragment])
  return Value.array [.text requirement.sourceId,.text source.digest,.text requirement.fragment,
   .text (identity (.array [.text requirement.sourceId,.text folded]))]
 return (expectedLabel,identity (.array receipts))
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 validateSources files
 extractRequirements files
end SFT.Biology.LifeOrganizationSource
