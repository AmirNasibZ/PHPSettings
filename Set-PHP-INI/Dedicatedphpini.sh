#!/bin/bash

php=$(find /*/*/*php[7,8]* -maxdepth 3 -mindepth 2 -iname php.ini)
phpalt=$(find /opt/alt/*php[7,8]* -maxdepth 3 -mindepth 2 -iname php.ini)


chattr -i $php
chattr -i $phpalt

# max_input_vars check

sed -i '/max_input_vars = /c\max_input_vars = 500000' $php

for file in $phpalt; do
    if ! grep -qxF "max_input_vars = " "$file"; then
        echo "max_input_vars = 500000" >> "$file"
    fi
done

if ( grep -q 'max_input_vars = 500000' $php $phpalt) ;then
        echo "max_input_vars = 500000 ==> true"
else
        echo "max_input_vars = 500000 ==> False $php $phpalt"
fi

# memory_limit check
sed -i '/memory_limit/c\memory_limit = 8192M' $php
echo "memory_limit = 8192M ==> true"

# max_file_uploads check
sed -i '/max_file_uploads/c\max_file_uploads = 1024' $php
echo "max_file_uploads = 1024 ==> true"

# max_input_time check
sed -i '/max_input_time = /c\max_input_time = 50000' $php
echo "max_input_time = 50000 ==> true"

# max_execution_time check
sed -i '/max_execution_time/c\max_execution_time = 50000' $php
echo "max_execution_time = 50000 ==> true"

# upload_max_filesize check
sed -i '/upload_max_filesize/c\upload_max_filesize = 2048M' $php
echo "upload_max_filesize = 2048M ==> true"

# post_max_size check
sed -i '/post_max_size/c\post_max_size = 2048M' $php
echo "post_max_size = 2048M ==> true"

# zlib.output_compression check
sed -i '/zlib.output_compression =/c\zlib.output_compression = On' $php
echo "zlib.output_compression = On ==> true"

# allow_url_fopen check
sed -i '/allow_url_fopen =/c\allow_url_fopen = On' $php
echo "allow_url_fopen = On ==> true"
