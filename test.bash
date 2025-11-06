#!/bin/bash
# SPDX-FileCopyrightText: 2025 Tatsunori Kanno
# SPDX-License-Identifier: BSD-3-Clause

ng () {
       echo ${1}行目が違うよ
       res=1
}

res=0
a=山田
[ "$a" = 上田 ] || ng "$LINENO"
[ "$a" = 山田 ] || ng "$LINEMO"

exit $res



