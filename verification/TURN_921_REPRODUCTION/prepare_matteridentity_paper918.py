from pathlib import Path
import shutil,datetime
w=Path('work');items=[('ckmphysical',918,'PhysicalCKMEntry','CKM_PHYSICAL',790,'Mass-root CKM physical relation graph','ckm_physical_identity and CKM_PHYSICAL_SPEC','''The prior quark derivation seals the down and up polynomials through their exact coefficient records:

p_d(x)=x³−x²+(1/8)x−1/383,
p_u(x)=x³−x²+(1/12)x−1/3071.

QuarkInvariants.exactCubics establishes these records. QuarkIsolation.rootBrackets and its retained positive-separation proof supply ordered rational enclosures without replacing the roots by irrational proof values. The dressing entry preserves the original carrier roles before this mixing graph is assembled.

Write m_d,l and m_d,c for the graph's light and central down masses, and r_d,c,r_d,h,r_u,c,r_u,h for its central/heavy ladder roots. The original three symbolic relations are

s₁₂²=m_d,l/m_d,c,
s₂₃=positive_take(r_d,c/r_d,h, r_u,c/r_u,h),
s₁₃²=(s₁₂²·s₂₃²)/(bc).

Here positive_take retains the original ordered positive difference and structural-empty equality case. These are the source's sealed relation graph; the operation preserves its three symbolic relation labels and does not form algebraic roots. The generated counts give

b=2, c=3, bc=6,
apex²=1/(bc)=1/6,
phase=1/b=1/2.

MatterIdentityGraphs.ckmPhysicalIdentity returns exactly the original five fields: all three symbolic relations, apex square and phase. completeCKMIdentity proves that full record; apexSixChannelIdentity proves (1/6)·6=1. The core comparison checks every original string and both exact rationals. Existing polynomial and enclosure proofs remain the graph's scientific dependencies.

The source base links the light and central roots through the first squared ratio. Its successor appends the second ladder and six-channel dilution while retaining the apex identity. The original witness checks that the apex square is exactly the reciprocal of the counted six channels. No CKM target or independently fitted angle enters the operation.'''),('protonidentity',919,'ProtonIdentityEntry','PROTON_IDENTITY',791,'Proton-to-electron hierarchy relation graph','proton_electron_identity and PROTON_ELECTRON_SPEC','''The source preserves the leading charged-lepton polynomial coefficient triple

(1,1/6,1/485),
p_ℓ(x)=x³−x²+(1/6)x−1/485.

The already sealed lepton derivation retains its roots by exact rational enclosures. Let r_e and r_μ denote the two light roots named by the original identity, with masses m_e=r_e² and m_μ=r_μ² in the common One normalization. The generator-three colour carrier gives

q_p=1/c=1/3,
3q_p=1.

The source's complete ratio graph is

R_p/e=(1/3)·positive_take(m_μ,m_e)/(m_μm_e).

On the ordered unequal mass branch, the same graph reads

R_p/e=(m_μ−m_e)/(3m_μm_e).

This expression retains the original polynomial-root carriers; it does not replace them with measured particle masses. The source operation returns the exact coefficient triple, the generated one-third share and the complete symbolic ratio label. MatterIdentityGraphs.protonElectronIdentity computes the share from generatorPeriod and retains the other two original fields. completeProtonIdentity proves the entire three-field record; threeColourShare proves the exact colour-share identity.

The original base supplies one colour-bound whole and its one-third share. The successor attaches the two required light mass roots of the complete lepton polynomial without adding a scale. The operational witness checks both the polynomial triple and the generated share. The prior polynomial and enclosure results are reused; no new numerical root, experimental ratio or fitted scale is introduced.''')]
for low,n,tag,key,sec,title,source,body in items:
 for suffix in ['science_report.json','core_audit.log','core_build.log']:shutil.copy2(w/('matteridentity918_'+suffix),w/(low+str(n)+'_'+suffix))
 s=(w/'register_ckmfibres917.py').read_text().replace("'CKMFibres':'Original ckm_fibres two generated bases,all9 absolute-difference overlap cells,original ordered indexing and complete diagonal guard;complete three-field output,cell count and diagonal proofs.'","'MatterIdentityGraphs':'Original ckm_physical_identity five-field symbolic graph and proton_electron_identity three-field graph,existing generated counts,exact rational divisions and complete original field proofs.'").replace('Original complete nine-cell matrix witness through the actual generated bases.','Original entry-specific exact apex or polynomial/share witness through the source identity.').replace("['ckmfibres917_core_build.log']","[f'{low}{n}_core_build.log']").replace("f'check_{low}{n}.py'","'check_matteridentity918.py'");(w/f'register_{low}{n}.py').write_text(s)
 shared='The original eight binary axes enumerate all 2⁸=256 forms. The relation axis retains the source identity above; the remaining axes retain generated carriers, root dependencies, complete enumeration, omission controls, seal-before-comparison, full polynomial/census/control records and no extra rule. Every original decision, unique survivor, witness, control and closure field is retained by the native program.'
 (w/f'paper_{low}{n}_addition.txt').write_text(f'\n{sec}. {title}\n\n'+body+'\n\n'+shared+f'\n\nOriginal V3: sft/physics/matter_flavour_laws_v1.py, {source}; its registered polynomial and carrier dependencies. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: MatterIdentityGraphs and {tag}Witnesses/Grammar/Controls/Evidence, with existing QuarkInvariants, QuarkIsolation and charged-lepton proofs. Timeline: TURN{n}. Receipt: verification/TURN_{n}_{key}_COMPLETION.json.\n\n[Original source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_laws_v1.py); [Native identities](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/MatterIdentityGraphs.lean); [Full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/{tag}Grammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).\n')
 (w/f'timeline{n}_addition.txt').write_text('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+f' — TURN{n}: translated {source},preserving original symbolic relation labels,generated rational fields and exact returned record. Read existing QuarkInvariants/QuarkIsolation definitions and proofs;reused scientific dependencies without numerical root substitution. Shared10-declaration audit empty;all original5+3 identity output fields match. Existing generator prepared original256 forms,entry witness,controls and program. Registrar requires full build,all declaration audits,entire native/original program and original independent-validator outcomes before entry completion. Section{sec} includes original polynomial and relation equations,generated counts,exact operations and source/Lean/timeline links.\n')
print('Prepared both papers and source-specific registrars')
