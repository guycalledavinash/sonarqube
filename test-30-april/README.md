# SonarQube Artifact (30 April)

This folder contains a reusable SonarQube scanner configuration for the app:

- https://github.com/guycalledavinash/miscellaneous/tree/main/test-8-apr-25

## Files

- `sonar-project.properties`: Baseline SonarQube project configuration.
- `scan.sh`: Validates required environment variables and invokes SonarScanner.
- `github-actions-sonar.yml.example`: CI example that uses GitHub secrets and
  waits for the configured SonarQube Quality Gate.

## Usage

Install a compatible SonarScanner, then set the server URL and a user or project
token outside source control. Do not put tokens in scanner properties, scripts,
or GitHub workflow files.

```bash
export SONAR_HOST_URL=https://sonarqube.example.com
export SONAR_TOKEN=replace-with-a-secret-token
chmod +x /path/to/test-30-april/scan.sh
/path/to/test-30-april/scan.sh /path/to/test-8-apr-25
```

To include coverage, generate the report first and provide both its path and the
matching scanner property. For example, for a JavaScript LCOV report:

```bash
SONAR_COVERAGE_REPORT=coverage/lcov.info \
SONAR_COVERAGE_PROPERTY=sonar.javascript.lcov.reportPaths \
/path/to/test-30-april/scan.sh /path/to/test-8-apr-25
```

The script stops before scanning if the required credentials, scanner executable,
or declared coverage report is missing. When the target app's source and test
layout is known, replace the broad test inclusion patterns with its exact paths.

## CI and Quality Gate

Copy `sonar-project.properties` to the target application's root and
`github-actions-sonar.yml.example` into its `.github/workflows/` directory,
then adapt its install/test commands. Store `SONAR_TOKEN` as a GitHub Actions
secret and `SONAR_HOST_URL` as a repository or organization variable. The
example passes `sonar.qualitygate.wait=true`, so CI fails when the configured
SonarQube Quality Gate does not pass.
