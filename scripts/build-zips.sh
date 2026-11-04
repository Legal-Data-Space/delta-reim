#!/usr/bin/env bash
# Build the manual-upload fallbacks into dist/:
#   dist/plugin-<name>.zip   one per plugin, plugin root at the zip root (Customize > Plugins > Upload,
#                            or Organization settings > Plugins & skills > Upload a plugin)
#   dist/skill-<name>.zip    one per skill, the skill folder at the zip root (Customize > Skills > Upload)
# Checks each SKILL.md: name == folder name, name <= 64 chars, description <= 200 chars.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist && mkdir dist
fail=0
for plugin in plugins/*/; do
  pname=$(basename "$plugin")
  (cd "$plugin" && zip -qr -X "../../dist/plugin-$pname.zip" . -x '*.DS_Store')
  for skill in "$plugin"skills/*/; do
    sname=$(basename "$skill")
    fm_name=$(sed -n '2,5p' "$skill/SKILL.md" | sed -n 's/^name: *//p')
    fm_desc=$(sed -n '2,5p' "$skill/SKILL.md" | sed -n 's/^description: *//p')
    dlen=$(printf '%s' "$fm_desc" | wc -m)
    if [[ "$fm_name" != "$sname" ]]; then echo "FAIL $sname: name '$fm_name' != folder"; fail=1; fi
    if (( ${#fm_name} > 64 )); then echo "FAIL $sname: name > 64 chars"; fail=1; fi
    if (( dlen > 200 )); then echo "FAIL $sname: description $dlen chars > 200"; fail=1; fi
    (cd "$plugin/skills" && zip -qr -X "../../../dist/skill-$sname.zip" "$sname" -x '*.DS_Store')
    echo "ok  skill $sname (description $dlen chars)"
  done
  echo "ok  plugin $pname"
done
exit $fail
