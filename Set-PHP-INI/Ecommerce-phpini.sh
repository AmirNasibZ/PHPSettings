#!/bin/bash

# find the php.ini file
php_ini=$(find /*/*/*php[7,8]* -maxdepth 3 -mindepth 2 -iname php.ini)

if [ -z "$php_ini" ]; then
    echo "php.ini file not found."
    exit 1
fi

# remove the chattr attribute
chattr -i $php_ini

# max_input_vars check
sed -i '/max_input_vars/c\max_input_vars = 20000' $php_ini
if ( grep -q 'max_input_vars = 20000' $php_ini) ;then
        echo "max_input_vars = 20000 ==> True"
else
        echo "max_input_vars = 20000 ==> False"
fi

# memory_limit check
sed -i '/memory_limit/c\memory_limit = 4096M' $php_ini
if ( grep -q 'memory_limit = 4096M' $php_ini ) ;then
        echo "memory_limit = 4096M ==> True"
else
        echo "memory_limit = 4096M ==> False"
fi

# max_file_uploads check
sed -i '/max_file_uploads/c\max_file_uploads = 128' $php_ini
if ( grep -q 'max_file_uploads = 128' $php_ini ) ;then
        echo "max_file_uploads = 128 ==> True"
else
        echo "max_file_uploads = 128 ==> False"
fi

# max_input_time check
sed -i '/max_input_time = /c\max_input_time = 2000' $php_ini
if ( grep -q 'max_input_time = 2000' $php_ini ) ;then
        echo "max_input_time = 2000 ==> True"
else
        echo "max_input_time = 2000 ==> False"
fi

# max_execution_time check
sed -i '/max_execution_time/c\max_execution_time = 600' $php_ini
if ( grep -q 'max_execution_time = 600' $php_ini ) ;then
        echo "max_execution_time = 600 ==> True"
else
        echo "max_execution_time = 600 ==> False"
fi

# upload_max_filesize check
sed -i '/upload_max_filesize/c\upload_max_filesize = 1024M' $php_ini
if ( grep -q 'upload_max_filesize = 1024M' $php_ini ) ;then
        echo "upload_max_filesize = 1024M ==> True"
else
        echo "upload_max_filesize = 1024M ==> False"
fi

# post_max_size check
sed -i '/post_max_size/c\post_max_size = 1024M' $php_ini
if ( grep -q 'post_max_size = 1024M' $php_ini ) ;then
        echo "post_max_size = 1024M ==> True"
else
        echo "post_max_size = 1024M ==> False"

fi

# zlib.output_compression check
sed -i '/zlib.output_compression =/c\zlib.output_compression = On' $php
echo "zlib.output_compression = On ==> true"

# allow_url_fopen check
sed -i '/allow_url_fopen =/c\allow_url_fopen = On' $php
echo "allow_url_fopen = On ==> true"