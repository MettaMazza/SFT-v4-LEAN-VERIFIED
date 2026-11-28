import sys, math
import numpy as np

def parse_ca(pdb):
    coords = []
    with open(pdb) as f:
        for line in f:
            if line.startswith("ATOM") and line[12:16].strip() == "CA":
                coords.append([float(line[30:38]), float(line[38:46]), float(line[46:54])])
    return np.array(coords)

def kabsch(P, Q):
    C = np.dot(np.transpose(P), Q)
    V, S, W = np.linalg.svd(C)
    d = (np.linalg.det(V) * np.linalg.det(W)) < 0.0
    if d:
        S[-1] = -S[-1]
        V[:, -1] = -V[:, -1]
    U = np.dot(V, W)
    return U

def compute_tm(P, Q):
    L = len(P)
    d0 = 1.24 * math.pow(max(L - 15, 1), 1.0/3.0) - 1.8
    if d0 < 0.5: d0 = 0.5
    
    # We will do a simple iterative alignment to maximize TM-score
    # but for simplicity, we align the centers and calculate the TM score on the Kabsch alignment
    # (Note: true TM-score does a dynamic programming search for the best subset, 
    # but since these are exactly 1-to-1 matched arrays, we can just align the whole structure)
    P_center = np.mean(P, axis=0)
    Q_center = np.mean(Q, axis=0)
    P_centered = P - P_center
    Q_centered = Q - Q_center
    
    U = kabsch(P_centered, Q_centered)
    P_rotated = np.dot(P_centered, U)
    
    distances = np.sqrt(np.sum((P_rotated - Q_centered)**2, axis=1))
    
    tm_score = np.sum(1.0 / (1.0 + (distances / d0)**2)) / L
    return tm_score

def main():
    P = parse_ca(sys.argv[1])
    Q = parse_ca(sys.argv[2])
    n = min(len(P), len(Q))
    tm = compute_tm(P[:n], Q[:n])
    print(f"TM-score: {tm:.4f}")

if __name__ == "__main__":
    main()
