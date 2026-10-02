# Grafana Observability Pipeline

This repository contains the complete configuration and documentation for my Grafana observability pipeline, designed to monitor system metrics, container logs, and alerts across Docker environments.

## Overview

This observability pipeline provides comprehensive monitoring capabilities using Prometheus, CAdvisor, Docker Health Exporter, Grafana Alloy, Grafana Loki, and Grafana. The setup includes:

- **Prometheus** for metric collection and storage
- **CAdvisor** for container resource utilization monitoring
- **Docker Health Exporter** for container health metrics
- **Grafana Alloy** for log collection and processing
- **Grafana Loki** for log aggregation and storage
- **Grafana** for dashboard visualization and alerting
- **Portainer** for container management

## Architecture

The pipeline consists of multiple interconnected components working together to provide complete observability:

1. **Data Collection Layer**
   - Prometheus scrapes system metrics from various sources including CAdvisor and Docker Health Exporter
   - Grafana Alloy collects and processes Docker container logs
   - Custom bash scripts monitor container health

2. **Processing Layer**
   - Configuration files define scraping rules and label assignments
   - Data staging and transformation logic
   - Log processing and enrichment

3. **Visualization Layer**
   - Grafana dashboards for real-time monitoring
   - Pre-configured panels for metrics, logs, and alerts
   - Custom visualizations for system health

## Key Components

### Configuration Files

- `config.alloy`: Main configuration file that defines the entire observability pipeline including:
  - Data sources and scraping endpoints
  - Label assignment and filtering rules
  - Log processing stages
  - Data routing destinations

### Monitoring Components

- **CAdvisor**: Container monitoring for resource utilization metrics
- **Docker Health Exporter**: Exports container health status as Prometheus metrics
- **Grafana Loki**: Log aggregation and storage system
- **Prometheus**: Main metric collection and storage system

### Monitoring Scripts

- **Docker Monitor Bash Script**: 
  - Scrapes container health information
  - Logs monitoring data to `docker-monitor.log`
  - Executes on a 5-minute cron job schedule
  - Provides container lifecycle tracking

### Container Management

- **Portainer**: Lightweight Docker container management UI
  - Provides visual interface for container operations
  - Network and volume management
  - Container health monitoring

## Screenshots

This repository includes comprehensive screenshots that illustrate the complete observability setup:

### Grafana Dashboards
- [Grafana_Dashboard.png](Grafana_Dashboard.png)
- [Grafana_Dashboard_2.png](Grafana_Dashboard_2.png)
- [Grafana_Dashboard_3.png](Grafana_Dashboard_3.png)
- [Grafana_Metrics.png](Grafana_Metrics.png)
- [Grafana_Logs.png](Grafana_Logs.png)
- [Grafana_Alloy.png](Grafana_Alloy.png)

### Container Management
- [Portainer.png](Portainer.png)
- [Portainer_2.png](Portainer_2.png)
- [Portainer_3.png](Portainer_3.png)

## Installation and Setup

### Prerequisites

- Docker and Docker Compose installed
- Grafana, Prometheus, and Alloy services configured
- Access to the monitoring environment

### Deployment

1. Clone this repository
2. Review and customize configuration files as needed
3. Deploy using your preferred container orchestration method
4. Access Grafana dashboard at `http://localhost:3000`

## Monitoring Features

### System Metrics
- Real-time system performance tracking
- Resource utilization monitoring (CPU, memory, disk) via CAdvisor
- Network activity visualization

### Container Logs
- Docker container log collection and processing via Grafana Alloy and Loki
- Log filtering and enrichment capabilities
- Historical log analysis

## Customization

The pipeline can be customized by:

1. Modifying `config.alloy` to adjust scraping rules and processing logic
2. Updating label assignments in Prometheus configuration
3. Creating custom Grafana dashboards
4. Extending the Docker monitoring script for additional metrics

## Troubleshooting

### Common Issues

- **Data Not Appearing in Grafana**: Check Prometheus scraping configuration
- **Log Processing Failures**: Review Alloy configuration and log permissions
- **Container Monitoring Gaps**: Verify cron job execution and script permissions

### Logs

The `docker-monitor.log` file contains detailed container health monitoring data, useful for troubleshooting.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a pull request