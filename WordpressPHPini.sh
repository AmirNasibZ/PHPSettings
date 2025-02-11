#!/bin/bash

php=$(find /*/*/*php[7,8]* -maxdepth 3 -mindepth 2 -iname php.ini)
phpalt=$(find /opt/alt/*php[7,8]* -maxdepth 3 -mindepth 2 -iname php.ini)


chattr -i $php
chattr -i $phpalt

# max_input_vars check

sed -i '/max_input_vars = /c\max_input_vars = 10000' $php

for file in $phpalt; do
    if ! grep -qxF "max_input_vars = " "$file"; then
        echo "max_input_vars = 10000" >> "$file"
    fi
done

if ( grep -q 'max_input_vars = 10000' $php $phpalt) ;then
        echo "max_input_vars = 10000 ==> true"
else
        echo "max_input_vars = 10000 ==> False $php $phpalt"
fi

# memory_limit check
sed -i '/memory_limit/c\memory_limit = 2048M' $php
if ( grep -q 'memory_limit = 2048M' $php ) ;then
        echo "memory_limit = 2048M ==> true"
else
        echo "memory_limit = 2048M ==> False"
fi

# max_file_uploads check
sed -i '/max_file_uploads/c\max_file_uploads = 40' $php
if ( grep -q 'max_file_uploads = 40' $php ) ;then
        echo "max_file_uploads = 40 ==> true"
else
        echo "max_file_uploads = 40 ==> False"
fi

# max_input_time check
sed -i '/max_input_time = /c\max_input_time = 600' $php
if ( grep -q 'max_input_time = 600' $php ) ;then
        echo "max_input_time = 600 ==> true"
else
        echo "max_input_time = 600 ==> False"
fi

# max_execution_time check
sed -i '/max_execution_time/c\max_execution_time = 300' $php
if ( grep -q 'max_execution_time = 300' $php ) ;then
        echo "max_execution_time = 300 ==> true"
else
        echo "max_execution_time = 300 ==> False"
fi

# upload_max_filesize check
sed -i '/upload_max_filesize/c\upload_max_filesize = 256M' $php
if ( grep -q 'upload_max_filesize = 256M' $php ) ;then
        echo "upload_max_filesize = 256M ==> true"
else
        echo "upload_max_filesize = 256M ==> False"
fi

# post_max_size check
sed -i '/post_max_size/c\post_max_size = 256M' $php
if ( grep -q 'post_max_size = 256M' $php ) ;then
        echo "post_max_size = 256M ==> true"
else
        echo "post_max_size = 256M ==> False"
fi

# zlib.output_compression check
sed -i '/zlib.output_compression =/c\zlib.output_compression = On' $php
echo "zlib.output_compression = On ==> true"

# allow_url_fopen check
sed -i '/allow_url_fopen =/c\allow_url_fopen = On' $php
echo "allow_url_fopen = On ==> true"

chattr +i $php $phpalt