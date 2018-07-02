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

	///Testing for operation Plus_or_Minus
	operation Plus_Minus_Test (expected : Result) : (Int) {
		body {
			mutable ans = 0;
			using (qubits = Qubit[1]) {
				Set(expected, qubits[0]);
				H(qubits[0]);

				set ans = Plus_or_Minus(qubits[0]);

				Set(Zero, qubits[0]);
			}

			//returns (integer result of measurement)
			return (ans);
		}
	}

	operation Pick_Basis (qs : Qubit[], bits0 : Bool[], bits1 : Bool[]) : Int {
		body {
			let register_len = Length(qs);

			for (index in 0..register_len-1) {
				if ( M(qs[index]) != Bool_to_Result(bits0[index]) ) {
					return 1;
				}
			}

			return 0;
		}
	}

	operation Bool_to_Result (b : Bool) : Result {
		body {
			if(b) { return One; }
			return Zero;
		}
	}

	operation Pick_Basis_Test (bits0 : Bool[], bits1 : Bool[], correct : Int) : Int {
		body {
			let register_len = Length(bits0);
			mutable ans = -1;
			using(qubits = Qubit[register_len]) {

				for(index in 0..register_len-1) {
					if( correct == 0 ) {
						Set( Bool_to_Result( bits0[index] ), qubits[index] );
					}
					else {
						Set( Bool_to_Result( bits1[index] ), qubits[index] );
					}
				}

				set ans = Pick_Basis(qubits, bits0, bits1);
			
				for(index in 0..register_len-1) {
					Set(Zero, qubits[index]);
				}
			}

			return ans;
		}
	}
}