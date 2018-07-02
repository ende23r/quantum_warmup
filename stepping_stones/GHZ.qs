/// GHZ stands for Greenberger–Horne–Zeilinger, who describe a fairly simple state for an array of qubits.
/// The state is a superposition of |0...0> and |1...1>

namespace Quantum.stepping_stones {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	/// Given an array of qubits of length 1 to 8,
	/// Puts GHZ state on them.
	operation GHZ (qs : Qubit[]) : () {
		body {
			H(qs[0]);

			let nQubits = Length(qs);
			for (idxQubit in 0..nQubits - 2) {
				CNOT(qs[idxQubit], qs[idxQubit + 1]);
			}
		}
	}

	operation GHZ_Test (count : Int, nQubits : Int) : (Int, Int, Int) {
		body {
			mutable num_ones = 0;
			mutable agree = 0;
			using (qubits = Qubit[nQubits]) {
			
				for(test in 1..count) {
					for(iQubit in 0..nQubits - 1) {
						Set(Zero, qubits[iQubit]);
					}

					GHZ(qubits);
					let res = M(qubits[0]);

					mutable consensus = 1;
					for(iQubit in 1..nQubits - 1) {
						if( M(qubits[iQubit]) == res) {
							set consensus = consensus + 1;
						}
					}

					if(consensus == nQubits) {
						set agree = agree + 1;
					}

					//Count the number of ones
					if(res == One) {
						set num_ones = num_ones + 1;
					}
				}

				for(iQubit in 0..nQubits - 1) {
					Set(Zero, qubits[iQubit]);
				}
			}

			//returns (# of zeros, # of ones)
			return (count-num_ones, num_ones, agree);
		}
	}
}