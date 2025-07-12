# secrets-template.nix
# Copy this to secrets.nix and add your actual values
# Make sure to chmod 600 secrets.nix and add it to .gitignore
# TODO: Change to use SOPS-Nix

{
  # API keys and tokens
  apiKeys = {
    openai = "sk-your_openai_key";
    anthropic = "your_anthropic_key";
    # Add other API keys as needed
  };
}
