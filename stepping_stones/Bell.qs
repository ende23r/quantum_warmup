namespace Quantum.stepping_stones {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Set (desired : Result, q1 : Qubit) : () {
        body {
			let current = M(q1);

			if(current != desired) {
				X(q1);
			}
            
        }
    }

	/// Given two qubits in state |00>, [1 0 0 0] permute them to a given Bell State:
	/// For index 0, [1 0 0 1]; for index 1, [1 0 0 -1]; for index 2, [0 1 1 0]; for index 3 [0 1 -1 0].
	operation Bell_State (qs : Qubit[], index : Int) : () {
		body {
			if (index == 1) {
				X(qs[0]); //Set first qubit to 1
			}
			elif (index == 2) {
				X(qs[1]); //Set second qubit to 1
			}
			elif (index == 3) {
				X(qs[0]); //Set first qubit to 1
				X(qs[1]); //Set second qubit to 1
			}
			//if index is 0, just leave it as |00>

			H(qs[0]);
			CNOT(qs[0], qs[1]);
		}
	}

	operation Distinguish_Bell_State (qs : Qubit[]) : Int {
		body {
			CNOT(qs[0], qs[1]);
			H(qs[0]);

			mutable state = 0;
			if ( M(qs[0]) == One) {
				set state = state + 1;
			}
			if ( M(qs[1]) == One ) {
				set state = state + 2;
			}

			return state;
		}
	}

	operation Bell_Test (count : Int, state : Int) : (Int, Int, Int) {
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

	operation Bell_Decode_Test (state : Int) : (Int) {
		body {
			mutable ans = 0;
			using (qubits = Qubit[2]) {
				Bell_State(qubits, state);
				set ans = Distinguish_Bell_State(qubits);

				Set(Zero, qubits[0]);
				Set(Zero, qubits[1]);
			}

			return ans;
		}
	}
}
