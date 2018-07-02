using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.stepping_stones {
    class Driver {
        static void Main(string[] args) {
            using (var sim = new QuantumSimulator()) {
                /* B
                // Try initial values
                int[] possibles = new int[] { 0, 1, 2, 3 };
                foreach (int possible in possibles) {
                    var res = Bell_Test.Run(sim, 1000, possible).Result;
                    var (num_zeros, num_ones, agree) = res;
                    System.Console.WriteLine(
                        $"State:{possible,-4} 0s={num_zeros,-4} 1s={num_ones,-4} agree={agree, -4}");
                }
                //*/

                /* D
                Result[] tests = new Result[] { Result.Zero, Result.One };
                foreach (Result t in tests) {
                    var res = Plus_Minus_Test.Run(sim, t).Result;

                    if(t == Result.Zero) {
                        System.Console.WriteLine($"Given:|+> Returned:{res,-4}");
                    }
                    else if (t == Result.One) {
                        System.Console.WriteLine($"Given:|-> Returned:{res,-4}");
                    }

                }
                //*/

                /* C
                int[] possibles = new int[] { 1, 2, 3, 4, 5, 6, 7, 8 };
                foreach (int possible in possibles) {
                    var res = GHZ_Test.Run(sim, 1000, possible).Result;
                    var (num_zeros, num_ones, agree) = res;
                    System.Console.WriteLine(
                        $"Qubits:{possible,-4} 0s={num_zeros,-4} 1s={num_ones,-4} agree={agree,-4}");
                }
                */

                /* E
                // Try initial values
                int[] possibles = new int[] { 0, 1, 2, 3 };
                foreach (int possible in possibles) {
                    var res = Bell_Decode_Test.Run(sim, possible).Result;
                        
                    System.Console.WriteLine(
                        $"Input State:{possible, -1}, Detected State:{res, -1}");
                }
                //*/

                /* F
                bool[] t11 = new bool[] { false, false, false, false };
                bool[] t12 = new bool[] { true, true, true, true };
                QArray<bool> hey = new QArray<bool>(t11);
                QArray<bool> bud = new QArray<bool>(t12);

                long r11 = Pick_Basis_Test.Run(sim, hey, bud, 0).Result;
                long r12 = Pick_Basis_Test.Run(sim, hey, bud, 1).Result;
                System.Console.WriteLine(
                        $"Test 1-1. Expected:0, Reply:{r11, -1}\n" +
                        $"Test 1-2. Expected:1, Reply:{r12, -1}");

                //*/

                //* H
                int bits1 = 5;
                for(int ones=0; ones <= bits1; ones++) {
                    var res = Get_Parity_Test.Run(sim, bits1, ones).Result;

                    System.Console.WriteLine(
                        $"Total Bits:{bits1} One Bits:{ones} Parity Discovered:{res}");
                }

                int bits2 = 8;
                for (int ones = 0; ones <= bits2; ones++) {
                    var res = Get_Parity_Test.Run(sim, bits2, ones).Result;

                    System.Console.WriteLine(
                        $"Total Bits:{bits2} One Bits:{ones} Parity Discovered:{res}");
                }
                //*/
            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
    }
}