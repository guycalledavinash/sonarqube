#!/usr/bin/env bash
# Run a SonarQube scan without putting credentials in source control.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="${1:-$PWD}"

if [[ ! -d "$project_dir" ]]; then
  printf 'Project directory does not exist: %s\n' "$project_dir" >&2
  exit 1
fi

: "${SONAR_HOST_URL:?Set SONAR_HOST_URL to the SonarQube server URL.}"
: "${SONAR_TOKEN:?Set SONAR_TOKEN to a SonarQube user or project token.}"

if ! command -v sonar-scanner >/dev/null 2>&1; then
  printf '%s\n' 'sonar-scanner was not found on PATH. Install SonarScanner first.' >&2
  exit 1
fi

if [[ -n "${SONAR_COVERAGE_REPORT:-}" && ! -f "$project_dir/$SONAR_COVERAGE_REPORT" ]]; then
  printf 'Coverage report not found: %s\n' "$project_dir/$SONAR_COVERAGE_REPORT" >&2
  exit 1
fi

args=(
  "-Dproject.settings=$script_dir/sonar-project.properties"
  "-Dsonar.projectBaseDir=$project_dir"
  "-Dsonar.host.url=$SONAR_HOST_URL"
  "-Dsonar.token=$SONAR_TOKEN"
)

# Use this only after the application generates a compatible report, for example:
# SONAR_COVERAGE_REPORT=coverage/lcov.info SONAR_COVERAGE_PROPERTY=sonar.javascript.lcov.reportPaths
if [[ -n "${SONAR_COVERAGE_REPORT:-}" ]]; then
  : "${SONAR_COVERAGE_PROPERTY:?Set SONAR_COVERAGE_PROPERTY with SONAR_COVERAGE_REPORT.}"
  args+=("-D$SONAR_COVERAGE_PROPERTY=$SONAR_COVERAGE_REPORT")
fi

if [[ -n "${SONAR_SCANNER_ARGS:-}" ]]; then
  # Intentionally split optional extra scanner arguments supplied by the caller.
  # Keep standard arguments above as an array so paths and secrets remain intact.
  read -r -a extra_args <<<"$SONAR_SCANNER_ARGS"
  args+=("${extra_args[@]}")
fi

sonar-scanner "${args[@]}"
