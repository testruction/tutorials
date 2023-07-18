#!/usr/bin/env bats


@test "Clone the Web application source code" {
    git clone https://github.com/testruction/fastapi-sqlalchemy-cockroachdb
    cd fastapi-sqlalchemy-cockroachdb
    git checkout -b feature/helm-chart
}

@test "Created initial chart" {
    cd fastapi-sqlalchemy-cockroachdb

    helm create ./chart
}

@test "Create and populate components directories" {
    cd fastapi-sqlalchemy-cockroachdb

    mkdir -p chart/templates/backend chart/templates/frontend
    cp chart/templates/*.yaml chart/templates/backend/
    cp chart/templates/*.yaml chart/templates/frontend/
    rm -vf chart/templates/*.yaml
}

@test "Create configuration sections for earch components" {
    cd fastapi-sqlalchemy-cockroachdb

    cat chart/values.yaml | head -4 > /tmp/values.yaml 
    
    tail +5 chart/values.yaml | yq '{"backend": .}' >> /tmp/values.yaml
    tail +5 chart/values.yaml | yq '{"frontend": .}' >> /tmp/values.yaml
    
    yq /tmp/values.yaml
    mv /tmp/values.yaml chart/values.yaml
}

@test "Record changes to the Git history" {
    cd fastapi-sqlalchemy-cockroachdb

    git config user.name 'Helm Student'
    git config user.email 'student.helm@testruction.lab'

    git add .
    git status
    git status -v

    git commit -m 'Initial helm chart commit'
}

@test "Reflect the new configuration structure in the templates" {
    cd fastapi-sqlalchemy-cockroachdb

    # Backend
    sed -i 's/\.Values\./.Values.backend./g' chart/templates/backend/*.yaml
    # Frontend
    sed -i 's/\.Values\./.Values.frontend./g' chart/templates/frontend/*.yaml

    git add .
    git status -v
    git commit -m 'Updated configuration values'
}

@test "Suffix Kubernetes resources" {
    cd fastapi-sqlalchemy-cockroachdb

    # Backend
    sed -i 's/^\(\s\{2\}name\:\s.*\)$/\1-backend/g' chart/templates/backend/*.yaml

    # Frontend
    sed -i 's/^\(\s\{2\}name\:\s.*\)$/\1-frontend/g' chart/templates/frontend/*.yaml

    git add .
    git status -v
    git commit -m 'Added component suffix to resources name'
}

@test "Allocate dinstinct container images" {
    cd fastapi-sqlalchemy-cockroachdb

    yq -i '.backend.image.repository = "testruction/fastapi-sqlalchemy-cockroachdb/backend"' chart/values.yaml
    yq -i '.frontend.image.repository = "testruction/fastapi-sqlalchemy-cockroachdb/frontend"' chart/values.yaml
}

@test "Update containers ports" {
    cd fastapi-sqlalchemy-cockroachdb

    sed -i 's/containerPort: 80/containerPort: 8000/g' chart/templates/backend/deployment.yaml
    sed -i 's/containerPort: 80/containerPort: 8000/g' chart/templates/frontend/deployment.yaml
}

@test "" {
    export SOURCE_URL=$(git config --get remote.origin.url)

    yq '.sources[0] = strenv(SOURCE_URL)' chart/Chart.yaml
    yq '.home = strenv(SOURCE_URL)' chart/Chart.yaml
    yq '.description = strenv(SOURCE_URL)' chart/Chart.yaml

    git commit -a -m 'Added source URL to chart definition'
}