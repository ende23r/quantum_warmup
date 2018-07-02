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

	operation GHZ_Test (count : Int, state : Int) : (Int, Int, Int) {
		body {
			mutable num_ones = 0;
			mutable agree = 0;
			using (qubits = Qubit[2]) {
			
				for(test in 1..count) {
					Set(Zero, qubits[0]);
					Set(Zero, qubits[1]);

					Bell_State(qubits, state);
					let res = M(qubits[0]);

					if( M(qubits[1]) == res ) {
						set agree = agree + 1;
					}

					//Count the number of ones
					if(res == One) {
						set num_ones = num_ones + 1;
					}
				}

				Set(Zero, qubits[0]);
				Set(Zero, qubits[1]);
			}

			//returns (# of zeros, # of ones)
			return (count-num_ones, num_ones, agree);
		}
	}
}