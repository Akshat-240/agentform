#!/bin/bash
# Run tests for all ACP libraries
# Usage: ./scripts/run_tests.sh [pytest-args]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Running ACP Test Suite ===${NC}\n"

# Function to run tests for a specific library
run_lib_tests() {
    local lib_name="$1"
    local lib_path="$2"
    
    echo -e "${BLUE}Testing ${lib_name}...${NC}"
    
    if cd "$lib_path" && poetry run pytest "${@:3}"; then
        echo -e "${GREEN}✓ ${lib_name} tests passed${NC}\n"
        cd "$PROJECT_ROOT"
        return 0
    else
        echo -e "${RED}✗ ${lib_name} tests failed${NC}\n"
        cd "$PROJECT_ROOT"
        return 1
    fi
}

# Track failures
FAILED=0

# Run tests for each library
run_lib_tests "acp-schema" "acp-schema" "$@" || FAILED=1
run_lib_tests "acp-compiler" "acp-compiler" "$@" || FAILED=1
run_lib_tests "acp-mcp" "acp-mcp" "$@" || FAILED=1
run_lib_tests "acp-runtime" "acp-runtime" "$@" || FAILED=1

# Summary
echo -e "${BLUE}=== Test Summary ===${NC}"
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed${NC}"
    exit 1
fi

