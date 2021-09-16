#!/bin/sh

#   Copyright (C) 2016 Deepin, Inc.
#
#   Author:     Li LongYu <lilongyu@linuxdeepin.com>
#               Peng Hao <penghao@linuxdeepin.com>

version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }

extract_archive()
{
    archive=$1
    version_file=$2
    dest_dir=$3
    if [ -f "$archive" ] && [ -n "$dest_dir" ] && [ "$dest_dir" != "." ];then
        archive_version=`cat $version_file`
        if [ -d "$dest_dir" ];then
            if [ -f "$dest_dir/VERSION" ];then
                dest_version=`cat $dest_dir/VERSION`
                if version_gt "$archive_version" "$dest_version";then
                    7z x "$archive" -o/"$dest_dir" -aoa
                    echo "$archive_version" > "$dest_dir/VERSION"
                fi
            fi
        else
            mkdir -p $dest_dir
            7z x "$archive" -o/"$dest_dir" -aoa
            echo "$archive_version" > "$dest_dir/VERSION"
        fi
    fi
}

BOTTLENAME="Deepin-WXWork"
APPVER="3.1.6.3605deepin6"
EXEC_PATH="c:/Program Files/WXWork/WXWork.exe"
START_SHELL_PATH="$HOME/.deepinwine/deepin-wine-helper/run_v4.sh"
export MIME_TYPE=""
export DEB_PACKAGE_NAME="com.qq.weixin.work.deepin"
export APPRUN_CMD="$HOME/.deepinwine/deepin-wine6-stable/bin/wine"
export DISABLE_ATTACH_FILE_DIALOG=""
export FILEDLG_PLUGIN="/app/files/gtkGetFileNameDlg"

if [ -z "$START_SHELL_PATH" ];then
    START_SHELL_PATH="$HOME/.deepinwine/deepin-wine-helper/run_v4.sh"
fi

export SPECIFY_SHELL_DIR=`dirname $START_SHELL_PATH`

DEEPIN_WINE_BIN_DIR=`dirname $APPRUN_CMD`
DEEPIN_WINE_DIR=`dirname $DEEPIN_WINE_BIN_DIR`
ARCHIVE_FILE_DIR="/app/files"

export WINEPREDLL="$ARCHIVE_FILE_DIR/dlls"

extract_archive "$ARCHIVE_FILE_DIR/helper_archive.7z" "$ARCHIVE_FILE_DIR/helper_archive.md5sum" "$SPECIFY_SHELL_DIR"

if [ -z "$DISABLE_ATTACH_FILE_DIALOG" ];then
    export ATTACH_FILE_DIALOG=1
fi

extract_archive "$ARCHIVE_FILE_DIR/wine_archive.7z" "$ARCHIVE_FILE_DIR/wine_archive.md5sum" "$DEEPIN_WINE_DIR"

if [ -d "$DEEPIN_WINE_BIN_DIR" ] && [ "$DEEPIN_WINE_BIN_DIR" != "." ];then
    export DEEPIN_WINE_BIN_DIR
fi

if [ -n "$EXEC_PATH" ];then
    $START_SHELL_PATH $BOTTLENAME $APPVER "$EXEC_PATH" "$@"
else
    $START_SHELL_PATH $BOTTLENAME $APPVER "uninstaller.exe" "$@"
fi
