exec(open('work/material_source651.py').read().split('registration=')[0])
from pathlib import Path
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer '+str(x)
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 if x is None:return '.null'
 raise TypeError(x)
sources=namespace['MATERIALS_AUTHORITY_SOURCES'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id]
seal=json.loads((root/namespace['PRE_SOURCE_SEAL_PATH']).read_text());preds=[(x.claim_id,x.exact_result,x.expected_observation_label) for x in namespace['MATERIALS_SPECS']]
s='''import SFT.Materials.SourceText
import SFT.Materials.MaterialEvidence
import SFT.Host.SHA256Window
namespace SFT.Materials.MaterialSource
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Snapshot where
 path : String
 bytes : ByteArray
structure Source where
 sourceId : String
 body : String
 uri : String
 path : String
 hash : String
structure Requirement where
 sourceId : String
 fragment : String
'''
s+='def sources : List Source := ['+','.join('⟨'+','.join(q(getattr(x,k)) for k in ['source_id','body','source_uri','snapshot_path','snapshot_hash'])+'⟩' for x in sources)+']\n'
s+='def requirements : List Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
s+='def targetId : String := '+q(spec.target_id)+'\n'
s+='def preSourcePath : String := '+q(namespace['PRE_SOURCE_SEAL_PATH'])+'\n'
s+='def predictionSet : Value := '+cv(preds)+'\n'
s+='def claimCount : Nat := '+str(len(preds))+'\n'
s+='def originalSeal : Value := '+cv(seal)+'\n'
s+='''
def field (v : Value) (key : String) : Value := match v with
 | .object ps => match ps.find? (fun p => Text.equal p.1 key) with | some p => p.2 | none => .null
 | _ => .null
def string (v : Value) : String := match v with | .text s => s | _ => ""
def isFalse (v : Value) : Bool := match v with | .boolean false => true | _ => false
def integerEqual (v : Value) (n : Nat) : Bool := match v with | .integer k => k == Int.ofNat n | _ => false
def bytesHash (bytes : ByteArray) : String := Text.append "sha256:" (SHA256Window.digest bytes)
def readSnapshot (files : List Snapshot) (path : String) : Except String ByteArray :=
 match files.find? (fun f => Text.equal f.path path) with
 | some f => .ok f.bytes
 | none => .error (Text.append "FileNotFoundError: " path)

def validatePreSeal (payload : Value) (files : List Snapshot) : Except String String := do
 let claimed := string (field payload "sealed_payload_hash")
 let content := match payload with
   | .object ps => Value.object (ps.filter (fun p => !Text.equal p.1 "sealed_payload_hash"))
   | _ => payload
 if !Text.equal (identity content) claimed then .error "Materials pre-source seal payload changed" else do
 if !(isFalse (field payload "external_source_identities_selected")) then
   .error "Materials derivation was not sealed before source selection" else do
 if !(isFalse (field payload "external_target_content_opened")) then
   .error "Materials target content was opened before sealing" else do
 if !(integerEqual (field payload "required_claim_count") claimCount) then
   .error "Materials pre-source seal does not cover the complete branch" else do
 if !(integerEqual (field payload "candidate_count") (claimCount*256)) then
   .error "Materials pre-source candidate count changed" else do
 if !Text.equal (string (field payload "claim_prediction_set_hash")) (identity predictionSet) then
   .error "Materials sealed prediction set changed" else do
 for (pathKey,hashKey) in [("inventory_path","inventory_hash"),("structural_counts_path","structural_counts_hash"),("derivation_path","derivation_hash")] do
   let path := string (field payload pathKey)
   let bytes ← readSnapshot files path
   if !Text.equal (bytesHash bytes) (string (field payload hashKey)) then
     throw (Text.append "Materials sealed source changed: " path)
 .ok claimed

def validateSources (files : List Snapshot) : Except String Unit := do
 for source in sources do
   let bytes ← readSnapshot files source.path
   if !Text.equal (bytesHash bytes) source.hash then
     throw (Text.append "Materials source snapshot changed: " source.sourceId)
 .ok ()

def continuation (n : Nat) : Bool := 128 ≤ n && n ≤ 191
-- Exact UTF-8 ignore decoding used by the original source reader.
def decodeIgnore : Nat → List UInt8 → List Char
 | 0, _ => []
 | fuel+1, bs => match bs with
   | [] => []
   | a::rest =>
     let n := a.toNat
     let b := (rest.headD 0).toNat
     let c := ((rest.drop 1).headD 0).toNat
     let d := ((rest.drop 2).headD 0).toNat
     if n < 128 then Char.ofNat n :: decodeIgnore fuel rest
     else if 194 ≤ n && n ≤ 223 && continuation b then
       Char.ofNat ((n-192)*64+b-128) :: decodeIgnore fuel (rest.drop 1)
     else if 224 ≤ n && n ≤ 239 && continuation b && continuation c &&
       (n != 224 || b ≥ 160) && (n != 237 || b ≤ 159) then
       Char.ofNat ((n-224)*4096+(b-128)*64+c-128) :: decodeIgnore fuel (rest.drop 2)
     else if 240 ≤ n && n ≤ 244 && continuation b && continuation c && continuation d &&
       (n != 240 || b ≥ 144) && (n != 244 || b ≤ 143) then
       Char.ofNat ((n-240)*262144+(b-128)*4096+(c-128)*64+d-128) :: decodeIgnore fuel (rest.drop 3)
     else decodeIgnore fuel rest

def corpus (bytes : ByteArray) : String :=
 SourceText.corpus (String.ofList (decodeIgnore bytes.size bytes.data.toList))

def extractTarget (files : List Snapshot) : Except String (String × String) := do
 validateSources files
 let mut receipts : List Value := []
 for requirement in requirements do
   let source ← match sources.find? (fun s => Text.equal s.sourceId requirement.sourceId) with
     | some s => .ok s
     | none => .error (Text.append "KeyError: " requirement.sourceId)
   let bytes ← readSnapshot files source.path
   if !(Text.contains (corpus bytes) (SFT.Chemistry.SourceText.casefold requirement.fragment)) then
     throw "required Materials feature is absent after source release"
   receipts := receipts ++ [.array [.text requirement.sourceId,.text source.hash,.text requirement.fragment,
     .text (identity (.array [.text requirement.sourceId,.text (SFT.Chemistry.SourceText.casefold requirement.fragment)]))]]
 .ok (expectedLabel,identity (.array receipts))

theorem originalSourceIdentity (bytes : ByteArray) :
 bytesHash bytes = Text.append "sha256:" (SHA256.digest bytes) := by
 unfold bytesHash
 rw [SHA256Window.digestPreserved]
end SFT.Materials.MaterialSource
'''
Path('work/constants-recovery/SFT/Materials/MaterialSource.lean').write_text(s)
# Capture the exact source registration even though source extraction rejects the normalized unrelated snapshot.
registration=namespace['experiment_registration_record'](root,spec)
Path('work/material_registration652.json').write_text(json.dumps(registration,indent=2)+'\n')
print('original registration',namespace['sha256_identity'](registration),'sources',len(sources),'claims',len(preds))
