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

	operation Bell_Test (count : Int, initial : Result) : (Int, Int, Int) {
		body {
			mutable num_ones = 0;
			mutable agree = 0;
			using (qubits = Qubit[2]) {
			
				for(test in 1..count) {
					Set(initial, qubits[0]);
					Set(Zero, qubits[1]);

					H(qubits[0]);
					CNOT(qubits[0], qubits[1]);
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
