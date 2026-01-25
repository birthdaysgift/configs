To work with more than one GH account in one local machine:

1. Generate two different ssh keys. One for personal usage and one for "company".

2. Add each key to according GH account in GH website.

3. Configure ~/.ssh/config so that it will use github.com-personal with personal ssh key,
    and github.com-company with company ssh key.

```
# Personal GH account
Host github.com-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519

# Org GH account
Host github.com-company
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519-company-github
```

4. For each cloning repository, add "-company" or "-personal" suffix to GH domain.
    (same as in "Host" in ~/.ssh/config file)

---

In case of issues, this may (potentially) help:


```bash
git credential-cache exit
```
