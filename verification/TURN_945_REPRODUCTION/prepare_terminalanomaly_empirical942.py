from pathlib import Path
w=Path('work')
for particle,n,tag,cid in [('electron',942,'TerminalElectronEmpirical','SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004'),('muon',943,'TerminalMuonEmpirical','SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004')]:
 s=(w/'prepare_terminalproton_empirical940.py').read_text().replace('matter_flavour_terminal_proton','matter_flavour_terminal_anomaly').replace('src.EMPIRICAL_SPEC','src.'+particle.upper()+'_EMPIRICAL_SPEC').replace('TerminalProtonEmpirical',tag).replace('TerminalProtonMeasurement','TerminalAnomalyMeasurement').replace('TerminalProtonRecords','TerminalAnomalyRecords').replace('940',str(n)).replace('SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004',cid)
 a=s.index("p=r/'SFT/Physics/TerminalAnomalyMeasurement.lean'");b=s.index("gen=(w/",a);s=s[:a]+s[b:]
 s=s.replace("['contributionCheck'],'classification'",f"['{particle}Check'],'{particle}Classification'")
 s=s.replace("p.write_text(s)\n\nfor root", "s=s.replace('TerminalAnomalyRecords.componentHashes','TerminalAnomalyRecords.componentFiles');p.write_text(s)\n\nfor root")
 (w/f'prepare_terminal{particle}_empirical{n}.py').write_text(s)
 exec(compile(s,'original-'+particle+'-empirical','exec'),{})
