

# ---------------- Handle inputs -----------------
print_usage() {
  printf "Useage: "
}

tempo=1
while getopts 'cbvt:' flag; do
  case "${flag}" in
    c) from_clipboard='true' ;;
    b) skip_lines='true' ;;
    v) verbose='true' ;;
    t) tempo="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done
shift $((OPTIND - 1))

# ---------------- Setup -----------------

folder_path=$HOME/.local/share/cliptts
aws_path=$HOME/.aws

if [ ! -d "$folder_path" ]; then
    mkdir -p "$folder_path"
fi

if [ ! -d "$aws_path" ]; then
  echo "Missing .aws folder, aws polly is needed to run this script"
  exit 1
fi

if [ "$verbose" != "true" ]; then
 exec 1> $folder_path/output.txt 2>&1  # For debugging
fi

maxwords=3000
notificationtime=1000

if [ "$from_clipboard" = "true" ]; then
  sayit=$(xclip -o -selection clipboard)
else
  sayit=$1
fi

if [ "$skip_lines" = "true" ]; then
  # Remove line breaks (\n) and replace them with spaces
  sayit=$(echo "$sayit" | tr '\n' ' ')
fi


# ---------------- read  -----------------
#
n_words=$(echo "$sayit" | wc --chars)

# Check if length of input exedes maximum length
if (($n_words > $maxwords))
then
  notify-send -t $notificationtime -a "Reader" "Too many characters"
elif (($n_words < 2 ))
then
  notify-send -t $notificationtime -a "Reader" "Nothing to send"
else
  # Send notificaion
  notify-send -t $notificationtime -a "Reader" "Text sent to reader"

  # Transer get mp3 using aws polly, notify if not working
  aws polly synthesize-speech --output-format mp3 --voice-id Joanna --engine neural --text "$sayit" $folder_path/temp_polly.mp3

  # Play
  ffplay -autoexit -showmode 0 -af "atempo=$tempo" $folder_path/temp_polly.mp3

  rm $folder_path/temp_polly.mp3
  
fi
