The Hiding Secrets & Finding Secrets repository
this will contain the material for the workshop.

# Finding secrets, everywhere

## The presentation of the  of the Hiding Secrets & Finding Secrets

[Presentation slides](https://github.com/dev-vs-ciso/wts24-secrets/blob/main/WhatTheStack_Hiding%20Secrets%20%26%20Finding%20Secrets.pdf)

## Finding stuff on github that someone tried to correct
`https://github.com/search?q=remove+api+key&type=pullrequests`

## Test out docker images for leaks
```
docker build . -t mysecureapp
docker run -t mysecureapp
docker ps -a
docker export (pid)  > mysecureapp.tar
untar
find . -name Dockerfile
find . \( ! -path "$mount_point/Windows/*" -a ! -path "$mount_point/Program Files/*" -a ! -path "$mount_point/Program Files \(x86\)/*" \) -size -25M \
                    \( -name ".aws" -o -name ".ssh" -o -name "credentials.xml" \
                    -o -name "secrets.yml" -o -name "config.php" -o -name "_history" \
                    -o -name "autologin.conf" -o -name "web.config" -o -name ".env" \
                    -o -name ".git" \) -not -empty
```

## Finding stuff on public indexed sites
### .git content
`".git" intitle:"Index of"`
`git-dumper https://website.cim/.git/ website.com`
`gitleaks detect -v`

### web.config
`inurl:"web.config" & intext:"Password" & ext:config -git`

## Checking AWS key in CloudTrail: 
CloudTrail->Event History -> search for AWS key


# How to protect from secrets - local pre-commit
`pip install pre-commit --break-system-packages`

Note: If invoking pip returns “not found”, try pip3.

`pip3 install pre-commit --break-system-packages`

This will show the folder of the installation, which needs to be added to PATH, because pre-commit is a binary executable.

You can open another terminal window and type pre-commit. If pre-commit is in path, you’ll se an error message like this An error has occurred: FatalError: git failed. Is it installed, and are you in a Git repository directory?

After this a file needs to be created in the root folder of every repository, called .pre-commit-config.yaml and containing the following:

```
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0  # Specify the desired version of Gitleaks
    hooks:
      - id: gitleaks

```
Finally, on each repository call the following command without a virtual environment:

`pre-commit install`