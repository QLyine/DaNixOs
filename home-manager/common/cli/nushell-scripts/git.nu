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
