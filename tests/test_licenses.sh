#!/usr/bin/env bash
set -eu
export TESTING=true
LICENSES=(
  'Academic Free License v3.0'
  'Apache License 2.0'
  'Artistic License 2.0'
  'BSD 2-Clause "Simplified" License'
  'BSD 3-Clause Clear License'
  'BSD 3-Clause "New" or "Revised" License'
  'Boost Software License 1.0'
  'Creative Commons Attribution 4.0'
  'Creative Commons Attribution Share Alike 4.0'
  'Creative Commons Zero v1.0 Universal'
  'Do What The F*ck You Want To Public License'
  'Educational Community License v2.0'
  'Eclipse Public License 1.0'
  'Eclipse Public License 2.0'
  'European Union Public License 1.1'
  'European Union Public License 1.2'
  'GNU Affero General Public License v3.0'
  'GNU General Public License v2.0'
  'GNU General Public License v3.0'
  'GNU Lesser General Public License v2.1'
  'GNU Lesser General Public License v3.0'
  'ISC License'
  'LaTeX Project Public License v1.3c'
  'MIT License'
  'Mozilla Public License 2.0'
  'Microsoft Public License'
  'Microsoft Reciprocal License'
  'University of Illinois/NCSA Open Source License'
  'SIL Open Font License 1.1'
  'Open Software License 3.0'
  'PostgreSQL License'
  'The Unlicense'
  'zlib License'
)

output=tests/tmp
template=$(mktemp -d)
cp -rf . "${template}"
(
  cd "${template}" || exit 1
  git add . -A || true
  git commit -m "test" || true
  git tag 99.99.99
)

for license in "${LICENSES[@]}"; do
  copier copy -f --trust "${template}" "${output}" \
    -d project_name="Pawamoy Testing" \
    -d project_description='Testing this great template' \
    -d author_fullname="Timothée Mazzucotelli" \
    -d author_username="pawamoy" \
    -d author_email="dev@pawamoy.fr" \
    -d copyright_license="${license}" &>/dev/null
  (
    cd "${output}"
    if [ -n "$(<LICENSE)" ]; then
      echo "${license}: OK"
    else
      echo "${license}: EMPTY!"
    fi
  )
  make --no-print-directory cleantests
done
