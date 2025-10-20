unalias gcm
gcm() {
  # Get the staged git diff.
  local staged_diff
  staged_diff=$(git diff --staged)

  # Check if there are any staged changes.
  if [ -z "$staged_diff" ]; then
    echo "No staged changes to generate a commit message for."
    return 1
  fi

  # Construct the prompt for Gemini, including the diff in a markdown block.
  local prompt
  prompt=$(printf "Generate a conventional commit message for the following git diff:\n\n\`\`\`diff\n%s\n\`\`\`" "${staged_diff}")

  # Try to copy the prompt to the clipboard (pbcopy for macOS, xclip for Linux).
  if command -v pbcopy >/dev/null; then
    printf "%s" "$prompt" | pbcopy
    echo "Prompt to generate commit message has been copied to your clipboard."
  elif command -v xclip >/dev/null; then
    printf "%s" "$prompt" | xclip -selection clipboard
    echo "Prompt to generate commit message has been copied to your clipboard."
  else
    # If no clipboard tool is found, print the prompt to the console.
    echo "--------------------------------------------------"
    echo "Copy the following prompt and paste it into Gemini:"
    echo "--------------------------------------------------"
    printf "%s\n" "$prompt"
    echo "--------------------------------------------------"
  fi
}
