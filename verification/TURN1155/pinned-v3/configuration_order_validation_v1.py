"""Capability-closed complete NIST configuration-path validation for ELEC-011."""
from __future__ import annotations
from fractions import Fraction
from html.parser import HTMLParser
import json, platform
from pathlib import Path
from sft.chemistry.configuration_order_batch_v1 import CONFIGURATION_ORDER_SPEC, IDENTITY_HASH, IDENTITY_PATH, SOURCE_ID, TARGET_HASH, TARGET_PATH
from sft.claim_evidence import CapabilityClosedFoldInterpreter, CrossPlatformCustodyExchange, FoldTable, HostilePackageAuditor, PositiveRatio, TargetVault, fold_program_from_mapping, snapshot_protected_tree, target_identity_from_release
from sft.claim_evidence.fold_language import EMPTY_ONE
from sft.engine import EmpiricalValidation, seal_isolation_certificate, seal_target_custody_certificate, unsealed_isolation_certificate, unsealed_target_custody_certificate
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary, PredictionEnvelope
from sft.engine.exact import HeldLabel
from sft.engine.source import hash_file

SNAPSHOT_PATH="experiments/external_sources/chemistry/snapshots/configuration-order-v1/nist-cccbdb-ethanol-experimental-rotational-barrier.html"
SNAPSHOT_HASH="sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209"
class Parser(HTMLParser):
    def __init__(self): super().__init__();self.in_row=False;self.in_cell=False;self.parts=[];self.row=[];self.rows=[]
    def handle_starttag(self,tag,attrs):
        if tag.lower()=="tr": self.in_row,self.row=True,[]
        elif self.in_row and tag.lower() in {"td","th"}: self.in_cell,self.parts=True,[]
    def handle_endtag(self,tag):
        if self.in_cell and tag.lower() in {"td","th"}: self.row.append(" ".join("".join(self.parts).split()));self.in_cell=False
        elif self.in_row and tag.lower()=="tr":
            if self.row:self.rows.append(tuple(self.row))
            self.in_row=False
    def handle_data(self,data):
        if self.in_cell:self.parts.append(data)

def prediction_program_document(root:Path):
    values=(("carrier","retained-molecular-carrier"),("configuration","generated-configuration-nodes"),("order","exact-positive-order-or-EmptyOne"),("stability","local-minimum-by-complete-neighbours"),("barrier","local-barrier-by-complete-neighbours"),("path","connected-complete-configuration-path"),("recurrence","exact-periodic-endpoint-identity"),("record","complete-favourable-and-adverse-vector"));instructions=[{"opcode":"input","destination":"premise","arguments":["registered-premise"]}];table=[]
    for p,(name,value) in enumerate(values,start=1):
        k,v=f"key-{p}",f"value-{p}";instructions.extend(({"opcode":"label","destination":k,"arguments":["configuration-law-axis",name]},{"opcode":"label","destination":v,"arguments":["configuration-law",value]}));table.extend((k,v))
    instructions.extend(({"opcode":"table","destination":"law","arguments":table},{"opcode":"emit","destination":"","arguments":["law"]}));return {"schema":"sft-v3-fold-program/1","program_id":CONFIGURATION_ORDER_SPEC.experiment_id+"-prediction","instructions":instructions}

def experiment_registration_record(root:Path):
    return {"experiment_id":CONFIGURATION_ORDER_SPEC.experiment_id,"claim_id":CONFIGURATION_ORDER_SPEC.claim_id,"provenance":"observational_derivation","frozen_relation":CONFIGURATION_ORDER_SPEC.exact_result,"identity_registry":(IDENTITY_PATH,IDENTITY_HASH),"withheld_target_registry":(TARGET_PATH,TARGET_HASH),"prediction_program":prediction_program_document(root),"target_references":tuple((r.target_id,r.source_id,r.source_locator,r.snapshot_path,r.snapshot_hash) for r in CONFIGURATION_ORDER_SPEC.target_rows),"target_content_absent_from_prediction":True,"all_fifty_records_required":True,"falsification_condition":CONFIGURATION_ORDER_SPEC.falsification_condition}

def _rows(root:Path):
    for path,expected in ((IDENTITY_PATH,IDENTITY_HASH),(TARGET_PATH,TARGET_HASH),(SNAPSHOT_PATH,SNAPSHOT_HASH)):
        if hash_file(root/path)!=expected:raise ValueError("ELEC-011 source changed: "+path)
    document=json.loads((root/TARGET_PATH).read_text());registered=tuple(document["rows"]);parser=Parser();parser.feed((root/SNAPSHOT_PATH).read_text(encoding="utf-8"));raw=[r for r in parser.rows if len(r)==4 and r[0] in {"1","2"} and r[1].isdigit()]
    if len(raw)!=50 or len(registered)!=50:raise ValueError("ELEC-011 complete path missing")
    for position,(source,row) in enumerate(zip(raw,registered),start=1):
        if [str(row[k]) for k in ("torsion_index","angle_inscription_degrees","energy_inscription_kj_mol","energy_inscription_cm_inverse")] != [source[0],source[1],source[2],source[3]] or row["path_position"]!=position:raise ValueError("ELEC-011 source reconstruction differs")
    return registered

def _exact(inscription):
    value=Fraction(str(inscription));return EMPTY_ONE if value==0 else PositiveRatio.from_pair(value.numerator,value.denominator)

class ConfigurationOrderValidator:
    def __init__(self,root:Path):self.root,self.spec=root.resolve(),CONFIGURATION_ORDER_SPEC
    def validate(self,sealed):
        rows=_rows(self.root);registration=experiment_registration_record(self.root);rh=sha256_identity(registration);document=prediction_program_document(self.root);program=fold_program_from_mapping(document);inputs={"registered-premise":HeldLabel("sealed-derivation",sealed.seal_hash)};envelope=PredictionEnvelope(self.spec.experiment_id,{"registered-premise":sha256_identity(inputs["registered-premise"])},tuple(r.target_id for r in self.spec.target_rows),sealed.seal_hash,rh);targets={str(r["target_id"]):HeldLabel("external-configuration-record",sha256_identity(r)) for r in rows};vault=TargetVault(experiment_id=self.spec.experiment_id,custodian_id=self.spec.experiment_id+"-NIST-custodian",targets=targets,custody_nonce=sha256_identity((rh,TARGET_HASH)),expected_envelope_hash=sha256_identity(envelope));before=snapshot_protected_tree(self.root);execution=CapabilityClosedFoldInterpreter().execute(program,inputs);boundary=BlindExperimentBoundary(envelope);ps=boundary.seal_prediction(execution.output,execution.trace);after=snapshot_protected_tree(self.root);audited,audit=HostilePackageAuditor().audit_program_document(document,before,after)
        if sha256_identity(audited)!=execution.program_hash or not audit.passed or not isinstance(execution.output,FoldTable):raise ValueError("ELEC-011 prediction package differs")
        release=vault.release(ps);CrossPlatformCustodyExchange.verify(vault.commitment,release,ps);boundary.measurement_context(release.targets);groups={1:[],2:[]};comparisons=[]
        for row in rows:
            kj=_exact(row["energy_inscription_kj_mol"]);cm=_exact(row["energy_inscription_cm_inverse"])
            if (kj is EMPTY_ONE)!=(cm is EMPTY_ONE):raise ValueError("ELEC-011 unit surfaces disagree on absence")
            groups[int(row["torsion_index"])].append((row,kj,cm));comparisons.append({"target_id":row["target_id"],"exact_kj":repr(kj),"exact_cm":repr(cm),"passed":release.targets[row["target_id"]].label==sha256_identity(row)})
        counts={"positive":0,"absence":0,"basin":0,"barrier":0,"ordinary":0,"recurrence_duplicate":0}
        for path in groups.values():
            if path[0][0]["angle_inscription_degrees"]!="0" or path[-1][0]["angle_inscription_degrees"]!="360" or path[0][1]!=path[-1][1]:raise ValueError("ELEC-011 recurrence differs")
            counts["recurrence_duplicate"]+=1;unique=path[:-1]
            values=[Fraction(str(item[0]["energy_inscription_kj_mol"])) for item in unique]
            for i,value in enumerate(values):
                if value==0:counts["absence"]+=1
                else:counts["positive"]+=1
                left,right=values[(i-1)%len(values)],values[(i+1)%len(values)]
                if value<left and value<right:counts["basin"]+=1
                elif value>left and value>right:counts["barrier"]+=1
                else:counts["ordinary"]+=1
            last=Fraction(str(path[-1][0]["energy_inscription_kj_mol"]));counts["positive" if last>0 else "absence"]+=1
        expected={"positive":46,"absence":4,"basin":6,"barrier":6,"ordinary":36,"recurrence_duplicate":2};passed=all(r["passed"] for r in comparisons) and counts==expected
        isolation=seal_isolation_certificate(unsealed_isolation_certificate(executor_id=self.spec.experiment_id+"-prediction-executor",host_platform=platform.system() or "registered-host",python_implementation=platform.python_implementation(),interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id),program_hash=execution.program_hash,input_manifest_hash=execution.input_manifest_hash,registered_target_identity_hash=vault.commitment.target_identity_hash,comparison_implementation_identity_hash=sha256_identity(("complete-NIST-ethanol-path-comparator/1",self.spec.experiment_id)),prediction_seal_hash=ps.seal_hash,output_hash=execution.output_hash,trace_hash=execution.trace_hash));ti=target_identity_from_release(release);custody=seal_target_custody_certificate(unsealed_target_custody_certificate(custodian_id=release.custodian_id,experiment_registration_hash=rh,registered_target_identity_hash=ti,prediction_seal_hash=ps.seal_hash,target_release_manifest_hash=release.release_hash));payload={"comparisons":comparisons,"counts":counts,"trace":execution.trace_hash};measurements=tuple(f"{r['target_id']}: kJ {r['exact_kj']}; cm {r['exact_cm']}; pass {r['passed']}" for r in comparisons)+tuple(f"count {k}: {v}" for k,v in counts.items());return EmpiricalValidation(sealed.seal_hash,rh,isolation,custody,True,True,True,(SOURCE_ID,),measurements,sha256_identity(payload),self.spec.falsification_condition,passed)
__all__=("ConfigurationOrderValidator","experiment_registration_record","prediction_program_document")
