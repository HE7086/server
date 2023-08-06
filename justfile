FLAKE_PATH := `nix flake metadata --json | jq '.path'`

deploy HOSTS=`ls ./hosts | sed 's/\.nix$//' | xargs`:
    for host in {{HOSTS}}; do
        rsync -acvF -e ssh {{FLAKE_PATH}}/ root@$host:/etc/nixos
        ssh root@$host nixos-rebuild switch --fast --flake /etc/nixos
    done