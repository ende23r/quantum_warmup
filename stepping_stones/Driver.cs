using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.stepping_stones {
    class Driver {
        static void Main(string[] args) {
            using (var sim = new QuantumSimulator()) {
                /*
                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials) {
                    var res = Bell_Test.Run(sim, 1000, initial).Result;
                    var (num_zeros, num_ones, agree) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={num_zeros,-4} 1s={num_ones,-4} agree={agree, -4}");
                }
                //*/

                ///*
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
            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
    }
}