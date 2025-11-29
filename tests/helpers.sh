generate() {
  copier copy -f --trust -r HEAD "$1" "$2" \
    -d testing=true \
    -d project_name="Oedokumaci Testing" \
    -d project_description='Testing this great template' \
    -d author_fullname="Oral Ersoy Dokumaci" \
    -d author_username="oedokumaci" \
    -d author_email="oral.ersoy.dokumaci@gmail.com"
}
