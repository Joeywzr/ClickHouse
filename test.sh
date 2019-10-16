#!/usr/bin/env bash

# NOTE: docker should have ipv6 support
# put the following into /etc/docker/daemon.json
#
# {
#       "ipv6": true,
#       "fixed-cidr-v6": "2001:db8:3:1::/64"
# }
#

set -e

arch=$(dpkg --print-architecture)

if [ "$arch" = "amd64" ]
then
   docker=yandex
elif [ "$arch" = "arm64" ]
then
   docker=amosbird
else
    echo "Only support arch = amd64|arm64. Given $arch."
    exit 1
fi

case "$(basename "$0")" in
ub)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/clickhouse-debs:/package_folder --volume=/tmp/test_output:/test_output --volume=/tmp/server_log:/var/log/clickhouse-server -e SKIP_TESTS_OPTION="--skip 00281 capnproto avx2 query_profiler" -e ADDITIONAL_OPTIONS="--hung-check" "$docker"/clickhouse-stateless-test
    ;;
rel)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/clickhouse-debs:/package_folder --volume=/tmp/test_output:/test_output --volume=/tmp/server_log:/var/log/clickhouse-server -e SKIP_TESTS_OPTION="--skip avx2" -e ADDITIONAL_OPTIONS="--hung-check" "$docker"/clickhouse-stateless-test
    ;;
uni)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/ClickHouse/build/dbms/unit_tests_dbms:/unit_tests_dbms --volume=/tmp/test_output:/test_output "$docker"/clickhouse-unit-test
    ;;
pf)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/clickhouse-debs:/package_folder --volume=/tmp/test_output:/test_output --volume=/tmp/server_log:/var/log/clickhouse-server --volume=/data/clickhouse-testdata:/var/lib/clickhouse -e DOWNLOAD_DATASETS=0 -e TESTS_TO_RUN='--recursive --input-files /usr/share/clickhouse-test/performance/' "$docker"/clickhouse-performance-test
    ;;
pf1)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/clickhouse-debs:/package_folder --volume=/tmp/test_output1:/test_output --volume=/tmp/server_log:/var/log/clickhouse-server --volume=/data/clickhouse-testdata:/var/lib/clickhouse -e DOWNLOAD_DATASETS=0 -e TESTS_TO_RUN='--input-files /usr/share/clickhouse-test/performance/website.xml --query-indexes 67 68 69 70' "$docker"/clickhouse-performance-test
    ;;
pf2)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/chorigin-debs:/package_folder --volume=/tmp/test_output2:/test_output --volume=/tmp/server_log:/var/log/clickhouse-server --volume=/data/clickhouse-testdata:/var/lib/clickhouse -e DOWNLOAD_DATASETS=0 -e TESTS_TO_RUN='--input-files /usr/share/clickhouse-test/performance/general_purpose_hashes.xml --query-indexes 20' "$docker"/clickhouse-performance-test
    ;;
pf3)
    docker run --rm --ulimit nofile=1000000:1000000 --volume=/data/pfdebs:/package_folder --volume=/tmp/test_output3:/test_output --volume=/tmp/server_log:/var/log/clickhouse-server --volume=/data/clickhouse-testdata:/var/lib/clickhouse -e DOWNLOAD_DATASETS=0 -e TESTS_TO_RUN='--input-files /usr/share/clickhouse-test/performance/' "$docker"/clickhouse-performance-test
    ;;
*)
    echo "There is no test for this variant yet."
    exit 1
    ;;
esac
