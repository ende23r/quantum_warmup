///Oracle time!!!!
namespace Quantum.stepping_stones {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	///Sets y to |1> if the parity of x is odd, otherwise |0>

	operation Parity_Oracle (x : Qubit[], y : Qubit) : () {
		body {
			ApplyToEachCA(H, x);
			H(y);

			let n = Length(x);
			for(index in 0..n-1) {
				CNOT(y, x[index]);
			}

			ApplyToEachCA(H, x);
			H(y);
		}
	}

	operation Get_Parity_Test (bits : Int, ones : Int) : Int {
		body {
			mutable parity = -1;
			using (qubits = Qubit[bits+1]) {

				for (bit in 0..bits-1) {
					if (bit < ones) { Set(One, qubits[bit]); }
				}

				using (output = Qubit[1]) {
					Parity_Oracle (qubits, output[0]);

					let res = M(output[0]);
					if (res == One) { set parity = 1; }
					elif (res == Zero) { set parity = 0; }

					Set(Zero, output[0]);
				}
				for (bit in 0..bits-1) {
					Set(Zero, qubits[bit]);
				}
			}

			return parity;
		}
	}

	operation DJ (N : Int, Uf : ((Qubit[], Qubit) => ())) : Bool {
        body {
			mutable ans = true;

			using (offer = Qubit[N]) {
				for(index in 0..N - 1) {
					Set(Zero, offer[index]);
				}

				using (receive = Qubit[1]) {
					Set(One, receive[0]);

		            ApplyToEachCA(H, offer);
					H(receive[0]);

					Uf(offer, receive[0]);

					ApplyToEachCA(H, offer);
					Set(Zero, receive[0]);
				}

				for(index in 0..N - 1) {
					if( M(offer[index]) == One ) {
						set ans = false;
					}
					Set(Zero, offer[index]);
				}
			}

			return ans;
        }
    }
}