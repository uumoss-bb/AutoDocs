@infrastructure
Feature: Infrastructure
  As a developer
  I want to know when my application is up or down
  Sot that I can automate actions

  As a developer
  I want to serve (prometheus) metrics
  so that I can visualize and alert on application and system metrics

  The service should serve:
  - A heartbeat which serves as a health-check
  - Prometheus metrics via the /metrics endpoint

  @important
  Scenario: Heartbeat
    When I GET from the /heartbeat endpoint
    Then the result matches the heartbeat schema

  @important
  @verifyAfter
  Scenario: Prometheus metrics
    When I GET from the /metrics endpoint
    Then the result contains all necessary metrics
    And the metrics all have a cardinality less than 12
    And no metric label contains mongoIds
