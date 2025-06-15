def dps [] {
  docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}" | from tsv --noheaders | rename ID Name Image Status
}

def dkill [] {
    let id = (docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf | split words | get 0)
    if ($id | is-empty) {
        echo "No container selected"
    } else {
        docker kill $id
    }
}
