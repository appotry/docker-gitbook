#!/bin/bash
set -uo pipefail

IMAGE="gitbook-builder:test"
REPORT_DIR="tests/reports"
REPORT_FILE="$REPORT_DIR/test-report-$(date +'%Y%m%d-%H%M%S').log"
PASSED=0
FAILED=0

mkdir -p "$REPORT_DIR"

# ---- helpers ----

header() {
  echo "" | tee -a "$REPORT_FILE"
  echo "============================================" | tee -a "$REPORT_FILE"
  echo "  $1" | tee -a "$REPORT_FILE"
  echo "============================================" | tee -a "$REPORT_FILE"
}

run_test() {
  local name="$1" cmd="$2"
  printf "  %-40s " "$name" | tee -a "$REPORT_FILE"
  if eval "$cmd" >> "$REPORT_FILE" 2>&1; then
    echo "PASS" | tee -a "$REPORT_FILE"
    PASSED=$((PASSED + 1))
  else
    echo "FAIL" | tee -a "$REPORT_FILE"
    FAILED=$((FAILED + 1))
  fi
}

# ---- report header ----

{
  echo "============================================"
  echo "  docker-gitbook-builder 测试报告"
  echo "============================================"
  echo "  镜像:       $IMAGE"
  echo "  时间:       $(date '+%Y-%m-%d %H:%M:%S')"
  echo "  主机:       $(uname -a)"
  echo "============================================"
} > "$REPORT_FILE"

# ---- Step 1: Build ----

header "Step 1: 构建镜像"
run_test "docker build -t $IMAGE" "docker build -t '$IMAGE' ."

# ---- Step 2: CLI smoke tests ----

header "Step 2: CLI 工具验证"

run_test "gitbook --help"        "docker run --rm $IMAGE gitbook --help | head -5"
run_test "honkit --help"         "docker run --rm $IMAGE honkit --help | head -5"
run_test "node --version"        "docker run --rm $IMAGE node --version"
run_test "npm --version"         "docker run --rm $IMAGE npm --version"
run_test "java --version"        "docker run --rm $IMAGE java --version"
run_test "ebook-convert (Calibre)" "docker run --rm $IMAGE ebook-convert --version"

# ---- Step 3: Workspace & entrypoint ----

header "Step 3: 容器运行时验证"
run_test "book.json 存在于 /"      "docker run --rm $IMAGE test -f /book.json"
run_test "entrypoint.sh 可执行"    "docker run --rm $IMAGE test -x /entrypoint.sh"
run_test "userRun.sh 可执行"       "docker run --rm $IMAGE test -x /userRun.sh"
run_test "/gitbook 目录可写"       "docker run --rm $IMAGE sh -c 'touch /gitbook/.write-test && rm /gitbook/.write-test'"

# ---- summary ----

{
  echo ""
  echo "============================================"
  echo "  测试结果汇总"
  echo "============================================"
  echo "  通过:  $PASSED"
  echo "  失败:  $FAILED"
  echo "  总计:  $((PASSED + FAILED))"
  echo "  报告:  $REPORT_FILE"
  echo "============================================"
} | tee -a "$REPORT_FILE"

# stdout 也输出简版
echo ""
echo "结果: $PASSED 通过, $FAILED 失败 / $((PASSED + FAILED)) 总计"

[ "$FAILED" -eq 0 ] && exit 0 || exit 1
