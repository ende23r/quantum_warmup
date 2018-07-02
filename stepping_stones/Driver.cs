using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.stepping_stones {
    class Driver {
        static void Main(string[] args) {
            using (var sim = new QuantumSimulator()) {
                /*
                // Try initial values
                int[] possibles = new int[] { 0, 1, 2, 3 };
                foreach (int possible in possibles) {
                    var res = Bell_Test.Run(sim, 1000, possible).Result;
                    var (num_zeros, num_ones, agree) = res;
                    System.Console.WriteLine(
                        $"State:{possible,-4} 0s={num_zeros,-4} 1s={num_ones,-4} agree={agree, -4}");
                }
                //*/

                /*
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

                int[] possibles = new int[] { 1, 2, 3, 4, 5, 6, 7, 8 };
                foreach (int possible in possibles) {
                    var res = GHZ_Test.Run(sim, 1000, possible).Result;
                    var (num_zeros, num_ones, agree) = res;
                    System.Console.WriteLine(
                        $"Qubits:{possible,-4} 0s={num_zeros,-4} 1s={num_ones,-4} agree={agree,-4}");
                }
            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
    }
}