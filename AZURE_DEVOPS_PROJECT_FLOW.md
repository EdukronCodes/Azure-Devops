# Azure DevOps Project Flow - FastAPI Inventory Management System

## Table of Contents
1. [Project Overview](#project-overview)
2. [Azure DevOps Organization Setup](#azure-devops-organization-setup)
3. [Project Structure](#project-structure)
4. [Repository Configuration](#repository-configuration)
5. [Branching Strategy](#branching-strategy)
6. [Work Items and Project Management](#work-items-and-project-management)
7. [Build Pipeline (CI)](#build-pipeline-ci)
8. [Release Pipeline (CD)](#release-pipeline-cd)
9. [Testing Strategy](#testing-strategy)
10. [Environment Management](#environment-management)
11. [Security and Compliance](#security-and-compliance)
12. [Monitoring and Logging](#monitoring-and-logging)
13. [Artifact Management](#artifact-management)
14. [Integration Points](#integration-points)
15. [Documentation](#documentation)
16. [Disaster Recovery](#disaster-recovery)
17. [Performance Optimization](#performance-optimization)
18. [Troubleshooting Guide](#troubleshooting-guide)
19. [Best Practices](#best-practices)
20. [Metrics and KPIs](#metrics-and-kpis)
21. [Continuous Improvement](#continuous-improvement)
22. [Appendix](#appendix)
23. [Checklists and Templates](#checklists-and-templates)
24. [Sample Scripts and Utilities](#sample-scripts-and-utilities)
25. [Complete Project Flow - End-to-End Lifecycle](#complete-project-flow---end-to-end-lifecycle)
26. [Kubernetes Configuration](#kubernetes-configuration)
27. [Terraform Infrastructure as Code](#terraform-infrastructure-as-code)
28. [Kubernetes and Terraform Integration](#kubernetes-and-terraform-integration)

---

## 1. Project Overview

The Project Overview section establishes the foundational understanding of the inventory management system, its architectural approach, and strategic objectives. This section serves as the entry point for stakeholders, developers, and operations teams to comprehend the system's purpose, technological foundations, and expected outcomes. Understanding the project's scope and goals is crucial for making informed decisions throughout the development lifecycle and ensuring alignment between technical implementation and business objectives.

### 1.1 Application Description

Application description provides a comprehensive view of the system's architecture, technology choices, and operational characteristics. This description helps team members understand not just what the system does, but how it's built and why specific technologies were chosen. The technology stack selection reflects modern cloud-native principles, emphasizing scalability, maintainability, and operational efficiency. Each component in the stack serves a specific purpose: FastAPI provides high-performance API capabilities, PostgreSQL ensures data integrity and relational query capabilities, Redis enables fast caching, Kubernetes orchestrates containerized workloads, and Docker ensures consistent deployment across environments.
- **Application Type**: FastAPI-based RESTful API for Inventory Management
- **Technology Stack**: 
  - Backend: Python 3.11+, FastAPI
  - Database: PostgreSQL/SQL Server
  - Cache: Redis
  - Message Queue: Azure Service Bus / RabbitMQ
  - Container: Docker
  - Orchestration: Kubernetes / Azure Container Apps

### 1.2 Project Goals

Project goals define the measurable outcomes and success criteria for the inventory management system implementation. These goals are derived from DevOps best practices and organizational requirements, focusing on automation, quality, security, and reliability. The emphasis on automated CI/CD pipelines reflects the need for rapid, reliable software delivery, while multi-environment deployments ensure proper testing and validation before production releases. Comprehensive testing automation reduces manual effort and increases confidence in releases, while security scanning and compliance measures protect against vulnerabilities and ensure regulatory adherence. Performance monitoring enables proactive issue detection and capacity planning, while disaster recovery capabilities ensure business continuity even during catastrophic failures.
- Automated CI/CD pipeline
- Multi-environment deployments (Dev, QA, Staging, Production)
- Comprehensive testing automation
- Security scanning and compliance
- Performance monitoring
- Disaster recovery capabilities

---

## 2. Azure DevOps Organization Setup

Azure DevOps Organization Setup is the foundational step in establishing a structured, scalable development and operations environment. This setup process involves creating an organizational hierarchy that supports multiple projects, teams, and workflows while maintaining proper access controls and resource management. The organization structure serves as the top-level container for all development activities, providing isolation between different business units or projects while enabling collaboration and resource sharing where appropriate. Proper organization setup ensures that teams can work independently without conflicts while maintaining visibility and governance at the organizational level.

### 2.1 Organization Structure

The organization structure in Azure DevOps represents a hierarchical model that organizes projects, repositories, pipelines, and work items into a logical, manageable hierarchy. This structure enables organizations to scale their DevOps practices across multiple teams and projects while maintaining clear boundaries and access controls. The hierarchical nature allows for centralized policy management, shared resources like build agents and artifact feeds, and consistent practices across projects. Understanding this structure is essential for planning resource allocation, managing permissions, and ensuring that each project has the appropriate level of isolation and access to shared resources.
```
Organization: [YourOrgName]
├── Project: InventoryManagementSystem
│   ├── Repositories
│   ├── Pipelines
│   ├── Work Items
│   ├── Test Plans
│   ├── Artifacts
│   └── Environments
```

### 2.2 Initial Setup Steps

Initial setup steps establish the project foundation within Azure DevOps, configuring essential services and connections that enable the entire development workflow. These steps involve creating the project container, selecting appropriate process templates that align with team methodologies, and enabling core services like version control and work item tracking. The setup process also involves configuring service connections that allow Azure DevOps to interact with external services like Azure resources, container registries, and third-party tools. Each configuration decision made during initial setup impacts the team's ability to collaborate effectively, deploy efficiently, and maintain code quality throughout the project lifecycle.

#### 2.2.1 Create Project

Project creation in Azure DevOps establishes a dedicated workspace for the inventory management system, complete with its own repositories, pipelines, work items, and artifacts. The project serves as a boundary for access control, allowing teams to work independently while maintaining organizational visibility. Selecting the appropriate process template (Agile/Scrum) determines the work item types, workflow states, and reporting capabilities available to the team. Enabling version control and work items at project creation ensures that all team members have immediate access to essential collaboration tools, while choosing private visibility protects intellectual property and ensures that only authorized personnel can access the project resources.
1. Navigate to Azure DevOps Portal
2. Create new project: `InventoryManagementSystem`
3. Select visibility: Private
4. Choose process template: Agile/Scrum
5. Enable version control: Git
6. Enable work items: Yes

#### 2.2.2 Configure Project Settings

Project settings configuration establishes the operational parameters and integrations that enable seamless workflows between Azure DevOps and external services. General settings define the project's identity, visibility, and basic metadata that help team members and stakeholders understand the project's purpose and scope. Service connections are critical integrations that enable automated deployments, artifact management, and resource provisioning without requiring manual intervention or storing credentials in code. These connections use secure authentication mechanisms like service principals, managed identities, or OAuth tokens to establish trust between Azure DevOps and external services, ensuring that automated processes can execute securely while maintaining audit trails and access controls.
- **General Settings**
  - Project name: Inventory Management System
  - Description: FastAPI-based inventory management REST API
  - Visibility: Private
  
- **Service Connections**
  - Azure Resource Manager (for deployments)
  - Docker Registry (Azure Container Registry)
  - GitHub (if using external repos)
  - NuGet Feed (for .NET dependencies if any)
  - npm Feed (for frontend dependencies if any)

#### 2.2.3 Service Principal Setup

Service principal setup creates a non-interactive identity that Azure DevOps uses to authenticate and authorize actions against Azure resources. Service principals follow the principle of least privilege, granting only the minimum permissions necessary for specific operations like deploying applications, managing resources, or accessing container registries. This approach enhances security by eliminating the need for user credentials in automated processes and enabling fine-grained access control through Azure Role-Based Access Control (RBAC). The service principal acts as a bridge between Azure DevOps pipelines and Azure resources, allowing CI/CD processes to provision infrastructure, deploy applications, and manage resources programmatically while maintaining security and compliance requirements.
```bash
# Azure CLI commands for service principal
az ad sp create-for-rbac --name "InventoryManagementSystem-SP" \
  --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \
  --sdk-auth
```

---

## 3. Project Structure

Project structure defines the organization of code, configuration files, documentation, and infrastructure definitions within the repository. A well-designed project structure promotes maintainability, scalability, and team collaboration by establishing clear conventions for where different types of files belong and how they relate to each other. This structure follows separation of concerns principles, isolating application code from infrastructure code, separating configuration from implementation, and organizing tests alongside the code they validate. The structure also supports multiple deployment targets and environments by organizing environment-specific configurations in dedicated directories, enabling teams to manage dev, QA, staging, and production configurations independently while maintaining consistency in structure and conventions.

### 3.1 Repository Structure

The repository structure represents a comprehensive organization scheme that accommodates all aspects of the software development lifecycle, from source code to infrastructure definitions, from documentation to deployment scripts. This structure follows industry best practices for Python projects, microservices architecture, and infrastructure as code, ensuring that new team members can quickly understand the codebase organization and locate relevant files. The separation of application code (`src/app/`), infrastructure definitions (`infrastructure/`), and operational scripts (`scripts/`) creates clear boundaries that enable different team members to work on different aspects of the system without conflicts. The inclusion of environment-specific directories allows for variations in configuration, resource sizing, and deployment strategies across different environments while maintaining a consistent overall structure.
```
inventory-management-system/
├── .azuredevops/
│   ├── pipelines/
│   │   ├── ci-pipeline.yml
│   │   ├── cd-pipeline.yml
│   │   ├── security-scan.yml
│   │   └── performance-test.yml
│   └── templates/
│       ├── build-template.yml
│       ├── test-template.yml
│       └── deploy-template.yml
├── src/
│   ├── app/
│   │   ├── __init__.py
│   │   ├── main.py
│   │   ├── api/
│   │   │   ├── v1/
│   │   │   │   ├── endpoints/
│   │   │   │   │   ├── inventory.py
│   │   │   │   │   ├── products.py
│   │   │   │   │   └── orders.py
│   │   │   │   └── router.py
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   ├── security.py
│   │   │   └── database.py
│   │   ├── models/
│   │   │   ├── inventory.py
│   │   │   ├── product.py
│   │   │   └── order.py
│   │   ├── schemas/
│   │   │   ├── inventory.py
│   │   │   ├── product.py
│   │   │   └── order.py
│   │   └── services/
│   │       ├── inventory_service.py
│   │       ├── product_service.py
│   │       └── order_service.py
│   └── tests/
│       ├── unit/
│       ├── integration/
│       └── e2e/
├── infrastructure/
│   ├── docker/
│   │   ├── Dockerfile
│   │   ├── Dockerfile.prod
│   │   └── docker-compose.yml
│   ├── kubernetes/
│   │   ├── namespace.yaml
│   │   ├── configmap.yaml
│   │   ├── secret.yaml
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   ├── ingress.yaml
│   │   ├── hpa.yaml
│   │   ├── pdb.yaml
│   │   ├── serviceaccount.yaml
│   │   ├── networkpolicy.yaml
│   │   └── environments/
│   │       ├── dev/
│   │       │   └── deployment.yaml
│   │       └── prod/
│   │           └── deployment.yaml
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── modules/
│       │   └── aks/
│       │       ├── main.tf
│       │       ├── variables.tf
│       │       └── outputs.tf
│       └── environments/
│           ├── dev/
│           │   └── terraform.tfvars
│           ├── qa/
│           │   └── terraform.tfvars
│           ├── staging/
│           │   └── terraform.tfvars
│           └── production/
│               └── terraform.tfvars
├── docs/
│   ├── api/
│   ├── architecture/
│   └── deployment/
├── scripts/
│   ├── setup.sh
│   ├── migrate.sh
│   ├── health-check.py
│   ├── deploy-k8s.sh
│   ├── terraform-deploy.sh
│   ├── deploy-full-stack.sh
│   └── sync-secrets-from-keyvault.sh
├── .github/
│   └── workflows/ (if using GitHub Actions alongside)
├── requirements.txt
├── requirements-dev.txt
├── pytest.ini
├── .pylintrc
├── .flake8
├── .env.example
├── .gitignore
├── README.md
└── azure-pipelines.yml
```

### 3.2 Key Configuration Files

Key configuration files establish the foundational settings and dependencies that govern how the application builds, runs, and integrates with external services. These files serve multiple purposes: they define dependencies and their versions, configure development tools and linters, specify build and deployment parameters, and establish coding standards. Configuration files act as contracts between different parts of the system, ensuring that developers, build systems, deployment tools, and runtime environments all operate with consistent expectations. Version pinning in dependency files ensures reproducible builds and deployments, while configuration files for tools like linters and formatters ensure consistent code quality and style across the team.

#### 3.2.1 `.gitignore`

The `.gitignore` file serves as a filter that prevents sensitive, temporary, or generated files from being committed to version control. This file protects against accidentally committing secrets, credentials, or environment-specific configurations that could expose security vulnerabilities or cause conflicts between different development environments. By excluding build artifacts, dependency caches, IDE configuration files, and local environment files, `.gitignore` keeps the repository clean and focused on source code and essential configuration. This practice reduces repository size, improves clone and pull performance, and prevents merge conflicts that could arise from environment-specific or machine-specific files. Additionally, excluding sensitive files like `.env` files helps maintain security by ensuring that credentials and secrets are managed through secure secret management systems rather than version control.
```gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
.venv
*.egg-info/
dist/
build/

# Environment
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# Testing
.pytest_cache/
.coverage
htmlcov/

# Azure
.azure/
*.publishsettings
```

#### 3.2.2 `requirements.txt`

The `requirements.txt` file serves as a manifest that declares all Python package dependencies and their specific versions required for the application to function correctly. This file enables reproducible builds by ensuring that all environments (development, testing, staging, production) use identical dependency versions, eliminating "works on my machine" issues. Version pinning provides stability and predictability, preventing unexpected behavior from dependency updates while allowing controlled updates through deliberate version changes. The file also documents the application's external dependencies, making it easier for new developers to understand what external libraries the project relies on and for security teams to audit dependencies for known vulnerabilities. Separating production dependencies (`requirements.txt`) from development dependencies (`requirements-dev.txt`) optimizes production container images by excluding development tools, testing frameworks, and debugging utilities that aren't needed in runtime environments.
```txt
fastapi==0.104.1
uvicorn[standard]==0.24.0
sqlalchemy==2.0.23
alembic==1.12.1
pydantic==2.5.0
pydantic-settings==2.1.0
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-multipart==0.0.6
redis==5.0.1
celery==5.3.4
psycopg2-binary==2.9.9
azure-storage-blob==12.19.0
azure-keyvault-secrets==4.7.0
prometheus-client==0.19.0
```

---

## 4. Repository Configuration

Repository configuration establishes the rules, policies, and conventions that govern how code flows through the development process, from initial commit to production deployment. These configurations enforce quality gates, ensure proper code review practices, and maintain code integrity through automated checks and manual approvals. Repository settings act as guardrails that prevent common mistakes like merging untested code, deploying without proper review, or accidentally deleting protected branches. By establishing clear policies and conventions upfront, teams can scale their development practices while maintaining code quality and security standards, even as the team grows or changes over time.

### 4.1 Repository Settings

Repository settings define the operational parameters and policies that control access, workflows, and quality standards for the codebase. These settings balance developer productivity with quality assurance, security, and compliance requirements. The configuration includes branch protection policies that prevent accidental or malicious changes to critical branches, file size limits that prevent repository bloat, and naming conventions that improve code organization and searchability. These settings are particularly important in collaborative environments where multiple developers work on the same codebase, as they ensure consistent practices and prevent conflicts or quality degradation.

#### 4.1.1 Branch Policies

Branch policies implement quality gates and workflow controls that ensure code meets established standards before it can be merged into protected branches. These policies enforce best practices like mandatory code reviews, which catch bugs and improve code quality through peer feedback, and build validation, which ensures that code compiles and tests pass before merging. Requiring linked work items creates traceability between code changes and business requirements, enabling impact analysis and change tracking. Status checks ensure that all automated quality gates (tests, security scans, code analysis) pass before allowing merges, while blocking force pushes and deletions prevents accidental or malicious destruction of code history. These policies collectively create a safety net that maintains code quality and repository integrity while allowing developers to work efficiently.
- **Main Branch Protection**
  - Require pull request reviews (minimum 2 approvers)
  - Require linked work items
  - Require comment resolution
  - Build validation (CI pipeline must pass)
  - Status checks (all tests must pass)
  - Require up-to-date branches
  - Block force push
  - Block deletion

#### 4.1.2 Branch Naming Convention

Branch naming conventions establish a standardized approach to organizing code changes, making it easier to understand the purpose and scope of each branch at a glance. These conventions enable automated workflows, improve code organization, and facilitate communication between team members about what work is happening in which branches. The convention categorizes branches by their purpose (feature, bugfix, hotfix, release), allowing teams to apply different policies, workflows, and quality gates based on branch type. Consistent naming also enables automation tools to route branches to appropriate pipelines, apply relevant labels, and trigger environment-specific deployments. This standardization becomes increasingly valuable as teams scale, as it reduces cognitive load and enables new team members to quickly understand the codebase organization.
- `main` - Production-ready code
- `develop` - Integration branch
- `feature/*` - New features (e.g., `feature/add-product-search`)
- `bugfix/*` - Bug fixes (e.g., `bugfix/inventory-calculation`)
- `hotfix/*` - Critical production fixes
- `release/*` - Release preparation branches

#### 4.1.3 File Size Limits

File size limits protect repository performance and prevent abuse by restricting the size of individual files that can be committed. Large files slow down clone operations, increase storage costs, and can cause performance issues in Git operations like diff, merge, and blame. These limits encourage developers to use appropriate storage solutions for large assets, such as object storage for binary files, artifact repositories for build outputs, or Git LFS (Large File Storage) for files that need version control but are too large for standard Git. By establishing these limits upfront, teams prevent performance degradation and ensure that the repository remains efficient and accessible, even as it grows over time.
- Maximum file size: 100 MB
- Large file storage: Git LFS for binary files

### 4.2 Git Configuration

Git configuration establishes the local and repository-specific settings that control how Git behaves for individual developers and the project as a whole. These configurations ensure consistent behavior across different operating systems and development environments, preventing issues related to line ending differences between Windows, Linux, and macOS systems. Proper Git configuration also enables useful features like credential caching, which improves developer productivity by reducing the frequency of authentication prompts, and default branch naming, which ensures consistency across the team. Repository-specific configurations override global settings when needed, allowing projects to enforce specific requirements while respecting individual developer preferences for their global Git configuration.
```bash
# Global Git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@company.com"

# Repository-specific settings
git config core.autocrlf true  # Windows
git config core.autocrlf input  # Linux/Mac
```

---

## 5. Branching Strategy

Branching strategy defines the systematic approach to organizing code changes, managing parallel development efforts, and controlling the flow of code from development through testing to production. A well-designed branching strategy balances developer productivity with code stability, enabling multiple developers to work simultaneously without conflicts while maintaining clear separation between stable production code and experimental or in-progress features. The strategy also supports different release cadences, allowing teams to maintain multiple versions in production, hotfix critical issues without disrupting ongoing development, and prepare releases independently of feature development. Understanding and consistently applying the branching strategy is crucial for preventing merge conflicts, maintaining code quality, and enabling reliable release processes.

### 5.1 Git Flow Model

The Git Flow model represents a branching strategy that provides clear separation between different types of work and different stages of the development lifecycle. This model uses long-lived branches (`main` for production, `develop` for integration) combined with short-lived branches (feature, bugfix, hotfix, release) to organize work and control code flow. The model's strength lies in its ability to support parallel development streams: developers can work on features independently, QA can test release candidates without blocking new feature development, and production hotfixes can be deployed immediately without waiting for the next release cycle. The clear branch purposes and merge patterns make it easier for teams to understand what code is where and how changes flow through the system, reducing confusion and enabling more reliable release processes.

```
main (production)
  │
  ├── develop (integration)
  │     │
  │     ├── feature/user-authentication
  │     ├── feature/inventory-tracking
  │     └── bugfix/order-calculation-error
  │
  └── hotfix/critical-security-patch
```

### 5.2 Branch Workflow

Branch workflow defines the step-by-step process for creating, developing, and merging branches according to the Git Flow model. This workflow ensures consistency across the team, reduces merge conflicts, and maintains code quality through standardized practices. Each workflow type (feature, release, hotfix) has specific steps that guide developers through the process, from branch creation to merge completion. Following these workflows ensures that code changes are properly reviewed, tested, and integrated without disrupting ongoing work or compromising code stability. The workflows also integrate with CI/CD pipelines, triggering appropriate builds and tests based on branch type and destination.

#### 5.2.1 Feature Development

Feature development workflow enables developers to work on new functionality independently without affecting the main codebase or other developers' work. This workflow starts by creating a feature branch from the integration branch (`develop`), ensuring that the feature includes all the latest changes from other developers. As development progresses, developers commit their changes frequently, creating a clear history of the feature's evolution. When the feature is complete, a pull request enables code review and discussion before merging, ensuring code quality and knowledge sharing. This workflow supports parallel development of multiple features while maintaining code stability in the main branches, and the short-lived nature of feature branches keeps the repository clean and manageable.
1. Create feature branch from `develop`
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/inventory-api
   ```

2. Develop and commit changes
   ```bash
   git add .
   git commit -m "feat: add inventory CRUD endpoints"
   ```

3. Push and create Pull Request
   ```bash
   git push origin feature/inventory-api
   ```

4. After PR approval, merge to `develop`

#### 5.2.2 Release Process

The release process workflow manages the transition from development to production, ensuring that code is properly prepared, tested, and documented before deployment. This workflow creates a release branch from the integration branch, allowing final testing, bug fixes, and documentation updates without blocking new feature development. The release branch serves as a stabilization period where only bug fixes and release-related changes are allowed, preventing new features from destabilizing the release candidate. Once the release is ready, merging to `main` creates a production release point that can be tagged for version tracking, while merging back to `develop` ensures that release fixes are included in future development. This workflow enables teams to maintain multiple release versions while continuing forward development, supporting both rapid feature delivery and stable production releases.
1. Create release branch from `develop`
   ```bash
   git checkout develop
   git checkout -b release/v1.2.0
   ```

2. Update version numbers, changelog
3. Merge to `main` and tag
   ```bash
   git checkout main
   git merge release/v1.2.0
   git tag -a v1.2.0 -m "Release version 1.2.0"
   git push origin main --tags
   ```

4. Merge back to `develop`

#### 5.2.3 Hotfix Process

The hotfix process workflow enables rapid response to critical production issues that cannot wait for the next regular release cycle. This workflow creates a hotfix branch directly from the production branch (`main`), allowing immediate fixes without including potentially unstable development code. The hotfix is developed, tested, and merged to production quickly, minimizing the impact of the critical issue. After production deployment, the hotfix must also be merged back to the integration branch (`develop`) to ensure that the fix is included in future releases and that the production and development branches don't diverge. This workflow balances the need for rapid production fixes with the need to maintain code consistency across branches, ensuring that hotfixes don't create technical debt or merge conflicts in future releases.
1. Create hotfix branch from `main`
   ```bash
   git checkout main
   git checkout -b hotfix/critical-bug
   ```

2. Fix and test
3. Merge to `main` and `develop`
4. Tag release

### 5.3 Commit Message Convention

Commit message conventions establish a standardized format for describing code changes, making it easier to understand the history and purpose of changes when reviewing code, debugging issues, or generating release notes. The Conventional Commits specification provides a structured format that includes a type (feat, fix, docs, etc.), optional scope, and descriptive message. This convention enables automated tools to parse commit messages and generate changelogs, determine version bumps, and route changes to appropriate reviewers or processes. Consistent commit messages also improve code review efficiency by providing context about the change's purpose and scope, and they make it easier to search through Git history when investigating when and why specific changes were made. The convention becomes particularly valuable in large codebases with many contributors, where clear communication through commit messages reduces the need for additional documentation or explanations.
Following Conventional Commits:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting)
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks
- `perf:` - Performance improvements
- `ci:` - CI/CD changes

Example:
```
feat(inventory): add low stock alert functionality

- Implemented threshold-based alerts
- Added email notification service
- Created unit tests for alert logic

Closes #123
```

---

## 6. Work Items and Project Management

Work items and project management in Azure DevOps provide a structured approach to planning, tracking, and managing software development work throughout its lifecycle. This system enables teams to break down large initiatives into manageable pieces, track progress, assign work, and maintain visibility into what's being worked on, what's completed, and what's blocked. The work item system integrates with code repositories, build pipelines, and release processes, creating traceability between business requirements, code changes, and deployments. This integration enables stakeholders to understand the impact of changes, developers to understand the business context of their work, and project managers to track progress and identify bottlenecks. Effective use of work items transforms ad-hoc development into a structured, measurable process that supports both agile methodologies and traditional project management approaches.

### 6.1 Work Item Types

Work item types represent different categories of work that teams need to track, each with its own purpose, fields, and workflow states. These types form a hierarchy that enables teams to organize work at different levels of granularity, from high-level epics that span multiple releases to specific tasks that individual developers complete in hours or days. The type system provides structure while remaining flexible enough to accommodate different team needs and methodologies. Understanding when to use each work item type is crucial for maintaining accurate project tracking and ensuring that work items provide value rather than becoming administrative overhead.

#### 6.1.1 Epics

Epics represent large bodies of work that typically span multiple sprints or releases and may involve multiple teams or significant architectural changes. Epics serve as containers for related features and user stories, providing high-level visibility into major initiatives and their progress. They help stakeholders understand the big picture and how individual features contribute to larger business objectives. Epics are particularly valuable for long-term planning and roadmap discussions, as they represent substantial investments of time and resources that require executive visibility and approval. Breaking work into epics also helps teams manage complexity by organizing related work together, making it easier to identify dependencies, coordinate efforts, and track progress toward major milestones.
- High-level features or initiatives
- Example: "Inventory Management System v2.0"

#### 6.1.2 Features

Features represent significant functionality that delivers value to users and typically requires multiple user stories to complete. Features bridge the gap between high-level epics and detailed user stories, providing a level of granularity that's useful for release planning and sprint planning. They help product owners prioritize work and communicate scope to stakeholders, while giving development teams a clear understanding of what they're building and why. Features often correspond to user-facing capabilities or major technical improvements that can be demonstrated and validated independently. This level of organization enables teams to track progress toward delivering complete capabilities rather than just completing individual tasks, providing better visibility into when features will be ready for release.
- Major functionality within an epic
- Example: "Real-time Inventory Tracking"

#### 6.1.3 User Stories

User stories represent specific functionality from the perspective of end users, following the format "As a [user], I want [goal] so that [benefit]." This format ensures that development work remains focused on delivering value to users rather than just implementing technical requirements. User stories are the primary unit of work in agile methodologies, sized to be completable within a single sprint and testable through acceptance criteria. The story format encourages collaboration between product owners, developers, and QA by requiring clear definition of who benefits, what they need, and why it matters. Well-written user stories provide enough detail for development while remaining flexible enough to allow technical teams to determine the best implementation approach, balancing business needs with technical constraints.
- Specific user requirements
- Format: "As a [user], I want [goal] so that [benefit]"
- Example: "As a warehouse manager, I want to see low stock alerts so that I can reorder products in time"

#### 6.1.4 Tasks
- Implementation details for user stories
- Example: "Create inventory alert API endpoint"

#### 6.1.5 Bugs

Bugs represent defects or issues found in the software that need to be fixed, ranging from critical production issues to minor UI inconsistencies. The bug work item type provides a structured way to track, prioritize, and resolve issues, ensuring that nothing falls through the cracks and that critical bugs receive appropriate attention. Bugs are typically linked to the user stories or features where they were discovered, creating traceability that helps teams understand the impact of issues and prioritize fixes based on affected functionality. The bug lifecycle—from discovery through triage, assignment, fix, verification, and closure—ensures that issues are properly tracked and resolved, while bug metrics help teams understand code quality trends and identify areas that need improvement.
- Defects found during testing or production

### 6.2 Work Item Fields

Work item fields capture the essential information needed to plan, track, and manage work effectively. These fields serve multiple purposes: they provide context about the work (title, description, acceptance criteria), enable planning and estimation (story points, priority, assigned to), track progress (state, tags), and create relationships between related work items. Well-populated fields transform work items from simple to-do lists into rich sources of information that support decision-making, progress tracking, and knowledge sharing. The field structure balances the need for comprehensive information with the need to avoid administrative overhead, ensuring that teams can capture essential details without spending excessive time on data entry.

**User Story Fields:**
- Title
- Description
- Acceptance Criteria
- Story Points (Fibonacci: 1, 2, 3, 5, 8, 13)
- Priority (1-Critical, 2-High, 3-Medium, 4-Low)
- Assigned To
- State (New, Active, Resolved, Closed)
- Tags
- Related Work Items
- Attachments

### 6.3 Sprint Planning

Sprint planning is a collaborative process where teams select work from the product backlog, break it down into tasks, estimate effort, and commit to completing it within a fixed time period (typically two weeks). This process balances the product owner's priorities with the development team's capacity and technical constraints, ensuring that sprints contain realistic, achievable work that delivers value. Effective sprint planning requires clear communication about priorities, honest estimation of effort, and realistic assessment of team capacity, accounting for meetings, support work, and other commitments. The planning process also identifies dependencies and risks early, allowing teams to adjust scope or approach before committing to work that might not be completable.

#### 6.3.1 Sprint Structure

Sprint structure defines the time-boxed periods and ceremonies that organize agile development work, providing rhythm and predictability to the development process. The typical two-week sprint duration balances the need for frequent delivery with the need for sufficient time to complete meaningful work, though teams may adjust this based on their context and release cadence. Sprint ceremonies—planning, daily standups, review, and retrospective—create regular opportunities for communication, feedback, and improvement. This structure enables teams to maintain focus on sprint goals while remaining responsive to changing priorities, and it provides stakeholders with regular visibility into progress and opportunities to provide feedback. The time-boxed nature of sprints also creates natural pressure to complete work, helping teams maintain momentum and avoid scope creep.
- **Duration**: 2 weeks
- **Sprint Planning**: First day (4 hours)
- **Daily Standups**: 15 minutes
- **Sprint Review**: Last day (2 hours)
- **Sprint Retrospective**: Last day (1 hour)

#### 6.3.2 Sprint Backlog Management

Sprint backlog management involves selecting, organizing, and tracking the work items that the team commits to completing during a sprint. This process starts with prioritizing user stories from the product backlog based on business value, dependencies, and team capacity, then breaking those stories into specific tasks that can be assigned and tracked. Effective backlog management ensures that sprint goals are clear, work is appropriately sized and estimated, and team members have a shared understanding of what needs to be accomplished. The backlog serves as the team's commitment and work plan for the sprint, providing visibility into progress and helping identify when work is at risk of not being completed. Regular backlog refinement throughout the sprint helps teams adapt to changing circumstances while maintaining focus on sprint goals.
1. Prioritize user stories from product backlog
2. Break down stories into tasks
3. Estimate story points
4. Assign to team members
5. Create sprint goal

### 6.4 Work Item Queries

Work item queries enable teams to filter, organize, and view work items based on specific criteria, providing customized views that support different needs and workflows. These queries can be saved and shared, creating standard views that teams use for daily standups, sprint planning, bug triage, or status reporting. Queries transform the work item database into a flexible reporting and tracking system, allowing teams to answer questions like "What bugs are blocking the current sprint?" or "Which features are ready for release?" without manually filtering through work items. Effective use of queries reduces the time spent finding relevant work items and ensures that teams have visibility into the information they need to make decisions and track progress.

#### 6.4.1 Active Sprint Items

Active sprint item queries provide real-time visibility into the work that's currently in progress, helping teams track sprint progress and identify blockers or risks. These queries typically filter work items by the current sprint iteration and exclude completed items, showing what's new, active, or resolved but not yet closed. This view is essential for daily standups, where team members discuss what they've completed and what they're working on, and it helps scrum masters identify when work is stuck or when the sprint is at risk. The query can be customized to show additional information like assigned team members, story points, or linked items, providing the level of detail needed for effective sprint management.
```
Work Item Type = User Story OR Task
AND State <> Closed
AND Iteration Path = [Current Sprint]
```

#### 6.4.2 Blocked Items

Blocked items queries help teams quickly identify work that cannot proceed due to dependencies, missing information, or external blockers. These queries typically filter work items by a "blocked" tag or state, enabling teams to focus attention on resolving blockers that are preventing progress. Identifying blocked items early is crucial for maintaining sprint velocity, as blocked work prevents teams from completing committed stories and can cascade to block other dependent work. Regular review of blocked items during standups and sprint planning helps teams proactively address blockers before they significantly impact sprint goals, and it provides visibility into systemic issues that might need process improvements or resource allocation.
```
State = Active
AND Tags Contains 'blocked'
```

#### 6.4.3 High Priority Bugs

High priority bug queries enable teams to quickly identify and address critical issues that require immediate attention, ensuring that production issues and severe defects don't get lost in the backlog. These queries filter bugs by priority level (typically Priority 1 or Critical) and exclude closed bugs, providing a focused view of urgent issues that need resolution. This query is essential for bug triage processes, where teams assess new bugs and determine their priority and assignment, and it helps product owners and managers understand the current state of critical issues. Regular monitoring of high-priority bugs also helps teams identify quality trends and areas of the system that might need additional testing or refactoring to reduce defect rates.
```
Work Item Type = Bug
AND Priority = 1
AND State <> Closed
```

---

## 7. Build Pipeline (CI)

Continuous Integration (CI) represents a development practice where developers frequently integrate code changes into a shared repository, with each integration triggering automated builds and tests. This practice enables teams to detect integration errors early, when they're easier to fix, and ensures that the codebase remains in a deployable state. CI pipelines automate the process of building applications, running tests, performing code quality checks, and creating deployment artifacts, reducing manual effort and human error while providing fast feedback to developers. The CI pipeline serves as a quality gate that prevents broken code from progressing to later stages, protecting downstream environments and reducing the cost of fixing defects. Effective CI practices require fast pipeline execution, comprehensive test coverage, and clear feedback mechanisms that help developers quickly understand and fix issues.

### 7.1 Pipeline Structure

Pipeline structure defines the organization of build stages, jobs, and tasks that transform source code into deployable artifacts. A well-structured pipeline follows a logical flow: code checkout, dependency installation, code quality checks, compilation or build, testing, security scanning, and artifact creation. This structure enables parallel execution where possible, reducing overall pipeline duration, while maintaining dependencies between stages that require sequential execution. The pipeline structure also supports conditional execution, allowing different paths for different branch types or enabling optional stages like performance testing only for production releases. Understanding pipeline structure helps teams optimize build times, identify bottlenecks, and ensure that all necessary quality gates are in place before code progresses to deployment.

#### 7.1.1 Pipeline Triggers

Pipeline triggers define the conditions that cause a CI pipeline to execute automatically, balancing the need for fast feedback with the need to avoid unnecessary builds. Trigger configuration specifies which branches and paths should trigger builds, enabling teams to run pipelines for feature branches, integration branches, and production branches while excluding documentation-only changes or other non-code modifications. Pull request triggers ensure that proposed changes are validated before merging, preventing broken code from entering the main codebase. Path-based filtering allows teams to optimize pipeline execution by only building when relevant code changes, reducing build agent usage and improving feedback speed. Effective trigger configuration ensures that developers receive timely feedback on their changes while avoiding resource waste on unnecessary builds.
```yaml
trigger:
  branches:
    include:
      - main
      - develop
      - feature/*
      - bugfix/*
      - hotfix/*
      - release/*
  paths:
    exclude:
      - docs/*
      - README.md

pr:
  branches:
    include:
      - main
      - develop
```

#### 7.1.2 Complete CI Pipeline (`azure-pipelines.yml`)
```yaml
name: $(Build.BuildId)

pool:
  vmImage: 'ubuntu-latest'

variables:
  pythonVersion: '3.11'
  dockerRegistryServiceConnection: 'ACR-Connection'
  imageRepository: 'inventory-management-api'
  containerRegistry: 'yourregistry.azurecr.io'
  dockerfilePath: '$(Build.SourcesDirectory)/infrastructure/docker/Dockerfile'
  tag: '$(Build.BuildId)'

stages:
- stage: Build
  displayName: 'Build and Test'
  jobs:
  - job: Build
    displayName: 'Build Application'
    steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '$(pythonVersion)'
      displayName: 'Use Python $(pythonVersion)'

    - task: Cache@2
      inputs:
        key: 'pip | "$(Agent.OS)" | requirements.txt'
        restoreKeys: |
          pip | "$(Agent.OS)"
        path: '$(PIP_CACHE_DIR)'
      displayName: 'Cache pip packages'

    - script: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install -r requirements-dev.txt
      displayName: 'Install dependencies'

    - script: |
        pylint --version
        pylint app/ --rcfile=.pylintrc || true
      displayName: 'Run Pylint'

    - script: |
        flake8 app/ --config=.flake8
      displayName: 'Run Flake8'

    - script: |
        black --check app/
      displayName: 'Check code formatting'

    - script: |
        pytest tests/unit/ -v --cov=app --cov-report=xml --cov-report=html
      displayName: 'Run unit tests'

    - task: PublishTestResults@2
      condition: succeededOrFailed()
      inputs:
        testResultsFiles: '**/test-*.xml'
        testRunTitle: 'Unit Test Results'

    - task: PublishCodeCoverageResults@1
      inputs:
        codeCoverageTool: 'Cobertura'
        summaryFileLocation: '$(System.DefaultWorkingDirectory)/**/coverage.xml'
        reportDirectory: '$(System.DefaultWorkingDirectory)/**/htmlcov'

    - script: |
        docker build -f $(dockerfilePath) -t $(containerRegistry)/$(imageRepository):$(tag) .
        docker build -f $(dockerfilePath) -t $(containerRegistry)/$(imageRepository):latest .
      displayName: 'Build Docker image'

    - task: Docker@2
      inputs:
        command: push
        repository: $(imageRepository)
        containerRegistry: $(dockerRegistryServiceConnection)
        tags: |
          $(tag)
          latest
      displayName: 'Push Docker image to ACR'

    - task: PublishBuildArtifacts@1
      inputs:
        pathToPublish: '$(Build.ArtifactStagingDirectory)'
        artifactName: 'drop'
        publishLocation: 'Container'

- stage: SecurityScan
  displayName: 'Security Scanning'
  dependsOn: Build
  jobs:
  - job: SecurityScan
    displayName: 'Security Analysis'
    steps:
    - task: Docker@2
      inputs:
        command: login
        containerRegistry: $(dockerRegistryServiceConnection)
      displayName: 'Login to ACR'

    - script: |
        docker pull $(containerRegistry)/$(imageRepository):$(tag)
        trivy image --exit-code 0 --severity HIGH,CRITICAL --format json -o trivy-results.json $(containerRegistry)/$(imageRepository):$(tag)
      displayName: 'Run Trivy security scan'

    - task: PublishSecurityAnalysisLogs@3
      inputs:
        scanType: 'containerScanning'
        scanResults: 'trivy-results.json'

    - task: WhiteSource@21
      inputs:
        cwd: '$(Build.SourcesDirectory)'
        scanType: 'pip'
      displayName: 'WhiteSource security scan'

    - script: |
        bandit -r app/ -f json -o bandit-results.json || true
      displayName: 'Run Bandit security scan'

    - task: PublishSecurityAnalysisLogs@3
      inputs:
        scanType: 'dependencyScanning'
        scanResults: 'bandit-results.json'

- stage: IntegrationTests
  displayName: 'Integration Tests'
  dependsOn: Build
  jobs:
  - job: IntegrationTests
    displayName: 'Run Integration Tests'
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: $(POSTGRES_PASSWORD)
          POSTGRES_DB: testdb
        ports:
          - 5432:5432
      redis:
        image: redis:7-alpine
        ports:
          - 6379:6379

    steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '$(pythonVersion)'

    - script: |
        pip install -r requirements.txt
        pip install -r requirements-dev.txt
      displayName: 'Install dependencies'

    - script: |
        pytest tests/integration/ -v --env=test
      displayName: 'Run integration tests'
      env:
        DATABASE_URL: postgresql://postgres:$(POSTGRES_PASSWORD)@localhost:5432/testdb
        REDIS_URL: redis://localhost:6379/0

    - task: PublishTestResults@2
      inputs:
        testResultsFiles: '**/test-*.xml'
        testRunTitle: 'Integration Test Results'

- stage: PerformanceTests
  displayName: 'Performance Tests'
  dependsOn: Build
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - job: PerformanceTests
    displayName: 'Load Testing'
    steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '$(pythonVersion)'

    - script: |
        pip install locust
        locust -f tests/performance/locustfile.py --headless -u 100 -r 10 -t 60s --html performance-report.html
      displayName: 'Run Locust performance tests'

    - task: PublishTestResults@2
      inputs:
        testResultsFiles: 'performance-report.html'
        testRunTitle: 'Performance Test Results'
```

### 7.2 Pipeline Templates

Pipeline templates provide reusable, parameterized pipeline definitions that enable consistency across multiple pipelines while reducing duplication and maintenance overhead. Templates encapsulate common build, test, and deployment patterns, allowing teams to define best practices once and apply them consistently across projects or environments. This approach reduces the risk of configuration drift, where similar pipelines diverge over time, and simplifies updates by allowing changes to be made in one place and propagated to all consuming pipelines. Templates also support parameterization, enabling customization for different environments, applications, or requirements while maintaining consistency in structure and quality gates. Effective use of templates transforms pipeline management from repetitive configuration to strategic pattern definition, enabling teams to scale their CI/CD practices efficiently.

#### 7.2.1 Build Template (`templates/build-template.yml`)

Build templates encapsulate the standard build process, including dependency installation, compilation, and basic quality checks, into a reusable component. These templates abstract away implementation details while exposing parameters for customization, allowing different projects to use the same build pattern with different Python versions, build configurations, or dependency sets. Template usage promotes consistency by ensuring that all builds follow the same quality gates and processes, while parameterization enables flexibility to accommodate different project needs. This approach reduces the learning curve for new projects, as teams can leverage proven templates rather than building pipelines from scratch, and it simplifies maintenance by centralizing build logic that can be updated once and propagated to all consuming pipelines.
```yaml
parameters:
  - name: pythonVersion
    type: string
    default: '3.11'
  - name: buildConfiguration
    type: string
    default: 'Release'

steps:
- task: UsePythonVersion@0
  inputs:
    versionSpec: '${{ parameters.pythonVersion }}'

- script: |
    python -m pip install --upgrade pip
    pip install -r requirements.txt
  displayName: 'Install dependencies'

- script: |
    python -m pytest tests/unit/ -v
  displayName: 'Run unit tests'
```

### 7.3 Build Artifacts

Build artifacts represent the outputs of the CI pipeline that are consumed by downstream processes, particularly CD pipelines that deploy applications to various environments. Artifacts serve as immutable snapshots of the build process, containing everything needed to deploy the application without requiring access to source code or build environments. The artifact management system provides versioning, retention policies, and promotion capabilities that enable teams to track what was built, when it was built, and where it has been deployed. Effective artifact management ensures that deployments are reproducible, as the exact same artifact can be deployed to multiple environments, and it enables rollback capabilities by maintaining historical artifacts that can be redeployed if issues are discovered. Artifact storage and retrieval must be fast and reliable, as CD pipelines depend on quick access to artifacts for efficient deployment processes.

#### 7.3.1 Artifact Types

Different artifact types serve different purposes in the deployment pipeline: Docker images contain the complete application runtime environment, Python packages enable library distribution and reuse, test results provide quality metrics and debugging information, and coverage reports help teams understand test effectiveness. Each artifact type has specific requirements for storage, versioning, and retention: Docker images require container registry storage with tagging strategies, test results need to be accessible for analysis and reporting, and coverage reports should be retained for trend analysis. Understanding artifact types helps teams design appropriate retention policies that balance storage costs with the need for historical data, and it enables proper artifact promotion strategies that ensure only validated artifacts progress to production environments.
- Docker images (stored in Azure Container Registry)
- Python wheels/packages
- Test results
- Coverage reports
- Documentation

#### 7.3.2 Artifact Retention

Artifact retention policies balance the need for historical artifacts with storage costs and management complexity. These policies define how long different types of artifacts are kept, with production artifacts typically retained longer than development artifacts, and critical artifacts like Docker images retained longer than intermediate build outputs. Retention policies also consider regulatory requirements, as some industries require extended retention of build artifacts for compliance or audit purposes. Effective retention policies enable rollback capabilities while preventing unbounded storage growth, and they support debugging and analysis needs by maintaining artifacts long enough for post-incident investigation. Automated retention policies reduce manual cleanup efforts and ensure consistent artifact lifecycle management across all builds and environments.
- Build artifacts: 30 days
- Test results: 90 days
- Coverage reports: 90 days

---

## 8. Release Pipeline (CD)

Continuous Deployment (CD) extends CI practices by automatically deploying validated code changes to various environments, reducing the time between code completion and user value delivery. CD pipelines automate the deployment process, including environment provisioning, application deployment, database migrations, health checks, and rollback procedures, enabling teams to deploy frequently and reliably. These pipelines implement deployment strategies like blue-green deployments, canary releases, and rolling updates that minimize downtime and risk while enabling rapid rollback if issues are detected. CD pipelines also integrate with monitoring and alerting systems, providing visibility into deployment success and application health, and they support approval gates that ensure appropriate oversight for production deployments. Effective CD practices transform deployment from a risky, manual process into a routine, automated operation that teams can execute with confidence.

### 8.1 Release Pipeline Structure

Release pipeline structure organizes deployment stages that progress code through environments from development to production, with each stage representing increasing levels of stability, validation, and business impact. The pipeline structure implements quality gates between stages, requiring successful deployment and validation in one environment before allowing progression to the next. This staged approach enables teams to catch issues early in lower-risk environments, reducing the probability of production incidents, while approval gates provide human oversight for critical deployments. The pipeline structure also supports parallel deployments to non-production environments and sequential deployments to production, balancing speed with risk management. Understanding pipeline structure helps teams optimize deployment processes, identify bottlenecks, and ensure that all necessary validations occur before production deployment.

#### 8.1.1 Environments

Environments represent isolated deployment targets that serve different purposes in the software development lifecycle, from development environments where developers test their changes to production environments where end users interact with the application. Each environment has specific characteristics: development environments prioritize speed and flexibility, QA environments focus on comprehensive testing, staging environments mirror production for final validation, and production environments emphasize stability and reliability. Environment isolation prevents changes in one environment from affecting others, enabling parallel work streams and reducing risk. Environment-specific configurations accommodate different resource sizes, feature flags, and integrations, allowing teams to test production-like scenarios without impacting production systems. Effective environment management ensures that each environment serves its intended purpose while maintaining consistency in deployment processes and application behavior.
1. **Development** - Auto-deploy from `develop` branch
2. **QA** - Manual approval required
3. **Staging** - Pre-production environment
4. **Production** - Manual approval + change management

#### 8.1.2 Complete Release Pipeline (`cd-pipeline.yml`)
```yaml
name: CD-Pipeline

trigger:
  branches:
    include:
      - main
      - develop
  paths:
    exclude:
      - docs/*

pr: none

resources:
  pipelines:
    - pipeline: CI
      source: CI-Pipeline
      trigger:
        branches:
          include:
            - main
            - develop

stages:
- stage: DeployDev
  displayName: 'Deploy to Development'
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/develop'))
  jobs:
  - deployment: DeployDev
    displayName: 'Deploy to Dev Environment'
    environment: 'Development'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureWebApp@1
            inputs:
              azureSubscription: 'Azure-Service-Connection'
              appName: 'inventory-api-dev'
              package: '$(Pipeline.Workspace)/drop'
              deploymentMethod: 'auto'

          - script: |
              az aks get-credentials --resource-group rg-dev --name aks-dev-cluster
              kubectl set image deployment/inventory-api inventory-api=$(containerRegistry)/$(imageRepository):$(tag) -n dev
            displayName: 'Deploy to AKS Dev'

          - script: |
              python scripts/health-check.py --env dev
            displayName: 'Health Check'

          - script: |
              python scripts/migrate.py --env dev
            displayName: 'Run Database Migrations'

- stage: DeployQA
  displayName: 'Deploy to QA'
  dependsOn: []
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/develop'))
  jobs:
  - deployment: DeployQA
    displayName: 'Deploy to QA Environment'
    environment: 'QA'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: ManualValidation@0
            inputs:
              notifyUsers: 'qa-team@company.com'
              instructions: 'Please review and approve deployment to QA'
              onTimeout: 'reject'

          - task: AzureWebApp@1
            inputs:
              azureSubscription: 'Azure-Service-Connection'
              appName: 'inventory-api-qa'
              package: '$(Pipeline.Workspace)/drop'

          - script: |
              az aks get-credentials --resource-group rg-qa --name aks-qa-cluster
              kubectl set image deployment/inventory-api inventory-api=$(containerRegistry)/$(imageRepository):$(tag) -n qa
            displayName: 'Deploy to AKS QA'

          - script: |
              pytest tests/e2e/ -v --env=qa
            displayName: 'Run E2E Tests'

- stage: DeployStaging
  displayName: 'Deploy to Staging'
  dependsOn: []
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - deployment: DeployStaging
    displayName: 'Deploy to Staging Environment'
    environment: 'Staging'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: ManualValidation@0
            inputs:
              notifyUsers: 'devops-team@company.com'
              instructions: 'Approve deployment to Staging'
              onTimeout: 'reject'

          - script: |
              az aks get-credentials --resource-group rg-staging --name aks-staging-cluster
              kubectl set image deployment/inventory-api inventory-api=$(containerRegistry)/$(imageRepository):$(tag) -n staging
            displayName: 'Deploy to AKS Staging'

          - script: |
              python scripts/smoke-tests.py --env staging
            displayName: 'Smoke Tests'

          - script: |
              python scripts/performance-baseline.py --env staging
            displayName: 'Performance Baseline Check'

- stage: DeployProduction
  displayName: 'Deploy to Production'
  dependsOn: []
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - deployment: DeployProduction
    displayName: 'Deploy to Production'
    environment: 'Production'
    strategy:
      canary:
        increments: [10, 25, 50, 100]
        deploy:
          steps:
          - task: ManualValidation@0
            inputs:
              notifyUsers: 'devops-lead@company.com,cto@company.com'
              instructions: 'Approve production deployment'
              onTimeout: 'reject'

          - script: |
              az aks get-credentials --resource-group rg-prod --name aks-prod-cluster
              kubectl set image deployment/inventory-api inventory-api=$(containerRegistry)/$(imageRepository):$(tag) -n production
            displayName: 'Deploy to AKS Production'

          - script: |
              python scripts/health-check.py --env production
            displayName: 'Production Health Check'

          - script: |
              python scripts/migrate.py --env production --backup true
            displayName: 'Run Production Migrations'

          - task: AzureAppServiceManage@0
            inputs:
              azureSubscription: 'Azure-Service-Connection'
              Action: 'Start Azure App Service'
              WebAppName: 'inventory-api-prod'

          - script: |
              python scripts/rollback-check.py --env production
            displayName: 'Rollback Check'
```

### 8.2 Deployment Strategies

Deployment strategies define how new application versions are rolled out to production, balancing the need for zero-downtime deployments with risk management and rollback capabilities. Different strategies suit different scenarios: blue-green deployments provide instant rollback by maintaining parallel environments, canary deployments gradually expose new versions to a subset of users, and rolling updates minimize resource usage by updating instances incrementally. Strategy selection depends on factors like application architecture, traffic patterns, risk tolerance, and infrastructure capabilities. Each strategy has trade-offs between deployment speed, resource usage, rollback speed, and risk exposure, requiring teams to choose approaches that align with their specific needs and constraints. Understanding deployment strategies enables teams to select appropriate approaches for different scenarios and implement them effectively to achieve reliable, low-risk deployments.

#### 8.2.1 Blue-Green Deployment

Blue-green deployment maintains two identical production environments, with one (blue) running the current version and the other (green) running the new version. This strategy enables instant rollback by simply switching traffic from the new environment back to the old environment, making it ideal for high-risk deployments or applications with strict availability requirements. The strategy requires maintaining duplicate infrastructure, which increases costs but provides the fastest rollback capability. Blue-green deployments also enable comprehensive testing of the new version in a production-like environment before switching traffic, reducing the risk of issues affecting users. The switch between environments can be automated or manual, depending on risk tolerance, and monitoring both environments during the switch provides immediate feedback on the new version's performance and stability.
```yaml
strategy:
  runOnce:
    deploy:
      steps:
      - script: |
          # Deploy to green environment
          kubectl apply -f infrastructure/kubernetes/green-deployment.yaml
          
          # Wait for green to be ready
          kubectl wait --for=condition=available deployment/inventory-api-green
          
          # Switch traffic
          kubectl patch service inventory-api -p '{"spec":{"selector":{"version":"green"}}}'
          
          # Monitor for 5 minutes
          sleep 300
          
          # If healthy, remove blue
          kubectl delete deployment inventory-api-blue
```

#### 8.2.2 Canary Deployment

Canary deployment gradually rolls out new versions by initially routing a small percentage of traffic to the new version, then gradually increasing that percentage as confidence grows. This strategy minimizes risk by limiting the impact of potential issues to a small subset of users, enabling teams to detect and respond to problems before they affect the entire user base. The gradual rollout provides real-world validation with actual production traffic and users, which often reveals issues that don't appear in staging environments. Canary deployments require sophisticated traffic routing capabilities and monitoring systems that can detect issues in the canary environment and automatically roll back if problems are detected. This strategy is particularly valuable for high-traffic applications where even small issues can affect many users, and it enables data-driven deployment decisions based on actual performance metrics rather than just test results.
```yaml
strategy:
  canary:
    increments: [10, 25, 50, 100]
    deploy:
      steps:
      - script: |
          # Deploy canary version
          kubectl set image deployment/inventory-api-canary \
            inventory-api=$(containerRegistry)/$(imageRepository):$(tag)
          
          # Gradually increase traffic
          # 10% -> 25% -> 50% -> 100%
```

#### 8.2.3 Rolling Update

Rolling updates deploy new versions incrementally by updating instances one at a time or in small batches, ensuring that the application remains available throughout the deployment process. This strategy minimizes resource overhead compared to blue-green deployments, as it doesn't require maintaining duplicate environments, making it cost-effective for resource-constrained scenarios. Rolling updates work well with container orchestration platforms like Kubernetes, which can manage the update process automatically, ensuring that new instances are healthy before terminating old ones. The strategy provides gradual rollback capability, as old instances remain available if issues are detected, though rollback speed is slower than blue-green deployments. Rolling updates are ideal for stateless applications that can handle mixed-version traffic and for scenarios where resource efficiency is more important than instant rollback capability.
```yaml
strategy:
  rolling:
    maxSurge: 1
    maxUnavailable: 0
    deploy:
      steps:
      - script: |
          kubectl set image deployment/inventory-api \
            inventory-api=$(containerRegistry)/$(imageRepository):$(tag)
          
          kubectl rollout status deployment/inventory-api
```

### 8.3 Environment Configuration

Environment configuration manages the settings and parameters that vary between environments, enabling the same application code to behave appropriately in different contexts. Configuration management separates code from configuration, following the twelve-factor app methodology, which promotes portability and reduces the need for environment-specific code branches. Effective configuration management uses secure storage for sensitive values like credentials and API keys, version control for non-sensitive configuration, and environment-specific overrides that allow customization without code changes. Configuration should be externalized and injectable at runtime, enabling the same container image to run in different environments with different configurations. This approach simplifies deployment processes, reduces configuration errors, and enables rapid environment provisioning.

#### 8.3.1 Environment Variables

Environment variables provide a standard mechanism for passing configuration to applications at runtime, enabling the same application code to adapt to different environments without recompilation or repackaging. These variables typically include connection strings, API endpoints, feature flags, logging levels, and other settings that vary between environments. Environment variable management requires secure handling of sensitive values, which should be stored in secret management systems rather than plain text files or version control. The variable system should support hierarchical overrides, allowing base configurations to be extended or overridden for specific environments, and it should provide validation to ensure that required variables are present and have valid values. Effective environment variable management enables consistent deployment processes while accommodating environment-specific requirements.
```yaml
# Development
variables:
  - group: 'dev-variables'
    - DATABASE_URL: 'postgresql://...'
    - REDIS_URL: 'redis://...'
    - LOG_LEVEL: 'DEBUG'

# Production
variables:
  - group: 'prod-variables'
    - DATABASE_URL: '$(DATABASE_URL_PROD)'
    - REDIS_URL: '$(REDIS_URL_PROD)'
    - LOG_LEVEL: 'INFO'
```

#### 8.3.2 Key Vault Integration

Key Vault integration provides secure storage and retrieval of secrets, credentials, and certificates used by applications and deployment processes. This integration follows the principle of least privilege, granting applications access only to the secrets they need, and it provides audit logging that tracks who accessed which secrets and when. Key Vault integration eliminates the need to store secrets in configuration files, environment variables, or code, reducing the risk of accidental exposure through version control or log files. The integration supports automatic secret rotation, enabling teams to update credentials without code changes or deployments, and it provides versioning that allows rollback to previous secret versions if needed. Effective Key Vault integration requires proper access policies, managed identities for applications, and secure retrieval mechanisms that don't expose secrets in logs or error messages.
```yaml
- task: AzureKeyVault@2
  inputs:
    azureSubscription: 'Azure-Service-Connection'
    KeyVaultName: 'inventory-kv-prod'
    SecretsFilter: '*'
    RunAsPreJob: true
```

---

## 9. Testing Strategy

Testing strategy defines a comprehensive approach to validating software quality at multiple levels, from individual units of code to complete end-to-end scenarios. This strategy balances the need for thorough validation with the constraints of time, resources, and feedback speed, recognizing that different types of tests serve different purposes and have different costs. A well-designed testing strategy provides confidence in code quality while enabling rapid development cycles, and it integrates testing into the development workflow rather than treating it as a separate phase. The strategy should cover functional correctness, performance characteristics, security vulnerabilities, and user experience, with different test types addressing different concerns. Effective testing strategies also include test data management, test environment provisioning, and test result analysis that helps teams understand quality trends and identify areas needing improvement.

### 9.1 Test Pyramid

The test pyramid represents a testing strategy that emphasizes a large number of fast, inexpensive unit tests at the base, a moderate number of integration tests in the middle, and a small number of slow, expensive end-to-end tests at the top. This pyramid structure optimizes for feedback speed and cost efficiency, as unit tests run quickly and catch most defects, while E2E tests provide confidence but are slow and expensive to maintain. The pyramid principle guides teams to write more unit tests that validate individual components in isolation, fewer integration tests that validate component interactions, and minimal E2E tests that validate complete user workflows. This approach balances test coverage with execution time and maintenance cost, ensuring that teams can run comprehensive test suites frequently without slowing down development cycles. Understanding the test pyramid helps teams allocate testing effort effectively and build test suites that provide maximum value with minimum cost.

```
        /\
       /  \      E2E Tests (10%)
      /____\     
     /      \    Integration Tests (30%)
    /________\   
   /          \  Unit Tests (60%)
  /____________\
```

### 9.2 Unit Tests

Unit tests validate individual functions, methods, or classes in isolation, providing fast feedback on code correctness and serving as executable documentation of expected behavior. These tests should be fast, independent, repeatable, and focused on a single unit of functionality, enabling developers to run them frequently during development. Unit tests help catch regressions immediately when code changes, provide confidence for refactoring, and serve as examples of how code should be used. Effective unit testing requires good testability in code design, with dependencies injected rather than hardcoded, enabling isolated testing with mocks or stubs. The goal is to achieve high coverage of business logic while maintaining test readability and maintainability, as poorly written tests can become a maintenance burden that slows down development.

#### 9.2.1 Structure

Unit test structure follows the Arrange-Act-Assert (AAA) pattern, organizing tests into three clear sections: arranging test data and dependencies, acting by invoking the code under test, and asserting that the results match expectations. This structure improves test readability and makes it easier to understand what each test validates. Test organization mirrors the application structure, with test files corresponding to source files and test classes corresponding to classes or modules, making it easy to locate tests for specific code. Descriptive test names that explain what is being tested and what the expected outcome is serve as documentation and make test failures easier to understand. Consistent test structure across the codebase reduces cognitive load and enables developers to quickly understand and modify tests.
```python
# tests/unit/test_inventory_service.py
import pytest
from app.services.inventory_service import InventoryService
from app.models.inventory import InventoryItem

class TestInventoryService:
    def test_add_item(self):
        service = InventoryService()
        item = service.add_item(product_id=1, quantity=10)
        assert item.quantity == 10
    
    def test_low_stock_alert(self):
        service = InventoryService()
        service.add_item(product_id=1, quantity=5)
        alerts = service.check_low_stock(threshold=10)
        assert len(alerts) > 0
```

#### 9.2.2 Coverage Requirements

Coverage requirements establish minimum thresholds for code coverage that teams must meet, ensuring that critical code paths are tested and providing a measurable quality metric. These requirements typically vary by code criticality: critical business logic requires 100% coverage, new code requires high coverage (90%+), and overall codebase coverage targets (80%+) ensure consistent quality. Coverage metrics help teams identify untested code and prioritize testing efforts, though high coverage alone doesn't guarantee quality—tests must also be meaningful and validate correct behavior. Coverage requirements should be enforced in CI pipelines, preventing code with insufficient coverage from being merged, and coverage reports should be visible to developers to encourage test writing. Effective coverage requirements balance the need for thorough testing with the reality that 100% coverage of all code may not be practical or valuable, focusing effort on high-value, high-risk code paths.
- Minimum coverage: 80%
- Critical paths: 100%
- New code: 90%

### 9.3 Integration Tests

Integration tests validate that multiple components work together correctly, testing interactions between application code, databases, external services, and other system components. These tests verify that components integrate properly, that data flows correctly between layers, and that external dependencies are handled appropriately. Integration tests typically run slower than unit tests because they involve real dependencies or test doubles that simulate real behavior, but they provide confidence that components work together as expected. Effective integration testing requires test environments that mirror production configurations, test data management that ensures consistent and isolated test scenarios, and cleanup mechanisms that prevent tests from affecting each other. Integration tests complement unit tests by validating that individually correct components work correctly together, catching issues that unit tests cannot detect.

#### 9.3.1 Database Integration

Database integration tests validate that application code correctly interacts with databases, testing queries, transactions, data persistence, and error handling. These tests require test databases that can be reset between tests, ensuring test isolation and preventing data pollution that could cause tests to fail unpredictably. Database integration tests verify that ORM mappings are correct, that queries perform as expected, that transactions work properly, and that database constraints are enforced. These tests are slower than unit tests because they involve actual database operations, but they provide confidence that data layer code works correctly with real database systems. Effective database integration testing uses transactions that roll back after each test, test fixtures that set up required data, and database migrations that ensure test databases match production schemas.
```python
# tests/integration/test_inventory_api.py
import pytest
from fastapi.testclient import TestClient
from app.main import app

@pytest.fixture
def client():
    return TestClient(app)

def test_create_inventory_item(client):
    response = client.post(
        "/api/v1/inventory",
        json={"product_id": 1, "quantity": 100}
    )
    assert response.status_code == 201
    assert response.json()["quantity"] == 100
```

### 9.4 End-to-End Tests

End-to-end tests validate complete user workflows from start to finish, testing the entire application stack including user interfaces, APIs, databases, and external integrations. These tests provide the highest level of confidence that the application works correctly from a user's perspective, but they are also the slowest and most expensive tests to write and maintain. E2E tests should focus on critical user journeys that represent high business value, as attempting to test every possible scenario through E2E tests would be prohibitively expensive and slow. These tests require complete test environments that mirror production, including all dependencies and integrations, making them complex to set up and maintain. Effective E2E testing balances coverage of critical paths with the cost and speed of execution, using E2E tests sparingly to validate that the most important workflows work correctly while relying on unit and integration tests for detailed validation.

#### 9.4.1 E2E Test Scenarios

E2E test scenarios represent complete user workflows that validate business-critical functionality from beginning to end. These scenarios should cover the most important user journeys, such as user registration, product ordering, inventory management, and reporting, ensuring that core business functions work correctly. Scenarios should be written from a user's perspective, describing what users do and what they expect to happen, rather than focusing on technical implementation details. Each scenario should be independent and able to run in any order, requiring proper test data setup and cleanup. Effective E2E scenarios provide confidence that critical business processes work correctly while remaining maintainable and fast enough to run regularly in CI pipelines.
```python
# tests/e2e/test_inventory_flow.py
def test_complete_inventory_flow():
    # 1. Create product
    # 2. Add inventory
    # 3. Create order
    # 4. Update inventory
    # 5. Verify low stock alert
    pass
```

### 9.5 Performance Tests

Performance tests validate that applications meet performance requirements under various load conditions, identifying bottlenecks, capacity limits, and degradation patterns. These tests help teams understand how applications behave under stress, plan capacity, and identify performance regressions before they affect users. Performance testing includes load testing (normal expected load), stress testing (beyond normal capacity), spike testing (sudden load increases), and endurance testing (sustained load over time). Effective performance testing requires realistic test scenarios that mirror actual user behavior, appropriate test data volumes, and monitoring that captures performance metrics during tests. Performance test results inform capacity planning, infrastructure sizing, and optimization efforts, ensuring that applications can handle expected loads and scale appropriately.

#### 9.5.1 Load Testing with Locust

Load testing with Locust simulates multiple concurrent users accessing the application, measuring response times, throughput, and error rates under various load conditions. Locust enables defining user behavior as code, making it easy to create realistic test scenarios that mirror actual user workflows. Load tests help identify performance bottlenecks, determine maximum capacity, and validate that applications meet performance SLAs. These tests should be run regularly to detect performance regressions and should be integrated into CI/CD pipelines for production releases. Effective load testing requires understanding expected user patterns, appropriate load levels that test realistic scenarios without overwhelming systems, and analysis of results that identifies root causes of performance issues.
```python
# tests/performance/locustfile.py
from locust import HttpUser, task, between

class InventoryUser(HttpUser):
    wait_time = between(1, 3)
    
    @task(3)
    def get_inventory(self):
        self.client.get("/api/v1/inventory")
    
    @task(1)
    def create_inventory_item(self):
        self.client.post(
            "/api/v1/inventory",
            json={"product_id": 1, "quantity": 100}
        )
```

### 9.6 Test Data Management

Test data management ensures that tests have consistent, predictable data that enables reliable test execution and accurate results. Effective test data management balances the need for realistic data that mirrors production scenarios with the need for controlled data that enables predictable test outcomes. Test data should be isolated between tests to prevent interference, and it should be easily reproducible to enable debugging and analysis. Management strategies include test fixtures that provide predefined data sets, factories that generate test data programmatically, and database seeding that sets up required baseline data. Proper test data management reduces test flakiness, enables parallel test execution, and makes tests easier to understand and maintain.

#### 9.6.1 Test Fixtures

Test fixtures provide predefined data sets that tests can use, ensuring consistency and reducing the effort required to set up test scenarios. Fixtures encapsulate data creation logic, making tests more readable and maintainable, and they can be reused across multiple tests, reducing duplication. Effective fixtures are focused on specific test needs, providing only the data required for a particular test scenario, and they support parameterization to enable variations for different test cases. Fixtures should be designed to create minimal data sets that satisfy test requirements, as overly complex fixtures can slow down tests and make them harder to understand. Proper fixture management includes cleanup mechanisms that remove test data after tests complete, ensuring test isolation and preventing data pollution.
- Use factories for test data
- Clean up after tests
- Use transactions for isolation

#### 9.6.2 Test Databases

Test databases provide isolated database environments for integration and E2E tests, ensuring that tests don't interfere with each other or with development databases. These databases should mirror production schemas through migrations, ensuring that tests validate code against the same database structure used in production. Test database management includes provisioning databases for test execution, applying migrations to ensure schema consistency, seeding baseline data, and cleaning up after tests complete. Effective test database management enables fast test execution through efficient setup and teardown, supports parallel test execution through database isolation, and ensures test reliability through consistent data states. Database strategies include in-memory databases for fast unit tests, containerized databases for integration tests, and dedicated test database instances for E2E tests.
- Separate test database per environment
- Automated cleanup
- Seed data scripts

---

## 10. Environment Management

Environment management encompasses the processes, tools, and practices used to create, configure, maintain, and decommission isolated deployment environments throughout the software development lifecycle. Effective environment management ensures that applications can be tested, validated, and deployed reliably by providing consistent, reproducible environments that mirror production conditions while accommodating the specific needs of different stages (development, QA, staging, production). This management includes infrastructure provisioning, configuration management, data management, access control, and lifecycle policies that govern how environments are created, updated, and destroyed. Proper environment management reduces deployment risks by enabling thorough testing in production-like conditions, supports parallel work streams by providing isolated spaces for different teams or features, and optimizes costs by right-sizing environments based on their purpose and usage patterns. The discipline requires balancing consistency across environments with the flexibility to accommodate different requirements, ensuring that what works in one environment will work in others while allowing optimizations for specific use cases.

### 10.1 Environment Types

Environment types represent distinct deployment targets that serve different purposes in the software development lifecycle, each with specific characteristics, requirements, and constraints. These types form a progression from development environments where developers experiment and iterate quickly, through testing environments where quality assurance validates functionality, to staging environments that mirror production for final validation, and finally production environments where end users interact with the application. Each environment type balances different priorities: development environments prioritize speed and flexibility, QA environments focus on comprehensive testing capabilities, staging environments emphasize production fidelity, and production environments prioritize stability, security, and performance. Understanding these types helps teams design appropriate infrastructure, establish proper access controls, manage costs effectively, and ensure that each environment serves its intended purpose while maintaining consistency in deployment processes.

#### 10.1.1 Development
- **Purpose**: Developer local testing
- **Resources**: Shared Azure resources
- **Data**: Synthetic/test data
- **Access**: All developers
- **Cost**: Low

#### 10.1.2 QA

QA environments provide dedicated spaces for quality assurance teams to conduct comprehensive testing, including functional testing, regression testing, integration testing, and user acceptance testing. These environments should closely mirror production configurations to ensure that test results accurately predict production behavior, while using anonymized or synthetic data that protects privacy while enabling realistic testing scenarios. QA environments require stable, consistent configurations that don't change during testing cycles, enabling reproducible test results and reliable bug reproduction. Access control in QA environments typically restricts write access to QA team members while allowing read access for developers who need to investigate issues, balancing security with collaboration needs. Effective QA environment management includes data refresh procedures that reset environments to known states, test data management that provides realistic scenarios, and monitoring that helps QA teams understand system behavior during testing.
- **Purpose**: Quality assurance testing
- **Resources**: Dedicated Azure resources
- **Data**: Production-like data (anonymized)
- **Access**: QA team
- **Cost**: Medium

#### 10.1.3 Staging

Staging environments serve as the final validation gate before production deployment, providing production-like infrastructure and configurations that enable teams to verify that applications work correctly under production conditions. These environments should mirror production as closely as possible in terms of infrastructure sizing, network topology, security configurations, and integration points, ensuring that staging validation accurately predicts production behavior. Staging environments enable final smoke tests, performance validation, security testing, and user acceptance testing in conditions that closely match production, reducing the risk of production issues. Access to staging environments is typically restricted to senior team members and stakeholders who need to validate releases, ensuring that staging remains stable and representative of production. Effective staging environment management includes regular synchronization with production configurations, data refresh procedures that maintain production-like data volumes and distributions, and monitoring that mirrors production monitoring setups to validate that observability works correctly.
- **Purpose**: Pre-production validation
- **Resources**: Production-like infrastructure
- **Data**: Production snapshot (anonymized)
- **Access**: DevOps, QA leads
- **Cost**: High

#### 10.1.4 Production

Production environments represent the live systems that serve end users, requiring the highest levels of stability, security, performance, and reliability. These environments demand rigorous change management processes, comprehensive monitoring and alerting, disaster recovery capabilities, and strict access controls that prevent unauthorized changes. Production environments prioritize availability and data integrity over development speed, implementing safeguards like deployment approvals, rollback procedures, and gradual rollout strategies that minimize risk. Configuration management in production requires careful version control, change documentation, and approval workflows that ensure all modifications are intentional, tested, and reversible. Effective production environment management includes capacity planning that ensures adequate resources for expected loads, security hardening that protects against threats, backup and recovery procedures that ensure business continuity, and monitoring that provides early warning of issues before they impact users.
- **Purpose**: Live production environment
- **Resources**: Full production infrastructure
- **Data**: Real production data
- **Access**: Restricted
- **Cost**: Highest

### 10.2 Environment Provisioning

Environment provisioning involves creating and configuring the infrastructure resources needed to run applications in each environment, transforming environment setup from manual, error-prone processes into automated, repeatable operations. Infrastructure as Code (IaC) approaches enable teams to define environments declaratively, version control infrastructure definitions, and provision environments consistently and reliably. Effective provisioning strategies support rapid environment creation for new projects or features, enable environment replication for testing scenarios, and ensure consistency across environments while allowing environment-specific customizations. Provisioning processes should integrate with CI/CD pipelines to enable automated environment updates, include validation steps that verify successful provisioning, and support rollback capabilities that can restore previous configurations if issues are detected. The provisioning approach balances automation with flexibility, enabling teams to create environments quickly while accommodating special requirements when needed.

#### 10.2.1 Infrastructure as Code (Terraform)

Terraform provides a declarative approach to infrastructure provisioning, enabling teams to define desired infrastructure state in code and let Terraform determine and execute the changes needed to achieve that state. This approach enables version-controlled infrastructure, reproducible environments, and consistent provisioning across different environments while allowing environment-specific customizations through variables and modules. Terraform's state management tracks resource relationships and dependencies, enabling safe updates and ensuring that infrastructure changes are applied in the correct order. The tool's plan-and-apply workflow provides visibility into proposed changes before execution, reducing the risk of unintended modifications, and its provider ecosystem supports provisioning across multiple cloud platforms and services. Effective Terraform usage requires understanding resource dependencies, state management best practices, module organization for reusability, and security considerations like remote state backends and secret management.
```hcl
# infrastructure/terraform/environments/dev/main.tf
module "inventory_api" {
  source = "../../modules/api"
  
  environment = "dev"
  app_name = "inventory-api"
  
  database_sku = "Basic"
  app_service_sku = "B1"
  
  tags = {
    Environment = "Development"
    CostCenter = "Engineering"
  }
}
```

#### 10.2.2 ARM Templates
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environment": {
      "type": "string",
      "allowedValues": ["dev", "qa", "staging", "prod"]
    }
  },
  "resources": [
    {
      "type": "Microsoft.Web/sites",
      "apiVersion": "2021-02-01",
      "name": "[concat('inventory-api-', parameters('environment'))]",
      "properties": {
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', 'app-plan')]"
      }
    }
  ]
}
```

### 10.3 Environment Variables Management

Environment variables management provides a mechanism for externalizing configuration that varies between environments, enabling the same application code to run in different contexts with different settings. This separation follows the twelve-factor app methodology, promoting application portability and reducing the need for environment-specific code branches or rebuilds. Effective variable management uses secure storage for sensitive values like credentials and API keys, version control for non-sensitive configuration, and environment-specific overrides that enable customization without code changes. Variable management systems should support hierarchical configuration where base values can be overridden for specific environments, provide validation to ensure required variables are present and valid, and enable easy updates without requiring code deployments. This approach simplifies environment provisioning, reduces configuration errors, and enables rapid environment creation and updates.

#### 10.3.1 Variable Groups
Create variable groups in Azure DevOps:
- `dev-variables`
- `qa-variables`
- `staging-variables`
- `prod-variables`

#### 10.3.2 Secret Management
- Use Azure Key Vault for secrets
- Link Key Vault to variable groups
- Rotate secrets regularly
- Audit secret access

---

## 11. Security and Compliance

Security and compliance in DevOps encompasses the practices, tools, and processes that protect applications, data, and infrastructure from threats while ensuring adherence to regulatory requirements and industry standards. This discipline integrates security throughout the software development lifecycle, shifting security left to catch vulnerabilities early when they're easier and cheaper to fix, rather than treating security as a final gate before production. Effective security practices include automated scanning of code, dependencies, and containers; secure configuration management; access control and authentication; network security; and continuous monitoring for threats and anomalies. Compliance requirements vary by industry and geography but commonly include data protection regulations like GDPR, security standards like SOC 2, and industry-specific requirements that mandate specific controls and documentation. Security and compliance work together to protect organizations from threats while demonstrating due diligence to regulators, customers, and partners, requiring ongoing attention and adaptation as threats evolve and requirements change.

### 11.1 Security Scanning

#### 11.1.1 Dependency Scanning
- **WhiteSource** - Open source vulnerability scanning
- **Snyk** - Dependency and container scanning
- **OWASP Dependency Check** - Known vulnerabilities

#### 11.1.2 Code Scanning
- **Bandit** - Python security linter
- **SonarQube** - Code quality and security
- **Semgrep** - Static analysis

#### 11.1.3 Container Scanning
- **Trivy** - Container vulnerability scanner
- **Azure Security Center** - Container security
- **Twistlock** - Runtime security

### 11.2 Security Policies

Security policies establish rules and controls that govern how code is developed, reviewed, and deployed, ensuring that security considerations are integrated into development workflows rather than treated as afterthoughts. These policies define requirements for code reviews, security scanning, secret management, access controls, and deployment approvals, creating guardrails that prevent security issues from reaching production. Effective security policies balance protection with developer productivity, automating security checks where possible while requiring human review for high-risk changes. Policies should be clearly documented, consistently enforced through automated tools, and regularly reviewed to ensure they remain effective as threats evolve and tools improve. Security policy enforcement through CI/CD pipelines ensures that security gates are applied consistently and cannot be bypassed, while policy exceptions require documented justification and approval processes.

#### 11.2.1 Branch Policies
- Require security scan approval
- Block merge if critical vulnerabilities found
- Require security review for sensitive changes

#### 11.2.2 Secret Management
- Never commit secrets to repository
- Use Azure Key Vault
- Rotate credentials regularly
- Audit secret access

#### 11.2.3 Network Security
- Private endpoints for databases
- Network security groups
- Application Gateway WAF
- DDoS protection

### 11.3 Compliance

Compliance in software development involves adhering to legal, regulatory, and industry standards that govern how applications handle data, protect privacy, ensure security, and demonstrate due diligence. Compliance requirements vary significantly by industry, geography, and application type, with regulations like GDPR focusing on data privacy, standards like SOC 2 emphasizing security controls, and industry-specific requirements addressing sector-specific concerns. Achieving and maintaining compliance requires understanding applicable requirements, implementing appropriate controls, documenting processes and evidence, and conducting regular audits to verify ongoing adherence. Compliance is not a one-time achievement but an ongoing process that requires continuous attention, regular reviews, and updates as regulations evolve and applications change. Effective compliance programs integrate requirements into development processes rather than treating compliance as a separate concern, ensuring that compliant practices become natural parts of how teams work.

#### 11.3.1 GDPR Compliance
- Data encryption at rest and in transit
- Right to deletion implementation
- Data access logging
- Privacy impact assessments

#### 11.3.2 SOC 2 Compliance
- Access controls
- Audit logging
- Change management
- Incident response procedures

### 11.4 Security Monitoring

#### 11.4.1 Azure Security Center
- Continuous security assessment
- Threat detection
- Security recommendations
- Compliance monitoring

#### 11.4.2 Application Insights
- Failed request tracking
- Exception logging
- Performance monitoring
- Custom security events

---

## 12. Monitoring and Logging

Monitoring and logging provide visibility into application behavior, system health, and user experience, enabling teams to detect issues, understand system performance, and make data-driven decisions about optimization and capacity planning. Effective monitoring encompasses multiple dimensions: application performance monitoring tracks response times, error rates, and throughput; infrastructure monitoring observes resource utilization, availability, and capacity; business metrics measure user behavior and business outcomes; and security monitoring detects threats and anomalous behavior. Logging captures detailed information about application execution, errors, and events, providing the raw data needed for debugging, analysis, and audit trails. Together, monitoring and logging create observability—the ability to understand system behavior from external outputs—enabling teams to maintain reliable, performant applications and respond quickly to issues. The discipline requires careful design of what to monitor and log, efficient storage and retrieval of monitoring data, and effective alerting that notifies teams of issues without creating alert fatigue.

### 12.1 Application Monitoring

#### 12.1.1 Azure Application Insights
```python
# app/core/monitoring.py
from applicationinsights import TelemetryClient
import os

telemetry_client = TelemetryClient(
    os.getenv('APPINSIGHTS_INSTRUMENTATION_KEY')
)

def track_event(name, properties=None):
    telemetry_client.track_event(name, properties)
    telemetry_client.flush()

def track_exception(exception):
    telemetry_client.track_exception(exception)
    telemetry_client.flush()
```

#### 12.1.2 Key Metrics
- Request rate
- Response time (p50, p95, p99)
- Error rate
- Availability
- Throughput

### 12.2 Logging Strategy

Logging strategy defines what information to capture, how to structure it, where to store it, and how to use it for debugging, analysis, and compliance. Effective logging balances the need for comprehensive information with the costs of storage and processing, focusing on capturing meaningful events and errors while avoiding excessive verbosity that obscures important information. Structured logging formats like JSON enable automated parsing and analysis, making logs searchable and allowing tools to extract insights programmatically. Log levels (DEBUG, INFO, WARNING, ERROR, CRITICAL) help control verbosity based on environment and needs, with production typically using INFO and above while development environments may include DEBUG logs. Log aggregation systems centralize logs from multiple sources, enabling correlation and analysis across components, while log retention policies balance the need for historical data with storage costs. Effective logging strategies include correlation IDs that track requests across services, contextual information that aids debugging, and sensitive data exclusion that protects privacy and security.

#### 12.2.1 Log Levels
- **DEBUG**: Detailed information for debugging
- **INFO**: General informational messages
- **WARNING**: Warning messages
- **ERROR**: Error messages
- **CRITICAL**: Critical errors

#### 12.2.2 Structured Logging
```python
# app/core/logging.py
import logging
import json
from datetime import datetime

class StructuredLogger:
    def __init__(self, name):
        self.logger = logging.getLogger(name)
    
    def log(self, level, message, **kwargs):
        log_entry = {
            "timestamp": datetime.utcnow().isoformat(),
            "level": level,
            "message": message,
            **kwargs
        }
        self.logger.log(level, json.dumps(log_entry))
```

#### 12.2.3 Log Aggregation
- **Azure Log Analytics** - Centralized log storage
- **Application Insights** - Application logs
- **Azure Monitor** - Infrastructure logs

### 12.3 Alerting

#### 12.3.1 Alert Rules
```yaml
# Alert: High Error Rate
- name: HighErrorRate
  condition: error_rate > 5%
  duration: 5 minutes
  action: Email DevOps team
  
# Alert: High Response Time
- name: HighResponseTime
  condition: p95_response_time > 2s
  duration: 10 minutes
  action: Page on-call engineer
  
# Alert: Low Availability
- name: LowAvailability
  condition: availability < 99.9%
  duration: 1 minute
  action: Critical alert
```

### 12.4 Dashboards

#### 12.4.1 Azure Dashboard Components
- Application performance metrics
- Infrastructure health
- Error trends
- User activity
- Business metrics (orders, inventory levels)

---

## 13. Artifact Management

Artifact management encompasses the storage, versioning, promotion, and lifecycle management of build outputs that are consumed by deployment processes. Artifacts serve as immutable snapshots of build processes, containing everything needed to deploy applications without requiring access to source code or build environments. Effective artifact management ensures that deployments are reproducible by maintaining historical artifacts that can be redeployed if needed, enables rollback capabilities by preserving previous versions, and supports audit requirements by tracking what was built and when. Artifact storage systems must be fast and reliable, as CD pipelines depend on quick artifact retrieval, and they should support retention policies that balance storage costs with the need for historical data. Artifact promotion strategies ensure that only validated artifacts progress through environments, preventing untested code from reaching production, while versioning schemes enable clear identification of artifact contents and relationships to source code.

### 13.1 Artifact Types

#### 13.1.1 Docker Images
- Stored in Azure Container Registry
- Tagged with build ID and git commit SHA
- Retention: 30 days for non-production, 90 days for production

#### 13.1.2 Python Packages
- Stored in Azure Artifacts
- Versioned using semantic versioning
- Used for library distribution

#### 13.1.3 Test Results
- JUnit XML format
- Published to Azure Test Plans
- Retention: 90 days

#### 13.1.4 Documentation
- API documentation (OpenAPI/Swagger)
- Architecture diagrams
- Deployment guides

### 13.2 Artifact Promotion

#### 13.2.1 Promotion Flow
```
Build Artifact → Dev → QA → Staging → Production
```

#### 13.2.2 Artifact Versioning
- Semantic versioning: `MAJOR.MINOR.PATCH`
- Build metadata: `1.2.3+build.123`
- Git tags: `v1.2.3`

---

## 14. Integration Points

Integration points represent the connections between the inventory management system and external services, APIs, and platforms that extend functionality or provide required capabilities. These integrations enable applications to leverage specialized services rather than building everything in-house, reducing development time and maintenance burden while benefiting from specialized expertise and infrastructure. Integration design requires careful consideration of reliability, as external dependencies can fail or change, requiring resilience patterns like retries, circuit breakers, and fallback mechanisms. Security is paramount in integrations, requiring proper authentication, authorization, and data protection, especially when handling sensitive information or user data. Effective integration management includes versioning strategies that accommodate external API changes, monitoring that detects integration issues, and documentation that helps teams understand dependencies and integration points. Integration testing validates that integrations work correctly, while contract testing ensures that API contracts remain stable and compatible.

### 14.1 External Services

#### 14.1.1 Azure Services
- **Azure SQL Database** - Primary database
- **Azure Redis Cache** - Caching layer
- **Azure Service Bus** - Message queue
- **Azure Blob Storage** - File storage
- **Azure Key Vault** - Secret management
- **Azure Active Directory** - Authentication

#### 14.1.2 Third-Party Integrations
- **Payment Gateway** - Stripe/PayPal
- **Email Service** - SendGrid/Azure Communication Services
- **SMS Service** - Twilio
- **Analytics** - Google Analytics/Mixpanel

### 14.2 API Integrations

#### 14.2.1 Webhook Configuration
```python
# app/services/webhook_service.py
import httpx
from app.core.config import settings

async def send_webhook(event_type, data):
    async with httpx.AsyncClient() as client:
        await client.post(
            settings.webhook_url,
            json={
                "event": event_type,
                "data": data,
                "timestamp": datetime.utcnow().isoformat()
            },
            headers={"Authorization": f"Bearer {settings.webhook_secret}"}
        )
```

### 14.3 CI/CD Integrations

#### 14.3.1 GitHub Integration
- Source code repository (if using GitHub)
- Pull request status checks
- Issue linking

#### 14.3.2 Slack/Teams Integration
- Build notifications
- Deployment alerts
- Error notifications

---

## 15. Documentation

Documentation serves as the knowledge repository that enables team members, stakeholders, and future maintainers to understand the system's architecture, APIs, processes, and operational procedures. Effective documentation balances comprehensiveness with maintainability, providing sufficient detail to be useful while remaining current and accessible. Documentation types serve different purposes: API documentation enables integration and usage, architecture documentation explains system design and decisions, runbooks provide operational procedures, and process documentation guides team workflows. Documentation should be treated as code—version controlled, reviewed, and updated as the system evolves—rather than as a separate, often-neglected artifact. Good documentation reduces onboarding time for new team members, enables self-service for common questions, supports troubleshooting and incident response, and preserves institutional knowledge that might otherwise be lost when team members leave. The key to effective documentation is making it easy to create, find, and update, ensuring that it remains valuable rather than becoming a burden.

### 15.1 API Documentation

#### 15.1.1 OpenAPI/Swagger
```python
# app/main.py
from fastapi import FastAPI
from fastapi.openapi.utils import get_openapi

app = FastAPI(
    title="Inventory Management API",
    description="RESTful API for inventory management",
    version="1.0.0"
)

def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    openapi_schema = get_openapi(
        title="Inventory Management API",
        version="1.0.0",
        routes=app.routes,
    )
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi
```

#### 15.1.2 API Documentation Hosting
- Swagger UI: `/docs`
- ReDoc: `/redoc`
- OpenAPI JSON: `/openapi.json`

### 15.2 Architecture Documentation

#### 15.2.1 Diagrams
- System architecture diagram
- Deployment architecture
- Data flow diagrams
- Sequence diagrams

#### 15.2.2 Decision Records
- ADR (Architecture Decision Records)
- Technology choices
- Design patterns

### 15.3 Runbooks

#### 15.3.1 Deployment Runbook
- Pre-deployment checklist
- Deployment steps
- Post-deployment verification
- Rollback procedures

#### 15.3.2 Incident Response Runbook
- Common issues and solutions
- Escalation procedures
- Contact information

---

## 16. Disaster Recovery

Disaster recovery encompasses the processes, procedures, and technologies that enable organizations to recover from catastrophic failures, data loss, or service disruptions and resume normal operations. This discipline recognizes that failures will occur despite best efforts at prevention, and it focuses on minimizing the impact and duration of outages through preparation, detection, response, and recovery capabilities. Disaster recovery planning defines Recovery Time Objectives (RTO) that specify maximum acceptable downtime and Recovery Point Objectives (RPO) that specify maximum acceptable data loss, guiding the design of backup, replication, and failover systems. Effective disaster recovery requires regular testing to ensure that recovery procedures work correctly and that teams are prepared to execute them under stress, as untested recovery plans often fail when needed most. The discipline balances recovery speed and data protection with cost, recognizing that perfect protection may be prohibitively expensive, and it requires ongoing maintenance as systems evolve and requirements change.

### 16.1 Backup Strategy

#### 16.1.1 Database Backups
- **Frequency**: Daily full backup, hourly transaction log backups
- **Retention**: 30 days
- **Storage**: Azure Backup Vault
- **Testing**: Monthly restore tests

#### 16.1.2 Application Backups
- Infrastructure as Code (Terraform/ARM)
- Configuration backups
- Secret backups (Key Vault)

### 16.2 Disaster Recovery Plan

#### 16.2.1 RTO/RPO Targets
- **RTO (Recovery Time Objective)**: 4 hours
- **RPO (Recovery Point Objective)**: 1 hour

#### 16.2.2 Failover Procedures
1. Detect disaster
2. Activate DR site
3. Restore database from backup
4. Deploy application
5. Verify functionality
6. Switch DNS
7. Monitor and validate

### 16.3 High Availability

#### 16.3.1 Multi-Region Deployment
- Primary region: East US
- Secondary region: West US
- Traffic Manager for failover

#### 16.3.2 Database Replication
- Primary database with read replicas
- Geo-replication enabled
- Automatic failover groups

---

## 17. Performance Optimization

Performance optimization involves identifying and addressing bottlenecks that limit application speed, throughput, or resource efficiency, ensuring that applications meet performance requirements while using resources efficiently. This discipline requires understanding performance characteristics through measurement and profiling, identifying optimization opportunities through analysis, and validating improvements through testing. Performance optimization spans multiple layers: application code optimization improves algorithm efficiency and reduces unnecessary work, database optimization improves query performance and reduces data access overhead, caching reduces redundant computations and data access, and infrastructure optimization ensures adequate resources and efficient resource utilization. Effective optimization follows a data-driven approach, measuring before and after changes to ensure improvements are real, and it balances performance gains with code complexity and maintainability. Performance optimization is an ongoing process rather than a one-time activity, as applications evolve, usage patterns change, and new bottlenecks emerge, requiring continuous monitoring and optimization efforts.

### 17.1 Application Performance

#### 17.1.1 Caching Strategy
- Redis for frequently accessed data
- Cache invalidation policies
- Cache warming strategies

#### 17.1.2 Database Optimization
- Index optimization
- Query optimization
- Connection pooling
- Read replicas for read-heavy workloads

#### 17.1.3 API Optimization
- Response compression
- Pagination
- Field filtering
- Rate limiting

### 17.2 Infrastructure Optimization

#### 17.2.1 Auto-Scaling
```yaml
# Kubernetes HPA
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: inventory-api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: inventory-api
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

#### 17.2.2 Resource Optimization
- Right-sizing VMs/containers
- Reserved instances for predictable workloads
- Spot instances for non-critical workloads

---

## 18. Troubleshooting Guide

### 18.1 Common Issues and Solutions

#### 18.1.1 Build Failures

**Issue**: Pipeline fails at build stage

**Root Causes and Solutions:**

1. **Python Version Mismatch**
   ```bash
   # Check Python version in pipeline
   python --version
   # Ensure requirements.txt specifies compatible versions
   # Update azure-pipelines.yml pythonVersion variable
   ```

2. **Dependency Installation Failures**
   ```bash
   # Verify requirements.txt syntax
   pip install -r requirements.txt --dry-run
   
   # Check for conflicting dependencies
   pip check
   
   # Common fixes:
   # - Update pip: python -m pip install --upgrade pip
   # - Use specific versions instead of ranges
   # - Check for platform-specific packages
   ```

3. **Syntax Errors**
   ```bash
   # Run linters locally before committing
   pylint app/ --rcfile=.pylintrc
   flake8 app/ --config=.flake8
   black --check app/
   
   # Use pre-commit hooks to catch errors early
   ```

4. **Build Agent Issues**
   - Check agent pool availability
   - Verify agent has required tools installed
   - Check disk space on build agent
   - Review agent logs in Azure DevOps

5. **Docker Build Failures**
   ```bash
   # Test Dockerfile locally
   docker build -t test-image .
   
   # Check for:
   # - Base image availability
   # - Network connectivity
   # - Build context size
   # - Multi-stage build issues
   ```

**Debugging Steps:**
1. Review build logs in Azure DevOps portal
2. Check for specific error messages
3. Reproduce locally using same Python version
4. Check build agent capabilities
5. Review recent changes to requirements.txt or Dockerfile

#### 18.1.2 Test Failures

**Issue**: Tests failing in pipeline

**Root Causes and Solutions:**

1. **Environment Variable Issues**
   ```yaml
   # Ensure variables are set in pipeline
   variables:
     - group: 'test-variables'
     - name: DATABASE_URL
       value: 'postgresql://...'
   ```

2. **Test Data Setup Problems**
   ```python
   # Use fixtures for consistent test data
   @pytest.fixture(scope="function")
   def test_db():
       # Setup test database
       yield db
       # Cleanup
   ```

3. **Race Conditions**
   ```python
   # Use proper async/await patterns
   # Add appropriate waits
   await asyncio.sleep(0.1)
   ```

4. **Database Connection Issues**
   ```python
   # Ensure test database is available
   # Use test containers or in-memory databases
   # Check connection strings
   ```

5. **Flaky Tests**
   - Identify non-deterministic tests
   - Add retry logic for external dependencies
   - Use mocking for external services
   - Ensure proper test isolation

**Debugging Steps:**
1. Run tests locally with same environment
2. Check test logs for specific failures
3. Review test data setup/teardown
4. Verify test database state
5. Check for timing issues

#### 18.1.3 Deployment Failures

**Issue**: Deployment to environment fails

**Root Causes and Solutions:**

1. **Service Connection Permissions**
   ```bash
   # Verify service principal permissions
   az role assignment list --assignee <service-principal-id>
   
   # Required roles:
   # - Contributor (for resource creation)
   # - AcrPush (for container registry)
   # - AKS Contributor (for Kubernetes)
   ```

2. **Environment Variables Missing**
   ```yaml
   # Check variable groups are linked
   variables:
     - group: 'prod-variables'
   
   # Verify Key Vault secrets are accessible
   - task: AzureKeyVault@2
     inputs:
       KeyVaultName: 'inventory-kv-prod'
       SecretsFilter: '*'
   ```

3. **Resource Availability**
   ```bash
   # Check resource quotas
   az vm list-usage --location eastus
   
   # Verify resource group exists
   az group show --name rg-prod
   
   # Check AKS cluster status
   az aks show --resource-group rg-prod --name aks-prod-cluster
   ```

4. **Kubernetes Deployment Issues**
   ```bash
   # Check pod status
   kubectl get pods -n production
   
   # View pod events
   kubectl describe pod <pod-name> -n production
   
   # Check logs
   kubectl logs <pod-name> -n production
   
   # Verify image pull
   kubectl get events -n production --sort-by='.lastTimestamp'
   ```

5. **Database Migration Failures**
   ```bash
   # Test migrations locally first
   alembic upgrade head
   
   # Check database connectivity
   psql $DATABASE_URL -c "SELECT 1"
   
   # Verify migration scripts
   alembic check
   ```

**Debugging Steps:**
1. Review deployment logs in Azure DevOps
2. Check Kubernetes events and pod status
3. Verify service connections and permissions
4. Test deployment scripts manually
5. Check resource group and resource availability

#### 18.1.4 Application Errors

**Issue**: Application errors in production

**Root Causes and Solutions:**

1. **Database Connectivity**
   ```python
   # Check connection pool settings
   engine = create_engine(
       DATABASE_URL,
       pool_size=10,
       max_overflow=20,
       pool_pre_ping=True  # Verify connections
   )
   
   # Monitor connection pool metrics
   ```

2. **External Service Failures**
   ```python
   # Implement retry logic with exponential backoff
   from tenacity import retry, stop_after_attempt, wait_exponential
   
   @retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=4, max=10))
   async def call_external_service():
       # Service call
       pass
   ```

3. **Memory Leaks**
   ```bash
   # Monitor memory usage
   kubectl top pods -n production
   
   # Check for memory leaks in code
   # Use memory profilers
   ```

4. **Configuration Errors**
   ```python
   # Validate configuration on startup
   from pydantic import BaseSettings, validator
   
   class Settings(BaseSettings):
       database_url: str
       
       @validator('database_url')
       def validate_db_url(cls, v):
           if not v.startswith('postgresql://'):
               raise ValueError('Invalid database URL')
           return v
   ```

5. **Rate Limiting Issues**
   ```python
   # Implement rate limiting
   from slowapi import Limiter
   limiter = Limiter(key_func=get_remote_address)
   
   @app.get("/api/v1/inventory")
   @limiter.limit("100/minute")
   async def get_inventory():
       pass
   ```

**Debugging Steps:**
1. Check Application Insights for error patterns
2. Review error logs and stack traces
3. Monitor application metrics (CPU, memory, requests)
4. Check database connection pool status
5. Verify external service health
6. Review recent deployments and changes

#### 18.1.5 Performance Issues

**Issue**: Slow response times or high resource usage

**Root Causes and Solutions:**

1. **Database Query Performance**
   ```sql
   -- Identify slow queries
   SELECT query, mean_exec_time, calls
   FROM pg_stat_statements
   ORDER BY mean_exec_time DESC
   LIMIT 10;
   
   -- Check for missing indexes
   SELECT schemaname, tablename, attname, n_distinct, correlation
   FROM pg_stats
   WHERE schemaname = 'public';
   ```

2. **N+1 Query Problems**
   ```python
   # Use eager loading
   from sqlalchemy.orm import joinedload
   
   items = session.query(InventoryItem)\
       .options(joinedload(InventoryItem.product))\
       .all()
   ```

3. **Cache Misses**
   ```python
   # Monitor cache hit rate
   cache_hits = redis_client.info()['keyspace_hits']
   cache_misses = redis_client.info()['keyspace_misses']
   hit_rate = cache_hits / (cache_hits + cache_misses)
   ```

4. **Inefficient API Endpoints**
   ```python
   # Add pagination
   @app.get("/api/v1/inventory")
   async def get_inventory(
       skip: int = 0,
       limit: int = 100,
       max_limit: int = 1000
   ):
       return items[skip:skip+limit]
   ```

### 18.2 Debugging Tools and Techniques

#### 18.2.1 Azure DevOps Debugging

**Pipeline Logs:**
- Access logs via Azure DevOps portal
- Download logs as ZIP for offline analysis
- Use log search functionality
- Filter by stage/job/task

**Test Results Analysis:**
```bash
# Download test results
az pipelines runs show --id <run-id> --org <org> --project <project>

# View test attachments
# Check for screenshots, logs, or artifacts
```

**Release Logs:**
- Review deployment logs per environment
- Check approval history
- View artifact versions deployed
- Monitor deployment duration

**Artifact Downloads:**
```bash
# Download artifacts via Azure CLI
az pipelines runs artifact download \
  --run-id <run-id> \
  --artifact-name drop \
  --path ./artifacts
```

#### 18.2.2 Application Debugging

**Application Insights Live Metrics:**
```python
# Enable live metrics
from applicationinsights import TelemetryClient

telemetry_client = TelemetryClient(instrumentation_key)
telemetry_client.track_metric("custom_metric", value)
```

**Log Streaming:**
```bash
# Stream logs from Azure App Service
az webapp log tail --name inventory-api-prod --resource-group rg-prod

# Stream Kubernetes logs
kubectl logs -f deployment/inventory-api -n production

# Follow multiple pods
kubectl logs -f -l app=inventory-api -n production
```

**Remote Debugging (Dev Environments):**
```python
# Use debugpy for remote debugging
import debugpy

debugpy.listen(("0.0.0.0", 5678))
debugpy.wait_for_client()  # Optional: wait for client
```

**Profiling Tools:**
```python
# Use cProfile for performance profiling
import cProfile
import pstats

profiler = cProfile.Profile()
profiler.enable()
# Your code here
profiler.disable()
stats = pstats.Stats(profiler)
stats.sort_stats('cumulative')
stats.print_stats(20)
```

#### 18.2.3 Database Debugging

**Query Analysis:**
```sql
-- Enable query logging
SET log_statement = 'all';
SET log_duration = on;
SET log_min_duration_statement = 1000;  -- Log queries > 1s

-- Analyze query plan
EXPLAIN ANALYZE SELECT * FROM inventory WHERE product_id = 1;

-- Check for locks
SELECT * FROM pg_locks WHERE NOT granted;
```

**Connection Pool Monitoring:**
```python
# Monitor SQLAlchemy connection pool
from sqlalchemy import event
from sqlalchemy.pool import Pool

@event.listens_for(Pool, "connect")
def receive_connect(dbapi_conn, connection_record):
    print("New connection created")

@event.listens_for(Pool, "checkout")
def receive_checkout(dbapi_conn, connection_record, connection_proxy):
    print("Connection checked out")
```

#### 18.2.4 Kubernetes Debugging

**Pod Debugging:**
```bash
# Get pod details
kubectl describe pod <pod-name> -n production

# View pod logs
kubectl logs <pod-name> -n production --tail=100 -f

# Execute commands in pod
kubectl exec -it <pod-name> -n production -- /bin/bash

# Check resource usage
kubectl top pod <pod-name> -n production

# View events
kubectl get events -n production --sort-by='.lastTimestamp'
```

**Service Debugging:**
```bash
# Check service endpoints
kubectl get endpoints -n production

# Test service connectivity
kubectl run -it --rm debug --image=busybox --restart=Never -- \
  wget -qO- http://inventory-api:8000/health

# Port forward for local testing
kubectl port-forward svc/inventory-api 8000:8000 -n production
```

**Deployment Debugging:**
```bash
# Check deployment status
kubectl rollout status deployment/inventory-api -n production

# View deployment history
kubectl rollout history deployment/inventory-api -n production

# Rollback to previous version
kubectl rollout undo deployment/inventory-api -n production

# View replica set
kubectl get rs -n production
```

### 18.3 Escalation Procedures

#### 18.3.1 Escalation Levels

**Level 1: Developer/Team Lead (0-30 minutes)**
- Initial investigation
- Check logs and metrics
- Attempt standard fixes
- Document findings
- **Contact**: Team Slack channel, email

**Level 2: DevOps Team (30 minutes - 2 hours)**
- Infrastructure issues
- Deployment problems
- Configuration errors
- **Contact**: devops@company.com, #devops-alerts

**Level 3: Architecture Team (2-4 hours)**
- System design issues
- Performance problems
- Scalability concerns
- **Contact**: architecture@company.com, escalate via DevOps lead

**Level 4: CTO/Management (4+ hours or critical)**
- Critical production outages
- Security incidents
- Business impact > $10k
- **Contact**: cto@company.com, +1-XXX-XXX-XXXX

#### 18.3.2 Incident Response Process

1. **Detection**
   - Automated alerts from monitoring
   - User reports
   - Health check failures

2. **Triage**
   - Assess severity (Critical/High/Medium/Low)
   - Identify affected systems
   - Estimate impact

3. **Investigation**
   - Review logs and metrics
   - Check recent changes
   - Identify root cause

4. **Resolution**
   - Implement fix
   - Verify resolution
   - Monitor for stability

5. **Post-Mortem**
   - Document incident
   - Root cause analysis
   - Action items
   - Process improvements

#### 18.3.3 On-Call Rotation

**Schedule:**
- Primary on-call: 1 week rotation
- Secondary on-call: Backup support
- Escalation: Architecture team

**Responsibilities:**
- Respond to alerts within SLA
- Investigate and resolve issues
- Escalate when needed
- Document incidents

**Tools:**
- PagerDuty for alerting
- Slack for communication
- Azure DevOps for tracking
- Runbooks for procedures

---

## 19. Best Practices

### 19.1 Code Quality

#### 19.1.1 Python Style Guide
```python
# Follow PEP 8
# Use type hints
def get_inventory_item(item_id: int) -> Optional[InventoryItem]:
    """Retrieve inventory item by ID.
    
    Args:
        item_id: Unique identifier for inventory item
        
    Returns:
        InventoryItem if found, None otherwise
        
    Raises:
        ValueError: If item_id is invalid
    """
    pass

# Use meaningful variable names
inventory_quantity = 100  # Good
iq = 100  # Bad

# Keep functions small and focused
# Maximum 50 lines per function
# Single responsibility principle
```

#### 19.1.2 Code Review Checklist
- [ ] Code follows PEP 8 style guide
- [ ] Type hints are used for all functions
- [ ] Docstrings are present and complete
- [ ] Tests are written and passing
- [ ] No hardcoded values or secrets
- [ ] Error handling is appropriate
- [ ] Logging is implemented
- [ ] Performance considerations addressed
- [ ] Security best practices followed
- [ ] Documentation updated

#### 19.1.3 Testing Standards
```python
# Test naming convention
def test_get_inventory_item_returns_item_when_exists():
    pass

def test_get_inventory_item_returns_none_when_not_exists():
    pass

# Use fixtures for common setup
@pytest.fixture
def sample_inventory_item():
    return InventoryItem(id=1, product_id=1, quantity=100)

# Test edge cases
def test_add_inventory_with_negative_quantity_raises_error():
    with pytest.raises(ValueError):
        service.add_item(product_id=1, quantity=-10)

# Maintain >80% code coverage
# Critical paths: 100% coverage
```

#### 19.1.4 Code Organization
```
app/
├── api/          # API endpoints
├── core/         # Core functionality (config, security)
├── models/       # Database models
├── schemas/      # Pydantic schemas
├── services/     # Business logic
└── utils/        # Utility functions
```

### 19.2 Security Best Practices

#### 19.2.1 Secret Management
```python
# NEVER commit secrets
# Use environment variables
import os
from azure.keyvault.secrets import SecretClient

# Retrieve from Key Vault
client = SecretClient(vault_url, credential)
secret = client.get_secret("database-password")

# Use in application
DATABASE_PASSWORD = secret.value
```

#### 19.2.2 Authentication and Authorization
```python
# Use OAuth2 with JWT tokens
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid token")

# Implement role-based access control
def require_role(required_role: str):
    def decorator(func):
        async def wrapper(*args, **kwargs):
            user = kwargs.get('current_user')
            if user.role != required_role:
                raise HTTPException(status_code=403)
            return await func(*args, **kwargs)
        return wrapper
    return decorator
```

#### 19.2.3 Input Validation
```python
# Use Pydantic for validation
from pydantic import BaseModel, validator, Field

class InventoryItemCreate(BaseModel):
    product_id: int = Field(..., gt=0)
    quantity: int = Field(..., ge=0, le=10000)
    
    @validator('product_id')
    def validate_product_exists(cls, v):
        if not product_exists(v):
            raise ValueError('Product does not exist')
        return v
```

#### 19.2.4 SQL Injection Prevention
```python
# Use parameterized queries
# SQLAlchemy handles this automatically
item = session.query(InventoryItem)\
    .filter(InventoryItem.id == item_id)\
    .first()

# NEVER use string formatting
# BAD: f"SELECT * FROM inventory WHERE id = {item_id}"
```

#### 19.2.5 Dependency Updates
```bash
# Regularly check for updates
pip list --outdated

# Use security scanning tools
safety check
pip-audit

# Update dependencies regularly
# Review changelogs before updating
# Test thoroughly after updates
```

### 19.3 Performance Best Practices

#### 19.3.1 Database Optimization
```python
# Use indexes for frequently queried columns
# Add indexes in Alembic migrations
def upgrade():
    op.create_index('ix_inventory_product_id', 'inventory', ['product_id'])

# Use connection pooling
engine = create_engine(
    DATABASE_URL,
    pool_size=10,
    max_overflow=20,
    pool_pre_ping=True
)

# Avoid N+1 queries
# Use eager loading
items = session.query(InventoryItem)\
    .options(joinedload(InventoryItem.product))\
    .all()

# Use pagination for large datasets
@app.get("/api/v1/inventory")
async def get_inventory(
    skip: int = 0,
    limit: int = Query(100, le=1000)
):
    return items[skip:skip+limit]
```

#### 19.3.2 Caching Strategy
```python
# Cache frequently accessed data
from functools import lru_cache
import redis

redis_client = redis.Redis.from_url(REDIS_URL)

@lru_cache(maxsize=100)
def get_product(product_id: int):
    return product_service.get(product_id)

# Cache API responses
@app.get("/api/v1/inventory/{item_id}")
@cache(expire=300)  # 5 minutes
async def get_inventory_item(item_id: int):
    return inventory_service.get(item_id)

# Cache invalidation
def update_inventory(item_id: int, quantity: int):
    inventory_service.update(item_id, quantity)
    cache.delete(f"inventory:{item_id}")
```

#### 19.3.3 Async Operations
```python
# Use async/await for I/O operations
async def get_inventory_item(item_id: int) -> InventoryItem:
    # Database query
    item = await db.fetch_one(
        "SELECT * FROM inventory WHERE id = $1", item_id
    )
    return item

# Use background tasks for non-critical operations
from fastapi import BackgroundTasks

@app.post("/api/v1/inventory")
async def create_inventory(
    item: InventoryItemCreate,
    background_tasks: BackgroundTasks
):
    new_item = inventory_service.create(item)
    background_tasks.add_task(send_notification, new_item.id)
    return new_item
```

#### 19.3.4 API Optimization
```python
# Implement response compression
from fastapi.middleware.gzip import GZipMiddleware
app.add_middleware(GZipMiddleware, minimum_size=1000)

# Use field filtering
class InventoryItemResponse(BaseModel):
    id: int
    product_id: int
    quantity: int
    
    class Config:
        fields = {'id': ..., 'product_id': ..., 'quantity': ...}

# Implement rate limiting
from slowapi import Limiter
limiter = Limiter(key_func=get_remote_address)

@app.get("/api/v1/inventory")
@limiter.limit("100/minute")
async def get_inventory():
    pass
```

### 19.4 Documentation Best Practices

#### 19.4.1 Code Documentation
```python
def calculate_inventory_value(items: List[InventoryItem]) -> float:
    """Calculate total value of inventory items.
    
    This function sums the value of all inventory items by multiplying
    each item's quantity by its unit price.
    
    Args:
        items: List of InventoryItem objects to calculate value for
        
    Returns:
        Total inventory value as float
        
    Raises:
        ValueError: If any item has invalid price or quantity
        
    Example:
        >>> items = [InventoryItem(quantity=10, price=5.0)]
        >>> calculate_inventory_value(items)
        50.0
    """
    return sum(item.quantity * item.price for item in items)
```

#### 19.4.2 API Documentation
```python
@app.post(
    "/api/v1/inventory",
    response_model=InventoryItemResponse,
    status_code=201,
    summary="Create inventory item",
    description="Create a new inventory item with specified product and quantity",
    response_description="Created inventory item",
    tags=["Inventory"]
)
async def create_inventory_item(
    item: InventoryItemCreate = Body(
        ...,
        example={
            "product_id": 1,
            "quantity": 100,
            "location": "Warehouse A"
        }
    )
):
    """Create a new inventory item."""
    pass
```

#### 19.4.3 Architecture Documentation
- Maintain system architecture diagrams
- Document data flow
- Update sequence diagrams for complex flows
- Keep ADRs (Architecture Decision Records)
- Document design patterns used

#### 19.4.4 Runbook Maintenance
- Update runbooks after each incident
- Include step-by-step procedures
- Add troubleshooting sections
- Include rollback procedures
- Keep contact information current

### 19.5 CI/CD Best Practices

#### 19.5.1 Pipeline Design
- Keep pipelines fast (< 15 minutes)
- Use parallel stages where possible
- Cache dependencies
- Fail fast on errors
- Use templates for reusability

#### 19.5.2 Deployment Practices
- Deploy to production during business hours
- Use canary deployments for risky changes
- Have rollback plan ready
- Monitor metrics after deployment
- Communicate deployments to team

#### 19.5.3 Version Management
- Use semantic versioning
- Tag releases in Git
- Maintain changelog
- Document breaking changes
- Provide migration guides

### 19.6 Monitoring Best Practices

#### 19.6.1 Metrics to Monitor
- Request rate and latency
- Error rates
- Resource utilization (CPU, memory)
- Database connection pool
- Cache hit rates
- External service health

#### 19.6.2 Alerting Strategy
- Set appropriate thresholds
- Avoid alert fatigue
- Use different severity levels
- Include context in alerts
- Test alerting regularly

#### 19.6.3 Logging Standards
```python
# Use structured logging
import logging
import json

logger = logging.getLogger(__name__)

def log_inventory_update(item_id: int, old_qty: int, new_qty: int):
    logger.info(
        "Inventory updated",
        extra={
            "item_id": item_id,
            "old_quantity": old_qty,
            "new_quantity": new_qty,
            "change": new_qty - old_qty
        }
    )
```

---

## 20. Metrics and KPIs

### 20.1 Development Metrics (DORA Metrics)

#### 20.1.1 Lead Time for Changes
**Definition**: Time from code commit to production deployment

**Measurement:**
```yaml
# Track in Azure DevOps pipeline
variables:
  commitTime: $[variables['Build.SourceVersionTimestamp']]
  deployTime: $[variables['System.JobStartTime']]

# Calculate lead time
- script: |
    LEAD_TIME=$(($(date +%s) - $(date -d "$(commitTime)" +%s)))
    echo "##vso[task.setvariable variable=LeadTime]$LEAD_TIME"
```

**Targets:**
- **Elite**: < 1 hour
- **High**: 1 day - 1 week
- **Medium**: 1 week - 1 month
- **Low**: 1 - 6 months

**Improvement Strategies:**
- Automate deployments
- Reduce approval bottlenecks
- Parallelize testing
- Optimize build times

#### 20.1.2 Deployment Frequency
**Definition**: How often deployments occur

**Measurement:**
```sql
-- Query Azure DevOps Analytics
SELECT 
    COUNT(*) as deployment_count,
    DATEPART(week, [DeploymentDate]) as week_number
FROM Deployments
WHERE Environment = 'Production'
GROUP BY DATEPART(week, [DeploymentDate])
```

**Targets:**
- **Elite**: Multiple per day
- **High**: Once per day to once per week
- **Medium**: Once per week to once per month
- **Low**: Once per month to once per 6 months

**Tracking:**
- Weekly deployment reports
- Deployment frequency dashboard
- Trend analysis

#### 20.1.3 Mean Time to Recovery (MTTR)
**Definition**: Average time to recover from production failures

**Measurement:**
```python
# Track incident resolution time
incidents = [
    {"start": "2026-01-01 10:00", "resolved": "2026-01-01 10:30"},
    {"start": "2026-01-02 14:00", "resolved": "2026-01-02 14:45"},
]

mttr = sum(
    (resolved - start).total_seconds() 
    for start, resolved in incidents
) / len(incidents)
```

**Targets:**
- **Elite**: < 1 hour
- **High**: < 1 day
- **Medium**: 1 day - 1 week
- **Low**: 1 week - 1 month

**Improvement Strategies:**
- Automated rollback procedures
- Comprehensive monitoring
- Runbook documentation
- Regular incident drills

#### 20.1.4 Change Failure Rate
**Definition**: Percentage of deployments causing production issues

**Measurement:**
```python
# Calculate change failure rate
total_deployments = 100
failed_deployments = 5
change_failure_rate = (failed_deployments / total_deployments) * 100
# Result: 5%
```

**Targets:**
- **Elite**: 0-15%
- **High**: 16-30%
- **Medium**: 31-45%
- **Low**: 46-60%

**Reduction Strategies:**
- Comprehensive testing
- Staged rollouts
- Feature flags
- Post-deployment monitoring

### 20.2 Application Performance Metrics

#### 20.2.1 Availability (Uptime)
**Definition**: Percentage of time service is operational

**Measurement:**
```python
# Calculate availability
total_time = 30 * 24 * 60  # 30 days in minutes
downtime = 120  # minutes
availability = ((total_time - downtime) / total_time) * 100
# Target: 99.9% = 43.2 minutes downtime per month
```

**SLA Targets:**
- **Development**: 95%
- **QA**: 98%
- **Staging**: 99%
- **Production**: 99.9% (43.2 min/month)

**Monitoring:**
- Health check endpoints
- Synthetic monitoring
- Real user monitoring
- Alert on availability drops

#### 20.2.2 Response Time Metrics
**Definition**: Time taken to process requests

**Percentiles:**
- **p50 (Median)**: < 200ms
- **p95**: < 500ms
- **p99**: < 1000ms
- **p99.9**: < 2000ms

**Measurement:**
```python
# Track in Application Insights
from applicationinsights import TelemetryClient

telemetry_client.track_metric(
    "response_time",
    duration_ms,
    properties={"endpoint": endpoint, "method": method}
)
```

**Optimization:**
- Database query optimization
- Caching strategies
- Async processing
- CDN for static content

#### 20.2.3 Error Rate
**Definition**: Percentage of requests resulting in errors

**Targets:**
- **Development**: < 5%
- **QA**: < 2%
- **Staging**: < 1%
- **Production**: < 0.1%

**Error Categories:**
- 4xx (Client Errors): < 1%
- 5xx (Server Errors): < 0.1%
- Timeouts: < 0.05%

**Monitoring:**
```python
# Track error rates
error_rate = (error_count / total_requests) * 100

# Alert if error rate exceeds threshold
if error_rate > 0.1:
    send_alert("High error rate detected")
```

#### 20.2.4 Throughput
**Definition**: Requests processed per second

**Targets:**
- **Baseline**: 100 req/s
- **Peak**: 1000 req/s
- **Sustained**: 500 req/s

**Measurement:**
```python
# Calculate throughput
requests_processed = 10000
time_elapsed = 100  # seconds
throughput = requests_processed / time_elapsed  # 100 req/s
```

**Scaling:**
- Horizontal scaling (add instances)
- Vertical scaling (increase resources)
- Load balancing
- Auto-scaling policies

### 20.3 Infrastructure Metrics

#### 20.3.1 Resource Utilization
**CPU Usage:**
- Target: 60-70% average
- Peak: < 90%
- Alert threshold: > 80%

**Memory Usage:**
- Target: 60-70% average
- Peak: < 85%
- Alert threshold: > 80%

**Disk Usage:**
- Target: < 70%
- Alert threshold: > 85%
- Critical: > 95%

**Network:**
- Bandwidth utilization
- Connection count
- Latency

#### 20.3.2 Database Metrics
**Connection Pool:**
- Active connections: Monitor pool usage
- Idle connections: Track pool efficiency
- Connection wait time: < 100ms

**Query Performance:**
- Average query time: < 50ms
- Slow queries (> 1s): < 1%
- Index usage: Monitor index hit rate

**Replication Lag:**
- Read replica lag: < 100ms
- Alert if lag > 1s

### 20.4 Business Metrics

#### 20.4.1 Order Processing Metrics
**Order Processing Time:**
- Average: < 2 seconds
- p95: < 5 seconds
- p99: < 10 seconds

**Order Success Rate:**
- Target: > 99.5%
- Failed orders: < 0.5%

**Order Volume:**
- Daily orders processed
- Peak hour capacity
- Growth trends

#### 20.4.2 Inventory Accuracy
**Inventory Accuracy Rate:**
- Target: > 99%
- Discrepancies: Track and resolve
- Cycle count frequency: Weekly

**Stock Level Metrics:**
- Low stock alerts: Response time < 1 hour
- Out of stock incidents: < 0.1%
- Overstock situations: Monitor and optimize

#### 20.4.3 User Experience Metrics
**API Response Times:**
- Critical endpoints: < 200ms
- Standard endpoints: < 500ms
- Background jobs: Track completion time

**User Satisfaction:**
- API uptime: > 99.9%
- Error rate: < 0.1%
- Support tickets: Track and reduce

### 20.5 Security Metrics

#### 20.5.1 Security Incidents
- Number of security incidents: Track monthly
- Mean time to detect (MTTD): < 15 minutes
- Mean time to respond (MTTR): < 1 hour
- Mean time to resolve: < 4 hours

#### 20.5.2 Vulnerability Management
- Critical vulnerabilities: Resolve within 24 hours
- High vulnerabilities: Resolve within 7 days
- Medium vulnerabilities: Resolve within 30 days
- Low vulnerabilities: Resolve within 90 days

#### 20.5.3 Compliance Metrics
- Security scan pass rate: > 95%
- Compliance audit results: Track quarterly
- Access review completion: 100% quarterly

### 20.6 Cost Metrics

#### 20.6.1 Infrastructure Costs
- Monthly cloud spend: Track and optimize
- Cost per deployment: Monitor trends
- Resource utilization efficiency: Optimize idle resources
- Reserved instance usage: Maximize savings

#### 20.6.2 Development Costs
- CI/CD pipeline costs: Monitor build minutes
- Test environment costs: Right-size environments
- Developer productivity: Track time to value

### 20.7 Reporting and Dashboards

#### 20.7.1 Executive Dashboard
- High-level KPIs
- Trend analysis
- Business impact metrics
- Cost overview

#### 20.7.2 Operational Dashboard
- Real-time metrics
- System health
- Recent deployments
- Active incidents

#### 20.7.3 Development Dashboard
- DORA metrics
- Build/deploy statistics
- Test coverage
- Code quality metrics

#### 20.7.4 Weekly Reports
- Deployment summary
- Incident report
- Performance trends
- Cost analysis

---

## 21. Continuous Improvement

### 21.1 Retrospectives and Reviews

#### 21.1.1 Sprint Retrospectives
**Frequency**: End of each sprint (2 weeks)

**Format:**
1. **What Went Well**
   - Successful deployments
   - Completed features
   - Team achievements

2. **What Could Be Improved**
   - Process bottlenecks
   - Technical debt
   - Communication issues

3. **Action Items**
   - Assign owners
   - Set deadlines
   - Track progress

**Tools:**
- Azure DevOps Boards for tracking
- Retrospective templates
- Voting on priorities

**Example Action Items:**
- Reduce build time by 20%
- Improve test coverage to 85%
- Automate manual deployment steps
- Document API endpoints

#### 21.1.2 Monthly Process Reviews
**Focus Areas:**
- DORA metrics analysis
- Deployment frequency trends
- Incident patterns
- Team velocity

**Participants:**
- Development team leads
- DevOps engineers
- Product managers
- QA leads

**Outputs:**
- Process improvement recommendations
- Tool evaluation
- Training needs assessment
- Resource allocation adjustments

#### 21.1.3 Quarterly Architecture Reviews
**Agenda:**
- System architecture assessment
- Technology stack evaluation
- Scalability analysis
- Security posture review
- Cost optimization opportunities

**Deliverables:**
- Architecture decision records (ADRs)
- Technology roadmap updates
- Migration plans
- Risk assessment

### 21.2 Feedback Loops

#### 21.2.1 User Feedback Collection
**Channels:**
- API usage analytics
- Support tickets analysis
- User surveys
- Beta testing feedback

**Process:**
1. Collect feedback from multiple sources
2. Categorize by priority and type
3. Analyze trends and patterns
4. Prioritize improvements
5. Implement changes
6. Communicate updates to users

**Tools:**
- Application Insights for usage data
- Support ticket system
- Survey tools
- Feedback forms in API documentation

#### 21.2.2 Performance Monitoring Feedback
**Continuous Monitoring:**
- Real-time performance metrics
- Alert on performance degradation
- Trend analysis
- Capacity planning

**Feedback Loop:**
1. Monitor performance metrics
2. Identify bottlenecks
3. Optimize code/infrastructure
4. Measure improvement
5. Document learnings

**Key Metrics:**
- Response times
- Error rates
- Resource utilization
- Throughput

#### 21.2.3 Error Tracking and Analysis
**Error Analysis Process:**
1. Collect error logs
2. Categorize errors
3. Identify root causes
4. Prioritize fixes
5. Implement solutions
6. Verify fixes

**Tools:**
- Application Insights
- Sentry (if integrated)
- Custom error tracking
- Log aggregation tools

**Error Categories:**
- Critical: Fix immediately
- High: Fix within 24 hours
- Medium: Fix within 1 week
- Low: Fix in next release

#### 21.2.4 Team Velocity Tracking
**Metrics:**
- Story points completed per sprint
- Features delivered per month
- Bug fixes per sprint
- Technical debt reduction

**Analysis:**
- Track velocity trends
- Identify blockers
- Measure improvement
- Forecast capacity

**Tools:**
- Azure DevOps Analytics
- Custom dashboards
- Velocity charts
- Burndown charts

### 21.3 Process Optimization

#### 21.3.1 Automation Opportunities
**Identify Manual Tasks:**
- Code reviews
- Testing
- Deployment steps
- Documentation updates
- Environment provisioning

**Automation Priorities:**
1. High-frequency tasks
2. Error-prone manual steps
3. Time-consuming processes
4. Repetitive work

**Examples:**
```yaml
# Automate code review with bots
- task: CodeReviewBot@1
  inputs:
    rules: 'security,performance,best-practices'

# Automate dependency updates
- task: Dependabot@1
  inputs:
    checkSchedule: 'daily'
```

#### 21.3.2 Deployment Time Optimization
**Current State Analysis:**
- Measure deployment times
- Identify bottlenecks
- Track improvement over time

**Optimization Strategies:**
- Parallelize stages
- Cache dependencies
- Optimize Docker builds
- Reduce approval wait times
- Use blue-green deployments

**Targets:**
- Build time: < 10 minutes
- Deployment time: < 5 minutes
- Total pipeline: < 15 minutes

#### 21.3.3 Test Coverage Improvement
**Current Coverage:**
- Measure baseline coverage
- Identify gaps
- Prioritize critical paths

**Improvement Plan:**
- Add unit tests for new code
- Increase integration test coverage
- Add E2E tests for critical flows
- Target: 85% overall coverage

**Tools:**
- Coverage.py for Python
- Codecov for reporting
- SonarQube for analysis

#### 21.3.4 Monitoring Enhancement
**Gaps Analysis:**
- Identify unmonitored areas
- Review alert effectiveness
- Assess dashboard usefulness

**Enhancements:**
- Add custom metrics
- Improve alerting rules
- Create new dashboards
- Implement log aggregation

### 21.4 Learning and Development

#### 21.4.1 Team Training
**Topics:**
- Azure DevOps best practices
- FastAPI advanced features
- Kubernetes operations
- Security best practices
- Performance optimization

**Format:**
- Internal workshops
- External training
- Conference attendance
- Online courses
- Pair programming sessions

#### 21.4.2 Knowledge Sharing
**Activities:**
- Tech talks
- Code reviews
- Documentation updates
- Runbook creation
- Post-mortem sharing

**Channels:**
- Team wiki
- Confluence pages
- Slack channels
- Monthly tech talks
- Blog posts

#### 21.4.3 Experimentation
**Encourage:**
- Proof of concepts
- Technology evaluations
- Process experiments
- Tool comparisons

**Process:**
1. Propose experiment
2. Get approval
3. Run experiment
4. Measure results
5. Share findings
6. Decide on adoption

### 21.5 Innovation and Experimentation

#### 21.5.1 Innovation Time
**Allocation:**
- 20% time for innovation
- Hackathons quarterly
- Innovation sprints

**Focus Areas:**
- New technologies
- Process improvements
- Tool evaluation
- Architecture enhancements

#### 21.5.2 A/B Testing
**Use Cases:**
- API endpoint versions
- Deployment strategies
- Performance optimizations
- Feature flags

**Process:**
1. Define hypothesis
2. Design experiment
3. Implement A/B test
4. Monitor results
5. Analyze data
6. Make decision

### 21.6 Continuous Improvement Metrics

#### 21.6.1 Improvement Tracking
**Metrics:**
- Number of improvements implemented
- Time saved per improvement
- Quality improvements
- Cost reductions

#### 21.6.2 Success Criteria
- Reduced deployment time by 30%
- Increased test coverage to 85%
- Reduced error rate by 50%
- Improved team velocity by 20%

#### 21.6.3 Regular Reviews
- Monthly improvement review
- Quarterly impact assessment
- Annual strategy review

---

## 22. Appendix

### 22.1 Useful Commands

#### 22.1.1 Azure CLI Commands

**Authentication and Account Management:**
```bash
# Login interactively
az login

# Login with service principal
az login --service-principal -u <app-id> -p <password> --tenant <tenant-id>

# List available subscriptions
az account list --output table

# Set active subscription
az account set --subscription "Subscription Name"

# Show current subscription
az account show
```

**Resource Group Management:**
```bash
# List resource groups
az group list --output table

# Create resource group
az group create --name rg-prod --location eastus

# Show resource group details
az group show --name rg-prod

# Delete resource group (careful!)
az group delete --name rg-prod --yes --no-wait
```

**Azure Container Registry (ACR):**
```bash
# Login to ACR
az acr login --name yourregistry

# List repositories
az acr repository list --name yourregistry --output table

# List tags for a repository
az acr repository show-tags --name yourregistry --repository inventory-api --output table

# Delete old images
az acr repository delete --name yourregistry --image inventory-api:old-tag

# Show ACR credentials
az acr credential show --name yourregistry
```

**Azure Kubernetes Service (AKS):**
```bash
# Get AKS credentials
az aks get-credentials --resource-group rg-prod --name aks-prod-cluster

# List AKS clusters
az aks list --output table

# Show cluster details
az aks show --resource-group rg-prod --name aks-prod-cluster

# Scale cluster
az aks scale --resource-group rg-prod --name aks-prod-cluster --node-count 5

# Upgrade cluster
az aks upgrade --resource-group rg-prod --name aks-prod-cluster --kubernetes-version 1.28.0

# Show cluster credentials
az aks get-credentials --resource-group rg-prod --name aks-prod-cluster --admin
```

**Azure App Service:**
```bash
# List web apps
az webapp list --output table

# Show web app details
az webapp show --name inventory-api-prod --resource-group rg-prod

# View logs
az webapp log tail --name inventory-api-prod --resource-group rg-prod

# Download logs
az webapp log download --name inventory-api-prod --resource-group rg-prod --log-file app-logs.zip

# Restart web app
az webapp restart --name inventory-api-prod --resource-group rg-prod

# Stop web app
az webapp stop --name inventory-api-prod --resource-group rg-prod

# Start web app
az webapp start --name inventory-api-prod --resource-group rg-prod
```

**Azure Key Vault:**
```bash
# List key vaults
az keyvault list --output table

# List secrets
az keyvault secret list --vault-name inventory-kv-prod --output table

# Get secret value
az keyvault secret show --vault-name inventory-kv-prod --name database-password --query value -o tsv

# Set secret
az keyvault secret set --vault-name inventory-kv-prod --name new-secret --value "secret-value"
```

**Azure SQL Database:**
```bash
# List SQL servers
az sql server list --output table

# List databases
az sql db list --resource-group rg-prod --server inventory-sql-server --output table

# Show database details
az sql db show --resource-group rg-prod --server inventory-sql-server --name inventory-db

# Create database backup
az sql db export --resource-group rg-prod --server inventory-sql-server --name inventory-db \
  --admin-user admin --admin-password password \
  --storage-key-type StorageAccessKey \
  --storage-key <storage-key> \
  --storage-uri https://storageaccount.blob.core.windows.net/backups/inventory-db.bacpac
```

**Azure DevOps:**
```bash
# List pipelines
az pipelines list --organization https://dev.azure.com/YourOrg --project InventoryManagementSystem

# Show pipeline runs
az pipelines runs list --organization https://dev.azure.com/YourOrg --project InventoryManagementSystem

# Trigger pipeline
az pipelines run --name CI-Pipeline --organization https://dev.azure.com/YourOrg --project InventoryManagementSystem

# Show pipeline run details
az pipelines runs show --id <run-id> --organization https://dev.azure.com/YourOrg --project InventoryManagementSystem
```

#### 22.1.2 Kubernetes Commands

**Cluster Information:**
```bash
# Get cluster info
kubectl cluster-info

# Get nodes
kubectl get nodes -o wide

# Describe node
kubectl describe node <node-name>

# Get cluster version
kubectl version --output=yaml
```

**Namespace Management:**
```bash
# List namespaces
kubectl get namespaces

# Create namespace
kubectl create namespace production

# Switch namespace context
kubectl config set-context --current --namespace=production

# Delete namespace (careful!)
kubectl delete namespace production
```

**Pod Management:**
```bash
# Get pods
kubectl get pods -n production

# Get pods with more details
kubectl get pods -n production -o wide

# Describe pod
kubectl describe pod <pod-name> -n production

# View pod logs
kubectl logs <pod-name> -n production

# Follow logs
kubectl logs -f <pod-name> -n production

# View logs from all pods in deployment
kubectl logs -f deployment/inventory-api -n production

# View logs from previous container instance
kubectl logs <pod-name> -n production --previous

# Exec into pod
kubectl exec -it <pod-name> -n production -- /bin/bash

# Execute command in pod
kubectl exec <pod-name> -n production -- env

# Delete pod
kubectl delete pod <pod-name> -n production

# Get pod YAML
kubectl get pod <pod-name> -n production -o yaml
```

**Deployment Management:**
```bash
# Get deployments
kubectl get deployments -n production

# Describe deployment
kubectl describe deployment inventory-api -n production

# Scale deployment
kubectl scale deployment inventory-api --replicas=5 -n production

# Update deployment image
kubectl set image deployment/inventory-api inventory-api=yourregistry.azurecr.io/inventory-api:v1.2.0 -n production

# Rollout status
kubectl rollout status deployment/inventory-api -n production

# Rollout history
kubectl rollout history deployment/inventory-api -n production

# Rollback to previous version
kubectl rollout undo deployment/inventory-api -n production

# Rollback to specific revision
kubectl rollout undo deployment/inventory-api --to-revision=2 -n production

# Pause rollout
kubectl rollout pause deployment/inventory-api -n production

# Resume rollout
kubectl rollout resume deployment/inventory-api -n production
```

**Service Management:**
```bash
# Get services
kubectl get services -n production

# Describe service
kubectl describe service inventory-api -n production

# Port forward to service
kubectl port-forward svc/inventory-api 8000:8000 -n production

# Get service endpoints
kubectl get endpoints inventory-api -n production
```

**ConfigMap and Secrets:**
```bash
# Get configmaps
kubectl get configmaps -n production

# Describe configmap
kubectl describe configmap app-config -n production

# Get configmap YAML
kubectl get configmap app-config -n production -o yaml

# Get secrets
kubectl get secrets -n production

# Describe secret
kubectl describe secret app-secret -n production

# Get secret value (base64 encoded)
kubectl get secret app-secret -n production -o jsonpath='{.data.password}' | base64 -d
```

**Events and Debugging:**
```bash
# Get events
kubectl get events -n production --sort-by='.lastTimestamp'

# Watch resources
kubectl get pods -n production -w

# Top resources
kubectl top pods -n production
kubectl top nodes

# Get resource usage
kubectl top pod <pod-name> -n production --containers
```

**Resource Queries:**
```bash
# Get all resources
kubectl get all -n production

# Get resources with labels
kubectl get pods -l app=inventory-api -n production

# Get resources in YAML format
kubectl get deployment inventory-api -n production -o yaml

# Get resources in JSON format
kubectl get deployment inventory-api -n production -o json
```

#### 22.1.3 Docker Commands

**Image Management:**
```bash
# Build image
docker build -t inventory-api:latest .

# Build with specific Dockerfile
docker build -f Dockerfile.prod -t inventory-api:prod .

# Build with build args
docker build --build-arg PYTHON_VERSION=3.11 -t inventory-api:latest .

# List images
docker images

# Remove image
docker rmi inventory-api:latest

# Remove unused images
docker image prune -a

# Inspect image
docker inspect inventory-api:latest

# Show image history
docker history inventory-api:latest
```

**Container Management:**
```bash
# Run container
docker run -p 8000:8000 inventory-api:latest

# Run in detached mode
docker run -d -p 8000:8000 --name inventory-api inventory-api:latest

# Run with environment variables
docker run -e DATABASE_URL=postgresql://... -p 8000:8000 inventory-api:latest

# Run with volume mount
docker run -v $(pwd):/app -p 8000:8000 inventory-api:latest

# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop inventory-api

# Start container
docker start inventory-api

# Restart container
docker restart inventory-api

# Remove container
docker rm inventory-api

# Remove running container
docker rm -f inventory-api

# View container logs
docker logs inventory-api

# Follow logs
docker logs -f inventory-api

# View last N lines
docker logs --tail 100 inventory-api

# Exec into container
docker exec -it inventory-api /bin/bash

# Execute command in container
docker exec inventory-api env
```

**Azure Container Registry:**
```bash
# Login to ACR
az acr login --name yourregistry

# Tag image for ACR
docker tag inventory-api:latest yourregistry.azurecr.io/inventory-api:latest

# Push to ACR
docker push yourregistry.azurecr.io/inventory-api:latest

# Pull from ACR
docker pull yourregistry.azurecr.io/inventory-api:latest

# List ACR repositories
az acr repository list --name yourregistry

# Show ACR repository tags
az acr repository show-tags --name yourregistry --repository inventory-api
```

**Docker Compose:**
```bash
# Start services
docker-compose up

# Start in detached mode
docker-compose up -d

# Stop services
docker-compose stop

# Down services (stop and remove)
docker-compose down

# View logs
docker-compose logs

# Follow logs
docker-compose logs -f

# Scale services
docker-compose up -d --scale inventory-api=3

# Build images
docker-compose build

# Rebuild images
docker-compose build --no-cache
```

**Docker System:**
```bash
# System information
docker info

# System disk usage
docker system df

# Prune system
docker system prune -a

# Show Docker version
docker version
```

#### 22.1.4 Python and FastAPI Commands

**Python Environment:**
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment (Windows)
venv\Scripts\activate

# Activate virtual environment (Linux/Mac)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install development dependencies
pip install -r requirements-dev.txt

# Freeze dependencies
pip freeze > requirements.txt

# Check for outdated packages
pip list --outdated

# Upgrade package
pip install --upgrade package-name
```

**FastAPI Development:**
```bash
# Run development server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# Run with specific workers
uvicorn app.main:app --workers 4 --host 0.0.0.0 --port 8000

# Run with SSL
uvicorn app.main:app --ssl-keyfile key.pem --ssl-certfile cert.pem

# Generate OpenAPI schema
python -c "from app.main import app; import json; print(json.dumps(app.openapi()))"
```

**Testing:**
```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=app --cov-report=html

# Run specific test file
pytest tests/unit/test_inventory_service.py

# Run specific test
pytest tests/unit/test_inventory_service.py::test_add_item

# Run with verbose output
pytest -v

# Run with output
pytest -s

# Run in parallel
pytest -n auto
```

**Code Quality:**
```bash
# Run pylint
pylint app/ --rcfile=.pylintrc

# Run flake8
flake8 app/ --config=.flake8

# Run black (format)
black app/

# Check with black
black --check app/

# Run mypy (type checking)
mypy app/

# Run bandit (security)
bandit -r app/
```

**Database Migrations:**
```bash
# Create migration
alembic revision --autogenerate -m "Add inventory table"

# Apply migrations
alembic upgrade head

# Rollback migration
alembic downgrade -1

# Show migration history
alembic history

# Show current revision
alembic current
```

#### 22.1.5 Git Commands

**Basic Operations:**
```bash
# Clone repository
git clone https://dev.azure.com/YourOrg/InventoryManagementSystem/_git/inventory-api

# Check status
git status

# Add files
git add .

# Commit changes
git commit -m "feat: add inventory endpoint"

# Push changes
git push origin feature/inventory-api

# Pull changes
git pull origin develop

# Fetch changes
git fetch origin
```

**Branch Management:**
```bash
# List branches
git branch -a

# Create branch
git checkout -b feature/new-feature

# Switch branch
git checkout develop

# Delete branch
git branch -d feature/old-feature

# Delete remote branch
git push origin --delete feature/old-feature
```

**Merge and Rebase:**
```bash
# Merge branch
git merge feature/new-feature

# Rebase branch
git rebase develop

# Interactive rebase
git rebase -i HEAD~3

# Abort rebase
git rebase --abort
```

**Stash:**
```bash
# Stash changes
git stash

# List stashes
git stash list

# Apply stash
git stash apply

# Drop stash
git stash drop
```

**Tags:**
```bash
# Create tag
git tag -a v1.2.0 -m "Release version 1.2.0"

# Push tags
git push origin --tags

# List tags
git tag

# Delete tag
git tag -d v1.2.0
git push origin --delete v1.2.0
```

### 22.2 Reference Links

#### 22.2.1 Azure Documentation
- [Azure DevOps Documentation](https://docs.microsoft.com/azure/devops/)
- [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/)
- [Azure Container Registry](https://docs.microsoft.com/azure/container-registry/)
- [Azure App Service](https://docs.microsoft.com/azure/app-service/)
- [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/)
- [Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/database/)
- [Azure Application Insights](https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview)
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/)

#### 22.2.2 Technology Documentation
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Python Documentation](https://docs.python.org/3/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Redis Documentation](https://redis.io/documentation)
- [SQLAlchemy Documentation](https://docs.sqlalchemy.org/)
- [Pydantic Documentation](https://docs.pydantic.dev/)
- [Alembic Documentation](https://alembic.sqlalchemy.org/)

#### 22.2.3 CI/CD and DevOps
- [Azure Pipelines YAML Schema](https://docs.microsoft.com/azure/devops/pipelines/yaml-schema)
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Ansible Azure Modules](https://docs.ansible.com/ansible/latest/collections/azure/azcollection/)

#### 22.2.4 Testing and Quality
- [pytest Documentation](https://docs.pytest.org/)
- [pytest-asyncio](https://pytest-asyncio.readthedocs.io/)
- [Coverage.py](https://coverage.readthedocs.io/)
- [Pylint Documentation](https://pylint.pycqa.org/)
- [Black Code Formatter](https://black.readthedocs.io/)
- [mypy Type Checker](https://mypy.readthedocs.io/)

#### 22.2.5 Security
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Bandit Security Linter](https://bandit.readthedocs.io/)
- [Trivy Scanner](https://aquasecurity.github.io/trivy/)
- [Azure Security Center](https://docs.microsoft.com/azure/security-center/)

### 22.3 Contact Information

#### 22.3.1 Team Contacts
- **DevOps Team**: devops@company.com
- **Development Team**: dev@company.com
- **QA Team**: qa@company.com
- **Architecture Team**: architecture@company.com
- **Security Team**: security@company.com

#### 22.3.2 On-Call Information
- **Primary On-Call**: +1-XXX-XXX-XXXX
- **Secondary On-Call**: +1-XXX-XXX-XXXX
- **Escalation**: +1-XXX-XXX-XXXX
- **On-Call Schedule**: [PagerDuty Link]

#### 22.3.3 Communication Channels
- **Slack Channel**: #inventory-devops
- **Teams Channel**: Inventory Management System
- **Email Distribution List**: inventory-team@company.com
- **Emergency Contact**: emergency@company.com

#### 22.3.4 Office Locations
- **Headquarters**: 123 Main St, City, State, ZIP
- **Development Office**: 456 Dev Ave, City, State, ZIP
- **Data Center**: Azure East US Region

### 22.4 Glossary

**Terms and Definitions:**
- **CI/CD**: Continuous Integration/Continuous Deployment
- **DORA**: DevOps Research and Assessment (metrics)
- **MTTR**: Mean Time to Recovery
- **RTO**: Recovery Time Objective
- **RPO**: Recovery Point Objective
- **SLA**: Service Level Agreement
- **ACR**: Azure Container Registry
- **AKS**: Azure Kubernetes Service
- **HPA**: Horizontal Pod Autoscaler
- **ADR**: Architecture Decision Record
- **IaC**: Infrastructure as Code
- **RBAC**: Role-Based Access Control
- **WAF**: Web Application Firewall
- **CDN**: Content Delivery Network
- **API**: Application Programming Interface
- **REST**: Representational State Transfer
- **JWT**: JSON Web Token
- **OAuth2**: Open Authorization 2.0
- **SQL**: Structured Query Language
- **NoSQL**: Not Only SQL
- **ORM**: Object-Relational Mapping
- **CRUD**: Create, Read, Update, Delete
- **E2E**: End-to-End
- **p95/p99**: 95th/99th percentile
- **SRE**: Site Reliability Engineering
- **SLI**: Service Level Indicator
- **SLO**: Service Level Objective
- **SLI**: Service Level Indicator

### 22.5 Quick Reference Cards

#### 22.5.1 Pipeline Status Check
```bash
# Check pipeline status
az pipelines runs list --top 5

# View latest run
az pipelines runs show --id $(az pipelines runs list --top 1 --query "[0].id" -o tsv)
```

#### 22.5.2 Health Check Commands
```bash
# Check API health
curl https://api.company.com/health

# Check Kubernetes pods
kubectl get pods -n production

# Check service endpoints
kubectl get endpoints -n production

# Check database connectivity
psql $DATABASE_URL -c "SELECT 1"
```

#### 22.5.3 Emergency Rollback
```bash
# Kubernetes rollback
kubectl rollout undo deployment/inventory-api -n production

# Azure App Service rollback
az webapp deployment slot swap --resource-group rg-prod \
  --name inventory-api-prod --slot staging --target-slot production
```

### 22.6 Troubleshooting Quick Reference

**Common Issues:**
1. **Pipeline fails**: Check logs, verify dependencies, test locally
2. **Deployment fails**: Check permissions, verify resources, review logs
3. **Pod not starting**: Check events, describe pod, review logs
4. **Database connection**: Verify connection string, check firewall rules
5. **High latency**: Check database queries, review caching, monitor resources

---

## 23. Checklists and Templates

### 23.1 Pre-Deployment Checklist

#### 23.1.1 Development Checklist
- [ ] All tests passing locally
- [ ] Code reviewed and approved
- [ ] No merge conflicts
- [ ] Branch is up to date with develop/main
- [ ] Documentation updated
- [ ] Changelog updated
- [ ] Version numbers updated
- [ ] No secrets in code
- [ ] Environment variables documented
- [ ] Migration scripts tested

#### 23.1.2 QA Checklist
- [ ] All test cases executed
- [ ] Regression testing completed
- [ ] Performance testing done
- [ ] Security scan passed
- [ ] Browser compatibility checked (if applicable)
- [ ] API documentation verified
- [ ] Test data prepared
- [ ] Test environment ready

#### 23.1.3 Production Deployment Checklist
- [ ] Staging deployment successful
- [ ] Smoke tests passed
- [ ] Performance baseline met
- [ ] Rollback plan prepared
- [ ] Team notified of deployment
- [ ] On-call engineer available
- [ ] Database backup completed
- [ ] Monitoring dashboards ready
- [ ] Change management ticket approved
- [ ] Post-deployment verification plan ready

### 23.2 Incident Response Checklist

#### 23.2.1 Detection Phase
- [ ] Incident detected and logged
- [ ] Severity assessed
- [ ] On-call engineer notified
- [ ] Incident channel created
- [ ] Initial impact assessment done

#### 23.2.2 Response Phase
- [ ] Incident response team assembled
- [ ] Status page updated
- [ ] Root cause investigation started
- [ ] Mitigation steps implemented
- [ ] Communication sent to stakeholders

#### 23.2.3 Resolution Phase
- [ ] Issue resolved
- [ ] Service restored
- [ ] Verification completed
- [ ] Monitoring confirmed normal
- [ ] Incident closed

#### 23.2.4 Post-Incident Phase
- [ ] Post-mortem scheduled
- [ ] Root cause documented
- [ ] Action items created
- [ ] Process improvements identified
- [ ] Lessons learned shared

### 23.3 Code Review Checklist

#### 23.3.1 Code Quality
- [ ] Code follows style guide
- [ ] Type hints used
- [ ] Docstrings present
- [ ] No hardcoded values
- [ ] Error handling appropriate
- [ ] Logging implemented
- [ ] No commented-out code
- [ ] Code is readable and maintainable

#### 23.3.2 Testing
- [ ] Unit tests written
- [ ] Integration tests added (if needed)
- [ ] Test coverage adequate
- [ ] Edge cases covered
- [ ] Tests are meaningful

#### 23.3.3 Security
- [ ] No secrets in code
- [ ] Input validation implemented
- [ ] SQL injection prevented
- [ ] Authentication/authorization correct
- [ ] Dependencies updated
- [ ] Security best practices followed

#### 23.3.4 Performance
- [ ] Database queries optimized
- [ ] Caching used appropriately
- [ ] No N+1 queries
- [ ] Pagination implemented (if needed)
- [ ] Resource usage considered

### 23.4 Release Checklist

#### 23.4.1 Pre-Release
- [ ] All features completed
- [ ] All bugs fixed
- [ ] Documentation updated
- [ ] Release notes prepared
- [ ] Version tagged in Git
- [ ] Changelog updated
- [ ] API version incremented (if breaking changes)

#### 23.4.2 Release
- [ ] Release branch created
- [ ] Final testing completed
- [ ] Production deployment successful
- [ ] Smoke tests passed
- [ ] Monitoring verified
- [ ] Announcement sent

#### 23.4.3 Post-Release
- [ ] Monitor for issues
- [ ] Collect feedback
- [ ] Update metrics
- [ ] Document learnings
- [ ] Plan next release

### 23.5 Security Audit Checklist

#### 23.5.1 Code Security
- [ ] Dependency vulnerabilities scanned
- [ ] Secrets audit completed
- [ ] Code security scan passed
- [ ] Container scan passed
- [ ] OWASP Top 10 reviewed

#### 23.5.2 Infrastructure Security
- [ ] Network security groups configured
- [ ] Private endpoints used
- [ ] WAF rules configured
- [ ] DDoS protection enabled
- [ ] SSL/TLS certificates valid

#### 23.5.3 Access Control
- [ ] RBAC implemented
- [ ] Least privilege principle followed
- [ ] Service principals reviewed
- [ ] Key Vault access audited
- [ ] Access logs reviewed

### 23.6 Performance Testing Checklist

#### 23.6.1 Test Preparation
- [ ] Test environment ready
- [ ] Test data prepared
- [ ] Load testing tools configured
- [ ] Baseline metrics captured
- [ ] Test scenarios defined

#### 23.6.2 Test Execution
- [ ] Load tests executed
- [ ] Stress tests executed
- [ ] Spike tests executed
- [ ] Endurance tests executed
- [ ] Results documented

#### 23.6.3 Analysis
- [ ] Performance metrics analyzed
- [ ] Bottlenecks identified
- [ ] Optimization opportunities found
- [ ] Recommendations documented
- [ ] Action plan created

---

## 24. Sample Scripts and Utilities

### 24.1 Health Check Script

```python
#!/usr/bin/env python3
"""Health check script for inventory API."""
import requests
import sys
import os
from datetime import datetime

def check_api_health(base_url: str) -> bool:
    """Check API health endpoint."""
    try:
        response = requests.get(f"{base_url}/health", timeout=5)
        if response.status_code == 200:
            print(f"✓ API health check passed: {response.json()}")
            return True
        else:
            print(f"✗ API health check failed: {response.status_code}")
            return False
    except Exception as e:
        print(f"✗ API health check error: {e}")
        return False

def check_database_health(database_url: str) -> bool:
    """Check database connectivity."""
    try:
        import psycopg2
        conn = psycopg2.connect(database_url)
        cursor = conn.cursor()
        cursor.execute("SELECT 1")
        cursor.close()
        conn.close()
        print("✓ Database health check passed")
        return True
    except Exception as e:
        print(f"✗ Database health check failed: {e}")
        return False

def check_redis_health(redis_url: str) -> bool:
    """Check Redis connectivity."""
    try:
        import redis
        r = redis.from_url(redis_url)
        r.ping()
        print("✓ Redis health check passed")
        return True
    except Exception as e:
        print(f"✗ Redis health check failed: {e}")
        return False

def main():
    """Run all health checks."""
    env = os.getenv("ENVIRONMENT", "dev")
    base_url = os.getenv("API_URL", "http://localhost:8000")
    database_url = os.getenv("DATABASE_URL")
    redis_url = os.getenv("REDIS_URL")
    
    print(f"Running health checks for {env} environment...")
    print(f"Timestamp: {datetime.utcnow().isoformat()}")
    print("-" * 50)
    
    results = []
    results.append(check_api_health(base_url))
    
    if database_url:
        results.append(check_database_health(database_url))
    
    if redis_url:
        results.append(check_redis_health(redis_url))
    
    print("-" * 50)
    if all(results):
        print("✓ All health checks passed")
        sys.exit(0)
    else:
        print("✗ Some health checks failed")
        sys.exit(1)

if __name__ == "__main__":
    main()
```

### 24.2 Database Migration Script

```python
#!/usr/bin/env python3
"""Database migration script with backup."""
import os
import sys
import subprocess
from datetime import datetime

def run_migration(env: str, backup: bool = False):
    """Run database migrations."""
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("Error: DATABASE_URL not set")
        sys.exit(1)
    
    if backup:
        print("Creating database backup...")
        backup_file = f"backup_{env}_{datetime.utcnow().strftime('%Y%m%d_%H%M%S')}.sql"
        subprocess.run([
            "pg_dump", database_url, "-f", backup_file
        ], check=True)
        print(f"Backup created: {backup_file}")
    
    print("Running migrations...")
    result = subprocess.run(["alembic", "upgrade", "head"], check=False)
    
    if result.returncode == 0:
        print("✓ Migrations completed successfully")
        sys.exit(0)
    else:
        print("✗ Migration failed")
        if backup:
            print(f"Restore from backup: psql {database_url} < {backup_file}")
        sys.exit(1)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", required=True, choices=["dev", "qa", "staging", "prod"])
    parser.add_argument("--backup", action="store_true")
    args = parser.parse_args()
    
    run_migration(args.env, args.backup)
```

### 24.3 Deployment Verification Script

```python
#!/usr/bin/env python3
"""Post-deployment verification script."""
import requests
import time
import sys

def verify_deployment(base_url: str, max_retries: int = 10):
    """Verify deployment is successful."""
    endpoints = [
        "/health",
        "/api/v1/inventory",
        "/docs"
    ]
    
    for attempt in range(max_retries):
        print(f"Attempt {attempt + 1}/{max_retries}...")
        all_passed = True
        
        for endpoint in endpoints:
            try:
                response = requests.get(f"{base_url}{endpoint}", timeout=5)
                if response.status_code == 200:
                    print(f"  ✓ {endpoint}")
                else:
                    print(f"  ✗ {endpoint}: {response.status_code}")
                    all_passed = False
            except Exception as e:
                print(f"  ✗ {endpoint}: {e}")
                all_passed = False
        
        if all_passed:
            print("✓ Deployment verification successful")
            return True
        
        if attempt < max_retries - 1:
            print("Waiting 10 seconds before retry...")
            time.sleep(10)
    
    print("✗ Deployment verification failed")
    return False

if __name__ == "__main__":
    base_url = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:8000"
    success = verify_deployment(base_url)
    sys.exit(0 if success else 1)
```

### 24.4 Log Analysis Script

```python
#!/usr/bin/env python3
"""Analyze application logs for errors."""
import re
import sys
from collections import Counter
from datetime import datetime

def analyze_logs(log_file: str):
    """Analyze log file for errors and patterns."""
    error_pattern = re.compile(r'ERROR|CRITICAL|Exception|Traceback', re.IGNORECASE)
    errors = []
    
    with open(log_file, 'r') as f:
        for line_num, line in enumerate(f, 1):
            if error_pattern.search(line):
                errors.append((line_num, line.strip()))
    
    print(f"Total errors found: {len(errors)}")
    print("-" * 50)
    
    if errors:
        print("Error Summary:")
        error_types = Counter()
        for _, error in errors[:20]:  # Show first 20
            print(f"  {error}")
            # Extract error type
            if "Exception" in error:
                error_type = error.split(":")[0] if ":" in error else "Unknown"
                error_types[error_type] += 1
        
        print("\nError Type Distribution:")
        for error_type, count in error_types.most_common():
            print(f"  {error_type}: {count}")
    else:
        print("No errors found in logs")

if __name__ == "__main__":
    log_file = sys.argv[1] if len(sys.argv) > 1 else "app.log"
    analyze_logs(log_file)
```

---

## 25. Complete Project Flow - End-to-End Lifecycle

### 25.1 Project Initiation Phase

#### 25.1.1 Planning and Setup (Week 1-2)

**Step 1: Project Kickoff**
```
1. Stakeholder Meeting
   - Define project scope
   - Identify team members
   - Set timelines and milestones
   - Establish communication channels

2. Requirements Gathering
   - Business requirements
   - Technical requirements
   - Non-functional requirements
   - Success criteria

3. Architecture Design
   - System architecture
   - Technology stack selection
   - Infrastructure design
   - Security architecture
```

**Step 2: Azure DevOps Setup**
```
1. Create Organization
   - Set up Azure DevOps organization
   - Configure billing
   - Set up user accounts

2. Create Project
   - Project: InventoryManagementSystem
   - Process: Agile/Scrum
   - Version Control: Git
   - Work Items: Enabled

3. Configure Service Connections
   - Azure Resource Manager
   - Azure Container Registry
   - GitHub (if applicable)
   - Service Principal creation
```

**Step 3: Repository Initialization**
```
1. Create Repository Structure
   - Initialize Git repository
   - Create branch structure (main, develop)
   - Set up .gitignore
   - Add initial README

2. Set Up Project Structure
   - Create directory structure
   - Add configuration files
   - Set up development environment
   - Initialize Python project
```

### 25.2 Development Phase

#### 25.2.1 Sprint Planning (Every 2 Weeks)

**Sprint Planning Process:**
```
Day 1 Morning (4 hours):
├── Review Product Backlog
├── Prioritize User Stories
├── Estimate Story Points
├── Create Sprint Backlog
└── Define Sprint Goal

Day 1 Afternoon:
├── Break down stories into tasks
├── Assign tasks to team members
├── Set up work items in Azure DevOps
└── Create feature branches
```

**Example Sprint Backlog:**
```
Sprint 1 (2 weeks):
├── Epic: Core Inventory Management
│   ├── Story: Create Product API (8 points)
│   ├── Story: Create Inventory API (8 points)
│   ├── Story: Database Schema Design (5 points)
│   └── Story: Authentication Setup (5 points)
└── Epic: CI/CD Pipeline
    ├── Story: Set up CI Pipeline (8 points)
    └── Story: Set up CD Pipeline (8 points)
```

#### 25.2.2 Daily Development Workflow

**Daily Standup (15 minutes):**
```
1. What did I complete yesterday?
2. What will I work on today?
3. Are there any blockers?
4. Update work item status
```

**Development Cycle:**
```
1. Pull Latest Changes
   git checkout develop
   git pull origin develop

2. Create Feature Branch
   git checkout -b feature/inventory-api

3. Develop Feature
   - Write code
   - Write tests
   - Run tests locally
   - Commit changes

4. Push and Create Pull Request
   git push origin feature/inventory-api
   # Create PR in Azure DevOps

5. Code Review
   - Team reviews code
   - Address feedback
   - Update PR

6. Merge to Develop
   - PR approved
   - CI pipeline passes
   - Merge to develop
   - Delete feature branch
```

### 25.3 CI/CD Pipeline Flow

#### 25.3.1 Complete CI Pipeline Flow

**Trigger: Developer pushes code to feature branch**

```
┌─────────────────────────────────────────────────────────────┐
│                    CI Pipeline Triggered                    │
│              (Push to feature/develop/main)                   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    Stage 1: Build                            │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Checkout Code                                      │   │
│  │ 2. Set Python Version (3.11)                         │   │
│  │ 3. Cache Dependencies                                │   │
│  │ 4. Install Dependencies                              │   │
│  │    - requirements.txt                                 │   │
│  │    - requirements-dev.txt                             │   │
│  │ 5. Code Quality Checks                                │   │
│  │    - Pylint                                           │   │
│  │    - Flake8                                           │   │
│  │    - Black (format check)                             │   │
│  │ 6. Build Docker Image                                │   │
│  │ 7. Push to ACR                                        │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│              Stage 2: Security Scanning                     │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Container Scanning (Trivy)                        │   │
│  │    - Scan Docker image                                │   │
│  │    - Check for vulnerabilities                        │   │
│  │ 2. Dependency Scanning (WhiteSource)                   │   │
│  │    - Scan Python dependencies                        │   │
│  │ 3. Code Scanning (Bandit)                            │   │
│  │    - Security linting                                │   │
│  │ 4. Publish Security Results                          │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│            Stage 3: Unit Testing                             │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Run Unit Tests                                     │   │
│  │    - pytest tests/unit/                               │   │
│  │ 2. Generate Coverage Report                           │   │
│  │    - Coverage.py                                     │   │
│  │ 3. Publish Test Results                              │   │
│  │ 4. Publish Coverage Report                             │   │
│  │ 5. Check Coverage Threshold (80%)                      │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│         Stage 4: Integration Testing                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Start Test Services                               │   │
│  │    - PostgreSQL container                            │   │
│  │    - Redis container                                 │   │
│  │ 2. Run Integration Tests                             │   │
│  │    - pytest tests/integration/                       │   │
│  │ 3. Publish Integration Test Results                   │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│         Stage 5: Performance Testing                         │
│              (Only for main branch)                          │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Run Load Tests (Locust)                            │   │
│  │    - 100 users, 10 spawn rate                        │   │
│  │ 2. Generate Performance Report                        │   │
│  │ 3. Check Performance Baselines                        │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │  CI Complete  │
                    │  Artifacts    │
                    │  Published    │
                    └───────────────┘
```

#### 25.3.2 Complete CD Pipeline Flow

**Trigger: CI Pipeline completes successfully on develop/main**

```
┌─────────────────────────────────────────────────────────────┐
│              CD Pipeline Triggered                           │
│         (CI completes on develop/main branch)                │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│         Stage 1: Deploy to Development                      │
│              (Auto-deploy from develop)                     │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Download Artifacts                                 │   │
│  │ 2. Get AKS Credentials                              │   │
│  │ 3. Update Kubernetes Deployment                      │   │
│  │    kubectl set image deployment/inventory-api        │   │
│  │ 4. Wait for Rollout                                  │   │
│  │ 5. Run Health Checks                                 │   │
│  │ 6. Run Database Migrations                           │   │
│  │ 7. Verify Deployment                                │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│         Stage 2: Deploy to QA                                │
│              (Manual Approval Required)                      │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Manual Approval Gate                              │   │
│  │    - Notify QA team                                  │   │
│  │    - Wait for approval                               │   │
│  │ 2. Deploy to QA Environment                          │   │
│  │ 3. Run E2E Tests                                     │   │
│  │ 4. Notify QA Team                                    │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│         Stage 3: Deploy to Staging                           │
│              (Manual Approval Required)                      │
│              (Only from main branch)                         │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Manual Approval Gate                              │   │
│  │    - Notify DevOps team                              │   │
│  │ 2. Deploy to Staging                                 │   │
│  │ 3. Run Smoke Tests                                   │   │
│  │ 4. Performance Baseline Check                         │   │
│  │ 5. Final Validation                                  │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│         Stage 4: Deploy to Production                        │
│              (Canary Deployment)                             │
│              (Manual Approval Required)                      │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Manual Approval Gate                              │   │
│  │    - Notify DevOps Lead & CTO                        │   │
│  │ 2. Canary Deployment                                 │   │
│  │    - Deploy 10% traffic                              │   │
│  │    - Monitor for 10 minutes                          │   │
│  │    - Deploy 25% traffic                              │   │
│  │    - Monitor for 10 minutes                          │   │
│  │    - Deploy 50% traffic                              │   │
│  │    - Monitor for 10 minutes                          │   │
│  │    - Deploy 100% traffic                             │   │
│  │ 3. Run Production Health Checks                       │   │
│  │ 4. Run Database Migrations (with backup)             │   │
│  │ 5. Verify Deployment                                 │   │
│  │ 6. Monitor for 30 minutes                             │   │
│  │ 7. Notify Stakeholders                                │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │  Production   │
                    │  Deployed     │
                    │  Successfully │
                    └───────────────┘
```

### 25.4 Complete Development Lifecycle Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    PROJECT LIFECYCLE FLOW                        │
└─────────────────────────────────────────────────────────────────┘

PHASE 1: PLANNING & SETUP
├── Week 1-2: Project Initiation
│   ├── Stakeholder meetings
│   ├── Requirements gathering
│   ├── Architecture design
│   └── Team formation
│
└── Week 2-3: Infrastructure Setup
    ├── Azure DevOps organization setup
    ├── Repository initialization
    ├── CI/CD pipeline creation
    └── Development environment setup

PHASE 2: DEVELOPMENT (Sprint 1)
├── Week 3-4: Core Features
│   ├── Database schema design
│   ├── Authentication implementation
│   ├── Product API development
│   └── Basic CI pipeline setup
│
└── Week 5-6: Inventory Features
    ├── Inventory API development
    ├── Unit tests writing
    ├── Integration tests
    └── Code reviews

PHASE 3: TESTING & QA (Sprint 2)
├── Week 7-8: Testing Phase
│   ├── Unit test completion
│   ├── Integration test completion
│   ├── E2E test development
│   └── Performance testing setup
│
└── Week 9-10: QA Testing
    ├── QA environment deployment
    ├── Manual testing
    ├── Bug fixes
    └── Test case execution

PHASE 4: STAGING & PRE-PRODUCTION (Sprint 3)
├── Week 11-12: Staging Deployment
│   ├── Staging environment setup
│   ├── Production-like testing
│   ├── Performance testing
│   └── Security testing
│
└── Week 13-14: Pre-Production
    ├── Final bug fixes
    ├── Documentation completion
    ├── Runbook creation
    └── Team training

PHASE 5: PRODUCTION DEPLOYMENT
├── Week 15: Production Deployment
│   ├── Production environment setup
│   ├── Database migration planning
│   ├── Deployment runbook review
│   └── Go-live preparation
│
└── Week 16: Go-Live
    ├── Production deployment
    ├── Monitoring setup
    ├── Post-deployment verification
    └── Support handover

PHASE 6: POST-PRODUCTION
├── Week 17+: Maintenance & Support
│   ├── Monitoring and alerting
│   ├── Bug fixes and patches
│   ├── Performance optimization
│   └── Feature enhancements
│
└── Ongoing: Continuous Improvement
    ├── Sprint retrospectives
    ├── Process improvements
    ├── Technology updates
    └── Team learning
```

### 25.5 Detailed Module Explanations

#### 25.5.1 Module 23: Checklists and Templates - Detailed Explanation

**Purpose:**
The Checklists and Templates module provides standardized procedures and verification steps to ensure consistency, quality, and completeness across all project activities. These checklists serve as:

1. **Quality Gates**: Ensure nothing is missed before moving to next phase
2. **Standardization**: Consistent processes across team members
3. **Risk Mitigation**: Prevent common mistakes and oversights
4. **Documentation**: Record of what was checked and when
5. **Training Tool**: Onboarding new team members

**Pre-Deployment Checklist Explained:**

**Development Checklist:**
- **All tests passing locally**: Ensures code works before CI pipeline
- **Code reviewed and approved**: Peer review catches bugs early
- **No merge conflicts**: Prevents integration issues
- **Branch up to date**: Ensures latest code is included
- **Documentation updated**: Maintains knowledge base
- **Changelog updated**: Tracks what changed and why
- **Version numbers updated**: Proper versioning for releases
- **No secrets in code**: Security best practice
- **Environment variables documented**: Helps with deployment
- **Migration scripts tested**: Prevents database issues

**QA Checklist Explained:**
- **All test cases executed**: Ensures comprehensive testing
- **Regression testing completed**: Prevents breaking existing features
- **Performance testing done**: Validates performance requirements
- **Security scan passed**: Identifies vulnerabilities
- **Browser compatibility checked**: Ensures cross-platform support
- **API documentation verified**: Maintains API contract
- **Test data prepared**: Ensures realistic testing scenarios
- **Test environment ready**: Proper environment configuration

**Production Deployment Checklist Explained:**
- **Staging deployment successful**: Validates in production-like environment
- **Smoke tests passed**: Quick validation of critical paths
- **Performance baseline met**: Ensures no performance degradation
- **Rollback plan prepared**: Quick recovery if issues occur
- **Team notified**: Communication and coordination
- **On-call engineer available**: Support during deployment
- **Database backup completed**: Data protection
- **Monitoring dashboards ready**: Real-time visibility
- **Change management ticket approved**: Compliance and tracking
- **Post-deployment verification plan ready**: Validation steps

**How to Use Checklists:**

1. **Create Checklist Items**: Use Azure DevOps work items or checklists
2. **Assign Owners**: Each item should have an owner
3. **Track Progress**: Update checklist as items are completed
4. **Review Before Proceeding**: Don't proceed until all items checked
5. **Document Exceptions**: If item skipped, document why
6. **Continuous Improvement**: Update checklists based on learnings

**Integration with Azure DevOps:**

```yaml
# Example: Pre-deployment gate in pipeline
- task: ManualValidation@0
  inputs:
    notifyUsers: 'devops-team@company.com'
    instructions: |
      Please verify:
      - [ ] All tests passing
      - [ ] Code reviewed
      - [ ] Documentation updated
      - [ ] Rollback plan ready
    onTimeout: 'reject'
```

#### 25.5.2 Module 24: Sample Scripts and Utilities - Detailed Explanation

**Purpose:**
The Sample Scripts and Utilities module provides ready-to-use scripts for common operational tasks. These scripts:

1. **Automate Repetitive Tasks**: Save time on manual operations
2. **Ensure Consistency**: Same process every time
3. **Reduce Human Error**: Automated checks and validations
4. **Enable Integration**: Can be called from CI/CD pipelines
5. **Documentation**: Scripts serve as executable documentation

**Health Check Script Explained:**

**Components:**
```python
# 1. API Health Check
# Purpose: Verify API is responding correctly
# Checks:
#   - HTTP status code (200 OK)
#   - Response format (JSON)
#   - Response time (< 5 seconds)
#   - Health endpoint returns expected data

# 2. Database Health Check
# Purpose: Verify database connectivity and responsiveness
# Checks:
#   - Connection successful
#   - Can execute queries
#   - Response time acceptable

# 3. Redis Health Check
# Purpose: Verify cache layer is operational
# Checks:
#   - Connection successful
#   - Can ping Redis server
#   - Response time acceptable
```

**Usage Scenarios:**
- **Pre-deployment**: Verify environment is ready
- **Post-deployment**: Confirm deployment successful
- **Monitoring**: Regular health checks
- **Troubleshooting**: Isolate issues
- **Automated Testing**: CI/CD pipeline integration

**Integration with Pipelines:**
```yaml
- script: |
    python scripts/health-check.py --env production
  displayName: 'Health Check'
  continueOnError: false
```

**Database Migration Script Explained:**

**Components:**
```python
# 1. Backup Creation
# Purpose: Safety net before migrations
# Process:
#   - Create timestamped backup
#   - Store in secure location
#   - Verify backup integrity

# 2. Migration Execution
# Purpose: Apply database schema changes
# Process:
#   - Run Alembic migrations
#   - Track migration status
#   - Handle errors gracefully

# 3. Rollback Capability
# Purpose: Quick recovery if migration fails
# Process:
#   - Keep backup available
#   - Document rollback steps
#   - Test rollback procedure
```

**Safety Features:**
- **Automatic Backup**: Before any migration
- **Error Handling**: Graceful failure handling
- **Rollback Instructions**: Clear recovery steps
- **Logging**: Complete audit trail
- **Verification**: Post-migration validation

**Deployment Verification Script Explained:**

**Purpose:**
Verify that deployment was successful and application is functioning correctly.

**Verification Steps:**
1. **Health Endpoint**: Basic application health
2. **API Endpoints**: Critical API functionality
3. **Documentation**: API docs accessible
4. **Response Times**: Performance validation
5. **Error Rates**: No unexpected errors

**Retry Logic:**
- Multiple attempts (configurable)
- Exponential backoff
- Clear failure reporting
- Success confirmation

**Log Analysis Script Explained:**

**Purpose:**
Analyze application logs to identify errors, patterns, and issues.

**Analysis Features:**
1. **Error Detection**: Find all errors in logs
2. **Pattern Recognition**: Identify common error types
3. **Frequency Analysis**: Most common errors
4. **Trend Analysis**: Error trends over time
5. **Reporting**: Summary and detailed reports

**Use Cases:**
- **Post-Incident Analysis**: Understand what happened
- **Proactive Monitoring**: Find issues before they escalate
- **Performance Analysis**: Identify slow operations
- **Security Auditing**: Find security-related events

### 25.6 Complete Workflow Integration

#### 25.6.1 End-to-End Flow Diagram

```
DEVELOPER WORKFLOW
│
├── 1. Feature Request
│   └── Create User Story in Azure DevOps
│
├── 2. Sprint Planning
│   ├── Estimate story points
│   ├── Break into tasks
│   └── Assign to developer
│
├── 3. Development
│   ├── Create feature branch
│   ├── Write code
│   ├── Write tests
│   ├── Run tests locally
│   └── Commit changes
│
├── 4. Pull Request
│   ├── Push to remote
│   ├── Create PR in Azure DevOps
│   ├── Link work items
│   └── Request reviews
│
├── 5. Code Review
│   ├── Reviewers check code
│   ├── Provide feedback
│   ├── Address comments
│   └── Update PR
│
├── 6. CI Pipeline (Automatic)
│   ├── Build application
│   ├── Run tests
│   ├── Security scans
│   ├── Code quality checks
│   └── Build Docker image
│
├── 7. Merge to Develop
│   ├── PR approved
│   ├── CI passes
│   ├── Merge to develop
│   └── Delete feature branch
│
├── 8. CD Pipeline - Dev (Automatic)
│   ├── Deploy to Dev environment
│   ├── Run health checks
│   ├── Run migrations
│   └── Notify team
│
├── 9. QA Testing
│   ├── Manual approval for QA
│   ├── Deploy to QA
│   ├── Run E2E tests
│   └── QA team testing
│
├── 10. Release Preparation
│    ├── Create release branch
│    ├── Update version
│    ├── Update changelog
│    └── Merge to main
│
├── 11. CD Pipeline - Staging (Manual Approval)
│    ├── Deploy to staging
│    ├── Smoke tests
│    ├── Performance tests
│    └── Final validation
│
├── 12. Production Deployment (Manual Approval)
│    ├── Canary deployment
│    ├── Gradual rollout
│    ├── Health checks
│    ├── Database migrations
│    └── Full deployment
│
└── 13. Post-Deployment
    ├── Monitor metrics
    ├── Verify functionality
    ├── Update documentation
    └── Close work items
```

#### 25.6.2 Timeline Example

**Sprint 1 (2 weeks) - Core Features:**

```
Day 1-2: Setup & Planning
├── Project setup
├── Repository initialization
├── Sprint planning
└── Environment setup

Day 3-5: Database & Authentication
├── Database schema design
├── Alembic migrations
├── Authentication implementation
└── Unit tests

Day 6-8: Product API
├── Product models
├── Product endpoints
├── Integration tests
└── API documentation

Day 9-10: CI Pipeline Setup
├── Azure Pipeline creation
├── Build configuration
├── Test configuration
└── Docker setup

Day 11-12: Code Review & Merge
├── Code reviews
├── Address feedback
├── Merge to develop
└── Deploy to Dev

Day 13-14: Testing & Bug Fixes
├── Integration testing
├── Bug fixes
├── Documentation
└── Sprint review
```

### 25.7 Role-Based Responsibilities

#### 25.7.1 Developer Responsibilities

```
Daily Tasks:
├── Attend standup
├── Work on assigned tasks
├── Write code and tests
├── Update work items
└── Code reviews

Sprint Tasks:
├── Complete user stories
├── Write unit tests
├── Update documentation
├── Participate in reviews
└── Deploy to Dev environment

Release Tasks:
├── Create release branch
├── Update version numbers
├── Update changelog
├── Fix release blockers
└── Support deployment
```

#### 25.7.2 DevOps Engineer Responsibilities

```
Daily Tasks:
├── Monitor pipelines
├── Monitor environments
├── Respond to alerts
├── Review deployments
└── Update runbooks

Sprint Tasks:
├── Maintain CI/CD pipelines
├── Environment management
├── Infrastructure updates
├── Security scanning
└── Performance optimization

Release Tasks:
├── Production deployment
├── Database migrations
├── Monitoring setup
├── Rollback procedures
└── Post-deployment support
```

#### 25.7.3 QA Engineer Responsibilities

```
Daily Tasks:
├── Execute test cases
├── Report bugs
├── Verify fixes
├── Update test cases
└── Test data management

Sprint Tasks:
├── Test planning
├── Test case creation
├── Test execution
├── Bug tracking
└── Test reporting

Release Tasks:
├── Regression testing
├── Performance testing
├── Security testing
├── UAT support
└── Sign-off for production
```

### 25.8 Communication Flow

```
┌─────────────────────────────────────────────────────────┐
│              COMMUNICATION CHANNELS                      │
└─────────────────────────────────────────────────────────┘

Daily Standup (15 min)
├── Team members
├── What completed yesterday
├── What working on today
└── Blockers

Sprint Planning (4 hours)
├── Product Owner
├── Development Team
├── Scrum Master
└── Define sprint goals

Sprint Review (2 hours)
├── Stakeholders
├── Demo completed work
├── Gather feedback
└── Update backlog

Sprint Retrospective (1 hour)
├── Team members
├── What went well
├── What to improve
└── Action items

Deployment Notifications
├── Slack channel
├── Email notifications
├── Teams notifications
└── Status page updates

Incident Response
├── Incident channel
├── On-call engineer
├── Escalation path
└── Post-mortem meeting
```

### 25.9 Decision Points and Gates

```
┌─────────────────────────────────────────────────────────┐
│              QUALITY GATES                               │
└─────────────────────────────────────────────────────────┘

Gate 1: Code Review
├── Minimum 2 approvals required
├── All comments resolved
├── CI pipeline passes
└── No security issues

Gate 2: Merge to Develop
├── PR approved
├── Tests passing
├── Code coverage > 80%
└── Documentation updated

Gate 3: Deploy to QA
├── Dev deployment successful
├── Manual approval
├── E2E tests passing
└── QA environment ready

Gate 4: Deploy to Staging
├── QA sign-off
├── Manual approval
├── Performance tests passing
└── Security scan passed

Gate 5: Deploy to Production
├── Staging validation
├── CTO approval
├── Change management approved
├── Rollback plan ready
└── On-call engineer available
```

### 25.10 Visual Flow Diagrams

#### 25.10.1 Complete CI/CD Pipeline Flow

```
                    ┌─────────────────────┐
                    │   Developer Push    │
                    │   Code to Branch    │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   CI Pipeline       │
                    │   Triggered         │
                    └──────────┬──────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│   Build       │    │   Security    │    │   Unit Tests  │
│   Stage       │───▶│   Scanning    │───▶│   Stage       │
└───────────────┘    └───────────────┘    └───────────────┘
        │                      │                      │
        └──────────────────────┼──────────────────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  Integration Tests  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  Build Artifacts    │
                    │  Published to ACR   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  CD Pipeline        │
                    │  Triggered          │
                    └──────────┬──────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│   Dev         │    │   QA           │    │   Staging     │
│   Deploy      │───▶│   Deploy       │───▶│   Deploy      │
│   (Auto)      │    │   (Manual)     │    │   (Manual)    │
└───────────────┘    └───────────────┘    └───────────────┘
        │                      │                      │
        └──────────────────────┼──────────────────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  Production         │
                    │  Deploy (Canary)    │
                    │  (Manual Approval)  │
                    └─────────────────────┘
```

#### 25.10.2 Branching Strategy Flow

```
                    main (Production)
                           │
                           │ Merge Release
                           │
                    ┌──────▼──────┐
                    │   Release   │
                    │   Branch    │
                    └──────┬──────┘
                           │
                           │ Merge Develop
                           │
                    ┌──────▼──────┐
                    │   develop   │
                    │  (Integration)
                    └──────┬──────┘
                           │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ▼                   ▼                   ▼
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│   feature/   │   │   bugfix/    │   │   hotfix/    │
│   branches   │   │   branches   │   │   branches   │
└──────────────┘   └──────────────┘   └──────────────┘
        │                   │                   │
        └───────────────────┼───────────────────┘
                           │
                           │ Merge to Develop
                           │
                    ┌──────▼──────┐
                    │   develop   │
                    └─────────────┘
```

#### 25.10.3 Deployment Strategy Flow

```
                    Production Deployment
                           │
                           ▼
                    ┌──────────────┐
                    │  Canary 10%  │─── Monitor 10 min
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  Canary 25%  │─── Monitor 10 min
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  Canary 50%  │─── Monitor 10 min
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  Canary 100% │─── Monitor 30 min
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  Full Rollout │
                    │  Complete     │
                    └──────────────┘
```

### 25.11 Detailed Module Explanations (Extended)

#### 25.11.1 Module 23: Checklists and Templates - Deep Dive

**Why Checklists Matter:**

Checklists are critical in DevOps because they:
1. **Prevent Human Error**: Even experts make mistakes under pressure
2. **Ensure Consistency**: Same process every time
3. **Enable Delegation**: Junior team members can follow procedures
4. **Document Knowledge**: Capture institutional knowledge
5. **Compliance**: Meet regulatory and audit requirements

**Checklist Design Principles:**

1. **Specific**: Each item should be clear and actionable
   - ❌ Bad: "Test the application"
   - ✅ Good: "Execute all unit tests and verify 100% pass rate"

2. **Measurable**: Can verify completion objectively
   - ❌ Bad: "Check performance"
   - ✅ Good: "Verify API response time p95 < 500ms"

3. **Time-Bound**: Clear when to complete
   - ❌ Bad: "Update documentation"
   - ✅ Good: "Update API documentation before merging PR"

4. **Prioritized**: Critical items first
   - Must-do items at top
   - Nice-to-have items at bottom

**Checklist Implementation:**

```yaml
# Azure DevOps Work Item Checklist
- [ ] All unit tests passing (Required)
- [ ] Code reviewed by 2+ reviewers (Required)
- [ ] Security scan passed (Required)
- [ ] Documentation updated (Required)
- [ ] Performance tests passing (Optional)
- [ ] E2E tests passing (Optional)
```

**Checklist Automation:**

Some checklist items can be automated:
- ✅ Tests passing → CI pipeline
- ✅ Code coverage → Coverage tool
- ✅ Security scan → Automated scanners
- ❌ Manual approval → Human decision
- ❌ Business validation → Stakeholder review

**Checklist Evolution:**

Checklists should evolve:
- Add items after incidents
- Remove items that are always done
- Update based on team feedback
- Review quarterly

#### 25.11.2 Module 24: Sample Scripts and Utilities - Deep Dive

**Script Design Principles:**

1. **Idempotency**: Scripts should be safe to run multiple times
   ```python
   # Good: Checks before creating
   if not resource_exists():
       create_resource()
   
   # Bad: Always creates (may fail on rerun)
   create_resource()
   ```

2. **Error Handling**: Graceful failure with clear messages
   ```python
   try:
       deploy_application()
   except DeploymentError as e:
       logger.error(f"Deployment failed: {e}")
       send_alert("Deployment failed")
       sys.exit(1)
   ```

3. **Logging**: Comprehensive logging for debugging
   ```python
   logger.info("Starting deployment")
   logger.debug(f"Environment: {env}")
   logger.error("Deployment failed", exc_info=True)
   ```

4. **Configuration**: Externalize configuration
   ```python
   # Use environment variables
   api_url = os.getenv("API_URL", "http://localhost:8000")
   
   # Use config files
   config = load_config("config.yaml")
   ```

5. **Testing**: Scripts should be testable
   ```python
   def health_check(url: str) -> bool:
       # Testable function
       pass
   
   if __name__ == "__main__":
       # Main execution
       main()
   ```

**Script Categories:**

1. **Health Check Scripts**
   - Purpose: Verify system health
   - Usage: Pre/post deployment, monitoring
   - Output: Exit codes, logs, metrics

2. **Deployment Scripts**
   - Purpose: Deploy applications
   - Usage: CI/CD pipelines, manual deployments
   - Features: Rollback, verification, notifications

3. **Database Scripts**
   - Purpose: Manage database operations
   - Usage: Migrations, backups, restores
   - Safety: Backups, transactions, rollback

4. **Monitoring Scripts**
   - Purpose: Collect and analyze metrics
   - Usage: Scheduled jobs, ad-hoc analysis
   - Output: Reports, alerts, dashboards

5. **Maintenance Scripts**
   - Purpose: Routine maintenance tasks
   - Usage: Cleanup, optimization, updates
   - Schedule: Cron jobs, scheduled tasks

**Script Integration:**

```yaml
# Azure Pipeline Integration
- script: |
    python scripts/health-check.py --env $(environment)
  displayName: 'Health Check'
  continueOnError: false
  env:
    API_URL: $(apiUrl)
    DATABASE_URL: $(databaseUrl)
```

**Script Security:**

1. **Input Validation**: Validate all inputs
   ```python
   if not api_url.startswith("https://"):
       raise ValueError("API URL must use HTTPS")
   ```

2. **Secret Management**: Never hardcode secrets
   ```python
   # Bad
   password = "secret123"
   
   # Good
   password = os.getenv("DATABASE_PASSWORD")
   # Or use Azure Key Vault
   password = key_vault.get_secret("db-password")
   ```

3. **Error Messages**: Don't expose sensitive info
   ```python
   # Bad
   logger.error(f"Database connection failed: {database_url}")
   
   # Good
   logger.error("Database connection failed")
   logger.debug(f"Connection string: {database_url}")
   ```

4. **Permissions**: Use least privilege
   ```python
   # Run with minimal permissions
   # Use service principals
   # Rotate credentials regularly
   ```

### 25.12 Real-World Scenarios

#### 25.12.1 Scenario 1: New Feature Development

**Timeline: 2 weeks**

```
Day 1:
├── Create user story
├── Break into tasks
├── Create feature branch
└── Set up local environment

Day 2-5:
├── Implement feature
├── Write unit tests
├── Run tests locally
└── Update documentation

Day 6-7:
├── Create pull request
├── Address code review feedback
├── Fix issues
└── Update PR

Day 8-9:
├── CI pipeline runs
├── Fix any pipeline issues
├── Merge to develop
└── Deploy to Dev

Day 10:
├── Test in Dev environment
├── Fix any issues
└── Prepare for QA

Day 11-12:
├── Deploy to QA
├── QA testing
├── Bug fixes
└── Sign-off

Day 13-14:
├── Merge to main
├── Deploy to staging
├── Final validation
└── Production deployment
```

#### 25.12.2 Scenario 2: Critical Bug Fix

**Timeline: 4 hours**

```
Hour 1:
├── Bug reported
├── Triage and prioritize
├── Create hotfix branch
└── Investigate root cause

Hour 2:
├── Implement fix
├── Write test for bug
├── Run tests
└── Code review

Hour 3:
├── CI pipeline
├── Deploy to Dev
├── Verify fix
└── Deploy to QA

Hour 4:
├── QA verification
├── Deploy to Production
├── Monitor
└── Post-mortem
```

#### 25.12.3 Scenario 3: Production Incident

**Timeline: 1-4 hours**

```
Minute 0-15: Detection
├── Alert triggered
├── On-call engineer notified
├── Incident channel created
└── Initial assessment

Minute 15-30: Investigation
├── Check logs
├── Check metrics
├── Identify root cause
└── Assess impact

Minute 30-60: Mitigation
├── Implement fix
├── Deploy hotfix
├── Verify resolution
└── Monitor

Hour 1-4: Resolution
├── Full service restoration
├── Post-incident analysis
├── Action items
└── Documentation
```

### 25.13 Success Metrics Tracking

#### 25.13.1 Development Velocity

```
Sprint 1: 42 story points
Sprint 2: 45 story points
Sprint 3: 48 story points
Sprint 4: 50 story points

Trend: Increasing velocity
Action: Continue current practices
```

#### 25.13.2 Deployment Frequency

```
Week 1: 5 deployments
Week 2: 7 deployments
Week 3: 6 deployments
Week 4: 8 deployments

Average: 6.5 deployments/week
Target: 10 deployments/week
Action: Reduce deployment friction
```

#### 25.13.3 Mean Time to Recovery

```
Incident 1: 45 minutes
Incident 2: 30 minutes
Incident 3: 20 minutes
Incident 4: 15 minutes

Trend: Decreasing MTTR
Action: Continue improving runbooks
```

#### 25.13.4 Change Failure Rate

```
Total Deployments: 100
Failed Deployments: 3
Change Failure Rate: 3%

Target: < 5%
Status: Meeting target
Action: Maintain current practices
```

```
┌─────────────────────────────────────────────────────────┐
│              QUALITY GATES                               │
└─────────────────────────────────────────────────────────┘

Gate 1: Code Review
├── Minimum 2 approvals required
├── All comments resolved
├── CI pipeline passes
└── No security issues

Gate 2: Merge to Develop
├── PR approved
├── Tests passing
├── Code coverage > 80%
└── Documentation updated

Gate 3: Deploy to QA
├── Dev deployment successful
├── Manual approval
├── E2E tests passing
└── QA environment ready

Gate 4: Deploy to Staging
├── QA sign-off
├── Manual approval
├── Performance tests passing
└── Security scan passed

Gate 5: Deploy to Production
├── Staging validation
├── CTO approval
├── Change management approved
├── Rollback plan ready
└── On-call engineer available
```

---

## 26. Kubernetes Configuration

Kubernetes configuration defines the declarative specifications that describe how containerized applications should be deployed, scaled, and managed in a Kubernetes cluster. These configurations follow the Infrastructure as Code (IaC) principle, enabling version-controlled, reproducible deployments that can be reviewed, tested, and audited like application code. Kubernetes manifests describe desired state rather than imperative commands, allowing Kubernetes to automatically reconcile actual state with desired state, healing from failures and maintaining consistency. The configuration system supports multiple resource types—deployments, services, ingress controllers, configmaps, secrets, and more—each serving specific purposes in the application architecture. Understanding Kubernetes configuration enables teams to leverage container orchestration capabilities like auto-scaling, self-healing, rolling updates, and service discovery, transforming application deployment from manual operations into automated, reliable processes.

### 26.1 Kubernetes Overview

Kubernetes (K8s) is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It provides abstractions that hide the complexity of managing containers across multiple hosts, enabling developers to focus on application logic rather than infrastructure concerns. Kubernetes implements concepts like pods (the smallest deployable units), services (stable network endpoints), deployments (declarative updates), and namespaces (logical isolation), creating a powerful platform for running distributed applications. The platform's architecture separates control plane components (API server, etcd, scheduler, controller manager) from worker nodes (kubelet, kube-proxy, container runtime), enabling horizontal scaling and high availability. Kubernetes' extensibility through custom resources and operators allows teams to model complex application requirements and automate operational tasks, making it the de facto standard for container orchestration in cloud-native applications.

Kubernetes (K8s) is used for container orchestration, providing:
- **Auto-scaling**: Automatically scale pods based on demand
- **Self-healing**: Restart failed containers
- **Load balancing**: Distribute traffic across pods
- **Rolling updates**: Zero-downtime deployments
- **Resource management**: CPU and memory limits

### 26.2 Complete Kubernetes Manifests

Kubernetes manifests are YAML or JSON files that declaratively describe the desired state of Kubernetes resources, enabling version-controlled infrastructure and reproducible deployments. These manifests define everything needed to run applications: container images, resource requirements, networking, storage, configuration, and scaling policies. The declarative nature of manifests means that Kubernetes continuously works to achieve and maintain the described state, automatically replacing failed pods, scaling based on demand, and updating configurations. Manifest organization follows best practices with separate files for different resource types and environment-specific overlays, enabling reuse while accommodating environment differences. Effective manifest design balances detail with maintainability, including all necessary configuration while remaining readable and manageable.

#### 26.2.1 Namespace Configuration

Namespaces provide logical isolation within a Kubernetes cluster, enabling multiple teams or applications to share cluster resources while maintaining separation and preventing conflicts. Namespaces scope resource names, so the same resource name can exist in different namespaces, and they enable resource quotas and limits that prevent one namespace from consuming excessive cluster resources. Namespace configuration establishes boundaries for access control, as RBAC policies can be scoped to namespaces, enabling fine-grained permissions. Namespaces also organize resources logically, making it easier to manage and monitor related components together. Effective namespace usage follows organizational structure, with separate namespaces for different environments (dev, qa, staging, production) or different teams, enabling isolation while sharing cluster infrastructure efficiently.

**File: `infrastructure/kubernetes/namespace.yaml`**
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: inventory-system
  labels:
    name: inventory-system
    environment: production
    managed-by: terraform
```

**Commands:**
```bash
# Create namespace
kubectl create namespace inventory-system

# Apply namespace
kubectl apply -f infrastructure/kubernetes/namespace.yaml

# List namespaces
kubectl get namespaces

# Delete namespace
kubectl delete namespace inventory-system
```

#### 26.2.2 ConfigMap Configuration

ConfigMaps provide a mechanism for storing non-sensitive configuration data separately from container images, enabling the same image to run in different environments with different configurations. This separation follows the twelve-factor app methodology, promoting portability and reducing the need to rebuild images for configuration changes. ConfigMaps can store configuration as key-value pairs, files, or entire configuration files, and they can be mounted into pods as volumes or injected as environment variables. This flexibility allows applications to consume configuration in ways that suit their architecture, whether through environment variables, configuration files, or command-line arguments. Effective ConfigMap usage externalizes all environment-specific configuration, keeping container images generic and reusable while enabling rapid environment provisioning and configuration updates without image rebuilds.

**File: `infrastructure/kubernetes/configmap.yaml`**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: inventory-api-config
  namespace: inventory-system
  labels:
    app: inventory-api
data:
  # Application settings
  LOG_LEVEL: "INFO"
  ENVIRONMENT: "production"
  API_VERSION: "v1"
  
  # Database settings (non-sensitive)
  DB_HOST: "inventory-postgresql"
  DB_PORT: "5432"
  DB_NAME: "inventory_db"
  
  # Redis settings
  REDIS_HOST: "inventory-redis"
  REDIS_PORT: "6379"
  REDIS_DB: "0"
  
  # Application settings
  CORS_ORIGINS: "https://app.company.com,https://admin.company.com"
  RATE_LIMIT_ENABLED: "true"
  RATE_LIMIT_REQUESTS: "100"
  RATE_LIMIT_WINDOW: "60"
  
  # Health check settings
  HEALTH_CHECK_PATH: "/health"
  READINESS_CHECK_PATH: "/ready"
  LIVENESS_CHECK_PATH: "/live"
```

**Commands:**
```bash
# Create ConfigMap
kubectl create configmap inventory-api-config \
  --from-literal=LOG_LEVEL=INFO \
  --from-literal=ENVIRONMENT=production \
  -n inventory-system

# Apply ConfigMap from file
kubectl apply -f infrastructure/kubernetes/configmap.yaml

# View ConfigMap
kubectl get configmap inventory-api-config -n inventory-system -o yaml

# Edit ConfigMap
kubectl edit configmap inventory-api-config -n inventory-system

# Delete ConfigMap
kubectl delete configmap inventory-api-config -n inventory-system
```

#### 26.2.3 Secret Configuration

Secrets provide secure storage for sensitive information like passwords, API keys, TLS certificates, and database connection strings, protecting this data from accidental exposure. Kubernetes stores secrets as base64-encoded data (not encrypted by default), so they should be used in conjunction with encryption at rest for the etcd database and encryption in transit for API communications. Secrets can be created manually, generated by Kubernetes, or synced from external secret management systems like Azure Key Vault. Best practices include using external secret management systems in production, rotating secrets regularly, and limiting secret access through RBAC policies. Effective secret management ensures that sensitive data never appears in container images, version control, or logs, maintaining security while enabling automated deployments that require credentials and keys.

**File: `infrastructure/kubernetes/secret.yaml`**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: inventory-api-secrets
  namespace: inventory-system
  labels:
    app: inventory-api
type: Opaque
stringData:
  # Database credentials
  DATABASE_URL: "postgresql://user:password@inventory-postgresql:5432/inventory_db"
  DB_USER: "inventory_user"
  DB_PASSWORD: "secure_password_here"
  
  # Redis password (if required)
  REDIS_PASSWORD: ""
  
  # JWT Secret
  JWT_SECRET_KEY: "your-super-secret-jwt-key-change-in-production"
  JWT_ALGORITHM: "HS256"
  
  # API Keys
  API_KEY: "your-api-key-here"
  
  # Azure Key Vault (if using)
  AZURE_KEYVAULT_URL: "https://inventory-kv.vault.azure.net/"
  
  # Application Insights
  APPINSIGHTS_INSTRUMENTATION_KEY: "your-instrumentation-key"
```

**Note:** In production, use Azure Key Vault integration instead of storing secrets directly.

**Commands:**
```bash
# Create secret from literal values
kubectl create secret generic inventory-api-secrets \
  --from-literal=DATABASE_URL='postgresql://user:pass@host:5432/db' \
  --from-literal=JWT_SECRET_KEY='secret-key' \
  -n inventory-system

# Create secret from file
kubectl create secret generic inventory-api-secrets \
  --from-file=secrets.env \
  -n inventory-system

# Apply secret from YAML (base64 encoded)
kubectl apply -f infrastructure/kubernetes/secret.yaml

# View secret (values are base64 encoded)
kubectl get secret inventory-api-secrets -n inventory-system -o yaml

# Decode secret value
kubectl get secret inventory-api-secrets -n inventory-system \
  -o jsonpath='{.data.DATABASE_URL}' | base64 -d

# Delete secret
kubectl delete secret inventory-api-secrets -n inventory-system
```

#### 26.2.4 Deployment Configuration

Deployment configurations define how applications are deployed and updated, specifying container images, replica counts, resource requirements, update strategies, and health checks. Deployments manage ReplicaSets, which in turn manage Pods, creating a hierarchy that enables declarative updates and automatic rollback capabilities. The deployment specification includes update strategies (rolling update, recreate) that control how new versions replace old ones, with rolling updates enabling zero-downtime deployments by gradually replacing old pods with new ones. Resource requests and limits ensure that applications receive adequate resources while preventing resource starvation, and health checks (liveness, readiness, startup probes) enable Kubernetes to make intelligent decisions about pod health and traffic routing. Effective deployment configuration balances availability, resource usage, and deployment speed, ensuring that applications run reliably while enabling rapid, safe updates.

**File: `infrastructure/kubernetes/deployment.yaml`**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventory-api
  namespace: inventory-system
  labels:
    app: inventory-api
    version: v1.0.0
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: inventory-api
  template:
    metadata:
      labels:
        app: inventory-api
        version: v1.0.0
    spec:
      serviceAccountName: inventory-api-sa
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
      containers:
      - name: inventory-api
        image: yourregistry.azurecr.io/inventory-management-api:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8000
          name: http
          protocol: TCP
        env:
        # From ConfigMap
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: inventory-api-config
              key: LOG_LEVEL
        - name: ENVIRONMENT
          valueFrom:
            configMapKeyRef:
              name: inventory-api-config
              key: ENVIRONMENT
        - name: DB_HOST
          valueFrom:
            configMapKeyRef:
              name: inventory-api-config
              key: DB_HOST
        # From Secrets
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: inventory-api-secrets
              key: DATABASE_URL
        - name: JWT_SECRET_KEY
          valueFrom:
            secretKeyRef:
              name: inventory-api-secrets
              key: JWT_SECRET_KEY
        # Resource limits
        resources:
          requests:
            cpu: "500m"
            memory: "512Mi"
          limits:
            cpu: "2000m"
            memory: "2Gi"
        # Health checks
        livenessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /ready
            port: 8000
          initialDelaySeconds: 10
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        # Startup probe (for slow-starting apps)
        startupProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 0
          periodSeconds: 10
          timeoutSeconds: 3
          failureThreshold: 30
        # Volume mounts
        volumeMounts:
        - name: app-logs
          mountPath: /app/logs
      volumes:
      - name: app-logs
        emptyDir: {}
      # Image pull secrets for ACR
      imagePullSecrets:
      - name: acr-secret
```

**Commands:**
```bash
# Apply deployment
kubectl apply -f infrastructure/kubernetes/deployment.yaml

# Get deployments
kubectl get deployments -n inventory-system

# Describe deployment
kubectl describe deployment inventory-api -n inventory-system

# Get pods
kubectl get pods -n inventory-system -l app=inventory-api

# View pod logs
kubectl logs -f deployment/inventory-api -n inventory-system

# Scale deployment
kubectl scale deployment inventory-api --replicas=5 -n inventory-system

# Update deployment image
kubectl set image deployment/inventory-api \
  inventory-api=yourregistry.azurecr.io/inventory-management-api:v1.1.0 \
  -n inventory-system

# Rollout status
kubectl rollout status deployment/inventory-api -n inventory-system

# Rollout history
kubectl rollout history deployment/inventory-api -n inventory-system

# Rollback to previous version
kubectl rollout undo deployment/inventory-api -n inventory-system

# Rollback to specific revision
kubectl rollout undo deployment/inventory-api --to-revision=2 -n inventory-system

# Pause rollout
kubectl rollout pause deployment/inventory-api -n inventory-system

# Resume rollout
kubectl rollout resume deployment/inventory-api -n inventory-system

# Delete deployment
kubectl delete deployment inventory-api -n inventory-system
```

#### 26.2.5 Service Configuration

Service configurations define stable network endpoints that enable pods to communicate with each other and external clients, abstracting away the dynamic nature of pod IP addresses. Services use label selectors to identify which pods they route traffic to, automatically updating as pods are created or destroyed, providing a consistent interface despite pod churn. Different service types serve different purposes: ClusterIP provides internal-only access, NodePort exposes services on node IPs, LoadBalancer integrates with cloud load balancers, and ExternalName maps to external DNS names. Services also enable session affinity, load balancing across pod replicas, and health-check-based traffic routing. Effective service configuration provides reliable, discoverable endpoints that enable microservices communication and external access while abstracting away infrastructure complexity.

**File: `infrastructure/kubernetes/service.yaml`**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: inventory-api-service
  namespace: inventory-system
  labels:
    app: inventory-api
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 8000
    protocol: TCP
    name: http
  selector:
    app: inventory-api
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800
```

**LoadBalancer Service (for external access):**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: inventory-api-lb
  namespace: inventory-system
  labels:
    app: inventory-api
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: /health
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8000
    protocol: TCP
    name: http
  - port: 443
    targetPort: 8000
    protocol: TCP
    name: https
  selector:
    app: inventory-api
```

**Commands:**
```bash
# Apply service
kubectl apply -f infrastructure/kubernetes/service.yaml

# Get services
kubectl get services -n inventory-system

# Describe service
kubectl describe service inventory-api-service -n inventory-system

# Get service endpoints
kubectl get endpoints inventory-api-service -n inventory-system

# Port forward to service (for testing)
kubectl port-forward svc/inventory-api-service 8000:80 -n inventory-system

# Delete service
kubectl delete service inventory-api-service -n inventory-system
```

#### 26.2.6 Ingress Configuration

Ingress configurations define HTTP and HTTPS routing rules that enable external access to services within the cluster, providing features like SSL termination, path-based routing, and host-based routing. Ingress resources work with ingress controllers (like NGINX, Application Gateway, or Traefik) that implement the actual routing logic, enabling sophisticated routing without modifying application code. Ingress supports features like TLS/SSL termination, which offloads encryption from applications, and annotations that enable controller-specific features like rate limiting, authentication, and rewrite rules. Effective ingress configuration provides a single entry point for external traffic while enabling flexible routing to multiple backend services, simplifying network architecture and enabling features like canary deployments and A/B testing through traffic splitting.

**File: `infrastructure/kubernetes/ingress.yaml`**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: inventory-api-ingress
  namespace: inventory-system
  annotations:
    # Azure Application Gateway annotations
    kubernetes.io/ingress.class: azure/application-gateway
    appgw.ingress.kubernetes.io/ssl-redirect: "true"
    appgw.ingress.kubernetes.io/backend-protocol: "http"
    appgw.ingress.kubernetes.io/health-probe-path: "/health"
    appgw.ingress.kubernetes.io/health-probe-interval: "30"
    appgw.ingress.kubernetes.io/health-probe-timeout: "10"
    appgw.ingress.kubernetes.io/health-probe-unhealthy-threshold: "3"
    appgw.ingress.kubernetes.io/health-probe-status-codes: "200-399"
    # WAF rules
    appgw.ingress.kubernetes.io/waf-policy: "inventory-waf-policy"
    # Rate limiting
    nginx.ingress.kubernetes.io/limit-rps: "100"
    nginx.ingress.kubernetes.io/limit-connections: "10"
    # CORS
    nginx.ingress.kubernetes.io/enable-cors: "true"
    nginx.ingress.kubernetes.io/cors-allow-origin: "https://app.company.com"
spec:
  tls:
  - hosts:
    - api.company.com
    secretName: inventory-api-tls
  rules:
  - host: api.company.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: inventory-api-service
            port:
              number: 80
      - path: /api/v1
        pathType: Prefix
        backend:
          service:
            name: inventory-api-service
            port:
              number: 80
```

**Commands:**
```bash
# Apply ingress
kubectl apply -f infrastructure/kubernetes/ingress.yaml

# Get ingress
kubectl get ingress -n inventory-system

# Describe ingress
kubectl describe ingress inventory-api-ingress -n inventory-system

# View ingress IP
kubectl get ingress inventory-api-ingress -n inventory-system \
  -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

# Delete ingress
kubectl delete ingress inventory-api-ingress -n inventory-system
```

#### 26.2.7 Horizontal Pod Autoscaler (HPA)

Horizontal Pod Autoscaler (HPA) automatically adjusts the number of pod replicas based on observed metrics like CPU utilization, memory usage, or custom application metrics. This autoscaling capability enables applications to handle variable loads efficiently, scaling up during peak demand and scaling down during low usage to optimize resource costs. HPA continuously monitors specified metrics and compares them against target values, adding or removing pods to maintain the desired metric levels. The autoscaler supports multiple metrics simultaneously, scaling based on the metric that requires the most replicas, and it includes configurable scaling behavior that controls how quickly and aggressively scaling occurs. Effective HPA configuration balances responsiveness to load changes with stability, preventing rapid scaling oscillations while ensuring that applications can handle traffic spikes without performance degradation.

**File: `infrastructure/kubernetes/hpa.yaml`**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: inventory-api-hpa
  namespace: inventory-system
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: inventory-api
  minReplicas: 3
  maxReplicas: 10
  metrics:
  # CPU-based scaling
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  # Memory-based scaling
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
  # Custom metrics (requests per second)
  - type: Pods
    pods:
      metric:
        name: http_requests_per_second
      target:
        type: AverageValue
        averageValue: "100"
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
      - type: Percent
        value: 50
        periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
      - type: Percent
        value: 100
        periodSeconds: 60
      - type: Pods
        value: 2
        periodSeconds: 60
      selectPolicy: Max
```

**Commands:**
```bash
# Apply HPA
kubectl apply -f infrastructure/kubernetes/hpa.yaml

# Get HPA
kubectl get hpa -n inventory-system

# Describe HPA
kubectl describe hpa inventory-api-hpa -n inventory-system

# Watch HPA
kubectl get hpa inventory-api-hpa -n inventory-system -w

# Delete HPA
kubectl delete hpa inventory-api-hpa -n inventory-system
```

#### 26.2.8 Pod Disruption Budget

**File: `infrastructure/kubernetes/pdb.yaml`**
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: inventory-api-pdb
  namespace: inventory-system
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: inventory-api
```

**Commands:**
```bash
# Apply PDB
kubectl apply -f infrastructure/kubernetes/pdb.yaml

# Get PDB
kubectl get pdb -n inventory-system

# Describe PDB
kubectl describe pdb inventory-api-pdb -n inventory-system
```

#### 26.2.9 Service Account and RBAC

**File: `infrastructure/kubernetes/serviceaccount.yaml`**
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: inventory-api-sa
  namespace: inventory-system
  labels:
    app: inventory-api
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: inventory-api-role
  namespace: inventory-system
rules:
- apiGroups: [""]
  resources: ["configmaps", "secrets"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: inventory-api-rolebinding
  namespace: inventory-system
subjects:
- kind: ServiceAccount
  name: inventory-api-sa
  namespace: inventory-system
roleRef:
  kind: Role
  name: inventory-api-role
  apiGroup: rbac.authorization.k8s.io
```

**Commands:**
```bash
# Apply service account and RBAC
kubectl apply -f infrastructure/kubernetes/serviceaccount.yaml

# Get service accounts
kubectl get serviceaccounts -n inventory-system

# Get roles
kubectl get roles -n inventory-system

# Get role bindings
kubectl get rolebindings -n inventory-system
```

#### 26.2.10 Network Policy

**File: `infrastructure/kubernetes/networkpolicy.yaml`**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: inventory-api-netpol
  namespace: inventory-system
spec:
  podSelector:
    matchLabels:
      app: inventory-api
  policyTypes:
  - Ingress
  - Egress
  ingress:
  # Allow ingress from ingress controller
  - from:
    - namespaceSelector:
        matchLabels:
          name: ingress-nginx
    ports:
    - protocol: TCP
      port: 8000
  # Allow ingress from monitoring namespace
  - from:
    - namespaceSelector:
        matchLabels:
          name: monitoring
    ports:
    - protocol: TCP
      port: 8000
  egress:
  # Allow egress to database
  - to:
    - podSelector:
        matchLabels:
          app: postgresql
    ports:
    - protocol: TCP
      port: 5432
  # Allow egress to Redis
  - to:
    - podSelector:
        matchLabels:
          app: redis
    ports:
    - protocol: TCP
      port: 6379
  # Allow DNS
  - to:
    - namespaceSelector: {}
    ports:
    - protocol: UDP
      port: 53
  # Allow HTTPS to external services
  - to: []
    ports:
    - protocol: TCP
      port: 443
```

**Commands:**
```bash
# Apply network policy
kubectl apply -f infrastructure/kubernetes/networkpolicy.yaml

# Get network policies
kubectl get networkpolicies -n inventory-system

# Describe network policy
kubectl describe networkpolicy inventory-api-netpol -n inventory-system
```

### 26.3 Environment-Specific Configurations

#### 26.3.1 Development Environment

**File: `infrastructure/kubernetes/environments/dev/deployment.yaml`**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventory-api-dev
  namespace: dev
spec:
  replicas: 1
  template:
    spec:
      containers:
      - name: inventory-api
        image: yourregistry.azurecr.io/inventory-management-api:dev
        resources:
          requests:
            cpu: "100m"
            memory: "256Mi"
          limits:
            cpu: "500m"
            memory: "512Mi"
```

#### 26.3.2 Production Environment

**File: `infrastructure/kubernetes/environments/prod/deployment.yaml`**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventory-api-prod
  namespace: production
spec:
  replicas: 5
  template:
    spec:
      containers:
      - name: inventory-api
        image: yourregistry.azurecr.io/inventory-management-api:prod
        resources:
          requests:
            cpu: "1000m"
            memory: "1Gi"
          limits:
            cpu: "4000m"
            memory: "4Gi"
```

### 26.4 Kubernetes Deployment Commands

#### 26.4.1 Complete Deployment Script

**File: `scripts/deploy-k8s.sh`**
```bash
#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
NAMESPACE=${ENVIRONMENT}
KUBECTL_OPTS="--namespace=${NAMESPACE}"

echo "Deploying to ${ENVIRONMENT} environment..."

# Create namespace if it doesn't exist
kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

# Apply ConfigMap
kubectl apply -f infrastructure/kubernetes/configmap.yaml ${KUBECTL_OPTS}

# Apply Secrets (from Azure Key Vault in production)
if [ "${ENVIRONMENT}" == "production" ]; then
    echo "Using Azure Key Vault for secrets..."
    # Secrets should be synced from Key Vault
else
    kubectl apply -f infrastructure/kubernetes/secret.yaml ${KUBECTL_OPTS}
fi

# Apply Service Account
kubectl apply -f infrastructure/kubernetes/serviceaccount.yaml ${KUBECTL_OPTS}

# Apply Deployment
kubectl apply -f infrastructure/kubernetes/deployment.yaml ${KUBECTL_OPTS}

# Apply Service
kubectl apply -f infrastructure/kubernetes/service.yaml ${KUBECTL_OPTS}

# Apply Ingress (only for production)
if [ "${ENVIRONMENT}" == "production" ]; then
    kubectl apply -f infrastructure/kubernetes/ingress.yaml ${KUBECTL_OPTS}
fi

# Apply HPA
kubectl apply -f infrastructure/kubernetes/hpa.yaml ${KUBECTL_OPTS}

# Apply PDB
kubectl apply -f infrastructure/kubernetes/pdb.yaml ${KUBECTL_OPTS}

# Wait for rollout
kubectl rollout status deployment/inventory-api ${KUBECTL_OPTS} --timeout=5m

echo "Deployment completed successfully!"
```

**Usage:**
```bash
# Make executable
chmod +x scripts/deploy-k8s.sh

# Deploy to dev
./scripts/deploy-k8s.sh dev

# Deploy to production
./scripts/deploy-k8s.sh production
```

### 26.5 Kubernetes Troubleshooting Commands

```bash
# Get all resources in namespace
kubectl get all -n inventory-system

# Describe pod for detailed info
kubectl describe pod <pod-name> -n inventory-system

# View pod logs
kubectl logs <pod-name> -n inventory-system

# Follow logs
kubectl logs -f <pod-name> -n inventory-system

# View logs from all pods
kubectl logs -f -l app=inventory-api -n inventory-system

# Execute command in pod
kubectl exec -it <pod-name> -n inventory-system -- /bin/bash

# Get events
kubectl get events -n inventory-system --sort-by='.lastTimestamp'

# Check resource usage
kubectl top pods -n inventory-system
kubectl top nodes

# Port forward for debugging
kubectl port-forward <pod-name> 8000:8000 -n inventory-system

# Check service endpoints
kubectl get endpoints inventory-api-service -n inventory-system

# Test service connectivity
kubectl run -it --rm debug --image=busybox --restart=Never -- \
  wget -qO- http://inventory-api-service:80/health
```

---

## 27. Terraform Infrastructure as Code

Terraform Infrastructure as Code (IaC) enables teams to define, provision, and manage cloud infrastructure using declarative configuration files that can be version controlled, reviewed, and tested like application code. This approach transforms infrastructure management from manual, error-prone operations into automated, repeatable processes that ensure consistency across environments. Terraform's declarative language describes desired infrastructure state, and Terraform automatically determines and executes the changes needed to achieve that state, handling dependencies, parallelization, and state management. The tool supports multiple cloud providers through plugins, enabling multi-cloud strategies and preventing vendor lock-in, while its state management system tracks resource relationships and enables safe updates and destruction. Effective Terraform usage requires understanding resource dependencies, state management, module organization, and best practices for security and maintainability, enabling teams to provision complex infrastructure reliably and efficiently.

### 27.1 Terraform Overview

Terraform is an open-source infrastructure provisioning tool that uses HashiCorp Configuration Language (HCL) to define infrastructure resources declaratively. Unlike imperative tools that require step-by-step commands, Terraform configuration describes the desired end state, and Terraform determines the execution plan to achieve it. The tool's core concepts include providers (plugins that interact with cloud APIs), resources (infrastructure components like virtual machines or databases), data sources (read-only information about existing infrastructure), modules (reusable configuration packages), and state (a record of managed resources). Terraform's plan-and-apply workflow enables teams to preview changes before execution, reducing the risk of unintended modifications, and its state locking prevents concurrent modifications that could corrupt infrastructure. The tool's extensive provider ecosystem supports hundreds of cloud services and platforms, making it a versatile choice for infrastructure automation across diverse technology stacks.

Terraform is used for infrastructure provisioning, providing:
- **Infrastructure as Code**: Version-controlled infrastructure
- **Multi-cloud Support**: Azure, AWS, GCP
- **State Management**: Track infrastructure state
- **Modularity**: Reusable modules
- **Plan and Apply**: Preview changes before applying

### 27.2 Complete Terraform Configuration

Complete Terraform configuration organizes infrastructure definitions into logical modules and files that enable maintainability, reusability, and clarity. The configuration structure separates concerns: main configuration files define resources, variable files declare inputs, output files expose important values, and provider configuration establishes cloud connections. Environment-specific variable files enable the same configuration to provision different environments with different sizes, regions, or feature sets. Module organization encapsulates related resources into reusable components, reducing duplication and enabling consistent patterns across projects. Effective Terraform configuration follows DRY (Don't Repeat Yourself) principles, uses meaningful variable names and descriptions, includes comprehensive outputs for integration with other tools, and implements security best practices like avoiding hardcoded secrets and using remote state backends.

#### 27.2.1 Main Configuration

Main Terraform configuration files define the actual infrastructure resources that will be provisioned, including compute resources, networking, storage, databases, and supporting services. These configurations use resource blocks to declare infrastructure components, with each resource specifying its type, name, and configuration parameters. Resource dependencies are handled automatically based on references, but explicit dependencies can be declared when needed. The configuration should organize resources logically, grouping related components together and using consistent naming conventions that reflect resource purpose and environment. Effective main configuration balances detail with readability, includes comments explaining non-obvious decisions, and follows cloud provider best practices for resource configuration, security, and cost optimization. The configuration should also include lifecycle rules that control resource creation, updates, and destruction behavior, enabling safe infrastructure evolution.

**File: `infrastructure/terraform/main.tf`**
```hcl
terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
  
  # Backend configuration (Azure Storage)
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateinventory"
    container_name       = "tfstate"
    key                  = "inventory-system.terraform.tfstate"
  }
}

# Configure Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-inventory-${var.environment}"
  location = var.location
  
  tags = {
    Environment = var.environment
    Project     = "Inventory Management System"
    ManagedBy   = "Terraform"
  }
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "acrinventory${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = var.environment == "production" ? "Premium" : "Standard"
  admin_enabled       = false
  
  network_rule_set {
    default_action = "Allow"
  }
  
  tags = azurerm_resource_group.main.tags
}

# Azure Kubernetes Service
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-inventory-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "inventory-${var.environment}"
  kubernetes_version  = var.kubernetes_version
  
  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.node_vm_size
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    min_count           = var.node_min_count
    max_count           = var.node_max_count
    os_disk_size_gb     = 50
    vnet_subnet_id      = azurerm_subnet.aks.id
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  role_based_access_control_enabled = true
  
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }
  
  addon_profile {
    http_application_routing {
      enabled = false
    }
    
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
    }
  }
  
  tags = azurerm_resource_group.main.tags
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-inventory-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  
  tags = azurerm_resource_group.main.tags
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = "appi-inventory-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.main.id
  
  tags = azurerm_resource_group.main.tags
}

# Azure PostgreSQL Server
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = "psql-inventory-${var.environment}"
  resource_group_name     = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  version                = "14"
  delegated_subnet_id    = azurerm_subnet.postgresql.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgresql.id
  administrator_login    = var.db_admin_login
  administrator_password = var.db_admin_password
  zone                   = "1"
  
  storage_mb = var.environment == "production" ? 32768 : 32768
  sku_name   = var.environment == "production" ? "GP_Standard_D2s_v3" : "B_Standard_B1ms"
  
  backup {
    geo_redundant_backup_enabled = var.environment == "production"
    backup_retention_days        = 7
  }
  
  high_availability {
    mode                      = var.environment == "production" ? "ZoneRedundant" : "Disabled"
    standby_availability_zone = "2"
  }
  
  maintenance_window {
    day_of_week  = 0
    start_hour   = 2
    start_minute = 0
  }
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgresql]
  
  tags = azurerm_resource_group.main.tags
}

# PostgreSQL Database
resource "azurerm_postgresql_flexible_database" "main" {
  name      = "inventory_db"
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# Azure Redis Cache
resource "azurerm_redis_cache" "main" {
  name                = "redis-inventory-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  capacity            = var.environment == "production" ? 2 : 0
  family              = var.environment == "production" ? "C" : "C"
  sku_name            = var.environment == "production" ? "Standard_C2" : "Basic_C0"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  
  redis_configuration {
    maxmemory_reserved = 2
    maxmemory_delta    = 2
    maxmemory_policy   = "allkeys-lru"
  }
  
  tags = azurerm_resource_group.main.tags
}

# Azure Key Vault
resource "azurerm_key_vault" "main" {
  name                = "kv-inventory-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  
  enabled_for_deployment          = true
  enabled_for_template_deployment  = true
  enabled_for_disk_encryption      = true
  
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
  
  tags = azurerm_resource_group.main.tags
}

# Key Vault Access Policy for AKS
resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  
  secret_permissions = [
    "Get",
    "List"
  ]
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-inventory-${var.environment}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  tags = azurerm_resource_group.main.tags
}

# AKS Subnet
resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
  
  delegation {
    name = "aks-delegation"
    service_delegation {
      name    = "Microsoft.ContainerService/managedClusters"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# PostgreSQL Subnet
resource "azurerm_subnet" "postgresql" {
  name                 = "snet-postgresql"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"
  
  delegation {
    name = "postgresql-delegation"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Private DNS Zone for PostgreSQL
resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgresql" {
  name                  = "postgresql-vnet-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = azurerm_virtual_network.main.id
}

# Application Gateway (for Ingress)
resource "azurerm_application_gateway" "main" {
  count = var.environment == "production" ? 1 : 0
  
  name                = "agw-inventory-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }
  
  gateway_ip_configuration {
    name      = "app-gateway-ip-config"
    subnet_id = azurerm_subnet.appgw[0].id
  }
  
  frontend_port {
    name = "http-port"
    port = 80
  }
  
  frontend_port {
    name = "https-port"
    port = 443
  }
  
  frontend_ip_configuration {
    name                 = "app-gateway-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw[0].id
  }
  
  backend_address_pool {
    name = "backend-pool"
  }
  
  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Enabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  
  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "app-gateway-frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }
  
  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name   = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
  }
  
  waf_configuration {
    enabled          = true
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }
  
  tags = azurerm_resource_group.main.tags
}

# Public IP for Application Gateway
resource "azurerm_public_ip" "appgw" {
  count = var.environment == "production" ? 1 : 0
  
  name                = "pip-appgw-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  
  tags = azurerm_resource_group.main.tags
}

# App Gateway Subnet
resource "azurerm_subnet" "appgw" {
  count = var.environment == "production" ? 1 : 0
  
  name                 = "snet-appgw"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

# Helm Provider
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  }
}
```

#### 27.2.2 Variables Configuration

Variables in Terraform provide a mechanism for parameterizing configurations, enabling reuse across environments and projects while maintaining flexibility. Variable declarations define the variable name, type, description, default value (if any), and validation rules, creating a contract for configuration consumers. Variables enable the same Terraform configuration to provision different environments (dev, staging, production) with different resource sizes, regions, or feature flags, reducing duplication and ensuring consistency. Variable validation ensures that inputs meet requirements, preventing invalid configurations that could cause provisioning failures or security issues. Effective variable design provides sensible defaults for common scenarios while exposing necessary customization points, includes comprehensive descriptions that explain purpose and constraints, and uses type constraints to catch errors early. Variable organization groups related variables together and uses naming conventions that clearly indicate purpose and scope.

**File: `infrastructure/terraform/variables.tf`**
```hcl
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, qa, staging, production)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "staging", "production"], var.environment)
    error_message = "Environment must be one of: dev, qa, staging, production"
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28.0"
}

variable "node_count" {
  description = "Default node pool node count"
  type        = number
  default     = 3
}

variable "node_min_count" {
  description = "Minimum node count for auto-scaling"
  type        = number
  default     = 1
}

variable "node_max_count" {
  description = "Maximum node count for auto-scaling"
  type        = number
  default     = 10
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "db_admin_login" {
  description = "PostgreSQL admin username"
  type        = string
  sensitive   = true
}

variable "db_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "Inventory Management System"
    ManagedBy   = "Terraform"
    Environment = ""
  }
}
```

#### 27.2.3 Outputs Configuration

Outputs in Terraform expose important values from provisioned infrastructure, enabling other systems, scripts, or Terraform configurations to consume these values. Outputs typically include resource identifiers, connection strings, endpoint URLs, and other values needed for application configuration or integration with CI/CD pipelines. Well-designed outputs provide all necessary information for downstream processes while avoiding exposure of sensitive data that should be managed through secret management systems. Outputs enable modular Terraform configurations where modules expose values that parent configurations consume, creating composable infrastructure patterns. Effective output design includes descriptive names and comments explaining output purpose, uses sensitive flags to prevent accidental exposure in logs, and organizes outputs logically to make them easy to find and use. Outputs also serve as documentation, showing what important values are available from a configuration.

**File: `infrastructure/terraform/outputs.tf`**
```hcl
output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_kube_config" {
  description = "AKS kubeconfig"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "acr_name" {
  description = "Azure Container Registry name"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "ACR login server URL"
  value       = azurerm_container_registry.acr.login_server
}

output "postgresql_server_name" {
  description = "PostgreSQL server name"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "postgresql_server_fqdn" {
  description = "PostgreSQL server FQDN"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "redis_cache_name" {
  description = "Redis cache name"
  value       = azurerm_redis_cache.main.name
}

output "redis_cache_hostname" {
  description = "Redis cache hostname"
  value       = azurerm_redis_cache.main.hostname
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.main.vault_uri
}

output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Application Insights connection string"
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
}
```

#### 27.2.4 Environment-Specific Variables

**File: `infrastructure/terraform/environments/dev/terraform.tfvars`**
```hcl
environment        = "dev"
location           = "East US"
node_count         = 1
node_min_count     = 1
node_max_count     = 3
node_vm_size       = "Standard_B2s"
kubernetes_version = "1.28.0"
```

**File: `infrastructure/terraform/environments/production/terraform.tfvars`**
```hcl
environment        = "production"
location           = "East US"
node_count         = 3
node_min_count     = 3
node_max_count     = 10
node_vm_size       = "Standard_D4s_v3"
kubernetes_version = "1.28.0"
```

### 27.3 Terraform Commands

Terraform commands provide the interface for interacting with Terraform configurations, enabling initialization, planning, application, and state management operations. Understanding these commands and their options is essential for effective Terraform usage, as different commands serve different purposes in the infrastructure lifecycle. Command-line options enable fine-grained control over Terraform behavior, such as targeting specific resources, specifying variable values, or controlling parallelism. Effective command usage includes understanding when to use different commands, what options are available, and how commands interact with Terraform state and remote backends. Mastery of Terraform commands enables efficient infrastructure management, troubleshooting, and integration with CI/CD pipelines.

#### 27.3.1 Initialization and Setup

Terraform initialization (`terraform init`) prepares a working directory for Terraform operations by downloading required providers, setting up backend configuration, and installing modules. This command must be run before other Terraform commands and should be rerun when provider versions change or modules are added. Initialization establishes the connection to remote state backends, downloads provider plugins, and prepares the working directory structure. The initialization process creates a `.terraform` directory containing provider binaries and module sources, which should be excluded from version control. Effective initialization practices include using version constraints in provider blocks to ensure consistent provider versions, configuring remote state backends for team collaboration, and verifying initialization success before proceeding with planning or application operations.

```bash
# Initialize Terraform
cd infrastructure/terraform
terraform init

# Initialize with backend
terraform init \
  -backend-config="resource_group_name=rg-terraform-state" \
  -backend-config="storage_account_name=tfstateinventory" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=inventory-system.terraform.tfstate"

# Format Terraform files
terraform fmt -recursive

# Validate configuration
terraform validate

# Check current state
terraform state list

# Show current state
terraform show
```

#### 27.3.2 Planning and Applying

Terraform planning (`terraform plan`) generates an execution plan showing what changes Terraform will make to achieve the desired state, enabling review before execution. The plan output details resource creation, modification, and destruction, helping teams understand the impact of configuration changes. Planning enables teams to catch errors early, review changes with stakeholders, and ensure that modifications align with expectations before applying them. The apply command (`terraform apply`) executes the plan, making actual changes to infrastructure, and it can operate in interactive mode (requiring confirmation) or automated mode (with auto-approve flag) for CI/CD integration. Effective planning and application practices include always reviewing plans before applying, using plan files to ensure apply matches plan, and understanding plan output to verify that changes are correct and expected.

```bash
# Set environment variable
export TF_VAR_environment=dev
export TF_VAR_subscription_id="your-subscription-id"
export TF_VAR_tenant_id="your-tenant-id"
export TF_VAR_db_admin_login="admin"
export TF_VAR_db_admin_password="secure-password"

# Or use tfvars file
terraform plan -var-file=environments/dev/terraform.tfvars

# Plan with specific variables
terraform plan \
  -var="environment=dev" \
  -var="node_count=2"

# Apply changes
terraform apply -var-file=environments/dev/terraform.tfvars

# Apply with auto-approve
terraform apply -var-file=environments/dev/terraform.tfvars -auto-approve

# Apply specific resource
terraform apply -target=azurerm_kubernetes_cluster.aks

# Destroy infrastructure
terraform destroy -var-file=environments/dev/terraform.tfvars
```

#### 27.3.3 State Management

```bash
# List resources in state
terraform state list

# Show resource details
terraform state show azurerm_kubernetes_cluster.aks

# Move resource in state
terraform state mv azurerm_resource_group.old azurerm_resource_group.new

# Remove resource from state (not destroy)
terraform state rm azurerm_resource_group.old

# Import existing resource
terraform import azurerm_resource_group.main /subscriptions/.../resourceGroups/rg-inventory-dev

# Refresh state
terraform refresh

# Output values
terraform output
terraform output aks_cluster_name
terraform output -json
```

#### 27.3.4 Workspace Management

```bash
# List workspaces
terraform workspace list

# Create workspace
terraform workspace new dev
terraform workspace new production

# Select workspace
terraform workspace select dev

# Show current workspace
terraform workspace show

# Delete workspace
terraform workspace delete old-workspace
```

### 27.4 Terraform Modules

#### 27.4.1 AKS Module

**File: `infrastructure/terraform/modules/aks/main.tf`**
```hcl
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  
  default_node_pool {
    name                = var.node_pool_name
    node_count          = var.node_count
    vm_size             = var.vm_size
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.min_count
    max_count           = var.max_count
    vnet_subnet_id      = var.subnet_id
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  role_based_access_control_enabled = true
  
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }
  
  tags = var.tags
}
```

**File: `infrastructure/terraform/modules/aks/variables.tf`**
```hcl
variable "cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.28.0"
}

variable "node_pool_name" {
  type    = string
  default = "default"
}

variable "node_count" {
  type    = number
  default = 3
}

variable "vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "enable_auto_scaling" {
  type    = bool
  default = true
}

variable "min_count" {
  type    = number
  default = 1
}

variable "max_count" {
  type    = number
  default = 10
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
```

**Usage:**
```hcl
module "aks" {
  source = "./modules/aks"
  
  cluster_name        = "aks-inventory-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "inventory-${var.environment}"
  kubernetes_version  = var.kubernetes_version
  node_count          = var.node_count
  vm_size             = var.node_vm_size
  subnet_id           = azurerm_subnet.aks.id
  tags                = azurerm_resource_group.main.tags
}
```

### 27.5 Terraform Scripts

#### 27.5.1 Deployment Script

**File: `scripts/terraform-deploy.sh`**
```bash
#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
TERRAFORM_DIR="infrastructure/terraform"

if [ ! -d "${TERRAFORM_DIR}/environments/${ENVIRONMENT}" ]; then
    echo "Error: Environment ${ENVIRONMENT} not found"
    exit 1
fi

cd ${TERRAFORM_DIR}

echo "Initializing Terraform..."
terraform init

echo "Selecting workspace..."
terraform workspace select ${ENVIRONMENT} || terraform workspace new ${ENVIRONMENT}

echo "Planning infrastructure changes..."
terraform plan \
  -var-file="environments/${ENVIRONMENT}/terraform.tfvars" \
  -out=tfplan

echo "Applying infrastructure changes..."
terraform apply tfplan

echo "Getting outputs..."
terraform output

echo "Infrastructure deployment completed!"
```

**Usage:**
```bash
chmod +x scripts/terraform-deploy.sh
./scripts/terraform-deploy.sh dev
./scripts/terraform-deploy.sh production
```

---

## 28. Kubernetes and Terraform Integration

Kubernetes and Terraform integration combines infrastructure provisioning with application deployment, creating a complete automation pipeline that provisions cloud resources and deploys containerized applications. This integration enables teams to manage the entire stack—from cloud infrastructure to application containers—using Infrastructure as Code principles, ensuring consistency, reproducibility, and version control throughout the deployment process. Terraform provisions the foundational infrastructure including Kubernetes clusters, container registries, databases, and networking, while Kubernetes manifests define how applications run within those clusters. The integration requires careful coordination to ensure that infrastructure is ready before application deployment, that credentials and connection strings are properly passed from Terraform outputs to Kubernetes configurations, and that both systems work together seamlessly. Effective integration patterns include using Terraform outputs to populate Kubernetes ConfigMaps and Secrets, coordinating deployment sequences through CI/CD pipelines, and maintaining separation of concerns where Terraform manages infrastructure lifecycle and Kubernetes manages application lifecycle.

### 28.1 Complete Deployment Flow

The complete deployment flow orchestrates the sequence of operations needed to go from code changes to running applications, coordinating Terraform infrastructure provisioning with Kubernetes application deployment. This flow typically starts with Terraform provisioning or updating infrastructure resources, then retrieves connection information and credentials needed for application deployment. The flow then transitions to Kubernetes operations, creating or updating namespaces, applying configuration, and deploying application manifests. Each stage includes validation steps that verify success before proceeding, and the flow supports rollback capabilities at multiple points if issues are detected. Understanding the complete flow helps teams design CI/CD pipelines that coordinate both infrastructure and application changes, ensuring that deployments are reliable, traceable, and reversible. The flow also highlights dependencies between stages, such as the need for AKS cluster credentials before Kubernetes operations can proceed, enabling proper sequencing and error handling.

```
┌─────────────────────────────────────────────────────────┐
│         INFRASTRUCTURE DEPLOYMENT FLOW                   │
└─────────────────────────────────────────────────────────┘

1. Terraform Provisioning
   ├── Initialize Terraform
   ├── Plan infrastructure changes
   ├── Apply infrastructure
   └── Output AKS credentials

2. Kubernetes Configuration
   ├── Get AKS credentials
   ├── Create namespaces
   ├── Apply ConfigMaps
   ├── Apply Secrets (from Key Vault)
   └── Apply Kubernetes manifests

3. Application Deployment
   ├── Build Docker image
   ├── Push to ACR
   ├── Update Kubernetes deployment
   └── Verify deployment
```

### 28.2 Integrated CI/CD Pipeline with Terraform and Kubernetes

**File: `azure-pipelines-infrastructure.yml`**
```yaml
name: Infrastructure Pipeline

trigger:
  branches:
    include:
      - main
      - develop
  paths:
    include:
      - infrastructure/terraform/*

pool:
  vmImage: 'ubuntu-latest'

variables:
  terraformVersion: '1.5.0'
  environment: $[coalesce(variables['Environment'], 'dev')]

stages:
- stage: TerraformPlan
  displayName: 'Terraform Plan'
  jobs:
  - job: Plan
    displayName: 'Plan Infrastructure'
    steps:
    - task: TerraformInstaller@0
      inputs:
        terraformVersion: '$(terraformVersion)'
      displayName: 'Install Terraform'
    
    - task: AzureCLI@2
      inputs:
        azureSubscription: 'Azure-Service-Connection'
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          az account set --subscription $(subscriptionId)
          az account show
      displayName: 'Azure Login'
    
    - script: |
        cd infrastructure/terraform
        terraform init \
          -backend-config="resource_group_name=$(tfStateResourceGroup)" \
          -backend-config="storage_account_name=$(tfStateStorageAccount)" \
          -backend-config="container_name=$(tfStateContainer)" \
          -backend-config="key=$(tfStateKey)"
      displayName: 'Terraform Init'
    
    - script: |
        cd infrastructure/terraform
        terraform workspace select $(environment) || terraform workspace new $(environment)
      displayName: 'Select Workspace'
    
    - script: |
        cd infrastructure/terraform
        terraform plan \
          -var-file="environments/$(environment)/terraform.tfvars" \
          -out=tfplan \
          -detailed-exitcode
      displayName: 'Terraform Plan'
      continueOnError: true
    
    - task: PublishBuildArtifacts@1
      inputs:
        pathToPublish: 'infrastructure/terraform/tfplan'
        artifactName: 'terraform-plan-$(environment)'
      displayName: 'Publish Plan'

- stage: TerraformApply
  displayName: 'Terraform Apply'
  dependsOn: TerraformPlan
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - deployment: Apply
    displayName: 'Apply Infrastructure'
    environment: 'Infrastructure-$(environment)'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: ManualValidation@0
            inputs:
              notifyUsers: 'devops-team@company.com'
              instructions: 'Review Terraform plan and approve infrastructure changes'
              onTimeout: 'reject'
          
          - task: TerraformInstaller@0
            inputs:
              terraformVersion: '$(terraformVersion)'
          
          - task: DownloadBuildArtifacts@0
            inputs:
              buildType: 'current'
              downloadType: 'specific'
              itemPattern: 'terraform-plan-$(environment)/tfplan'
              downloadPath: '$(System.ArtifactsDirectory)'
          
          - script: |
              cd infrastructure/terraform
              terraform apply -auto-approve $(System.ArtifactsDirectory)/terraform-plan-$(environment)/tfplan
            displayName: 'Terraform Apply'
          
          - script: |
              cd infrastructure/terraform
              terraform output -json > terraform-outputs.json
            displayName: 'Get Terraform Outputs'
          
          - task: PublishBuildArtifacts@1
            inputs:
              pathToPublish: 'infrastructure/terraform/terraform-outputs.json'
              artifactName: 'terraform-outputs-$(environment)'

- stage: KubernetesDeploy
  displayName: 'Deploy to Kubernetes'
  dependsOn: TerraformApply
  jobs:
  - deployment: DeployK8s
    displayName: 'Deploy Kubernetes Manifests'
    environment: 'Kubernetes-$(environment)'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureCLI@2
            inputs:
              azureSubscription: 'Azure-Service-Connection'
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                # Get AKS credentials from Terraform outputs
                AKS_NAME=$(terraform output -raw aks_cluster_name)
                RESOURCE_GROUP=$(terraform output -raw resource_group_name)
                
                az aks get-credentials \
                  --resource-group $RESOURCE_GROUP \
                  --name $AKS_NAME \
                  --overwrite-existing
                
                kubectl cluster-info
            displayName: 'Get AKS Credentials'
          
          - script: |
              # Create namespace
              kubectl create namespace $(environment) --dry-run=client -o yaml | kubectl apply -f -
              
              # Apply Kubernetes manifests
              kubectl apply -f infrastructure/kubernetes/namespace.yaml
              kubectl apply -f infrastructure/kubernetes/configmap.yaml -n $(environment)
              kubectl apply -f infrastructure/kubernetes/serviceaccount.yaml -n $(environment)
              kubectl apply -f infrastructure/kubernetes/deployment.yaml -n $(environment)
              kubectl apply -f infrastructure/kubernetes/service.yaml -n $(environment)
              
              if [ "$(environment)" == "production" ]; then
                kubectl apply -f infrastructure/kubernetes/ingress.yaml -n $(environment)
              fi
              
              kubectl apply -f infrastructure/kubernetes/hpa.yaml -n $(environment)
              kubectl apply -f infrastructure/kubernetes/pdb.yaml -n $(environment)
            displayName: 'Apply Kubernetes Manifests'
          
          - script: |
              kubectl rollout status deployment/inventory-api -n $(environment) --timeout=5m
            displayName: 'Wait for Rollout'
          
          - script: |
              kubectl get pods -n $(environment)
              kubectl get services -n $(environment)
              kubectl get ingress -n $(environment) || true
            displayName: 'Verify Deployment'
```

### 28.3 Combined Deployment Script

**File: `scripts/deploy-full-stack.sh`**
```bash
#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}

echo "=========================================="
echo "Deploying Full Stack to ${ENVIRONMENT}"
echo "=========================================="

# Step 1: Terraform Infrastructure
echo ""
echo "Step 1: Provisioning Infrastructure with Terraform..."
cd infrastructure/terraform
terraform init
terraform workspace select ${ENVIRONMENT} || terraform workspace new ${ENVIRONMENT}
terraform plan -var-file="environments/${ENVIRONMENT}/terraform.tfvars" -out=tfplan
read -p "Review plan and press Enter to apply..."
terraform apply tfplan

# Get outputs
AKS_NAME=$(terraform output -raw aks_cluster_name)
RESOURCE_GROUP=$(terraform output -raw resource_group_name)
ACR_NAME=$(terraform output -raw acr_name)

# Step 2: Get AKS Credentials
echo ""
echo "Step 2: Getting AKS Credentials..."
az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${AKS_NAME} --overwrite-existing

# Step 3: Deploy Kubernetes Resources
echo ""
echo "Step 3: Deploying Kubernetes Resources..."
cd ../kubernetes

# Create namespace
kubectl create namespace ${ENVIRONMENT} --dry-run=client -o yaml | kubectl apply -f -

# Apply all manifests
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml -n ${ENVIRONMENT}
kubectl apply -f serviceaccount.yaml -n ${ENVIRONMENT}
kubectl apply -f deployment.yaml -n ${ENVIRONMENT}
kubectl apply -f service.yaml -n ${ENVIRONMENT}

if [ "${ENVIRONMENT}" == "production" ]; then
    kubectl apply -f ingress.yaml -n ${ENVIRONMENT}
fi

kubectl apply -f hpa.yaml -n ${ENVIRONMENT}
kubectl apply -f pdb.yaml -n ${ENVIRONMENT}

# Step 4: Wait for Deployment
echo ""
echo "Step 4: Waiting for Deployment..."
kubectl rollout status deployment/inventory-api -n ${ENVIRONMENT} --timeout=5m

# Step 5: Verify
echo ""
echo "Step 5: Verifying Deployment..."
kubectl get pods -n ${ENVIRONMENT}
kubectl get services -n ${ENVIRONMENT}
kubectl get ingress -n ${ENVIRONMENT} || true

echo ""
echo "=========================================="
echo "Deployment Completed Successfully!"
echo "=========================================="
```

**Usage:**
```bash
chmod +x scripts/deploy-full-stack.sh
./scripts/deploy-full-stack.sh dev
./scripts/deploy-full-stack.sh production
```

### 28.4 Key Vault Integration for Secrets

**File: `scripts/sync-secrets-from-keyvault.sh`**
```bash
#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
KEY_VAULT_NAME="kv-inventory-${ENVIRONMENT}"
NAMESPACE=${ENVIRONMENT}

echo "Syncing secrets from Azure Key Vault to Kubernetes..."

# Install CSI Secret Store Driver (if not installed)
kubectl apply -f https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/deployment/provider-azure-installer.yaml

# Create SecretProviderClass
cat <<EOF | kubectl apply -f -
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: inventory-api-secrets
  namespace: ${NAMESPACE}
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    useVMManagedIdentity: "true"
    userAssignedIdentityID: "<managed-identity-id>"
    keyvaultName: ${KEY_VAULT_NAME}
    objects: |
      array:
        - |
          objectName: database-url
          objectType: secret
          objectVersion: ""
        - |
          objectName: jwt-secret-key
          objectType: secret
          objectVersion: ""
        - |
          objectName: api-key
          objectType: secret
          objectVersion: ""
    tenantId: "<tenant-id>"
  secretObjects:
  - secretName: inventory-api-secrets
    type: Opaque
    data:
    - objectName: database-url
      key: DATABASE_URL
    - objectName: jwt-secret-key
      key: JWT_SECRET_KEY
    - objectName: api-key
      key: API_KEY
EOF

echo "SecretProviderClass created. Secrets will be synced automatically."
```

### 28.5 Complete Project Flow with Terraform and Kubernetes

```
┌─────────────────────────────────────────────────────────┐
│         COMPLETE DEPLOYMENT FLOW                         │
└─────────────────────────────────────────────────────────┘

PHASE 1: Infrastructure Provisioning (Terraform)
├── Initialize Terraform backend
├── Plan infrastructure changes
├── Review and approve plan
├── Apply infrastructure
│   ├── Create Resource Group
│   ├── Create AKS Cluster
│   ├── Create ACR
│   ├── Create PostgreSQL
│   ├── Create Redis
│   ├── Create Key Vault
│   └── Create Networking
└── Output infrastructure details

PHASE 2: Kubernetes Setup
├── Get AKS credentials
├── Create namespaces
├── Create ConfigMaps
├── Sync secrets from Key Vault
├── Create Service Accounts
└── Apply RBAC

PHASE 3: Application Deployment
├── Build Docker image
├── Push to ACR
├── Update Kubernetes deployment
├── Apply Service
├── Apply Ingress (production)
├── Apply HPA
└── Apply PDB

PHASE 4: Verification
├── Check pod status
├── Check service endpoints
├── Run health checks
├── Verify ingress
└── Monitor metrics
```

### 28.6 Quick Reference Commands

#### 28.6.1 Terraform Quick Reference

```bash
# Initialize
terraform init

# Plan
terraform plan -var-file=environments/dev/terraform.tfvars

# Apply
terraform apply -var-file=environments/dev/terraform.tfvars

# Destroy
terraform destroy -var-file=environments/dev/terraform.tfvars

# Outputs
terraform output
terraform output aks_cluster_name

# State
terraform state list
terraform state show <resource>
terraform refresh
```

#### 28.6.2 Kubernetes Quick Reference

```bash
# Get credentials
az aks get-credentials --resource-group rg-inventory-dev --name aks-inventory-dev

# Apply manifests
kubectl apply -f infrastructure/kubernetes/deployment.yaml -n dev

# Get resources
kubectl get pods,services,deployments -n dev

# View logs
kubectl logs -f deployment/inventory-api -n dev

# Scale
kubectl scale deployment inventory-api --replicas=5 -n dev

# Rollout
kubectl rollout status deployment/inventory-api -n dev
kubectl rollout undo deployment/inventory-api -n dev
```

#### 28.6.3 Combined Workflow

```bash
# Full stack deployment
./scripts/deploy-full-stack.sh dev

# Infrastructure only
cd infrastructure/terraform
terraform apply -var-file=environments/dev/terraform.tfvars

# Kubernetes only
./scripts/deploy-k8s.sh dev

# Update application
kubectl set image deployment/inventory-api \
  inventory-api=yourregistry.azurecr.io/inventory-api:v1.1.0 \
  -n dev
```

### 28.7 Best Practices

#### 28.7.1 Terraform Best Practices

1. **State Management**
   - Use remote state (Azure Storage)
   - Enable state locking
   - Never commit state files
   - Use workspaces for environments

2. **Variable Management**
   - Use `.tfvars` files for environments
   - Mark sensitive variables
   - Use variable validation
   - Document all variables

3. **Module Organization**
   - Create reusable modules
   - Keep modules focused
   - Version modules
   - Document module usage

4. **Security**
   - Use Azure Key Vault for secrets
   - Enable RBAC
   - Use managed identities
   - Encrypt state files

#### 28.7.2 Kubernetes Best Practices

1. **Resource Management**
   - Set resource requests and limits
   - Use HPA for auto-scaling
   - Implement PDB for availability
   - Monitor resource usage

2. **Security**
   - Use RBAC
   - Implement network policies
   - Use secrets management
   - Scan container images

3. **Deployment**
   - Use rolling updates
   - Implement health checks
   - Use readiness probes
   - Monitor deployments

4. **Configuration**
   - Use ConfigMaps for config
   - Use Secrets for sensitive data
   - Use namespaces for isolation
   - Label resources properly

### 28.8 Troubleshooting

#### 28.8.1 Terraform Issues

**Issue: State Lock**
```bash
# Force unlock (use with caution)
terraform force-unlock <lock-id>
```

**Issue: Resource Already Exists**
```bash
# Import existing resource
terraform import azurerm_resource_group.main /subscriptions/.../resourceGroups/rg-inventory-dev
```

**Issue: Provider Version Conflicts**
```bash
# Update provider versions
terraform init -upgrade
```

#### 28.8.2 Kubernetes Issues

**Issue: Pod Not Starting**
```bash
# Check pod events
kubectl describe pod <pod-name> -n dev

# Check logs
kubectl logs <pod-name> -n dev

# Check resource quotas
kubectl describe quota -n dev
```

**Issue: Image Pull Errors**
```bash
# Check image pull secrets
kubectl get secrets -n dev

# Create image pull secret
kubectl create secret docker-registry acr-secret \
  --docker-server=yourregistry.azurecr.io \
  --docker-username=<service-principal-id> \
  --docker-password=<service-principal-password> \
  -n dev
```

**Issue: Service Not Accessible**
```bash
# Check service endpoints
kubectl get endpoints <service-name> -n dev

# Check service selector
kubectl get service <service-name> -n dev -o yaml

# Test connectivity
kubectl run -it --rm debug --image=busybox --restart=Never -- \
  wget -qO- http://<service-name>:80/health
```

---

## Conclusion

This comprehensive Azure DevOps project flow document provides a complete guide for managing the FastAPI Inventory Management System through Azure DevOps. It covers all aspects from initial setup to production deployment, monitoring, and continuous improvement.

### Key Highlights:

1. **Complete Lifecycle Coverage**: From project initiation to post-production support
2. **Detailed Workflows**: Step-by-step processes for all activities
3. **Practical Tools**: Ready-to-use scripts and checklists
4. **Best Practices**: Industry-standard approaches and patterns
5. **Comprehensive Documentation**: Every aspect explained in detail

### Document Structure:

- **Sections 1-17**: Core concepts and setup
- **Sections 18-22**: Operations and troubleshooting
- **Sections 23-24**: Tools and utilities
- **Section 25**: Complete project flow and lifecycle

### Usage Guidelines:

1. **For New Projects**: Follow sections 1-3 for initial setup
2. **For Development**: Reference sections 4-9 for daily work
3. **For Deployment**: Use sections 7-8 and checklists in section 23
4. **For Troubleshooting**: Refer to section 18
5. **For Operations**: Use sections 12-17 and scripts in section 24

### Maintenance:

- **Weekly**: Update metrics and dashboards
- **Monthly**: Review and update processes
- **Quarterly**: Major document review and updates
- **After Incidents**: Update runbooks and procedures
- **After Releases**: Update changelog and documentation

Regular updates to this document are recommended as the project evolves and new practices are adopted.

**Last Updated**: February 2026
**Version**: 2.0.0
**Maintained By**: DevOps Team
**Next Review**: March 2026
