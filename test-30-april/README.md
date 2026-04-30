# SonarQube Artifact (30 April)

This folder contains a reusable SonarQube scanner configuration for the app:

- https://github.com/guycalledavinash/miscellaneous/tree/main/test-8-apr-25

## Files

- `sonar-project.properties`: Baseline SonarQube project configuration.

## Usage

From the root of the `test-8-apr-25` app checkout:

```bash
sonar-scanner -Dproject.settings=/path/to/test-30-april/sonar-project.properties
```

If your app produces coverage reports, uncomment the matching coverage key in
`sonar-project.properties` and ensure the report path exists before running the scan.
