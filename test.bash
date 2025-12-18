#!/bin/bash
# SPDX-FileCopyrightText: 2025 Tatsunori Kanno
# SPDX-License-Identifier: BSD-3-Clause

PROGRAM="dice"

ERROR_COUNT=0

#テストケース定義
TEST_CASES=(
    "3 5"     # 正常
    "1 1"     # 正常
    "0 5"     # 異常: n = 0
    "3 0"     # 異常: m = 0
    "-2 5"    # 異常: n < 0
    "3 -4"    # 異常: m < 0
)

#テスト実行
for INPUT in "${TEST_CASES[@]}"; do
    n=$(echo "$INPUT" | awk '{print $1}')
    m=$(echo "$INPUT" | awk '{print $2}')

    # 入力値チェック
    if [ "$n" -le 0 ] || [ "$m" -le 0 ]; then
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    OUTPUT=$(echo "$INPUT" | python3 "$PROGRAM" 2>/dev/null)
    STATUS=$?

    # プログラム異常終了チェック
    if [ $STATUS -ne 0 ]; then
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    # 出力行数チェック
    LINES=$(echo "$OUTPUT" | wc -l)
    if [ "$LINES" -ne "$m" ]; then
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    # 出目・合計チェック
    echo "$OUTPUT" | while read line; do
        DICE=$(echo "$line" | sed -n 's/.*\[\(.*\)\].*/\1/p')
        TOTAL=$(echo "$line" | awk '{print $NF}')

        SUM=0
        for d in $(echo "$DICE" | tr ',' ' '); do
            d=$(echo "$d" | tr -d ' ')
            if [ "$d" -lt 1 ] || [ "$d" -gt 6 ]; then
                exit 1
            fi
            SUM=$((SUM + d))
        done

        if [ "$TOTAL" -ne "$SUM" ]; then
            exit 1
        fi
    done

    if [ $? -ne 0 ]; then
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
done

#結果
echo "$ERROR_COUNT"

