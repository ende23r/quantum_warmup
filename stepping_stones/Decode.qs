namespace Quantum.stepping_stones {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    
	/// Operations for distinguishing between known sets of Qubits.

	/// Returns 1 for a qubit in |+> state and -1 for a qubit in |-> state.
	/// Argument q may be dirty after measurement.
	
	operation Plus_or_Minus(q : Qubit) : (Int) {
		body {
			H(q);
			let res = M(q);

			if(res == Zero) {
				return 1;
			}
			elif (res == One) {
				return -1;
			}

			return 0;
		}
	}

	operation Plus_Minus_Test (expected : Result) : (Int) {
		body {
			mutable ans = 0;
			using (qubits = Qubit[1]) {
				Set(expected, qubits[0]);
				H(qubits[0]);

				set ans = Solve(qubits[0]);

				Set(Zero, qubits[0]);
			}

			//returns (integer result of measurement)
			return (ans);
		}
	}
}