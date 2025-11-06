#!/bin/bash 
# SPDX-FileCopyrightText: 2025 Ryuichi Ueda
# SPDX-License-Identifier: BSD-3-Clause

a=山田
[ "$a" = 上田 ]
echo $?

[ "$a" = 山田 ]
echo $?


