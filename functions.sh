## Gets the current git branch
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\<\1\>/'
}

## Resize an image using 'sips'
function resize_image {
    input="$1"
    output=''
    width=0
    height=0
    v=false


    ## Usage and getopts
    usage () {
        echo "Usage: resize_image input.png [-o <output.png>] [-w <width in px>] [-h <height in px>]"
    }

    OPTIND=2
    while getopts 'o:w:h:v' flag; do
        case "$flag" in
            o) output="$OPTARG" ;;
            w) width="$OPTARG" ;;
            h) height="$OPTARG" ;;
            v) v=true ;;
            *) usage; return 1 ;;
        esac
    done


    ## Checkers
    if [ -z "${output}" ]; then
        $v && echo "No output file, will overwrite '${input}'"
        output=$input
    fi

    if [ $width -eq 0 ] || [ $height -eq 0 ]; then
        echo "Invalid values for width and/or height (must be > 0):"
        echo "  width:  ${width}"
        echo "  height: ${height}"
        return 1
    fi


    ## Let's do this
    if [ -f $input ]; then
        echo "Resizing '${input}'"

        if [ "${input}" != "${output}" ]; then
            $v && echo "  Copying to '${output}'' ..."
            cp "${input}" "${output}"
        fi

        sips "${output}" --resampleHeightWidth $height $width
    else
        echo "File '$input' does not exist!"
        return 1
    fi

    echo "Done!"
}
