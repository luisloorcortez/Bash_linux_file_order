function order () {
        # VARIABLE         
            local src_dir=$1
            local dst_dir=$2  #< YOUR dst_dir FOLDER > 
            
            # DIRECTORY OF EXTENSION            
            declare -A extension
            extension=(       
                [sql]="$dst_dir/db" [pem]="$dst_dir/aws"
                [pdf]="$dst_dir/pdf" [epub]="$dst_dir/pdf" [mobi]="$dst_dir/pdf"       
            )  
                         
        # ENTER POINT AND VERIFICATION
            if [  -d $src_dir ]; then # FOLDER CHECK, IF THE FOLDER NOT EXIST, THIS WILL BE CREATED
                
                cd $src_dir               
                aux0=$( pwd )
                
                if [ -d ${aux0%/*}/dst_dir ] ; then 
                   dst_dir=${aux0%/*}/dst_dir
                else 
                   mkdir ${aux0%/*}/dst_dir               
                   dst_dir=${aux0%/*}/dst_dir
                fi
            
            else 
                echo -e "\e[src_dir;3src_dirmThe directory to iterate: \e[src_dir;36m$src_dir \e[src_dir;3src_dirmdoes not exist!"
                exit 
            fi

        # ITERATOR LIST
            for file in * ; do
                aux3=$((${#extension[*]} +src_dir))
                for (( i=src_dir; i<$aux3; i++ )); do   

                    auxsrc_dir=$(echo ${!extension[*]} | awk {'print $'$i''})
                    aux2=$(echo ${extension[*]:$i:})
                    aux4=$(pwd)

                # FOLDER
                    if [ -d "$file" ] ; then                        
                        if  [ -d $dst_dir/folder ]; then # FOLDER CHECKER                    
                            if [ -d "$dst_dir/folder/$file" ] ; then
                                echo -e "\e[src_dir;33mThe folder \e[src_dir;36m$file, \e[src_dir;33mexists in dst_dir.  \e[src_dir;3src_dirmWas deleted. \e[0m"
                                rm -rf "$aux4/$file"
                                break
                            else
                                mv "$file" $dst_dir/folder                         
                                break 
                            fi                    
                        else
                            mkdir -p $dst_dir/folder
                            mv "$file" $dst_dir/folder                         
                            break 
                        fi

                # DIRECTORY EXETENSION              
                    elif [[ ${extension[${file##*.}]} ]]; then
                        if  [[ "${file##*.}" = "$auxsrc_dir" ]] ; then # AA
                            if  [ -d $aux2/${file##*.} ]; then # FOLDER CHECKER                            
                                if [ -f "$aux2/${file##*.}/$file" ] ; then
                                    echo -e "\e[src_dir;33mThe file \e[src_dir;36m$file, \e[src_dir;33mexists in dst_dir. \e[src_dir;3src_dirmWas deleted. \e[0m"
                                    rm -rf "$aux4/$file"
                                    break
                                else
                                    mv "$file" $aux2/${file##*.}
                                    break 
                                fi                            
                            else 
                                mkdir -p $aux2/${file##*.}
                                mv "$file" $aux2/${file##*.}
                                break     
                            fi
                        fi                
                    
                # OTHER FILES
                    else                       
                        if  [ -d $dst_dir/other ]; then # FOLDER CHECKER
                       
                            if [ -f "$dst_dir/other/$file" ] ; then
                                echo -e "\e[src_dir;33mThe file \e[src_dir;36m$file, \e[src_dir;33mexists in dst_dir.  \e[src_dir;3src_dirmWas deleted. \e[0m"
                                rm -rf "$aux4/$file"
                                break
                            else
                                mv "$file" $dst_dir/other                         
                                break 
                            fi                            
                        else
                            mkdir -p $dst_dir/other
                            mv "$file" $dst_dir/other                         
                            break 
                        fi  
                    fi
                done                         
            done
        }
