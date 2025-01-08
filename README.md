# DevOps Challenge (.NET)

# Overview 

This repository demonstrates a DevOps challenge to containerize and build a .NET 5 application using a GitHub Actions CI/CD pipeline. The solution incorporates best practices to ensure a high-quality deliverable and an efficient developer experience.

# CI/CD Pipeline Details
Pipeline Configuration: .github/workflows/ci-cd-pipeline.yml

The pipeline is designed to build, containerize, and optionally push the application as a Docker image. Here's a breakdown:

# Triggers

push: Automatically triggers the pipeline for every push to the main branch.
pull_request: Executes the pipeline for pull requests targeting the main branch.
Jobs and Steps

1. Checkout Code

Uses the actions/checkout@v2 action to clone the repository into the runner.

2. Set Up .NET SDK

Configures the runner with .NET 5 SDK using the actions/setup-dotnet@v2 action.

3. Build Docker Image

Navigates to the source directory and builds the Docker image using the provided Dockerfile. Tags the image with the current GitHub run number for versioning.

4. Tag Docker Image

Tags the image with a user-specific Docker Hub namespace for easier identification.

5. Push to Docker Hub 

Authenticates with Docker Hub using repository secrets and pushes the tagged image.

# Dockerfile Details

Multi-Stage Build Process

1. Build Stage

Uses the official .NET 5 SDK image for compiling the application.
Restores dependencies using the project files.
Publishes the application in Release mode.

2. Final Stage

Runs the application using the optimized mcr.microsoft.com/dotnet/aspnet:5.0 image.
Copies published files from the build stage to the final image.
Exposes ports 80 and 443 for HTTP and HTTPS traffic.
Configures the application entry point.

# Best Practices

Dependency Restoration: Copies only necessary files for dependency restoration to optimize caching.
Multi-Stage Build: Minimizes the final image size by separating build and runtime stages.

Security: Cleans the apt cache after updates to reduce vulnerabilities.

# Best Practices in the CI/CD Pipeline

1. Efficient Caching
Utilized dependency restoration steps in Docker to leverage build layer caching.
3. Versioning
Tagged Docker images with the GitHub run number for traceability.
4. Secrets Management
Stored Docker Hub credentials as GitHub repository secrets to prevent exposure.
5. Portability
Leveraged ubuntu-latest runners for a consistent and platform-independent pipeline.

# Conclusion

This guide outlines the CI/CD pipeline and the best practices applied in this project. The solution ensures a streamlined and secure process for building and containerizing the .NET 5 application while adhering to DevOps principles.
