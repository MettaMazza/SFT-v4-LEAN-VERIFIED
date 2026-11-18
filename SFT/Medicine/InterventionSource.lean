import SFT.Biology.LifeOrganizationSource
namespace SFT.Medicine.InterventionSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := SFT.Materials.MaterialSource.Snapshot
abbrev readSnapshot := SFT.Materials.MaterialSource.readSnapshot
abbrev bytesHash := SFT.Materials.MaterialSource.bytesHash
structure Source where
 sourceId : String
 body : String
 uri : String
 snapshotPath : Option String
 snapshotHash : Option String
 textPath : Option String
 textHash : Option String
 scope : String
 transportStatus : String
 failurePath : Option String
 failureHash : Option String
structure Requirement where
 sourceId : String
 fragment : String
def sources : List Source := [⟨"MED-WHO-HEALTH-001","World Health Organization","https://www.who.int/about/frequently-asked-questions",(some "experiments/external_sources/medicine/snapshots/MED-WHO-HEALTH-001.html"),(some "sha256:274c2ad78787f127a9f1cf8a479c691e1f89b263d0e21dd49b1753f7805d64f4"),(some "experiments/external_sources/medicine/snapshots/MED-WHO-HEALTH-001.txt"),(some "sha256:4a895afb8bd430d6a619d8f07c5e45c199298dd67a16fd05fa254e47042a345d"),"health state and disease-absence distinction","captured",(none),(none)⟩,⟨"MED-FDA-BIOMARKER-001","United States Food and Drug Administration","https://www.fda.gov/drugs/biomarker-qualification-program/about-biomarkers-and-qualification",(some "experiments/external_sources/medicine/snapshots/MED-FDA-BIOMARKER-001.html"),(some "sha256:93c5ee4b5e3480ed27aa805a7739f4acf7108701fc6f429ae5d4e5a1ad9d3d31"),(some "experiments/external_sources/medicine/snapshots/MED-FDA-BIOMARKER-001.txt"),(some "sha256:f82a712f63b6c8e0de9e2807038051f549a09deccaea480240f9f44e637023fa"),"normal and pathogenic processes; risk, diagnostic, monitoring, prognostic, response and safety biomarkers; method and context","captured",(none),(none)⟩,⟨"MED-CDC-EPIDEMIOLOGY-001","United States Centers for Disease Control and Prevention","https://archive.cdc.gov/www_cdc_gov/csels/dsepd/ss1978/lesson1/summary.html",(some "experiments/external_sources/medicine/snapshots/MED-CDC-EPIDEMIOLOGY-001.html"),(some "sha256:430c2d885670c185491ab9b84d1c703eeaff0eece3ddb69fc855c001fb93478b"),(some "experiments/external_sources/medicine/snapshots/MED-CDC-EPIDEMIOLOGY-001.txt"),(some "sha256:8a6116f8803b6a7f649053b0295feb8faabc17c3ad4513430f2fdda39fe9b7d3"),"population, comparison, frequency, pattern, cause, disease and injury epidemiology","captured",(none),(none)⟩,⟨"MED-ICH-E6R3-001","International Council for Harmonisation","https://database.ich.org/sites/default/files/ICH_E6%28R3%29_Step4_FinalGuideline_2025_0106.pdf",(some "experiments/external_sources/medicine/snapshots/MED-ICH-E6R3-001.pdf"),(some "sha256:e6ce19e36ce7d2e294f89ee89492b9e035178c3cca48984392bbd92eec9b002c"),(some "experiments/external_sources/medicine/snapshots/MED-ICH-E6R3-001.txt"),(some "sha256:66bf30ef9101596bd9e70ae82e7d55bab519a554c50c77b99670f2294c949592"),"final Good Clinical Practice: rights, safety, wellbeing, consent, protocol, allocation, blinding, adverse events, confidentiality and essential records","captured",(none),(none)⟩,⟨"MED-ICH-E9R1-001","International Council for Harmonisation","https://database.ich.org/sites/default/files/E9-R1_Step4_Guideline_2019_1203.pdf",(some "experiments/external_sources/medicine/snapshots/MED-ICH-E9R1-001.pdf"),(some "sha256:f7471f411f1c87ee76783d5b2b9faaeca31d01d530213f71b50d136b39e3b0d9"),(some "experiments/external_sources/medicine/snapshots/MED-ICH-E9R1-001.txt"),(some "sha256:95bcb99e56eb725947eb2acb0b9f0bfe4c6efedb9ffaba18b8232c700e7ff0f5"),"final estimand, population, endpoint, intercurrent-event, missing-data and sensitivity-analysis distinctions","captured",(none),(none)⟩,⟨"MED-FDA-EXPOSURE-RESPONSE-001","United States Food and Drug Administration","https://www.fda.gov/regulatory-information/search-fda-guidance-documents/exposure-response-relationships-study-design-data-analysis-and-regulatory-applications",(some "experiments/external_sources/medicine/snapshots/MED-FDA-EXPOSURE-RESPONSE-001.html"),(some "sha256:748ca63404e58ef7f56d321395e646aa918f1ba0e679dbab98e62be95bc40291"),(some "experiments/external_sources/medicine/snapshots/MED-FDA-EXPOSURE-RESPONSE-001.txt"),(some "sha256:38b68aea1735c0e5cee35f0383ea9c2a4959431cf3907c078d425583e87c4338"),"dose, exposure, response, benefit and risk study boundary","captured",(none),(none)⟩,⟨"MED-COCHRANE-HANDBOOK-001","Cochrane","https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current",(some "experiments/external_sources/medicine/snapshots/MED-COCHRANE-HANDBOOK-001.html"),(some "sha256:31f56118fc994e14f9703298b798983c2039c6328ee4c5f983f53bdef2bc0004"),(some "experiments/external_sources/medicine/snapshots/MED-COCHRANE-HANDBOOK-001.txt"),(some "sha256:784ffb274b550dcc55be18189542515ab5d2d8e73dd9d86e815ee0b00e91bf57"),"current intervention-review scope, study selection, bias, adverse effects and interpretation","captured",(none),(none)⟩,⟨"MED-COCHRANE-MISSING-EVIDENCE-001","Cochrane","https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-13",(some "experiments/external_sources/medicine/snapshots/MED-COCHRANE-MISSING-EVIDENCE-001.html"),(some "sha256:9ebd35b49c689f1b12fa3919051ea9a5ed315b168d9eaec7b1eb8860317d07bb"),(some "experiments/external_sources/medicine/snapshots/MED-COCHRANE-MISSING-EVIDENCE-001.txt"),(some "sha256:a0b274f7613fdc00437f68193541343ad00b26a145dcba905617a9e708f4c4e9"),"selective dissemination, missing evidence, benefit overestimation and harm underestimation","captured",(none),(none)⟩,⟨"MED-WHO-SCREENING-001","World Health Organization Regional Office for Europe","https://www.who.int/publications/i/item/9789289054782",(some "experiments/external_sources/medicine/snapshots/MED-WHO-SCREENING-001.html"),(some "sha256:b56f491a97d2efbe4ff4d59e304649dd1fb1d551a2ca6b88a9bbcf43d385b5f7"),(some "experiments/external_sources/medicine/snapshots/MED-WHO-SCREENING-001.txt"),(some "sha256:8c39fbeb90e52cc44b728718e3b25de977c522f7be189d5d72e7415fcba6708e"),"screening population, risk, early intervention, benefits, harms and quality assurance","captured",(none),(none)⟩,⟨"MED-HHS-CONSENT-001","United States Department of Health and Human Services Office for Human Research Protections","https://www.hhs.gov/ohrp/regulations-and-policy/guidance/faq/informed-consent/index.html",(none),(none),(none),(none),"prospective informed-consent identity; transport failure preserved and not used for a passing comparison","failed",(some "experiments/external_sources/medicine/snapshots/MED-HHS-CONSENT-001.failure.txt"),(some "sha256:f2dda5323f2dfa71d16fad0fb1aa65c5d3ecf0c567603dba0d2076ca0517f291")⟩,⟨"MED-HHS-PRIVACY-001","United States Department of Health and Human Services Office for Civil Rights","https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/minimum-necessary-requirement/index.html",(none),(none),(none),(none),"minimum-necessary privacy identity; transport failure preserved and not used for a passing comparison","failed",(some "experiments/external_sources/medicine/snapshots/MED-HHS-PRIVACY-001.failure.txt"),(some "sha256:f2dda5323f2dfa71d16fad0fb1aa65c5d3ecf0c567603dba0d2076ca0517f291")⟩,⟨"MED-NICHD-REHABILITATION-001","Eunice Kennedy Shriver National Institute of Child Health and Human Development","https://www.nichd.nih.gov/health/topics/rehabilitation-medicine",(some "experiments/external_sources/medicine/snapshots/MED-NICHD-REHABILITATION-001.html"),(some "sha256:c1b54134e6cbcfb9542a7c012236395eb609a67a789818f201c5b42202dc8cae"),(some "experiments/external_sources/medicine/snapshots/MED-NICHD-REHABILITATION-001.txt"),(some "sha256:cfecdd3cd39e0a9363ef0d039a740808cb545f8386f29d1f2b29760e394bd808"),"rehabilitation function, participation, independence, quality of life and outcomes","captured",(none),(none)⟩,⟨"MED-STROBE-001","STROBE Initiative","https://www.strobe-statement.org/",(some "experiments/external_sources/medicine/snapshots/MED-STROBE-001.html"),(some "sha256:420432c148d01e7aaaab8f7bcb4bcbc4412d028aa50cd7814fc1b058faf1cf7c"),(some "experiments/external_sources/medicine/snapshots/MED-STROBE-001.txt"),(some "sha256:846530d8dfd2b38331defa6388d14ff7d9eeb4ddeef248f0435428549c18c996"),"observational-study planning, conduct, findings and interpretation reporting","captured",(none),(none)⟩]
def requirements : List Requirement := [⟨"MED-ICH-E6R3-001","trial protocol"⟩,⟨"MED-ICH-E6R3-001","randomisation"⟩,⟨"MED-ICH-E6R3-001","blinding"⟩,⟨"MED-ICH-E9R1-001","treatment effect"⟩]
def expectedLabel : String := "medicine:patient-directed-action__action-to-course-transition__content-delivery-and-adherence__eligibility-setting-time-and-provider"
def lookup (sourceId : String) : Except String Source :=
 match sources.find? (fun s => Text.equal s.sourceId sourceId) with
 | none => .error (Text.intercalate "" ["'",sourceId,"'"])
 | some s => .ok s
-- Original source_corpus reads the registered text file directly, with UTF-8
-- replacement and casefold; it does not perform the Biology HTML extraction.
def sourceCorpus (files : List Snapshot) (sourceId : String) : Except String String := do
 let source ← lookup sourceId
 if !Text.equal source.transportStatus "captured" then
  throw (Text.append "Medicine source is unavailable and may not support a passing comparison: " sourceId)
 let path ← match source.textPath with
  | some p => .ok p
  | none => .error (Text.append "Medicine source is unavailable and may not support a passing comparison: " sourceId)
 let bytes ← readSnapshot files path
 let decoded := Text.chars (SFT.Biology.LifeOrganizationSource.decodeReplace bytes)
 let normalized := (decoded.foldl (fun (state : List Char × Bool) c =>
  if c.toNat==13 then ('\n'::state.1,true)
  else if c.toNat==10 && state.2 then (state.1,false)
  else (c::state.1,false)) ([],false)).1.reverse
 return SFT.Chemistry.SourceText.casefold (String.ofList normalized)
def validateSources (files : List Snapshot) : Except String Unit := do
 if sources.length==13 && !(SFT.Biology.LifeOrganizationSource.distinctIds (sources.map Source.sourceId)) then
  throw "Medicine source identities repeat or are incomplete"
 let mut capturedCount := 0
 let mut failedCount := 0
 for source in sources do
  if Text.equal source.transportStatus "captured" then
   capturedCount := capturedCount+1
   let (sp,sh,tp,th) ← match source.snapshotPath,source.snapshotHash,source.textPath,source.textHash with
    | some sp,some sh,some tp,some th => .ok (sp,sh,tp,th)
    | _,_,_,_ => .error (Text.append "Medicine captured source lacks immutable paths: " source.sourceId)
   let snapshot ← readSnapshot files sp
   if !Text.equal (bytesHash snapshot) sh then
    throw (Text.append "Medicine snapshot changed: " source.sourceId)
   let text ← readSnapshot files tp
   if !Text.equal (bytesHash text) th then
    throw (Text.append "Medicine snapshot changed: " source.sourceId)
  else if Text.equal source.transportStatus "failed" then
   failedCount := failedCount+1
   let (fp,fh) ← match source.failurePath,source.failureHash with
    | some fp,some fh => .ok (fp,fh)
    | _,_ => .error (Text.append "Medicine failed-transport receipt changed: " source.sourceId)
   let failure ← readSnapshot files fp
   if !Text.equal (bytesHash failure) fh then
    throw (Text.append "Medicine failed-transport receipt changed: " source.sourceId)
  else throw (Text.append "Medicine source has unknown transport status: " source.sourceId)
 if capturedCount!=11 || failedCount!=2 then
  throw "Medicine source transport census changed"
 return ()
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let receipts ← requirements.mapM fun requirement => do
  let source ← lookup requirement.sourceId
  let corpus ← sourceCorpus files requirement.sourceId
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  if !(Text.contains corpus folded) then
   throw (Text.intercalate "" ["required Medicine feature absent: ",requirement.sourceId," :: ",requirement.fragment])
  let snapshotHash := match source.snapshotHash with
   | some digest => Value.text digest
   | none => Value.null
  return Value.array [.text requirement.sourceId,snapshotHash,.text requirement.fragment,
   .text (identity (.array [.text requirement.sourceId,.text folded]))]
 return (expectedLabel,identity (.array receipts))
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 validateSources files
 extractRequirements files
end SFT.Medicine.InterventionSource
