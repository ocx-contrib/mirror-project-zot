# Smoke test for project-zot/zot. Contract, not prose.
ZOT = "zot.exe" if ocx.target_platform.os == ocx.os.Windows else "zot"

# Tier 1+2 — `-v` logs one JSON line. Stream moved across the range
# (stderr on 2.0.0, stdout on 2.1.x), so check both.
r = ocx.run(ZOT, "-v")
expect.ok(r)
out = r.stdout + r.stderr
# Stamped build: commit is the tag, and binary-type lists the extensions
# compiled in — the `-minimal` asset has none, so a flavour mix-up reds here.
# v2.1.10 alone shipped without build ldflags (module moved to /v2, the -X
# paths missed): commit and binary-type are both empty on every flavour. Only
# that fully unstamped shape is accepted; the anchored asset patterns keep
# `-minimal` out for that one release.
expect.matches(out, r'"commit":"(v\d+\.\d+\.\d+[^"]*","binary-type":"[^"]*-search|","binary-type":"")')

# Tier 3 — `verify` parses and validates a config. Hermetic: config and
# storage root both under scratch. Forward slashes keep the JSON valid on
# Windows (Go accepts them there).
root = ocx.scratch_root.replace("\\", "/")
ocx.mkdir("data")
ocx.write_file("good.json", '{"distSpecVersion":"1.1.1","storage":{"rootDirectory":"' + root + '/data"},"http":{"address":"127.0.0.1","port":"5999"},"log":{"level":"error"}}')
expect.ok(ocx.run(ZOT, "verify", "good.json"))

# Negative: an unknown key must be rejected, or `verify` proves nothing.
ocx.write_file("bad.json", '{"storage":{"rootDirectory":"' + root + '/data"},"http":{"address":"127.0.0.1","port":"5999"},"bogusKey":1}')
expect.ne(ocx.run(ZOT, "verify", "bad.json").exit_code, 0)
