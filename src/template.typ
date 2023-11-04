/* Imports */
#import "metadata.typ": *


/* Utility functions */
#let autoImport(file) = {
    if cvLanguage == "" {
        include {"content/en/" + file + ".typ"}
    }
    else {
        include {"content/" + cvLanguage + "/" + file + ".typ"}
    }
}

#let languageSwitch(dict) = {
    for (k, v) in dict {
        if k == cvLanguage {
            return v
            break
        }
    }
    panic("i18n: language value not matching any key in the array")
}


/* Styling */
#let headerFont = "Source Sans Pro"
#let textFont = "Source Sans Pro"

#let textColors = (
    lightGray: rgb("#ededef"),
    mediumGray: rgb("#78787e"),
    darkGray: rgb("#3c3c42"),
)

#let accentColors = (
    burgundy: rgb("#800020"),
)

#let chosenAccentColor = {
    if type(accentColor) == color {
        accentColor
    } else {
        accentColors.at(accentColor)
    }
}

#let divider() = align(center,
    line(length: 95%, stroke: (paint: textColors.mediumGray, dash: "dashed"))
)

#let headerFirstNameStyle(str) = {text(
    font: headerFont,
    size: 28pt,
    weight: "light",
    str
)}

#let headerLastNameStyle(str) = {text(
    font: headerFont,
    size: 28pt,
    weight: "bold",
    str
)}

#let headerInfoStyle(str) = {text(
    font: headerFont,
    size: 9pt,
    str
)}

#let headerQuoteStyle(str) = {text(
    size: 12pt,
    weight: "medium",
    style: "italic",
    fill: chosenAccentColor,
    str
)}

#let sectionTitleStyle(str, color:black) = {text(
    size: 16pt, 
    weight: "bold", 
    fill: color,
    str
)}

#let entryA1Style(str) = {text(
    size: 12pt,
    weight: "bold",
    str
)}

#let entryA2Style(str) = {align(right, text(
    weight: "medium",
    fill: chosenAccentColor,
    style: "oblique",
    str
))}

#let entryB1Style(str) = {text(
    size: 11pt,
    fill: chosenAccentColor,
    weight: "medium",
    smallcaps(str)
)}

#let entryB2Style(str) = {align(right, text(
    size: 11pt,
    weight: "medium",
    fill: textColors.mediumGray,
    style: "oblique",
    str
))}

#let skillTypeStyle(str) = {text(
    size: 12pt,
    weight: "bold",
    str
)}

#let languageNameStyle(str) = {text(
    size: 12pt,
    weight: "bold",
    str
)}

#let languageInfoStyle(str) = {text(
    str
)}

#let descriptionStyle(str) = {text(
    fill: textColors.darkGray,
    str
)}

#let tagStyle(str) = {align(center, text(
    size: 11pt,
    weight: "regular",
    str
))}

#let tagListStyle(tags) = {for tag in tags {
    box(
        inset: (x: 0.3em),
        outset: (y: 0.3em),
        fill: textColors.lightGray, 
        radius: 3pt,
        tagStyle(tag),
    )
    h(5pt)
}}

#let letterHeaderNameStyle(str) = {text(
    fill: chosenAccentColor,
    weight: "bold",
    str
)}

#let letterHeaderAddressStyle(str) = {text(
    fill: textColors.mediumGray,
    size: 0.9em,
    smallcaps(str)
)}

#let letterDateStyle(str) = {text(
    size: 0.9em,
    style: "italic",
    str
)}

#let letterSubjectStyle(str) = {text(
    fill: chosenAccentColor,
    weight: "bold",
    underline(str)
)}


/* Sections */
#let cvHeader(
    align: left,
    hasPhoto: false
) = {
    let makeHeaderInfo() = {
        let personalInfoIcons = (
        phone: "󰏲",
        email: "󰇮",
        homepage: "󰖟",
        github: "󰊤",
        gitlab: "󰮠",
        location: "󰍎",
        extraInfo: "",
        )
        let n = 1
        for (k, v) in personalInfo {
        // A dirty trick to add linebreaks with "linebreak" as key in personalInfo
        if k == "linebreak" {
            n = 0
            linebreak()
            continue
        }
        if v != "" {box({
            
            // Adds icons
            personalInfoIcons.at(k) + h(5pt)
            // Adds hyperlinks
            if k == "email" {
            link("mailto:" + v)[#v]
            } else if k == "linkedin" {
            link("https://www.linkedin.com/in/" + v)[#v]
            } else if k == "github" {
            link("https://github.com/" + v)[#v]
            } else if k == "gitlab" {
            link("https://gitlab.com/" + v)[#v]
            } else if k == "homepage" {
            link("https://" + v)[#v]
            } else {
            v
            }
        })}
        // Adds hBar
            if n != personalInfo.len() {
            h(12pt)
            }
        n = n + 1
        }
    }

    let makeHeaderNameSection() = table(
        columns: 1fr,
        inset: 0pt,
        stroke: none,
        row-gutter: 4mm,
        [#headerFirstNameStyle(firstName) #h(5pt) #headerLastNameStyle(lastName)],
        [#headerQuoteStyle(languageSwitch(headerQuoteInternational))],
        [#headerInfoStyle(makeHeaderInfo())],
    )

    let makeHeaderPhotoSection() = {
        if profilePhoto != "" {
            image(profilePhoto, height: 3.6cm)
        } else {
            v(3.6cm)
        }
    } 

    let makeHeader(leftComp, rightComp, columns, align) = table(
        columns: columns,
        inset: 0pt,
        stroke: none,
        column-gutter: 15pt,
        align: align + horizon,
        {leftComp},
        {rightComp}
    )

    if hasPhoto {
        makeHeader(makeHeaderNameSection(), makeHeaderPhotoSection(), (auto, 20%), align)
    } else {
        makeHeader(makeHeaderNameSection(), makeHeaderPhotoSection(), (auto, 0%), align)
    }
}

#let cvSection(title) = {
    sectionTitleStyle(title, color: chosenAccentColor)
    h(4pt)
    box(width: 1fr, line(stroke: 0.9pt, length: 100%))
}

#let cvEntry(
    title: "Title",
    organisation: "Organisation",
    date: "Date",
    location: "Location",
    description: "Description",
    logo: "",
    tags: ()
) = {
    let ifOrganisationFirst(condition, field1, field2) = {
        return if condition {field1} else {field2}
    }
    let ifLogo(path, ifTrue, ifFalse) = {
        return if varDisplayLogo {
            if path == "" { ifFalse } else { ifTrue }
        } else { ifFalse }
    }
    let setLogoLength(path) = {
        return if path == "" { 0% } else { 4% }
    }
    let setLogoContent(path) = {
        return if logo == "" [] else {image(path, width: 100%)}
    }
    table(
        columns: (ifLogo(logo, 4%, 0%), 1fr),
        inset: 0pt,
        stroke: none,
        align: horizon,
        column-gutter: ifLogo(logo, 4pt, 0pt),
        setLogoContent(logo),
        table(
            columns: (1fr, auto),
            inset: 0pt,
            stroke: none,
            row-gutter: 8pt,
            align: auto,
            {entryA1Style(ifOrganisationFirst(varEntryOrganisationFirst, organisation, title))},
            {entryA2Style(date)},
            {entryB1Style(ifOrganisationFirst(varEntryOrganisationFirst, title, organisation))},
            {entryB2Style(location)},
        )
    )
    descriptionStyle(description)
    tagListStyle(tags)
}

#let cvSkill(
    type: "Type",
    tags: (),
) = {
    skillTypeStyle(type)
    v(-1mm)
    tagListStyle(tags)
}

#let cvLanguage(
    name: "Name",
    info: "Info",
) = {
    table(
        columns: (25%, 1fr),
        inset: 0pt,
        column-gutter: 10pt,
        stroke: none,
        align: horizon,
        languageNameStyle(name),
        languageInfoStyle(info),
    )
}

#let cvInterestTags(
    tags: (),
) = {
    tagListStyle(tags)
}

#let cvInterestDescription(
    description: "Description",
) = {
    descriptionStyle(description)
}

#let letterHeader(
    myAddress: "Your Address Here",
    recipientName: "Recipient Name Here",
    recipientAddress: "Recipient Address Here",
    date: "Today's Date",
    subject: "Subject: Hey!"
) = {
    letterHeaderNameStyle(firstName + " " + lastName)
    v(1pt)
    letterHeaderAddressStyle(myAddress)
    v(1pt)
    align(right, letterHeaderNameStyle(recipientName))
    v(1pt)
    align(right, letterHeaderAddressStyle(recipientAddress))
    v(1pt)
    letterDateStyle(date)
    v(1pt)
    letterSubjectStyle(subject)
    linebreak(); linebreak()
}

#let letterSignature(path) = {
    linebreak()
    place(right, dx:-5%, dy:0%, image(path, width: 25%))
}


/* Layout */
#let layout(doc) = {
    set text(
        font: textFont,
        weight: "regular",
        size: 11pt,
    )
    set par(
        leading: 0.75em,
    )
    set align(left)
    set page(
        paper: "a4",
        margin: (
            left: 1.2cm,
            right: 1.2cm,
            top: .6cm,
            bottom: 1.2cm,
        ),
    )
    doc
}
