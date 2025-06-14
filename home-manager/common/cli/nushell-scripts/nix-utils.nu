# Define the function in NuShell
def nix-gc [
    n: int  # number of generations to keep
] {
    # Clean user profile generations older than N
    nix profile wipe-history --older-than $"($n)d"

    # Garbage collect
    sudo nix store gc
}