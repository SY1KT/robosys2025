#!/bin/bash
# SPDX-FileCopyrightText: 2025 Ryuichi Ueda
ng () {
       echo ${1}行目が違うよ #$1はngの1番目の引数
       res=1
}

res=0
a=山田
[ "$a" = 上田 ] || ng "$LINENO" #LINENOは、この行の行番号の入る変数
[ "$a" = 山田 ] || ng "$LINENO"

exit $res

