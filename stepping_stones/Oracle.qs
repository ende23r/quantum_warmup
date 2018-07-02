///Oracle time!!!!
namespace Quantum.stepping_stones {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	///Sets y to |1> if the parity of x is odd, otherwise |0>
	operation Get_Parity (x : Qubit[], y : Qubit) : () {
        body {
			Set(Zero, y);
            let input_len = Length(x);

			for (index in 0..input_len - 1) {
				if( M(x[index]) == One) {
					X(y);
				}
			}
        }
    }
}