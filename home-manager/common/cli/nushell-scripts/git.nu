# Aliases

alias gs = git status

alias gstash = git stash
alias gstashpop = git stash pop

alias ggpush = git push --set-upstream origin (git branch --show-current)

# Functions

# Define a new branch
def gnew [branch: string] {
  git checkout -b $branch
}

def gundo [] {
  git reset --soft HEAD~1
}

def gstage-summary [] {
  git status --short | lines | each { |line| echo $line }
}


def grcm [] {
  git reset --hard HEAD

  try {
    git checkout master
  } catch {
    git checkout main
  }

  git fetch --all
  git pull

  try {
    git reset --hard origin/master
  } catch {
    git reset --hard origin/main
  }
}

def gconf [] {
   let selected = (
     git branch --all --color=never
     | lines
     | str trim
     | where { |it| not ($it | str contains 'HEAD') }
     | str replace '* ' ''
     | str replace 'remotes/' ''
     | uniq
     | fzf
     | split words
     | get 1
     | str trim
   )

    if ($selected | is-empty) {
      print "no branch selected"
    } else {
      git checkout $selected
    }
}
