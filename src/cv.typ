#import "template.typ": *
#show: layout

#cvHeader(align: left, hasPhoto: true)
#grid(
    columns: (60%, 40%),
    gutter: 16pt,
    stack(
        spacing: 20pt,
        autoImport("experience"),
        autoImport("education"),
    ),
    stack(
        spacing: 20pt,
        autoImport("skills"),
        autoImport("languages"),
        autoImport("interests"),
    ),
)
